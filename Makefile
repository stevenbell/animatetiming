GHDL=ghdl
FLAGS="--std=08"

SRC=fulladder.vhd prop2.vhd test_carrylookahead.vhd # Source file(s)
TOP=test_ripplecarry # Top module to simulate
#SRC=test_timing.vhd
#TOP=test_timing
VCD=result.vcd # VCD file to write the results to

all:
	$(GHDL) -a $(FLAGS) $(SRC)
	$(GHDL) -e $(FLAGS) $(TOP)
	$(GHDL) -r $(FLAGS) $(TOP) --vcd=$(VCD)

frames:
	python animatetiming.py

gif:
	convert -delay 30 -loop 0 -dispose previous frame-*.png adder.gif

clean:
	rm frame-*.png adder.gif

