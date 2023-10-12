----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:21 10/12/2023 
-- Design Name: 
-- Module Name:    troca_sinal - Behavioral 
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

entity troca_sinal is
	Port (
			N   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
			  
			T   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			co  : out  STD_LOGIC;								-- Carry Out
			ov  : out  STD_LOGIC									-- Overflow
	);
end troca_sinal;

architecture Behavioral of troca_sinal is

component somador_subtrator is
    Port ( A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor
           B   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Segundo Valor
           C_i : in   STD_LOGIC;									-- Carry In
			  
           S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
           C_o : out  STD_LOGIC;									-- Carry Out
           O   : out  STD_LOGIC									-- Overflow
			  );
end component;

begin
	
	troca : somador_subtrator PORT MAP("00000", N, '1', T, co, ov);

end Behavioral;