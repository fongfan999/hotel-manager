class Admin::CustomersController < Admin::ApplicationController
  def archive
    @customer = Customer.find(params[:id])
    @customer.account.archive

    flash[:notice] = "Customer was successfully destroyed."
    redirect_to customers_path
  end
end

