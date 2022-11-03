LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL; 
USE IEEE.std_logic_unsigned.ALL;

entity top_kalk is
port(
	-- INPUT
	in_operator 					: in std_logic_vector (7 downto 0); -- Input operator operasi
	in_operand_1, in_operand_2	: in std_logic_vector (7 downto 0); -- Input angka yang akan dikalkulasi
	in_sign_1, in_sign_2			: in std_logic_vector (7 downto 0); -- Input sign angka yang akan dikalkulasi
	in_go_kalk						: in std_logic; -- Penanda bahwa kalkulator siap digunakan
	clk 								: in std_logic;
	-- OUTPUT
	out_sign						: out std_logic_vector (7 downto 0); -- Output tanda angka yang telah dikalkulasi
	out_result					: out std_logic_vector (9 downto 0); -- Output hasil yang telah dikalkulasi
	out_finish_kalk			: out std_logic -- Penanda bahwa kalkulator telah selesai digunakan
);
end top_kalk;

architecture behavioral of top_kalk is
	component mux_kalk is
	port(
		operator 	: in std_logic_vector(7 downto 0); 
		go_kalk 		: in std_logic;         

		enable_adder 	: out std_logic; 
		enable_sub 		: out std_logic; 
		enable_mult 	: out std_logic; 
		enable_div 		: out std_logic 
	);
	end component;
	
	component adder is
	port(
		sign_1, sign_2    	: in std_logic_vector (7 downto 0); 
		operand_1, operand_2 : in std_logic_vector (7 downto 0); 
		en_adder       		: in std_logic;

		sign_out       		: out std_logic_vector (7 downto 0);
		result         		: out std_logic_vector (9 downto 0); 
		finish_kalk      		: out std_logic
	);
	end component;
	
	component sub is
	port(
		sign_1, sign_2    	: in std_logic_vector (7 downto 0); 
		operand_1, operand_2 : in std_logic_vector (7 downto 0); 
		en_sub	      		: in std_logic;
	 
		sign_out       		: out std_logic_vector (7 downto 0); 
		result         		: out std_logic_vector (9 downto 0); 
		finish_kalk      		: out std_logic
	);
	end component;
	
	component mult is
	port(
		sign_1, sign_2    	: in std_logic_vector (7 downto 0); 
		operand_1, operand_2 : in std_logic_vector (7 downto 0); 
		en_mult	      		: in std_logic;
	 
		sign_out       		: out std_logic_vector (7 downto 0); 
		result         		: out std_logic_vector (9 downto 0); 
		finish_kalk      		: out std_logic
	);
	end component;

	component divider is
	port(
		operand_1, operand_2	: in std_logic_vector(7 downto 0);
		sign_1, sign_2			: in std_logic_vector(7 downto 0);
		en_div			 		: in std_logic;
		clock 			 		: in std_logic;

		result			 		: out std_logic_vector(9 downto 0);
		sign_out		    		: out std_logic_vector(7 downto 0);
		finish_kalk				: out std_logic
	);
	end component;
	
	-- SIGNAL 
	signal s_enable_adder, s_enable_sub, s_enable_mult, s_enable_div : std_logic;
	signal s_result			: std_logic_vector (9 downto 0);
	signal s_sign_out			: std_logic_vector (7 downto 0);
	signal s_sign_out_add 	: std_logic_vector (7 downto 0);
	signal s_result_add		: std_logic_vector (9 downto 0);
	signal s_sign_out_sub	: std_logic_vector (7 downto 0);
	signal s_result_sub		: std_logic_vector (9 downto 0);
	signal s_sign_out_mult	: std_logic_vector (7 downto 0);
	signal s_result_mult		: std_logic_vector (9 downto 0);
	signal s_sign_out_div 	: std_logic_vector (7 downto 0);
	signal s_result_div		: std_logic_vector (9 downto 0);
	signal s_finish_kalk_add, s_finish_kalk_sub, s_finish_kalk_mult, s_finish_kalk_div		: std_logic;
	
begin
	mux_kalkulator : mux_kalk
	port map(
		operator 		=> in_operator,
		go_kalk 			=> in_go_kalk,
		enable_adder	=> s_enable_adder,
		enable_sub 		=> s_enable_sub,
		enable_mult 	=> s_enable_mult,
		enable_div		=> s_enable_div
	);
	
	penjumlahan : adder
	port map(
		sign_1	    	=> in_sign_1,
		sign_2			=> in_sign_2,
		operand_1		=> in_operand_1,
		operand_2		=> in_operand_2,
		en_adder       => s_enable_adder,
		sign_out       => s_sign_out_add,
		result         => s_result_add, 
		finish_kalk    => s_finish_kalk_add
	);
	
	pengurangan : sub
	port map(
		sign_1	    	=> in_sign_1,
		sign_2			=> in_sign_2,
		operand_1		=> in_operand_1,
		operand_2		=> in_operand_2,
		en_sub       	=> s_enable_sub,
		sign_out       => s_sign_out_sub,
		result         => s_result_sub,  
		finish_kalk    => s_finish_kalk_sub
	);
	
	perkalian : mult
	port map(
		sign_1	    	=> in_sign_1,
		sign_2			=> in_sign_2,
		operand_1		=> in_operand_1,
		operand_2		=> in_operand_2,
		en_mult       	=> s_enable_mult,
		sign_out       => s_sign_out_mult,
		result         => s_result_mult, 
		finish_kalk    => s_finish_kalk_mult
	);
	
	pembagian : divider
	port map(
		sign_1	    	=> in_sign_1,
		sign_2			=> in_sign_2,
		operand_1		=> in_operand_1,
		operand_2		=> in_operand_2,
		en_div       	=> s_enable_div,
		clock				=> clk,
		sign_out       => s_sign_out_div,
		result         => s_result_div, 
		finish_kalk    => s_finish_kalk_div
	);
	
	process (s_finish_kalk_add, s_finish_kalk_sub, s_finish_kalk_mult, s_finish_kalk_div, s_sign_out_add, s_sign_out_sub, s_sign_out_mult, s_sign_out_div, s_sign_out, s_result)
	begin
		if s_finish_kalk_add ='1' then
			s_result 	<= s_result_add;
			s_sign_out 	<= s_sign_out_add;
		elsif s_finish_kalk_sub = '1' then
			s_result 	<= s_result_sub;
			s_sign_out 	<= s_sign_out_sub;
		elsif s_finish_kalk_mult ='1' then
			s_result <= s_result_mult;
			s_sign_out 	<= s_sign_out_mult;
		elsif s_finish_kalk_div = '1' then
			s_result <= s_result_div;
			s_sign_out 	<= s_sign_out_div;
		end if;
	end process;
	
	out_sign				<= s_sign_out;
	out_result			<= s_result;
	out_finish_kalk	<= s_finish_kalk_div or s_finish_kalk_mult or s_finish_kalk_sub or s_finish_kalk_add;

end behavioral;