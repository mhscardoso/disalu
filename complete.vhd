----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:23:29 09/26/2023 
-- Design Name: 
-- Module Name:    complete - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity complete is
	Port (X        : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
			Y        : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Segundo Valor
			Control  : in   STD_LOGIC_VECTOR(2 DOWNTO 0);		-- Carry In
				  
			R        : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			Co       : out  STD_LOGIC;									-- Carry Out
			Ov       : out  STD_LOGIC									-- Overflow
			);
end complete;

architecture Behavioral of complete is

-- Componente do Somador
component somador_subtrator is
    Port ( A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
           B   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Segundo Valor
           C_i : in   STD_LOGIC;									-- Carry In
			  
           S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
           C_o : out  STD_LOGIC;									-- Carry Out
           O   : out  STD_LOGIC									-- Overflow
			  );
end component;

-- Componente do Incremento
component incremento is
		Port (
			  A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
			  
			  S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			  C_o : out  STD_LOGIC;									-- Carry Out
			  O   : out  STD_LOGIC									-- Overflow
				);
end component;

-- Componente da troca de sinal
component troca_sinal is
	Port (
			N   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
			  
			T   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			co  : out  STD_LOGIC;								-- Carry Out
			ov  : out  STD_LOGIC									-- Overflow
	);
end component;

-- Componente do Decremento
component decremento is
		Port (
			  A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
			  
			  S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			  C_o : out  STD_LOGIC;									-- Carry Out
			  O   : out  STD_LOGIC									-- Overflow
			);	
end component;

-- Componente shift left

-- Componente Shift Right

-- Componente Comparador

	-- Condicoes de Controle
	signal sum : std_logic := '0';
	signal sub : std_logic := '0';
	signal inc : std_logic := '0';
	signal tro : std_logic := '0';
	signal dec : std_logic := '0';

	-- Resultados apos a soma
	signal sum_res : std_logic_vector(4 downto 0) := "00000";
	signal sum_co  : std_logic := '0';
	signal sum_ov  : std_logic := '0';
	
	-- Resultados apos o incremento
	signal inc_res : std_logic_vector(4 downto 0) := "00000";
	signal inc_co  : std_logic := '0';
	signal inc_ov  : std_logic := '0';
	
	-- Resultados apos o troca de sinal
	signal tro_res : std_logic_vector(4 downto 0) := "00000";
	signal tro_co  : std_logic := '0';
	signal tro_ov  : std_logic := '0';
	
	-- Resultados apos o decremento
	signal dec_res : std_logic_vector(4 downto 0) := "00000";
	signal dec_co  : std_logic := '0';
	signal dec_ov  : std_logic := '0';

begin

	sum <= (not Control(2)) and (not Control(1)) and (not Control(0)); -- 000
	sub <= (not Control(2)) and (not Control(1)) and (    Control(0)); -- 001
	inc <= (not Control(2)) and (    Control(1)) and (not Control(0)); -- 010
	tro <= (not Control(2)) and (    Control(1)) and (    Control(0)); -- 011
	dec <= (    Control(2)) and (not Control(1)) and (not Control(0)); -- 100

	som_sub : somador_subtrator PORT MAP(X, Y, Control(0), sum_res, sum_co, sum_ov);
	increme : incremento        PORT MAP(X, inc_res, inc_co, inc_ov);
	trocado : troca_sinal		 PORT MAP(X, tro_res, tro_co, tro_ov);
	decreme : decremento        PORT MAP(X, dec_res, dec_co, dec_ov);
	
	R <=    ((sum & sum & sum & sum & sum) and (sum_res))
		  or ((sub & sub & sub & sub & sub) and (sum_res))
		  or ((inc & inc & inc & inc & inc) and (inc_res))
		  or ((tro & tro & tro & tro & tro) and (tro_res))
		  or ((dec & dec & dec & dec & dec) and (dec_res));
		  
	Co <= (sum and sum_co) or 
			(sub and sum_co) or 
			(inc and inc_co) or
			(tro and tro_co) or
			(dec and dec_co);
	
	Ov <= (sum and sum_ov) or 
			(sub and sum_ov) or 
			(inc and inc_ov) or
			(tro and tro_ov) or
			(dec and dec_ov);

end Behavioral;