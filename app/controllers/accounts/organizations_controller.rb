module Accounts
  class OrganizationsController < ApplicationController
    include WithCurrentUser
    before_action :set_organization, only: %i[ show edit update destroy ]

    # GET /accounts/organizations or /accounts/organizations.json
    def index
      @organizations = Organization.all
    end

    # GET /accounts/organizations/1 or /accounts/organizations/1.json
    def show
    end

    # GET /accounts/organizations/new
    def new
      @organization = Organization.new
    end

    # GET /accounts/organizations/1/edit
    def edit
    end

    # POST /accounts/organizations or /accounts/organizations.json
    def create
      @organization = Organization.new(organization_params)

      respond_to do |format|
        if @organization.save
          format.html { redirect_to [ @organization ], notice: "Organization was successfully created." }
          format.json { render :show, status: :created, location: @organization }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /accounts/organizations/1 or /accounts/organizations/1.json
    def update
      respond_to do |format|
        if @organization.update(organization_params)
          format.html { redirect_to [ @organization ], notice: "Organization was successfully updated." }
          format.json { render :show, status: :ok, location: @organization }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /accounts/organizations/1 or /accounts/organizations/1.json
    def destroy
      @organization.destroy!

      respond_to do |format|
        format.html { redirect_to accounts_organizations_path, status: :see_other, notice: "Organization was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.require(:accounts_organization).permit(:name, :domain)
    end
  end
end
