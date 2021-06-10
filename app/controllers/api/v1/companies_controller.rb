class Api::V1::CompaniesController < ApplicationController
  # before_action :authenticate_admin!
  
  def create
    @company = Company.new(company_params)
    if @company.save
      render json: {company: @company}, status: 200
    else
      render json: { error: @company.errors.full_messages.join(', ') } , status: 400
    end
  end

  private 

  def company_params
    params.require(:company).permit(:name, :website, :contact_no, :address, :tenant_id)
  end
end
