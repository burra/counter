# Example how to make a coverage report with GHDL

Dependencies: the ones from Arch-Linux stable repo works.

* ghdl v0.37 built with gcc 10.2.0
* gcc v10.2.0
* gcov v10.2.0
* lcov v1.15



Analyze files


* ghdl -a --std=08 -g -fprofile-arcs -ftest-coverage counter.vhd
* ghdl -a --std=08 -g -fprofile-arcs -ftest-coverage counter_tb.vhd

Elaborate Testbench


ghdl -e --std=08 -Wl,-lgcov -Wl,--coverage counter_tb

Run the test bench code and make a GTKwave file


./counter_tb --wave=counter_tb.ghw

You will get two files:


.gcno and .gcda

lcov -t "counter_tb_coverage" -o counter_tb_coverage.info -c -d ./



Here covarage.info is my output file.

* -t sets a test name
* -o to specify the output file
* -c to capture the coverage data
* -d to specify the directory where the data files needs to be searched

genhtml -o coverage_report counter_tb_coverage.info

## TODO ## make build script
