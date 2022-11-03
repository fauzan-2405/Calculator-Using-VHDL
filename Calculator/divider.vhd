library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity divider is
 port(
 --INPUT
	  operand_1, operand_2 	: in std_logic_vector(7 downto 0);
	  sign_1, sign_2   		: in std_logic_vector(7 downto 0);
	  en_div      				: in std_logic;
	  clock       				: in std_logic;

 --OUTPUT
	  result     				: out std_logic_vector(9 downto 0);
	  sign_out       			: out std_logic_vector(7 downto 0);
	  finish_kalk   			: out std_logic
  );
end divider;

architecture RTL of divider is
 
	 signal count       		: std_logic_vector(9 downto 0);
	 signal sisa       		: std_logic_vector(7 downto 0);
	 signal sign    	  		: std_logic_vector(7 downto 0);
	 signal first_load   	: std_logic;
	 signal num_finished    : std_logic;
	 signal sign_finished   : std_logic;
	 
begin
 process(operand_1, operand_2, sign_1, sign_2, clock, en_div)
 begin
	 if en_div ='1' then
		if rising_edge(clock) then
			if first_load = '1' then
				if (sisa > operand_2) or (sisa = operand_2) then
					sisa <= sisa - operand_2;
					count <= count + "0000000001";
				else
					num_finished <= '1';
				end if;
				
			else --first_load = '0'
				first_load <= '1';
				if (sign_1 = sign_2) then
					sign <= "00101011";
					sign_finished <= '1';
				else --beda tanda
					sign <= "00101101";
					sign_finished <= '1';
				end if;
				
			if (operand_1 > operand_2) or (operand_1 = operand_2) then
				sisa <= operand_1 - operand_2;
				count <= "0000000001";
			else
				count <= "0000000000";
				sisa  <= "00000000";
				num_finished <= '1';
			end if;
		end if;
		end if;
	 else --ketika enable = '0'
		count <= "0000000000";
		sisa  <= "00000000";
		first_load <= '0';
		num_finished <= '0';
		sign_finished <= '0';
	 end if;
	 
end process;
	 -- Output Generator
	 result <= count;
	 sign_out <= sign;
	 finish_kalk <= (num_finished) and (sign_finished);     
end architecture;