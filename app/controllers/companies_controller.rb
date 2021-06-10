module Api
  module V1
    class CompaniesController < BaseApiController
      def create
        @company = Company.new(company_params)
        # just for testing purpose
        @company.user.password = '123456'
        if @company.save
          @company.user.send_reset_password_instructions
          render json: {company: CompanySerializer.new(@company) }, status: 200
        else
          render json: { error: @company.errors.full_messages.join(', ') } , status: 400
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
