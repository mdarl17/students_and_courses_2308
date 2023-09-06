require './lib/student'
require './lib/course'

class Course
  attr_reader :name, :capacity, :students

  def initialize(name, capacity)
    @name = name
    @capacity = capacity
    @students = []
  end

  def full?
    @students.count == @capacity
  end

  def enroll(student)
    if !full?
      @students << student
    # else
    #   puts "Can't enroll this student. Course is full."
    end
  end
end
