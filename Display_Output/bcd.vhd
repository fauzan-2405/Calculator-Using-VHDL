-- LIBRARY
Library ieee;
USE ieee.std_logic_1164.all;

-- ENTITY
ENTITY bcd IS
	PORT (
		dig	 	: IN std_logic_vector (7 downto 0); -- Input dalam bentuk ASCII
		en_bcd	: OUT std_logic ;
		SevSeg	: OUT std_logic_vector (1 to 7)
		);
END bcd;

-- ARCHTECTURE 
ARCHITECTURE behavioral OF bcd IS
BEGIN
en_bcd <= '0';
SevSeg <=	"1111110" WHEN dig = "00101101" else -- MENUNJUKKAN TANDA MINUS		
				"0000001" WHEN dig = "00110000" else -- MENUNJUKKAN ANGKA 0
				"1001111" WHEN dig = "00110001" else -- MENUNJUKKAN ANGKA 1
				"0010010" WHEN dig = "00110010" else -- MENUNJUKKAN ANGKA 2
				"0000110" WHEN dig = "00110011" else -- MENUNJUKKAN ANGKA 3
				"1001100" WHEN dig = "00110100" else -- MENUNJUKKAN ANGKA 4
				"0100100" WHEN dig = "00110101" else -- MENUNJUKKAN ANGKA 5
				"0100000" WHEN dig = "00110110" else -- MENUNJUKKAN ANGKA 6
				"0001111" WHEN dig = "00110111" else -- MENUNJUKKAN ANGKA 7
				"0000000" WHEN dig = "00111000" else -- MENUNJUKKAN ANGKA 8
				"0000100" WHEN dig = "00111001" else -- MENUNJUKKAN ANGKA 9
				"1111111";
END behavioral;
