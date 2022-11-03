library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bin_to_asc is
	port(
		bin_in	: in std_logic_vector(7 downto 0);
		enable	: in std_logic;
		clk		: in std_logic;
		out_asc	: out std_logic_vector(7 downto 0);
		finish_bin2asc : out std_logic
		);
end entity;

architecture converter of bin_to_asc is
	
	signal asc_out	: std_logic_vector(7 downto 0);
	
begin
	process(bin_in, clk)
	begin
	if rising_edge(clk) then
		if enable = '1' then
			if bin_in 	 = "00000000" then	--0
				asc_out 	<= "00110000";
			elsif bin_in = "00000001" then	--1
				asc_out 	<= "00110001";
			elsif bin_in = "00000010" then	--2
				asc_out	<= "00110010";
			elsif bin_in = "00000011" then	--3
				asc_out 	<=	"00110011";
			elsif bin_in = "00000100" then	--4
				asc_out	<= "00110100";
			elsif bin_in = "00000101" then	--5 
				asc_out 	<= "00110101";
			elsif bin_in = "00000110" then	--6
				asc_out	<= "00110110";
			elsif bin_in = "00000111" then	--7
				asc_out	<= "00110111";
			elsif bin_in = "00001000" then	--8
				asc_out	<= "00111000";
			elsif bin_in = "00001001" then	--9
				asc_out	<= "00111001";
			end if;
			
			finish_bin2asc <= '1';
		end if;
	end if;
	end process;
	
	out_asc <= asc_out;

end converter;

			
			
			
			