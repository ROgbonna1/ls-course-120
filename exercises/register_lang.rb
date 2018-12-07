require 'pry'
class Stack

  def initialize
    @values = []
  end
  
  def stack
    @values
  end
  
  def <<(num)
    @values << num
  end
  
  def pop
    raise TypeError.new("Empty Stack!") if @values.empty?
    @values.pop
  end
end

class Register
  
  def initialize
    @value = 0
  end
  
  def register
    @value
  end
  
  def register=(num)
    @value = num
  end
end

class Minilang
  attr_accessor :register, :stack
  attr_reader :program
  
  def initialize(program)
    @register = Register.new
    @stack = Stack.new
    @program = program
  end
  
  def eval
    program.split.each do |command|
      if command.to_i.to_s == command
        self.register = command.to_i
      else
        self.send COMMANDS.fetch(command) { raise TypeError.new("Invalid Token: #{command}")}.to_sym
      end
    end
  end
  
  private
  COMMANDS = { "PUSH" => "push_register", "ADD" => "add", "SUB" => "subtract", 
              "MULT" => "multiply", "DIV" => "divide", "MOD" => "modulo",
              "POP" => "pop", "PRINT" => "print_register" }
  
  
  
  def push_register
    self.stack << register
  end
  
  def add
    self.register = stack.pop + register
  end
  
  def subtract
    self.register = register - stack.pop
  end
  
  def multiply
    self.register = stack.pop * register
  end
  
  def divide
    self.register = stack.pop / register
  end
  
  def modulo
    self.register = register % stack.pop
  end
  
  def pop
    self.register = stack.pop
  end
  
  def print_register
    puts register
  end
  
end
binding.pry
puts "Hi"