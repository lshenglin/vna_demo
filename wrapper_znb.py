import rohde_znb as rs
import LT360 as tt
import sys
import os
from time import sleep
from datetime import datetime


angle_step = 10
angle_list  = [ angle_step  * x for x in range(360/angle_step)]
START_FREQ = 3e9
END_FREQ = 8e9
STEP_SIZE = 1000000
timestamp = datetime.now().strftime("%Y_%m_%d_%H_%M_%S")
file_location = "~/Documents/R1/"
file_name = 'Sparameter_' + timestamp + '.csv'
res_file = os.path.expanduser(file_location) + file_name
output=open(res_file,'w')
tr_name = ['CH1Tr1','CH1Tr2','CH1Tr3']
meas_obj = ['S14','S24','S34']


znb = rs.spawn('10.0.1.3')
lt = tt.spawn(ipAddr='10.0.1.253',port =9001)

znb.set_freq_range(START_FREQ,END_FREQ)
znb.set_sweep_params(STEP_SIZE,auto=1)

#--------Set turn table to zeo position, turn turntable to certain degree--------------
lt.zero()
output.write("Angle,Freq[Hz],")
for i in range(len(tr_name)):
	output.write("%s_%s_re,%s_%s_im," % (tr_name[i],meas_obj[i],tr_name[i],meas_obj[i]))
output.write("\n")

for angle in angle_list:
	lt.ccw(angle)
	print "Turn table set to %s degree\n" % angle
	sleep(3)
#--------Create New trace for S21,31,41 measurement, trace name format should follow 'CH#Tr#'------------
	znb.delete_all_trace()
	for i in range(len(tr_name)):
		znb.create_new_trace(tr_name[i],meas_obj[i])

#--------Set sweep to single mode nad start sweep once-------------
	znb.set_sweep_control(1,single=True)
	sleep(2)
	re,im = [[],[],[]],[[],[],[]]
	for i in range(len(tr_name)):
		znb.select_active_trace(tr_name[i])
		re[i],im[i] = znb.save_trace_data()
		znb.update_display('ON')
	# znb.save_trace_data_local('CH1Tr1','C:\Users\Public\Documents\Rohde-Schwarz\Vna\Traces\Trc100.dat')
	# znb.save_trace_data_local('CH1Tr2','C:\Users\Public\Documents\Rohde-Schwarz\Vna\Traces\Trc101.dat')
	# znb.save_trace_data_local('CH1Tr3','C:\Users\Public\Documents\Rohde-Schwarz\Vna\Traces\Trc102.dat')
	
	for i in range(len(re[0])):
		output.write("%.15f,%.15f," % (angle,START_FREQ+STEP_SIZE*i))	
		for j in range(len(tr_name)):
	 	#print"%f,%f,%f\n" % (START_FREQ+STEP_SIZE*i,re[i],im[i])
	 		output.write("%.15f,%.15f," % (re[j][i],im[j][i]))
		output.write("\n")
#data = znb.interpret("TRAC? CH1DATA").split(',')
output.close()



