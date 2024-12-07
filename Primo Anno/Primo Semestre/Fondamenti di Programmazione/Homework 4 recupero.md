**Traccia:**
One of the mechanisms used to store and manage large quantities of
data is databases. There are many types of databases, but the one that
has revolutionized the sector is the database organized according to
the relational model theorized by Codd half a century ago. According
to this model, the data are arranged in tables in direct relation, to
optimize memory requirements, promote data consistency and minimize
errors.

We need to design a set of functions that implements a simple
relational database for a training school, with four tables, namely
students, teachers, courses, and exams. The databases can be of three
sizes: small, medium, and large. The database tables of size dbsize
are in four JSON files \<dbsize>\_\<table name>.json (for example, the
small DB consists of the files small_students.json,
small_teachers.json, small_courses.json, and small_exams.json). The
tables are implemented as lists of dictionaries (see, for example, the
file small_students.json) and have the following structures:
   - students: keys stud_code, stud_name, stud_surname, stud_email
   - teachers: keys teach_code, teach_name, teach_surname, teach_email
   - courses: keys course_code, course_name, teach_code
   - exams: keys exam_code, course_code, stud_code, date, grade.
The relationship between the tables implies that each row in each of
the tables have a reference to another table: an exam (exam_code)
corresponds to a grade given by the teacher (teach_code) to a student
(stud_code) for having taken an exam of a given course (course_code)
in a certain date. Every student can have taken several exams. Every
teacher can be responsible for several courses. However, exactly
one teacher is responsible for every course.

The field stud_code is the primary key for the students table since
it uniquely identifies a student; namely no two students have the same
stud_code. Similarly, teach_code is the primary key for the teachers table,
course_code for the courses table and exam_code for the exams tables.
Thus, they are used to realize the relationships between the tables.

The fields in all tables are never empty.

We must realize some functions to query databases of different sizes.
Then, every function always requires a 'dbsize' string type parameter, which can assume the values 'small,' 'medium,' and 'large.'
The functions are:

   \ - student_average(stud_code, dbsize), which receives the code of
      a student and returns the average of the grades of the exams
      taken by the student.

   \ - course_average(course_code, dbsize), which receives the code of
      a course and returns the average grade of the exams for that
      course, taken by all students.

   \ - teacher_average(teach_code, dbsize), which receives the code of
      a teacher and returns the average grade for all the exams taken
      in all of the teacher's courses.

   \ - top_students(dbisze), which returns the list of the 'stud_code's
      of those students with an average of taken exams, greater than
      or equal to 28. The stud_codes are sorted in descending order by
      average grade and, in case of a tie, in lexicographic order by
      the student's last name and first name, finally the stud_code
      in ascending order.

   \ - print_recorded_exams(stud_code, dbsize, fileout), which receives a
      stud_code of a student and saves in fileout the list of the exams
      taken by that student. The rows are sorted in ascending
      order by date of exam taken and, in case of the same date, by
      alphabetical order of the exam names. The file has an initial line
      with the text
"Exams taken by student <stud_surname> <stud_name>, student number <stud_code>",
      while the following lines have the following structure:
"<course_name>t\<date>\t\<grade>",
      where the fields are aligned with the longest course name (i.e. all
      dates and grades are vertically aligned). The function returns the
      number of exams taken by the student.

   \ - print_top_students(dbsize, fileout), which saves in fileout a
      row for each student with an average grade greater than or equal
      to 28. The rows in the file are in descending order by average
      grade and, in case of a tie, in lexicographic order by the
      student's last name and first name.
      The rows in the file have the following structure:
"<stud_surname> \<names>\t\<average>",
      where the average values are vertically aligned for all rows. The
      function returns the number of rows saved in the file.

   \ - print_exam_record(exam_code, dbsize, fileout), which receives an
      exam_code of an exam and saves in fileout the information about that
      exam, using the following formula
"The student <stud_surname> <stud_name>, student number <stud_code>, took on \<date> the <course_name> exam with the teacher <teach_surname> <teach_name> with grade \<grade>."
      The function returns the exam grade associated with the exam_code
      received as input.

