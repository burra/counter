library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- required for unsigned type for counters

library std;
use std.env.finish;

-- make all components in library work visible
library work;
use work.all;

-- test benches has no inputs/outputs
entity counter_tb is
end entity counter_tb;

architecture logic of counter_tb is

signal reset, clk, load, pause, down: std_logic;
signal C_in, C_out: std_logic_vector(3 downto 0);

Constant P0: time := 20 ns;	--50 MHz
component counter is
port (reset, clk, load, pause, down: in std_logic;
	C_in:  in std_logic_vector(3 downto 0);
	C_out: out std_logic_vector(3 downto 0));
end component;

begin

DUT: counter
port map (reset=>reset, clk=>clk, load=>load, pause=>pause, down=>down,
C_in=>C_in, C_out=>C_out);

-- generate a clock
process	begin
clk<='0';
wait for P0/2;
clk<='1';
wait for P0/2;
end process;

process
begin

-- initialize all input signals
pause <='0';
load<='0';
down<='0';
C_in<=(others=>'0');

-- reset the counter
reset<='0';
wait for 100 ns;
reset <= '1';

-- count up
wait for 400 ns;

--pause
pause<='1';
wait for 400 ns;
report "Calling 'finish'";
finish;
--run again
pause<='0';
wait for 400 ns;

-- count down
down<='1';
wait for 400 ns;

-- load 12
C_in<=X"C";
load<='1';
wait for 20 ns;
load<='0';
wait for 400 ns;

report "Calling 'finish'";
finish;
end process;


end architecture logic;
