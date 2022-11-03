LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL; 
USE IEEE.std_logic_unsigned.ALL;

entity toplevel_bcd is
port(
	-- INPUT
	dig1	: in std_logic_vector (7 downto 0); -- Input digit ratusan
	dig2	: in std_logic_vector (7 downto 0); -- Input digit puluhan
	dig3	: in std_logic_vector (7 downto 0); -- Input digit satuan
	sign	: in std_logic_vector (7 downto 0); -- Input sign hasil

	-- OUTPUT
	seg1	: out std_logic_vector (1 to 7); -- Output segmen display 1 (sign)
	seg2	: out std_logic_vector (1 to 7); -- Output segmen display 2 (digit ratusan)
	seg3	: out std_logic_vector (1 to 7); -- Output segmen display 3 (digit puluhan) 		
	seg4	: out std_logic_vector (1 to 7); -- Output segmen display 4 (digit ratusan)
	en_bcd1, en_bcd2, en_bcd3, en_bcd4 : out std_logic -- output display mana yg ingin digunakan 
);
end toplevel_bcd;

architecture behavioral of toplevel_bcd is
	component bcd is
	port(
		dig	 	: IN std_logic_vector (7 downto 0); -- Input dalam bentuk ASCII
		en_bcd	: OUT std_logic ;
		SevSeg	: OUT std_logic_vector (1 to 7)
	);
	end component;

begin
	-- Sign
	display_1 : bcd
	port map(
		dig	 	=> sign,
		en_bcd	=> en_bcd1,
		SevSeg	=> seg1
	);
	
	-- Digit ratusan
	display_2 : bcd
	port map(
		dig	 	=> dig1,
		en_bcd	=> en_bcd2,
		SevSeg	=> seg2
	);

	-- Digit puluhan
	display_3 : bcd
	port map(
		dig	 	=> dig2,
		en_bcd	=> en_bcd3,
		SevSeg	=> seg3
	);
	
 	-- Digit satuan
	display_4 : bcd
	port map(
		dig	 	=> dig3,
		en_bcd	=> en_bcd4,
		SevSeg	=> seg4
	);

end behavioral;