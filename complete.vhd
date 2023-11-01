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
			--clk      : in   STD_LOGIC;									-- Clock
			--reset    : in   STD_LOGIC;
				  
			R        : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			Co       : out  STD_LOGIC;									-- Carry Out
			Ov       : out  STD_LOGIC;									-- Overflow
			Zero     : out  STD_LOGIC
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

-- Componente incrementa 2
component inc2 is
		Port (
			  A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
			  
			  S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			  C_o : out  STD_LOGIC;									-- Carry Out
			  O   : out  STD_LOGIC									-- Overflow
				);
end component;

-- Componente decrementa 2
component decrem2 is
		Port (
			  A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
			  
			  S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			  C_o : out  STD_LOGIC;									-- Carry Out
			  O   : out  STD_LOGIC									-- Overflow
				);
end component;

-- Componente Comparador
component comparador is
    Port ( M   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
           N   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Segundo Valor
			  
			  G   : out  STD_LOGIC;									-- Greater
			  E	: out  STD_LOGIC;									-- Equals
			  D   : out  STD_LOGIC   								-- Minor
			  );
end component;

	-- Condicoes de Controle
	signal sum : std_logic := '0';
	signal sub : std_logic := '0';
	signal inc : std_logic := '0';
	signal tro : std_logic := '0';
	signal dec : std_logic := '0';
	signal in2 : std_logic := '0';
	signal de2 : std_logic := '0';
	signal com : std_logic := '0';
	
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
	
	-- Resultados apos o incremento de 2
	signal in2_res : std_logic_vector(4 downto 0) := "00000";
	signal in2_co  : std_logic := '0';
	signal in2_ov  : std_logic := '0';
	
	-- Resultados apos o decremento de 2
	signal de2_res : std_logic_vector(4 downto 0) := "00000";
	signal de2_co  : std_logic := '0';
	signal de2_ov  : std_logic := '0';
	
	-- Resultados apos o comparador
	signal com_res : std_logic_vector(2 downto 0) := "000";
	
	-- resultado final
	signal result  : std_logic_vector(4 downto 0) := "00000";

begin

	sum <= (not Control(2)) and (not Control(1)) and (not Control(0)); -- 000
	sub <= (not Control(2)) and (not Control(1)) and     (Control(0)); -- 001
	inc <= (not Control(2)) and (    Control(1)) and (not Control(0)); -- 010
	tro <= (not Control(2)) and (    Control(1)) and     (Control(0)); -- 011
	dec <= (    Control(2)) and (not Control(1)) and (not Control(0)); -- 100
	in2 <= (    Control(2)) and (not Control(1)) and (    Control(0)); -- 101
	de2 <= (    Control(2)) and (    Control(1)) and (not Control(0)); -- 110
	com <= (    Control(2)) and (    Control(1)) and (    Control(0)); -- 111
	
	-- cont 	  : counter				 PORT MAP(clk, reset, first, secnd);
	som_sub : somador_subtrator PORT MAP(X, Y, Control(0), sum_res, sum_co, sum_ov);
	increme : incremento        PORT MAP(X, inc_res, inc_co, inc_ov);
	trocado : troca_sinal		 PORT MAP(X, tro_res, tro_co, tro_ov);
	decreme : decremento        PORT MAP(X, dec_res, dec_co, dec_ov);
	increm2 : inc2					 PORT MAP(X, in2_res, in2_co, in2_ov);
	decre2  : decrem2   			 PORT MAP(X, de2_res, de2_co, de2_ov);
	comp    : comparador			 PORT MAP(X, Y, com_res(2), com_res(1), com_res(0));
	
	result <=    ((sum & sum & sum & sum & sum) and (sum_res))
				 or ((sub & sub & sub & sub & sub) and (sum_res))
				 or ((inc & inc & inc & inc & inc) and (inc_res))
		       or ((tro & tro & tro & tro & tro) and (tro_res))
		       or ((dec & dec & dec & dec & dec) and (dec_res))
		       or ((in2 & in2 & in2 & in2 & in2) and (in2_res))
		       or ((de2 & de2 & de2 & de2 & de2) and (de2_res))
		       or (('0' & '0' & com & com & com) and ('0' & '0' & com_res));
	
	Zero <= not result(3) and
			  not result(2) and
			  not result(1) and
			  not result(0);
	
	R <= result;
		  
	Co <= (sum and sum_co) or 
			(sub and sum_co) or 
			(inc and inc_co) or
			(tro and tro_co) or
			(dec and dec_co) or
			(in2 and in2_co) or
			(de2 and de2_co);
	
	Ov <= (sum and sum_ov) or 
			(sub and sum_ov) or 
			(inc and inc_ov) or
			(tro and tro_ov) or
			(dec and dec_ov) or
			(in2 and in2_ov) or
			(de2 and de2_ov);

end Behavioral; 