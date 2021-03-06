module DailyNoteHelper
  def daily_note_student_name_class(student_note)
    if student_note.exempted_from_discipline
      'exempted-student-from-discipline'
    elsif !student_note.active
      'inactive-student'
    elsif student_note.exempted
      'exempted-student'
    elsif student_note.dependence
      'dependence-student'
    else
      ''
    end
  end

  def daily_note_student_name(student_note)
    if student_note.exempted_from_discipline
      "****#{student_note.student.to_s}"
    elsif !student_note.active
      "***#{student_note.student.to_s}"
    elsif student_note.exempted
      "**#{student_note.student.to_s}"
    elsif student_note.dependence
      "*#{student_note.student.to_s}"
    else
      "#{student_note.student.to_s}"
    end
  end
end
