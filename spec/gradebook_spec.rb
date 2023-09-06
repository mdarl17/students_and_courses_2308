require './lib/student'
require './lib/course'
require './lib/gradebook'

describe Gradebook do
  it 'exists' do
    gradebook = Gradebook.new("Mr. Wendell")
    expect(gradebook).to be_a(Gradebook)
  end

  it 'has attributes' do
    gradebook = Gradebook.new("Mr. Wendell")
    expect(gradebook.instructor).to eq("Mr. Wendell")
    expect(gradebook.courses).to eq([])
  end

  it 'can #addcourse' do
    gradebook = Gradebook.new("Mr. Wendell")
    course = Course.new("Calculus", 2)
    gradebook.add_course(course)
    expect(gradebook.courses[0]).to be_a Course
    expect(gradebook.courses.count).to eq(1)
  end

  it 'can #list_all_students' do
    gradebook = Gradebook.new("Mr. Wendell")
    course = Course.new("Calculus", 2)
    gradebook.add_course(course)
    student1 = Student.new({name: "Morgan", age: 21})
    student2 = Student.new({name: "Jordan", age: 29})
    course.enroll(student1)
    course.enroll(student2)

    expect(gradebook.list_all_students).to eq([{course: course.students}])
    expect(gradebook.list_all_students[0][:course].count).to eq(2)
  end

  it 'can list all students below a given grade threshold' do
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
    
    expect(gradebook.students_below(70)).to eq([student2])
  end
end