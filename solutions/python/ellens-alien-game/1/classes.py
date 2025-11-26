"""Solution to Ellen's Alien Game exercise."""


class Alien:
    """Create an Alien object with location x_coordinate and y_coordinate.

    Attributes
    ----------
    (class)total_aliens_created: int
    x_coordinate: int - Position on the x-axis.
    y_coordinate: int - Position on the y-axis.
    health: int - Number of health points.

    Methods
    -------
    hit(): Decrement Alien health by one point.
    is_alive(): Return a boolean for if Alien is alive (if health is > 0).
    teleport(new_x_coordinate, new_y_coordinate): Move Alien object to new coordinates.
    collision_detection(other): Implementation TBD.
    """

# 6. CLASS ATTRIBUTE (shared by all aliens)
    total_aliens_created = 0

    # 1. CONSTRUCTOR
    def __init__(self, x_coordinate, y_coordinate):
        self.x_coordinate = x_coordinate
        self.y_coordinate = y_coordinate
        self.health = 3

        # When an Alien is created, increase the class counter
        Alien.total_aliens_created += 1

    # 2. HIT METHOD
    def hit(self):
        self.health -= 1

    # 3. IS_ALIVE METHOD
    def is_alive(self):
        return self.health > 0

    # 4. TELEPORT METHOD
    def teleport(self, new_x_coordinate, new_y_coordinate):
        self.x_coordinate = new_x_coordinate
        self.y_coordinate = new_y_coordinate

    # 5. COLLISION DETECTION (placeholder)
    def collision_detection(self, other):
        pass


# 7. Standalone function — create a list of Aliens from a list of coordinates
def new_aliens_collection(positions):
    return [Alien(x, y) for (x, y) in positions]