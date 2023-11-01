----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:12:25 10/31/2023 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	port (
		clock_i    : in  std_logic;
		reset_i    : in  std_logic;
		contro     : in   STD_LOGIC_VECTOR(2 DOWNTO 0);		-- control
		
		res        : out  STD_LOGIC_VECTOR(4 DOWNTO 0);		-- Resultado
		cout       : out  STD_LOGIC;								-- Carry Out
		over       : out  STD_LOGIC;								-- Overflow
		zer        : out  STD_LOGIC
		);
end counter;

architecture Behavioral of counter is	
	-- signals to count digits
	signal   unit_counter  : integer   := 0;
	signal   unit_counter2 : integer   := 0;
	---------------------------------------
	
	-- numbers per se
	signal   digit_1 : std_logic_vector(4 downto 0) := "00000";
	signal   digit_2 : std_logic_vector(4 downto 0) := "00000";

-- COMPONENTE DA alu COMPLETA
component complete is
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
end component;

begin	
	-- increment a unit value
	process(clock_i, reset_i)
	begin
		if reset_i = '1' then
			unit_counter <= 0;
			unit_counter2 <= 0;
		else
			if (clock_i'event and clock_i = '1') then
				unit_counter <= unit_counter + 1;
				if unit_counter >= 15 then
					unit_counter <= 0;
					
					unit_counter2 <= unit_counter2 + 1;
					if unit_counter2 >= 15 then
						unit_counter2 <= 0;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	digit_1 <= std_logic_vector(to_unsigned(unit_counter , digit_1'length));
	digit_2 <= std_logic_vector(to_unsigned(unit_counter2, digit_2'length));
	
	alu : complete PORT MAP(digit_1, digit_2, contro, res, cout, over, zer);	

end Behavioral;