All averages are rounded to the second decimal place, before any sorting.
All files must have "utf8" encoding.
To easily print aligned rows, consider the format function with the
modifiers for alignment (https://pyformat.info/#string_pad_align)



**Mia Soluzione**:
```python
import json


def open_exams(dbsize):
    with open(f'{dbsize}_exams.json', encoding='utf-8') as json_file:
        return json.load(json_file)


def open_teachers(dbsize):
    with open(f'{dbsize}_teachers.json', encoding='utf-8') as json_file:
        return json.load(json_file)


def open_students(dbsize):
    with open(f'{dbsize}_students.json', encoding='utf-8') as json_file:
        return json.load(json_file)


def open_courses(dbsize):
    with open(f'{dbsize}_courses.json', encoding='utf-8') as json_file:
        return json.load(json_file)


def media_studente(stud_code, dbsize):
    exams = open_exams(dbsize)
    tot = 0
    i = 0
    for exam in exams:
        if exam['stud_code'] == stud_code:
            tot += exam['grade']
            i += 1
    return round(tot / i, 2)


def media_corso(course_code, dbsize):
    exams = open_exams(dbsize)
    tot, i, = 0, 0
    for exam in exams:
        if exam['course_code'] == course_code:
            tot += exam['grade']
            i += 1
    return round(tot / i, 2)


def media_docente(teach_code, dbsize):
    courses = open_courses(dbsize)
    exams = open_exams(dbsize)

    courses_codes = []

    for course in courses:
        if course['teach_code'] == teach_code:
            courses_codes.append(course['course_code'])

    tot, i = 0, 0

    for exam in exams:
        if exam['course_code'] in courses_codes:
            tot += exam['grade']
            i += 1

    return round(tot / i, 2)


def studenti_brillanti(dbsize):
    students = open_students(dbsize)
    exams = open_exams(dbsize)

    all_students = {}
    for student in students:
        all_students[student['stud_code']] = [[], student['stud_surname'], student['stud_name']]

    for exam in exams:
        all_students[exam['stud_code']][0].append(exam['grade'])

    brillanti = {}
    for student in all_students:
        media = round(sum(all_students[student][0]) / len(all_students[student][0]), 2)
        if media >= 28:
            brillanti[student] = [media, all_students[student][1], all_students[student][2]]

    brillanti = [key for key in sorted(brillanti, key=lambda x: (-brillanti[x][0], brillanti[x][1], brillanti[x][2],
                                                                 x))]

    return brillanti


def stampa_verbale(exam_code, dbsize, fileout):
    exams = open_exams(dbsize)
    new_exams = {}
    for exam in exams:
        new_exams[exam['exam_code']] = [exam['course_code'], exam['stud_code'], exam['date'], exam['grade']]

    students = open_students(dbsize)
    new_students = {}
    for student in students:
        new_students[student['stud_code']] = [student['stud_name'], student['stud_surname'], student['stud_email']]

    courses = open_courses(dbsize)
    new_courses = {}
    for course in courses:
        new_courses[course['course_code']] = [course['course_name'], course['teach_code']]

    teachers = open_teachers(dbsize)
    new_teachers = {}
    for teacher in teachers:
        new_teachers[teacher['teach_code']] = [teacher['teach_name'], teacher['teach_surname'],
                                               teacher['teach_email']]

    to_print = ''

    for exam in new_exams:
        if exam == exam_code:
            matricola = new_exams[exam][1]
            nome = new_students[matricola][0]
            cognome = new_students[matricola][1]
            data = new_exams[exam][2]
            codice_corso = new_exams[exam][0]
            nome_corso = new_courses[codice_corso][0]
            codice_docente = new_courses[codice_corso][1]
            nome_docente = new_teachers[codice_docente][0]
            cognome_docente = new_teachers[codice_docente][1]
            grade = new_exams[exam][3]
            to_print += (f'Lo studente {nome} {cognome}, matricola {matricola}, ha sostenuto in data {data} l\'esame di'
                         f' {nome_corso} con il docente {nome_docente} {cognome_docente} con votazione {grade}.\n')

    with open(fileout, 'w', encoding='utf-8') as file:
        file.write(to_print)

    return grade


def stampa_esami_sostenuti(stud_code, dbsize, fileout):
    students = open_students(dbsize)
    for student in students:
        if student['stud_code'] == stud_code:
            name = student['stud_name']
            surname = student['stud_surname']

    to_print = f'Esami sostenuti dallo studente {surname} {name}, matricola {stud_code}\n'

    exams = open_exams(dbsize)
    new_exams = {}
    for exam in exams:
        new_exams[exam['exam_code']] = [exam['course_code'], exam['stud_code'], exam['date'], exam['grade']]

    courses = open_courses(dbsize)
    new_courses = {}
    for course in courses:
        new_courses[course['course_code']] = [course['course_name'], course['teach_code']]

    esami_sostenuti = []
    for exam in new_exams:
        if new_exams[exam][1] == stud_code:
            esami_sostenuti.append([new_courses[new_exams[exam][0]][0], new_exams[exam][2], new_exams[exam][3]])

    esami_sostenuti = sorted(esami_sostenuti, key=lambda x: (x[1], x))

    max = 0
    for exam in esami_sostenuti:
        if len(exam[0]) > max:
            max = len(exam[0])
    for exam in esami_sostenuti:
        line = f'{exam[0]}'
        while len(line) < max:
            line += ' '
        to_print += f'{line}\t{exam[1]}\t{exam[2]}\n'

    with open(fileout, 'w', encoding='utf-8') as file:
        file.write(to_print)

    return len(esami_sostenuti)


def stampa_studenti_brillanti(dbsize, fileout):
    students = open_students(dbsize)
    exams = open_exams(dbsize)

    all_students = {}
    for student in students:
        all_students[student['stud_code']] = [[], student['stud_surname'], student['stud_name']]

    for exam in exams:
        all_students[exam['stud_code']][0].append(exam['grade'])

    brillanti = {}
    for student in all_students:
        media = round(sum(all_students[student][0]) / len(all_students[student][0]), 2)
        if media >= 28:
            brillanti[student] = [media, all_students[student][1], all_students[student][2]]

    brillanti = {k: v for k, v in
                 sorted(brillanti.items(), key=lambda x: (-x[1][0], x[1][1], x[1][2], x[0]))}

    to_print = ''
    maxl = len(max([f'{elem[1]} {elem[2]}' for elem in brillanti.values()], key=len))

    for student in brillanti:
        line = f'{brillanti[student][1]} {brillanti[student][2]}'
        to_print += line + ' ' * (maxl - len(line)) + '\t' + str(brillanti[student][0]) + '\n'

    with open(fileout, 'w', encoding='utf-8') as file:
        file.write(to_print)

    return len(brillanti)
```