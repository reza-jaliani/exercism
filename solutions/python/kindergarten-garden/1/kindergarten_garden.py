class Garden:
    PLANTS = {
        "G": "Grass",
        "C": "Clover",
        "R": "Radishes",
        "V": "Violets",
    }

    DEFAULT_STUDENTS = [
        "Alice", "Bob", "Charlie", "David", "Eve", "Fred",
        "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"
    ]

    def __init__(self, diagram, students=None):
        self.rows = diagram.split("\n")

        if students is None:
            self.students = self.DEFAULT_STUDENTS
        else:
            self.students = sorted(students)

    def plants(self, student):
        index = self.students.index(student)
        start = index * 2

        letters = (
            self.rows[0][start:start + 2] +
            self.rows[1][start:start + 2]
        )

        return [self.PLANTS[letter] for letter in letters]
