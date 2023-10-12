----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
--
-- Create Date:    20:10:57 10/12/2023 
-- Design Name: 
-- Module Name:    decremento - Behavioral 
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

entity decremento is
		Port (
			  A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor		  

			  S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			  C_o : out  STD_LOGIC;									-- Carry Out
			  O   : out  STD_LOGIC									-- Overflow
			);	
end decremento;

architecture Behavioral of decremento is

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

	decrementado : somador_subtrator PORT MAP(A, "00001", '1', S, C_o, O);

end Behavioral;

