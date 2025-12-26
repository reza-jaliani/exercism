NORTH = "north"
EAST = "east"
SOUTH = "south"
WEST = "west"


class Robot:
    def __init__(self, direction, x, y):
        self.direction = direction
        self.x = x
        self.y = y

    @property
    def coordinates(self):
        return (self.x, self.y)

    def move(self, instructions):
        directions = [NORTH, EAST, SOUTH, WEST]

        for instruction in instructions:
            if instruction == "R":
                idx = directions.index(self.direction)
                self.direction = directions[(idx + 1) % 4]

            elif instruction == "L":
                idx = directions.index(self.direction)
                self.direction = directions[(idx - 1) % 4]

            elif instruction == "A":
                if self.direction == NORTH:
                    self.y += 1
                elif self.direction == SOUTH:
                    self.y -= 1
                elif self.direction == EAST:
                    self.x += 1
                elif self.direction == WEST:
                    self.x -= 1
