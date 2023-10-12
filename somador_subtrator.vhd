----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:39:05 09/19/2023 
-- Design Name: 
-- Module Name:    somador_subtrator - Behavioral 
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
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity somador_subtrator is
    Port ( A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
           B   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Segundo Valor
           C_i : in   STD_LOGIC;									-- Carry In
			  
           S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
           C_o : out  STD_LOGIC;									-- Carry Out
           O   : out  STD_LOGIC									-- Overflow
			  );
end somador_subtrator;

architecture Behavioral of somador_subtrator is
 -- P_i = A_i XOR B_i
 -- G_i = A_i AND B_i
 -- C_(i + 1) = G_i + Pi . C_i

SIGNAL carries : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
SIGNAL B_i  	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
SIGNAL P			: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
SIGNAL G			: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";


begin
	-- Trocando o sinal, caso o carry in == 1 (nesse caso sera uma subtracao)
	B_i(0) <= B(0) XOR C_i;
	B_i(1) <= B(1) XOR C_i;
	B_i(2) <= B(2) XOR C_i;
	B_i(3) <= B(3) XOR C_i;
	B_i(4) <= B(4) XOR C_i;

-- Calculando P e G
	P <= A XOR B_i;
	G <= A AND B_i;
	
	-- Calculando os Carries
	carries(0) <= C_i;
	carries(1) <= G(0) OR (P(0) AND C_i);
	carries(2) <= G(1) OR (P(1) AND (G(0) OR (P(0) AND C_i)));
	carries(3) <= G(2) OR (P(2) AND (G(1) OR (P(1) AND (G(0) OR (P(0) AND C_i)))));
	carries(4) <= G(3) OR (P(3) AND (G(2) OR (P(2) AND (G(1) OR (P(1) AND (G(0) OR (P(0) AND C_i)))))));


-- Saidas ->>>>>	
	-- Carry Out
	C_o <= G(4) OR (P(4) AND (G(3) OR (P(3) AND (G(2) OR (P(2) AND (G(1) OR (P(1) AND (G(0) OR (P(0) AND C_i)))))))));
	
	-- Overflow
	O <= carries(4) XOR (G(4) OR (P(4) AND (G(3) OR (P(3) AND (G(2) OR (P(2) AND (G(1) OR (P(1) AND (G(0) OR (P(0) AND C_i))))))))));
	
	-- Resultado
	S <= carries XOR A XOR B_i;

end Behavioral;