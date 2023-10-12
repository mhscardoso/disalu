----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
--
-- Create Date:    15:20:31 10/10/2023 
-- Design Name: 
-- Module Name:    incremento - Behavioral 
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

entity incremento is
		Port (
			  A   : in   STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Primeiro Valor	  

			  S   : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
			  C_o : out  STD_LOGIC;									-- Carry Out
			  O   : out  STD_LOGIC									-- Overflow
			);
end incremento;

architecture Behavioral of incremento is

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
	som_zero : somador_subtrator PORT MAP(A, "00001", '0', S, C_o, O);
end Behavioral;