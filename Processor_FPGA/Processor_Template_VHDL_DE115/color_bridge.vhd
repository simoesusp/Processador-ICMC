LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY COLOR_BRIDGE IS
	PORT(
			CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			BRG_EN : IN STD_LOGIC;
			COLOR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			R : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			G : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			B : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
END COLOR_BRIDGE;

ARCHITECTURE main OF COLOR_BRIDGE IS
BEGIN
	PROCESS(CLK, RST)
	BEGIN
		IF(RST = '1') THEN
			R <= "0000000000";
			G <= "0000000000";
			B <= "0000000000";
		ELSIF(CLK'EVENT AND CLK = '1') THEN
			IF(BRG_EN = '1') THEN
				CASE COLOR IS
					--BLACK
					WHEN x"0" =>
						R <= "0000000000";
						G <= "0000000000";
						B <= "0000000000";
					--DARK RED
					WHEN x"1" =>
						R <= "0111111111";
						G <= "0000000000";
						B <= "0000000000";
					--DARK GREEN
					WHEN x"2" =>
						R <= "0000000000";
						G <= "0111111111";
						B <= "0000000000";
					--DARK YELLOW
					WHEN x"3" =>
						R <= "0111111111";
						G <= "0111111111";
						B <= "0000000000";
					--DARK BLUE
					WHEN x"4" =>
						R <= "0000000000";
						G <= "0000000000";
						B <= "0111111111";
					--PURPLE
					WHEN x"5" =>
						R <= "0111111111";
						G <= "0000000000";
						B <= "0111111111";
					--GREENISH BLUE
					WHEN x"6" =>
						R <= "0000000000";
						G <= "0111111111";
						B <= "0111111111";
					--LIGHT GRAY
					WHEN x"7" =>
						R <= "1011111111";
						G <= "1011111111";
						B <= "1011111111";
					--GRAY
					WHEN x"8" =>
						R <= "0111111111";
						G <= "0111111111";
						B <= "0111111111";
					--RED
					WHEN x"9" =>
						R <= "1111111111";
						G <= "0000000000";
						B <= "0000000000";
					--GREEN
					WHEN x"A" =>
						R <= "0000000000";
						G <= "1111111111";
						B <= "0000000000";
					--YELLOW
					WHEN x"B" =>
						R <= "1111111111";
						G <= "1111111111";
						B <= "0000000000";
					--BLUE
					WHEN x"C" =>
						R <= "0000000000";
						G <= "0000000000";
						B <= "1111111111";
					--PINK
					WHEN x"D" =>
						R <= "1111111111";
						G <= "0000000000";
						B <= "1111111111";
					--SKY BLUE
					WHEN x"E" =>
						R <= "0000000000";
						G <= "1111111111";
						B <= "1111111111";
					--WHITE
					WHEN x"F" =>
						R <= "1111111111";
						G <= "1111111111";
						B <= "1111111111";
					WHEN OTHERS =>
				END CASE;
			ELSE
				R <= "0000000000";
				G <= "0000000000";
				B <= "0000000000";
			END IF;
		END IF;
	END PROCESS;
END main;
