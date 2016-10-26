require './employee'

class Department < ActiveRecord::Base

  def add_employee(new_employee)
    new_employee.department_id = self.id
    new_employee.save
  end

  def staff
    Employee.where(department_id: self.id).to_a
  end

  def number_of_employees
    staff.size
  end

  def department_salary
    staff.reduce(0.0) {|sum, e| sum + e.salary}
  end

  def department_raise(alloted_amount)
    raise_eligible = staff.select {|e| yield(e)}
    amount = alloted_amount / raise_eligible.length
    raise_eligible.each {|e| e.raise_by_amount(amount)}
  end

  def lowest_paid_employee
    Employee.where(department_id: self.id).order(:salary).first
  end

end
