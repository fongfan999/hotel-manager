class Admin::EmployeesController < Admin::ApplicationController
  before_action :set_employee, only: [:edit, :update, :destroy]

  def index
    @employees = Employee.all.order(:name).paginate(:page => params[:page])
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  # def search
  #   unless params[:search][:q].blank?
  #     @employees = Employee.search(params[:search][:q])
  #   else
  #     @employees = Employee.all
  #   end
    
  #   @employees = @employees.paginate(:page => params[:page])

  #   render :index
  # end

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

  def destroy
    @employee.destroy
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
