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

  def all_grades
    scores_by_course = Hash.new(nil)
    @courses.each do |course|
      scores = course.students.map do |student|
        student.scores
      end
      scores_by_course[course] = scores.flatten
    end
    scores_by_course
  end
  
  def students_in_range(min, max)
    students_in_thresh = []
    all_grades_obj = all_grades
    all_grades_obj.each do |course, grades|
      course.students.each do |student|
        students_in_thresh << student if student.grade > min && student.grade < max
      end
    end
    students_in_thresh
  end
end

gradebook = Gradebook.new("Mr. Wendell")
course = Course.new("Calculus", 2)
gradebook.add_course(course)
student1 = Student.new({name: "Morgan", age: 21})
student2 = Student.new({name: "Jordan", age: 29})
course.enroll(student1)
course.enroll(student2)
student1.log_score(89)
student1.log_score(78)
student2.log_score(60)
student2.log_score(70)

p gradebook.all_grades
gradebook.students_in_range(85, 100).each do |student|
  p "In range: #{student.name} with a score of #{student.grade}"
end

p student1.grade
p student2.grade
