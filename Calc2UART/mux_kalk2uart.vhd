library ieee;
use ieee.std_logic_1164.all;

entity MUX_KALK2UART is
	port(
	--INPUT
		in_sign	: in std_logic_vector(7 downto 0);
		in_dig1	: in std_logic_vector(7 downto 0);
		in_dig2	: in std_logic_vector(7 downto 0);
		in_dig3	: in std_logic_vector(7 downto 0);
	--Selector
		error				 : in std_logic;
		finish_bin2ascii : in std_logic;
	--OUTPUT
		out_reg1 : out std_logic_vector(7 downto 0);
		out_reg2 : out std_logic_vector(7 downto 0);
		out_reg3 : out std_logic_vector(7 downto 0);
		out_reg4 : out std_logic_vector(7 downto 0)
		);
end MUX_KALK2UART;

architecture RTL of MUX_KALK2UART is
	signal reg1: std_logic_vector(7 downto 0);
	signal reg2: std_logic_vector(7 downto 0);
	signal reg3: std_logic_vector(7 downto 0);
	signal reg4: std_logic_vector(7 downto 0);
	
begin
	process(error, finish_bin2ascii, in_sign,in_dig1, in_dig2, in_dig3)
	begin
	if error = '1' then
		reg1 <= "00100011"; -- ASCII : #
		reg2 <= "01000101"; -- ASCII : E
		reg2 <= "01010010"; -- ASCII : R
		reg3 <= "01010010"; -- ASCII : R

	elsif finish_bin2ascii ='1' then
			reg1 <= in_sign;
			reg2 <= in_dig1;
			reg3 <= in_dig2;
			reg4 <= in_dig3;
	end if;
end process;

		out_reg1 <= reg1;
		out_reg2 <= reg2;
		out_reg3 <= reg3;
		out_reg4 <= reg4;

end architecture;
