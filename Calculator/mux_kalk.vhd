LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL; 
USE IEEE.std_logic_unsigned.ALL;

entity mux_kalk is
port(
--INPUT
	operator 	: in std_logic_vector(7 downto 0); --ASCII
	go_kalk 	: in std_logic;         -- Kalkulator siap dimulai
--OUTPUT
	enable_adder 	: out std_logic; -- Untuk mengaktifkan operasi penjumlahan
	enable_sub 		: out std_logic; -- Untuk mengaktifkan operasi pengurangan
	enable_mult 	: out std_logic; -- Untuk mengaktifkan operasi perkalian
	enable_div 		: out std_logic -- Untuk mengaktifkan operasi pembagian
);
end entity;

architecture behavioral of mux_kalk is
	signal s_adder : std_logic;
	signal s_sub : std_logic;
	signal s_mult : std_logic;
	signal s_div : std_logic;
begin
	process(operator, go_kalk)
	begin
	 if go_kalk = '1' then
	  if operator = "00101011" then --ADD
		s_adder <= '1';
		S_sub <= '0';
		s_mult <= '0';
		s_div <= '0';
	  elsif operator = "00101101" then --SUB
	  	s_adder <= '0';
		S_sub <= '1';
		s_mult <= '0';
		s_div <= '0';
		
	  elsif operator = "00101010" then --MULT
		s_adder <= '0';
		S_sub <= '0';
		s_mult <= '1';
		s_div <= '0';
	  elsif operator = "00101111" then --DIV
		s_adder <= '0';
		S_sub <= '0';
		s_mult <= '0';
		s_div <= '1';
	  end if;
	 else
		s_adder <= '0';
		S_sub <= '0';
		s_mult <= '0';
		s_div <= '0';
	 end if;
	end process;

enable_adder   <= s_adder;
enable_sub 		<= s_sub;
enable_mult  	<= s_mult;
enable_div  	<= s_div;

end behavioral;