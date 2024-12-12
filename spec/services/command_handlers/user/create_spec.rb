require 'rails_helper'

RSpec.describe Accounts::CommandHandlers::Organization::Create do
  describe '.handle' do
    let(:user_id) { SecureRandom.uuid }
    let(:email) { 'test@example.com' }
    let(:command) do
      OpenStruct.new(
        id: user_id,
        email: email
      )
    end
    let(:current_user_id) { SecureRandom.uuid }

    subject { described_class.handle(command: command, current_user_id: current_user_id) }

    context 'when user creation is successful' do
      it 'creates a new user' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'returns a successful result' do
        result = subject
        expect(result.success?).to be true
        expect(result.object).to be_a(User)
        expect(result.object.email).to eq(email)
        expect(result.object.id).to eq(user_id)
        expect(result.errors).to be_nil
      end

      context 'when user already exists' do
        let!(:existing_user) { User.create!(id: user_id, email: email) }

        it 'does not create a new user' do
          expect { subject }.not_to change(User, :count)
        end

        it 'returns the existing user' do
          result = subject
          expect(result.success?).to be true
          expect(result.object).to eq(existing_user)
          expect(result.errors).to be_nil
        end
      end
    end

    context 'when user creation fails' do
      let(:email) { 'invalid-email' }

      it 'returns a failure result' do
        result = subject
        expect(result.success?).to be false
        expect(result.object).to be_nil
        expect(result.errors).to be_present
      end

      it 'does not create a new user' do
        expect { subject }.not_to change(User, :count)
      end
    end
  end
end
