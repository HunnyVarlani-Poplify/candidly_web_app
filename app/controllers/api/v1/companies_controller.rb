module Api
  module V1
    class CompaniesController < BaseApiController
      def create
        @company = Company.new(company_params)
        if @company.save
          
          @company.admin.send_reset_password_instructions
          binding.pry
          render json: {company: CompanySerializer.new(@company).serializable_hash}, status: 200
        else
          render json: { error: @company.errors.full_messages.join(', ') } , status: 400
        end
      end
    
      private 
    
      def company_params
        params.require(:company).permit(:name, :website, :contact_no, :address, :tenant_id,
        admin_attributes: %i[first_name email])
      end
    end
  end
end
