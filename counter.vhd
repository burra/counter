library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port (reset, clk, load, pause, down: in std_logic;
	C_in:  in std_logic_vector(3 downto 0);
	C_out: out std_logic_vector(3 downto 0)
	);
end entity counter;

architecture logic of counter is

signal C_reg, C_next: unsigned(3 downto 0);

begin

process (reset, clk)
begin

if reset = '0' then
C_reg<=(others=>'0');
elsif rising_edge (clk) then
C_reg<=C_next;
end if;
	
end process;

C_next <= C_reg 	when pause = '1' else
	unsigned(C_in)  when load  = '1' else
	C_reg - 1 	when down  = '1' else
	C_reg + 1;
				 
C_out <= std_logic_vector(C_reg);

end architecture logic;