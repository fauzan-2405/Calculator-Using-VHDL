library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity toplevel_bin2asc is
	port(
		in_converter		:	in std_logic_vector(9 downto 0);
		en_bin2asc			:	in std_logic;
		clk					:	in std_logic;
		asc_dig1				:	out std_logic_vector(7 downto 0);
		asc_dig2				:	out std_logic_vector(7 downto 0);
		asc_dig3				:	out std_logic_vector(7 downto 0);
		finish_bin2ascii	:	out std_logic
		);
end entity;

architecture convert of toplevel_bin2asc is
	
component bin_to_asc is
	port(
		bin_in	: in std_logic_vector(7 downto 0);
		enable	: in std_logic;
		clk 		: in std_logic;
		out_asc	: out std_logic_vector(7 downto 0);
		finish_bin2asc : out std_logic
		);
end component;

component parser_3digit is
	port(
		in_data					: in std_logic_vector(9 downto 0);
		en_bin2ascii			: in std_logic;
		clock						: in std_logic;
		dig1						: out std_logic_vector(7 downto 0);
		dig2						: out std_logic_vector(7 downto 0);
		dig3						: out std_logic_vector(7 downto 0);
		finish					: out std_logic
		);
end component;

	signal hasil_parse_dig1 : std_logic_vector(7 downto 0);
	signal hasil_parse_dig2 : std_logic_vector(7 downto 0);
	signal hasil_parse_dig3 : std_logic_vector(7 downto 0);
	signal hasil_conv1		: std_logic_vector(7 downto 0);
	signal hasil_conv2		: std_logic_vector(7 downto 0);
	signal hasil_conv3		: std_logic_vector(7 downto 0);
	signal finish_parse	 : std_logic; --selesai parse
	signal finish_1 : std_logic; --conv 1 selesai
	signal finish_2 : std_logic; --conv 2 selesai
	signal finish_3 : std_logic; --conv 3 selesai
Begin

	parser_bin	: parser_3digit		 
	port map(
		in_data				=> in_converter,
		en_bin2ascii		=> en_bin2asc,
		clock					=> clk,
		dig1					=> hasil_parse_dig1,
		dig2					=> hasil_parse_dig2,
		dig3					=> hasil_parse_dig3,
		finish				=>	finish_parse
		);

	
	conv_dig1 : bin_to_asc
	port map( 
			bin_in => hasil_parse_dig1,
			enable => finish_parse,
			clk => clk,
			out_asc => hasil_conv1,
			finish_bin2asc => finish_1
			);
 
	conv_dig2 : bin_to_asc
	port map( 
			bin_in => hasil_parse_dig2,
			enable => finish_parse,
			clk => clk,
			out_asc => hasil_conv2,
			finish_bin2asc => finish_2
			 );
	
	conv_dig3 : bin_to_asc
	port map( 
			bin_in => hasil_parse_dig3,
			enable => finish_parse,
			clk => clk,
			out_asc => hasil_conv3,
			finish_bin2asc => finish_3
			 );
			 
			 
		finish_bin2ascii <= finish_1 AND finish_2 AND finish_3;
		asc_dig1 <= hasil_conv1;
		asc_dig2 <= hasil_conv2;
		asc_dig3 <= hasil_conv3;
		
end architecture;