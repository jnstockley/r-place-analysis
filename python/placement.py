class Placement:
    timestamp: str

    user_id: str

    pixel_color: str

    x_coordinate: int

    y_coordinate: int

    def __init__(self, placement: list):
        self.timestamp = placement[1]
        self.pixel_color = placement[3]
        coordinates = placement[2].split(",")
        self.x_coordinate = int(coordinates[0])
        self.y_coordinate = int(coordinates[1])

    def __repr__(self):
        return f"Timestamp: {self.timestamp}, Hashed User ID: {self.user_id}, Pixel Color: {self.pixel_color}, " \
               f"Coordinates: <{self.x_coordinate}, {self.y_coordinate}>"

    def __str__(self):
        return f"{self.timestamp},{self.user_id},{self.pixel_color}"