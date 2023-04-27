import csv
import pandas as pd

from python.placement import Placement

turkey_flag = []
mona_lisa = []
bear = []
guy_with_racecar = []
header = []

# Turkey
TURKEY_TOP_LEFT_X = 299
TURKEY_BOTTOM_RIGHT_X = 480
TURKEY_TOP_LEFT_Y = 343
TURKEY_BOTTOM_RIGHT_Y = 450

# Mona Lisa
MONA_LISA_TOP_LEFT_X = 1489
MONA_LISA_BOTTOM_RIGHT_X = 1576
MONA_LISA_TOP_LEFT_Y = 1289
MONA_LISA_BOTTOM_RIGHT_Y = 1359

# Bear
BEAR_TOP_LEFT_X = 1490
BREAR_BOTTOM_RIGHT_X = 1562
BEAR_TOP_LEFT_Y = 612
BEAR_BOTTOM_RIGHT_Y = 688

# Guy w/ Racecar
GUY_TOP_LEFT_X = 413
GUY_BOTTOM_RIGHT_X = 499
GUY_TOP_LEFT_Y = 1699
GUY_BOTTOM_RIGHT_Y = 1800

with open('data/data.csv', 'r') as file:
    reader = csv.reader(file)

    for row in reader:
        print(reader.line_num)
        if "timestamp" in row:
            header = row
        if "timestamp" not in row:
            row = Placement(row)
            # Turkey Flag
            if TURKEY_TOP_LEFT_X <= row.x_coordinate <= TURKEY_BOTTOM_RIGHT_X and TURKEY_TOP_LEFT_Y <= row.y_coordinate <= TURKEY_BOTTOM_RIGHT_Y:
                turkey_flag.append(
                    [row.timestamp, row.user_id, row.pixel_color, f"{row.x_coordinate},{row.y_coordinate}"])
            # Mona Lisa
            elif MONA_LISA_TOP_LEFT_X <= row.x_coordinate <= MONA_LISA_BOTTOM_RIGHT_X and MONA_LISA_TOP_LEFT_Y <= row.y_coordinate <= MONA_LISA_BOTTOM_RIGHT_Y:
                mona_lisa.append(
                    [row.timestamp, row.user_id, row.pixel_color, f"{row.x_coordinate},{row.y_coordinate}"])
            # Bear
            elif BEAR_TOP_LEFT_X <= row.x_coordinate <= BREAR_BOTTOM_RIGHT_X and BEAR_TOP_LEFT_Y <= row.y_coordinate <= BEAR_BOTTOM_RIGHT_Y:
                bear.append([row.timestamp, row.user_id, row.pixel_color, f"{row.x_coordinate},{row.y_coordinate}"])
            # Guy w/ Racecar
            elif GUY_TOP_LEFT_X <= row.x_coordinate <= GUY_BOTTOM_RIGHT_X and GUY_TOP_LEFT_Y <= row.y_coordinate <= GUY_BOTTOM_RIGHT_Y:
                guy_with_racecar.append(
                    [row.timestamp, row.user_id, row.pixel_color, f"{row.x_coordinate},{row.y_coordinate}"])

REGION_NAME = "turkey-flag"
pd.DataFrame(turkey_flag).to_csv(f"data/{REGION_NAME}.csv", index=False, header=header)
REGION_NAME = "mona-lisa"
pd.DataFrame(mona_lisa).to_csv(f"data/{REGION_NAME}.csv", index=False, header=header)
REGION_NAME = "bear"
pd.DataFrame(bear).to_csv(f"data/{REGION_NAME}.csv", index=False, header=header)
REGION_NAME = "guy-with-racecar"
pd.DataFrame(guy_with_racecar).to_csv(f"data/{REGION_NAME}.csv", index=False, header=header)
