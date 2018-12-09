require 'pry'

class Employee
  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end
  
  def to_s
    puts "Name: #{@name}"
    puts "Type: #{self.class}"
    puts "Serial Number: #{@serial_number}"
    puts "Vacation Days: #{@vacation_days}"
    puts "Desk: #{@desk.to_s.capitalize}"
  end
end

class FullTimeEmployee < Employee
  def initialize(name, serial_number)
    super(name, serial_number)
    @vacation_days = 10
    @desk = :cubicle
  end
  
  def take_vacation; end
end

class PartTimeEmployee < Employee
  def initialize(name, serial_number)
    super(name, serial_number)
    @vacation_days = 0
    @desk = :open
  end
end

module Delegatable
  def delegate(employee); end
end

class Manager < FullTimeEmployee
  include Delegatable

  def initialize(name, serial_number)
    super(name, serial_number)
    @vacation_days = 14
    @desk = :private
  end
end

class Executive < FullTimeEmployee
  include Delegatable
  
  def initialize(name, serial_number)
    super(name, serial_number)
    @vacation_days = 20
    @desk = :corner
  end
end

binding.pry
puts "hi"