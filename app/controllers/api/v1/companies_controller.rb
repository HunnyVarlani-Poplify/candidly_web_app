module Api
  module V1
    class CompaniesController < ApplicationController

      def index 
        @companies = Company.all 
        render json: {company: CompanySerializer.new(@companies).serializable_hash }, status: 200
      end

      def create
        @company = Company.new(company_params) 
        # just for testing
        @company.user.skip_password_validation = true
        if @company.save
          @company.user.send_reset_password_instructions
          render json: { company: CompanySerializer.new(@company).serializable_hash }, status: 200
        else
          render json: { errors: @company.errors.full_messages.join(', ') } , status: 400
        end
      end
    
      private 
    
      def company_params
        params.require(:company).permit(:name, :website, :contact_no, :address, :tenant_id,
        user_attributes: %i[name email])
      end
    end
  end
end
