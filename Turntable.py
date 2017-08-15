# Manually controls turn table, ZNB, matlab
# for testing and debug purpose.

import rohde_znb as rs
import LT360 as tt
import sys
import os
from time import sleep
from datetime import datetime
from socket import *
import errno


# Turntable manual test
lt = tt.spawn(ipAddr='10.0.1.253', port=9001)
#
#         #     # --------Set turn table to zeo position, turn turntable to certain degree--------------
# lt.zero()
# lt.velocity(1)


# ------------------------------------------------Manual rotation by step-------------------------------
# -----------------Set step size ----------------
lt.stepSize(10)


# -----------------Clockwise ----------------
# lt.stepCW()
# -----------------Conterclockwise ----------------
# lt.stepCCW()


# ------------------------------------------------Auto rotation -------------------------------
# lt.velocity(1)
# # -----------------Clockwise ----------------
# lt.cw(310)
lt.cw(0)
#
# # -----------------counterClockwise ----------------
# lt.ccw(0)
# lt.ccw(40)
#
sleep(2.1)
# if float(lt.position())<=180:
print(float(lt.position()))
# else:
    # print(float(lt.position())-360)