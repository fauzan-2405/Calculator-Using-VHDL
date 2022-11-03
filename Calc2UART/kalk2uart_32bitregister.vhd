library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity kalk2uart_32bitregister is
	port(
		Reset		: in std_logic;
		D1			: in std_logic_vector(7 downto 0);
		D2			: in std_logic_vector(7 downto 0);
		D3			: in std_logic_vector(7 downto 0);
		D4 		: in std_logic_vector(7 downto 0);
		Clock		: in std_logic;
		Enable	: in std_logic;
		out_paralel : out std_logic_vector(7 downto 0);
		sending : out std_logic
		);
end kalk2uart_32bitregister;

architecture RTL of kalk2uart_32bitregister is

	signal paralel_out : std_logic_vector(31 downto 0);
	signal count		: std_logic_vector(2 downto 0);
	signal s_sending		: std_logic;
	
begin
	process(Clock, Reset, D1, D2, D3, D4, Enable)
		begin
			if (enable ='0') OR (Reset= '1') then
				paralel_out <= (others => '-');
				count <= "---";
				s_sending <= '0';
			else
				if Clock = '1' and Clock'event then
						if count < "100"  then
							paralel_out(7 downto 0) <= "00000000";
							paralel_out(15 downto 8) <= paralel_out(7 downto 0);
							paralel_out(23 downto 16) <= paralel_out(15 downto 8);
							paralel_out(31 downto 24) <= paralel_out(23 downto 16);
							count <= count + "001";
							s_sending <= '1';
							out_paralel <= paralel_out(31 downto 24);
						elsif count = "100" then
							s_sending <= '0';
							out_paralel <= "--------";
							count <= "111";
						else
							paralel_out  <= D1 & D2 & D3 & D4;
							count <= "000";
							s_sending <= '0';
						end if;
				end if;
			end if;
	end process;
	
sending <= s_sending;

	
end architecture;
