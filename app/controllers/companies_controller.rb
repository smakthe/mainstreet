class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    @company.update(city: ZipCodes.identify(@company.zip_code)[:city], state: ZipCodes.identify(@company.zip_code)[:state_code])
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params) && @company.update(city: ZipCodes.identify(@company.zip_code)[:city], state: ZipCodes.identify(@company.zip_code)[:state_code])
      redirect_to companies_path, notice: "Changes Saved"
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_path, notice: 'Company is successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end


end
