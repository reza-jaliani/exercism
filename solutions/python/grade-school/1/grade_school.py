class School:
    def __init__(self):
        self._grades = {}      # grade -> set of student names
        self._students = set() # all students in school
        self._added = []       # record of add attempts (True/False)

    def add_student(self, name, grade):
        # Student already exists anywhere in school
        if name in self._students:
            self._added.append(False)
            return

        # Add student
        self._students.add(name)
        self._grades.setdefault(grade, set()).add(name)
        self._added.append(True)

    def roster(self):
        result = []

        for grade in sorted(self._grades.keys()):
            result.extend(sorted(self._grades[grade]))

        return result

    def grade(self, grade_number):
        if grade_number not in self._grades:
            return []

        return sorted(self._grades[grade_number])

    def added(self):
        return self._added
