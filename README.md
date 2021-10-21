
# Dependencies
* [vcdvcd](https://github.com/cirosantilli/vcdvcd)
* [lxml](https://lxml.de/)

# Steps
1. Create an SVG file where each circuit node is in an SVG group, and give the group a unique (hopefully meaningful) name.
2. Create a VCD file (I use GHDL, but Verilog tools should work too) which records the timing behavior of the signals you care about
3. Create a JSON config file which associates the VCD signal names with the SVG groups
4. Run the `animatetiming.py` script


