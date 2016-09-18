# Makefile for Memory - Regression Testing 
RTL= ../rtl/counter.v
work= work #library name
COVOP= -coveropt 3 +cover +acc
SVTB1= ../env/counter_if.sv ../env/counter_assertion.sv ../env/top.sv
INC = +incdir+../env +incdir+../test
SVTB2 = ../env/counter_pkg.sv
TEST = ../test/test.sv
#TEST1 = ../test/test1.sv
#TEST2 = ../test/test2.sv
VSIMOPT= -coverage -novopt -sva -sv_seed 2475652473 work.top 
VSIMCOV= coverage save -onexit -assert -directive -cvg -codeAll counter_cov
VSIMBATCH= -c -do "$(VSIMCOV); run -all; exit"
VSIMBATCH1 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov1;run -all;exit"
VSIMBATCH2 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov2;run -all;exit"
VSIMBATCH3 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov3;run -all;exit"
VSIMBATCH4 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov4;run -all;exit"
VSIMBATCH5 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov5;run -all;exit"
VSIMBATCH6 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov6;run -all;exit"
VSIMBATCH7 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov7;run -all;exit"
VSIMBATCH8 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov8;run -all;exit"
VSIMBATCH9 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll counter_cov9;run -all;exit"


html:
	firefox covhtmlreport/pages/__frametop.htm

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(COVOP) $(RTL) $(SVTB2) $(SVTB1) $(INC) #$(TEST)
	
run_sim:
	vsim $(VSIMBATCH1) $(VSIMOPT) -l test1_sim.log +TEST1 +nowarn3829   
	vcover report -html counter_cov1   

run_testg:
	vsim -novopt -sva -sv_seed random work.top +TEST1
	clear

clean:
	rm -rf modelsim.* transcript* vlog.* work vsim.wlf counter_cov* fcover* covhtml* vcover* *.log
	clear

TC2:
	vsim  $(VSIMBATCH2) -coverage -novopt -sva -sv_seed 598761566 -l test2_sim.log work.top +TEST2
	vcover report -html counter_cov2
TC3:
	vsim  $(VSIMBATCH3) -coverage -novopt -sva -sv_seed 74473697 -l test3_sim.log work.top +TEST3
	vcover report -html counter_cov3
TC4:
	vsim  $(VSIMBATCH4) -coverage -novopt -sva -sv_seed 4275076933 -l test4_sim.log work.top +TEST4
	vcover report -html counter_cov4

TC5:
	vsim  $(VSIMBATCH5) -coverage -novopt -sva -sv_seed 3868229417 -l test5_sim.log work.top +TEST5
	vcover report -html counter_cov5

TC6:
	vsim  $(VSIMBATCH6) -coverage -novopt -sva -sv_seed 749764269 -l test6_sim.log work.top +TEST6
	vcover report -html counter_cov6

TC7:
	vsim  $(VSIMBATCH7) -coverage -novopt -sva -sv_seed 1982889551 -l test7_sim.log work.top +TEST7
	vcover report -html counter_cov7

TC8:
	vsim  $(VSIMBATCH8) -coverage -novopt -sva -sv_seed 1987083824 -l test8_sim.log work.top +TEST8
	vcover report -html counter_cov8

TC9:
	vsim  $(VSIMBATCH9) -coverage -novopt -sva -sv_seed 1987083824 -l test8_sim.log work.top +TEST9
	vcover report -html counter_cov9
report:
	vcover merge counter_cov counter_cov1 counter_cov2 #counter_cov3 counter_cov4 counter_cov5 counter_cov6 counter_cov7 
	vcover report -html counter_cov

regress: clean run_test TC2 report html #TC3 TC4 TC5 TC6 TC7 report html

gui:  
	vsim $(VSIMOPT)  -l test1_sim.log +TEST1 +nowarn3829  

run_gui: sv_cmp gui

run_test: clean sv_cmp run_sim
	

