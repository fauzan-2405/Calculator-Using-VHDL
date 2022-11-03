LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL; 
USE IEEE.std_logic_unsigned.ALL;

entity sub is
port (
-- INPUT
	sign_1, sign_2			: in std_logic_vector (7 downto 0); -- Input tanda dari kedua operan
	operand_1, operand_2	: in std_logic_vector (7 downto 0); -- Input angka kedua operan
	en_sub       			: in std_logic;

-- OUTPUT
	sign_out					: out std_logic_vector (7 downto 0); -- Output sign hasil pengurangan kedua operan
	result					: out std_logic_vector (9 downto 0); -- Output hasil pengurangan kedua operan
	finish_kalk      		: out std_logic
);
end entity;

architecture behavioral of sub is
	signal s_result 		: std_logic_vector (9 downto 0);
	signal s_sign_out		: std_logic_vector (7 downto 0);
	signal s_finish_sub	: std_logic;
begin
process (en_sub, sign_1, sign_2, operand_1, operand_2, s_sign_out, s_result)
	begin
	if en_sub = '1' then
		-- Jika kedua operand memiliki tanda yang sama
		if (sign_1 = sign_2) then
			if (sign_1 = "00101101") then -- Minus
				if (unsigned(operand_1) > unsigned(operand_2)) then
					s_sign_out <= "00101101"; -- Minus
					s_result <= (("00" & unsigned(operand_1)) - ("00" & unsigned(operand_2)));
				else
					s_sign_out <= "00101011"; -- Plus
					s_result <= (("00" & unsigned(operand_2)) - ("00" & unsigned(operand_1)));
				end if;
				
			else	-- Plus
				if (unsigned(operand_1) > unsigned(operand_2)) then
					s_sign_out <= "00101011"; -- Plus
					s_result <= (("00" & unsigned(operand_1)) - ("00" & unsigned(operand_2)));
				else
					s_sign_out <= "00101101"; -- Minus
					s_result <= (("00" & unsigned(operand_2)) - ("00" & unsigned(operand_1)));
				end if;
			end if;
				
		-- Jike kedua operand memiliki tanda yang berbeda		
		else
			if (sign_2 = "00101101") then -- Minus
				s_sign_out <= "00101011"; -- Plus
				s_result <= (("00" & unsigned(operand_1)) + ("00" & unsigned(operand_2)));
			else -- Plus
				s_sign_out <= "00101101"; -- Minus
				s_result <= (("00" & unsigned(operand_1)) + ("00" & unsigned(operand_2)));
			end if;
		end if;
		
		-- Jika hasil pengurangan = 0, maka sign hasilnya menjadi (+)
		if s_result = "0000000000" then
			s_sign_out <= "00101011"; -- Plus
		end if;
		s_finish_sub <= '1';
	else
		s_finish_sub <= '0';
	end if;
		

end process;
	-- Output Generator
	result <= s_result;
	sign_out <= s_sign_out;
	finish_kalk <= s_finish_sub;
end behavioral;