library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity parser_3digit is
	port(
	--INPUT
		in_data			 : in std_logic_vector(9 downto 0);
		en_BIN2ASCII	 : in std_logic;
		clock 			 : in std_logic;

	--OUTPUT
		dig1				 : out std_logic_vector(7 downto 0);
		dig2			    : out std_logic_vector(7 downto 0);
		dig3				 : out std_logic_vector(7 downto 0);
		finish			 : out std_logic
		);
end parser_3digit;

architecture RTL of parser_3digit is
	
	signal count_ratusan	  		: std_logic_vector(9 downto 0);
	signal count_puluhan 		: std_logic_vector(9 downto 0);
	signal sisa				   	: std_logic_vector(9 downto 0);
	signal first_load				: std_logic;
	signal parse_finished		: std_logic;
	
begin
	process(in_data, clock, en_bin2ascii)
	begin
	
	if en_BIN2ASCII ='1' then
		if parse_finished = '0' then
			if rising_edge(clock) then
				if first_load = '0' then
					if (in_data > "0001100100") or (in_data = "0001100100") then
						sisa <= in_data - "0001100100";
						count_ratusan <= count_ratusan + "0000000001";
						first_load <= '1';
					elsif (in_data > "0000001010") or (in_data = "0000001010") then
						sisa <= in_data - "0000001010";
						count_puluhan <= count_puluhan + "0000000001";
						first_load <= '1';
					else
						parse_finished <= '1';
					end if;
		
				else
					if (sisa > "0001100100") or (sisa = "0001100100") then
						sisa <= sisa - "0001100100";
						count_ratusan <= count_ratusan + "0000000001";
					elsif (sisa > "0000001010") or (sisa = "0000001010") then
						sisa <= sisa - "0000001010";
						count_puluhan <= count_puluhan + "0000000001";
					else
						parse_finished <= '1';
					end if;
				end if; --first load
			end if; -- clock
		end if; --parse finished
	else
		count_ratusan 	 <= "0000000000";
		count_puluhan	 <= "0000000000";
		sisa 			  	 <= "0000000000";
		first_load 	  	 <= '0';
		parse_finished  <= '0';

	end if;
end process;

dig1 <= count_ratusan(7 downto 0);
dig2 <= count_puluhan(7 downto 0);
dig3 <= sisa(7 downto 0);
finish <= parse_finished;
					
end architecture;
