## Classes and Objects I Exercises ##
module PowerUpable
  def rev_engine
    puts "Vrrrmmmm"
  end
end

class Vehicle
  attr_accessor :color, :speed, :status
  attr_reader :model, :year
  
  @@number_of_vehicles = 0
  
  def self.number_of_vehicles
    @@number_of_vehicles
  end
  
  def self.gas_milage(gallons, miles)
    puts "#{miles/gallons.to_f} miles per gallon."
  end
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @status = "on"
    @@number_of_vehicles += 1
  end
  
  def accelerate(speed)
    self.speed = speed
  end
  
  def brake
    self.speed = 0
  end
  
  def turn_off
    self.status = "off"
  end
  
  def spray_paint(color)
    self.color = (color)
  end
  
  def to_s
    "#{self.year} #{self.color} #{self.model}"
  end
  
  def age
    puts "This car is #{calculate_age} years old."
  end
  
  private
  
  def calculate_age
    2019 - self.year
  end
  
end

class MyCar < Vehicle
  MAX_SPEED = 155
end

class MyTruck < Vehicle
  include PowerUpable
  MAX_SPEED = 135
end

=begin
puts Vehicle.number_of_vehicles

lambo = MyCar.new(2000, "red", "Lambo")
ford150 = MyTruck.new(2015, "black", "Ford F-150")

puts lambo
puts ford150
puts Vehicle.number_of_vehicles
ford150.rev_engine

puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors

puts lambo.accelerate(90)
puts lambo.spray_paint("brown")
puts lambo.turn_off

puts lambo.age
puts ford150.age
=end

class Student
  attr_reader :name
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(name)
    self.grade > name.grade
  end
  
  protected
  attr_reader :grade
  
end

tim = Student.new("Tim", 90)
howard = Student.new("Howard", 78)

puts tim.better_grade_than? howard