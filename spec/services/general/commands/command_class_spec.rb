require 'rails_helper'

RSpec.describe General::Commands::CommandClass do
  let(:test_class) do
    Class.new do
      include General::Commands::CommandClass
    end
  end

  let(:instance) { test_class.new }

  describe '#command_class' do
    context 'when command class exists' do
      before do
        module Commands
          module User
            class Create
            end
          end
        end
      end

      it 'returns the correct constant' do
        result = instance.command_class(name: 'user', action: 'create')
        expect(result).to eq(Commands::User::Create)
      end

      it 'handles different case formats' do
        result = instance.command_class(name: 'USER', action: 'CREATE')
        expect(result).to eq(Commands::User::Create)
      end
    end

    context 'when command class does not exist' do
      it 'raises an error' do
        expect {
          instance.command_class(name: 'nonexistent', action: 'missing')
        }.to raise_error(RuntimeError, 'Commands::Nonexistent::Missing NOT DEFINED')
      end
    end

    context 'with various input formats' do
      before do
        module Commands
          module Product
            class Update
            end
          end
        end
      end

      it 'handles lowercase input' do
        result = instance.command_class(name: 'product', action: 'update')
        expect(result).to eq(Commands::Product::Update)
      end

      it 'handles mixed case input' do
        result = instance.command_class(name: 'ProDuct', action: 'UpDate')
        expect(result).to eq(Commands::Product::Update)
      end
    end
  end
end

