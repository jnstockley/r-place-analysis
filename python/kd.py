import csv
import pandas as pd

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


pic = [["0" for x in range(1490, 1563)] for y in range(612, 689)]

X_OFFSET = 1490
Y_OFFSET = 612

RUN_TIME = 637.47
TIME = 0
TIME_OFFSET = 145513.0

# pic[Y][X]


with open('../data/bear_reduced.csv', 'r') as file:
    reader = csv.reader(file)

    for row in reader:
        if "time" in row:
            header = row
        else:
            if float(row[1]) > TIME + TIME_OFFSET + RUN_TIME:
                with open(f"bear-{TIME}-{TIME+RUN_TIME}.csv", "w+") as output:
                    writer = csv.writer(output, delimiter=',')
                    writer.writerows(pic)
                TIME += RUN_TIME
            row = Placement(row)
            pic[row.y_coordinate-Y_OFFSET][row.x_coordinate-X_OFFSET] = row.pixel_color
            # print(pic)
