require './lib/student'
require './lib/course'

class Gradebook
  attr_reader :instructor, :courses

  def initialize(instructor)
    @instructor = instructor
    @courses = []
  end
  def add_course(course)
    @courses << course
  end
  def list_all_students
    @courses.map do |course|
      { course: course.students }
    end
  end
  def students_below(threshold)
    student_arr = []
    @courses.select do |course|
      course.students.select do |student|
        student_arr << student if student.grade < threshold
      end
    end
    student_arr
  end
end