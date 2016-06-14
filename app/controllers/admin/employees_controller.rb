class Admin::EmployeesController < Admin::ApplicationController
  before_action :set_employee, only: [:edit, :reset_password, :update,
    :destroy]

  def index
    @employees = Employee.excluding_archived.order(:name).paginate(:page => params[:page])
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def reset_password
    user = User.find(@employee.account.id)
    user.update(password: "password")

    flash[:notice] = "Password has been reseted successfully."
    redirect_to customers_path
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      password = @employee.phone
      email = @employee.name.split[-1].downcase + password + "@example.com"
      account = User.create!(email: email, password: password, role: "employee")
      @employee.account = account
      @employee.save

      flash[:notice] = "Employee was successfully created."
      redirect_to admin_employees_path
    else
      flash.now[:alert] = "Employee was not successfully created."
      render :new
    end
  end

  def update
    if @employee.update(employee_params)
      flash[:notice] = "Employee was successfully updated."
      redirect_to admin_employees_path
    else
      flash.now[:alert] = "Employee was not successfully updated."
      render :edit
    end
  end

  def archive
    @employee.account.archive

    flash[:notice] = "Employee was successfully destroyed."
    redirect_to admin_employees_path
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :gender, :date_of_birth,
      :hire_date, :phone, :address)
  end
end
