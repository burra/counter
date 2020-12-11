# Example how to make a coverage report with GHDL

##Requirements
ghdl
gcc
gcov
lcov

Analyze files

ghdl -a --std=08 -g -fprofile-arcs -ftest-coverage counter.vhd
ghdl -a --std=08 -g -fprofile-arcs -ftest-coverage counter_TB.vhd

Elaborate Testbench
ghdl -e --std=08 -Wl,-lgcov -Wl,--coverage counter_tb

Run the test bench code and make a GTKwave file
./counter_TB --wave=counter_TB.ghw

You will get two files:
.gcno and.gcda

lcov -t "counter_tb_coverage" -o covarage.info -c -d ./

Here covarage.info is my output file.

-t sets a test name\n
-o to specify the output file\n
-c to capture the coverage data\n
-d to specify the directory where the data files needs to be searched\n

genhtml -o res counter_tb_coverage.info
