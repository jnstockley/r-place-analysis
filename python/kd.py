import csv

from python.placement import Placement

pic = [["0" for x in range(1490, 1563)] for y in range(612, 689)]

X_OFFSET = 1490
Y_OFFSET = 612

RUN_TIME = 637.47
TIME = 0
TIME_OFFSET = 145513.0

# pic[Y][X]

with open('data/bear_reduced.csv', 'r') as file:
    reader = csv.reader(file)

    for row in reader:
        if "time" in row:
            header = row
        else:
            if float(row[1]) > TIME + TIME_OFFSET + RUN_TIME:
                with open(f"data/bear-{TIME}-{TIME+RUN_TIME}.csv", "w+") as output:
                    writer = csv.writer(output, delimiter=',')
                    writer.writerows(pic)
                TIME += RUN_TIME
            row = Placement(row)
            pic[row.y_coordinate-Y_OFFSET][row.x_coordinate-X_OFFSET] = row.pixel_color
            # print(pic)
