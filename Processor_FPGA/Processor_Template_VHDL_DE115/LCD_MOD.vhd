LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY LCD_MOD IS
	PORT(
			CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			PC : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			KEYB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			H_STATE : IN STD_LOGIC;
			LCD_DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			LCD_ENABLE: OUT STD_LOGIC;
			LCD_RW : OUT STD_LOGIC;
			LCD_RS : OUT STD_LOGIC
		);
END LCD_MOD;

ARCHITECTURE main OF LCD_MOD IS
CONSTANT RUNNING : STD_LOGIC_VECTOR(55 DOWNTO 0) :=  x"676E696E6E7552";
CONSTANT HALTED : STD_LOGIC_VECTOR(55 DOWNTO 0) :=  x"206465746C6148";
CONSTANT PCS : STD_LOGIC_VECTOR(31 DOWNTO 0) :=  x"203A4350";
CONSTANT KEYBS : STD_LOGIC_VECTOR(47 DOWNTO 0) :=  x"203A4259454B";
CONSTANT AP9S : STD_LOGIC_VECTOR(23 DOWNTO 0) :=  x"395041";
SIGNAL MAINSTATE : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL STATE : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL STATEA : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	PROCESS(CLK, RST)
	VARIABLE COUNTER : INTEGER RANGE 0 TO 2500000;
	VARIABLE ITER : INTEGER RANGE 0 TO 256;
	VARIABLE INPC : STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE INKEYB : STD_LOGIC_VECTOR(7 DOWNTO 0);
	BEGIN
		IF(RST = '1') THEN
			ITER := 0;
			INPC := x"FFFF";
			INKEYB := x"FF";
			LCD_ENABLE <= '0';
			LCD_DATA <= x"00";
			MAINSTATE <= x"0";
			STATE <= x"F";
			STATEA <= x"0";
		ELSIF(CLK'EVENT AND CLK = '1') THEN
			CASE STATE IS
				--CLEAR SCREEN
				WHEN x"0" =>
					LCD_DATA <= x"01";
					LCD_RS <= '0';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					STATEA <= x"D";
					STATE <= x"E";
				--PREPARE TO WRITE RUNNING
				WHEN x"1" =>
					LCD_DATA <= x"80";
					LCD_RS <= '0';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					STATEA <= x"2";
					STATE <= x"E";
				--WRITE RUNNING
				WHEN x"2" =>
					LCD_DATA <= RUNNING(ITER + 7 DOWNTO ITER);
					LCD_RS <= '1';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					ITER := ITER + 8;
					IF(ITER = 56) THEN
						ITER := 0;
						STATEA <= x"D";
					ELSE
						STATEA <= x"2";
					END IF;
					STATE <= x"F";
				--PREPARE TO WRITE PC: XXXX
				WHEN x"3" =>
					LCD_DATA <= x"88";
					LCD_RS <= '0';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					STATEA <= x"4";
					STATE <= x"E";
				--WRITE PC: XXXX
				WHEN x"4" =>
					IF(ITER < 32) THEN
						LCD_DATA <= PCS(ITER + 7 DOWNTO ITER);
					ELSE
						CASE ITER IS
							WHEN 32 =>
								IF(PC(15 DOWNTO 12) < x"A") THEN
									LCD_DATA <= PC(15 DOWNTO 12) + x"30";
								ELSE
									LCD_DATA <= PC(15 DOWNTO 12) + x"37";
								END IF;
							WHEN 40 =>
								IF(PC(11 DOWNTO 8) < x"A") THEN
									LCD_DATA <= PC(11 DOWNTO 8) + x"30";
								ELSE
									LCD_DATA <= PC(11 DOWNTO 8) + x"37";
								END IF;
							WHEN 48 =>
								IF(PC(7 DOWNTO 4) < x"A") THEN
									LCD_DATA <= PC(7 DOWNTO 4) + x"30";
								ELSE
									LCD_DATA <= PC(7 DOWNTO 4) + x"37";
								END IF;
							WHEN 56 =>
								IF(PC(3 DOWNTO 0) < x"A") THEN
									LCD_DATA <= PC(3 DOWNTO 0) + x"30";
								ELSE
									LCD_DATA <= PC(3 DOWNTO 0) + x"37";
								END IF;
							WHEN OTHERS =>
						END CASE;
					END IF;
					LCD_RS <= '1';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					ITER := ITER + 8;
					IF(ITER = 64) THEN
						ITER := 0;
						STATEA <= x"D";
					ELSE
						STATEA <= x"4";
					END IF;
					STATE <= x"F";
				--PREPARE TO WRITE KEYB: XX
				WHEN x"5" =>
					LCD_DATA <= x"C8";
					LCD_RS <= '0';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					STATEA <= x"6";
					STATE <= x"E";
				--WRITE KEYB: XX
				WHEN x"6" =>
					IF(ITER < 48) THEN
						LCD_DATA <= KEYBS(ITER + 7 DOWNTO ITER);
					ELSE
						CASE ITER IS
							WHEN 48 =>
								IF(KEYB(7 DOWNTO 4) < x"A") THEN
									LCD_DATA <= KEYB(7 DOWNTO 4) + x"30";
								ELSE
									LCD_DATA <= KEYB(7 DOWNTO 4) + x"37";
								END IF;
							WHEN 56 =>
								IF(KEYB(3 DOWNTO 0) < x"A") THEN
									LCD_DATA <= KEYB(3 DOWNTO 0) + x"30";
								ELSE
									LCD_DATA <= KEYB(3 DOWNTO 0) + x"37";
								END IF;
							WHEN OTHERS =>
						END CASE;
					END IF;
					LCD_RS <= '1';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					ITER := ITER + 8;
					IF(ITER = 64) THEN
						ITER := 0;
						STATEA <= x"D";
					ELSE
						STATEA <= x"6";
					END IF;
					STATE <= x"F";
				--PREPARE TO WRITE AP9
				WHEN x"7" =>
					LCD_DATA <= x"C0";
					LCD_RS <= '0';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					STATEA <= x"8";
					STATE <= x"E";
				--WRITE AP9
				WHEN x"8" =>
					LCD_DATA <= AP9S(ITER + 7 DOWNTO ITER);
					LCD_RS <= '1';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					ITER := ITER + 8;
					IF(ITER = 24) THEN
						ITER := 0;
						STATEA <= x"D";
					ELSE
						STATEA <= x"8";
					END IF;
					STATE <= x"F";
				--PREPARE TO WRITE HALTED
				WHEN x"9" =>
					LCD_DATA <= x"80";
					LCD_RS <= '0';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					STATEA <= x"A";
					STATE <= x"E";
				--WRITE HALTED
				WHEN x"A" =>
					LCD_DATA <= HALTED(ITER + 7 DOWNTO ITER);
					LCD_RS <= '1';
					LCD_RW <= '0';
					LCD_ENABLE <= '1';
					ITER := ITER + 8;
					IF(ITER = 56) THEN
						ITER := 0;
						STATEA <= x"D";
					ELSE
						STATEA <= x"A";
					END IF;
					STATE <= x"F";
				--LOOP STATE, ALMOST A MAIN FUNCTION
				WHEN x"D" =>
					CASE MAINSTATE IS
						--DRAW AP9
						WHEN x"0" =>
							STATE <= x"7";
							MAINSTATE <= x"1";
						--DRAW STATE RUNNING
						WHEN x"1" =>
							STATE <= x"1";
							MAINSTATE <= x"2";
						--DRAW PC (IF NECESSARY)
						WHEN x"2" =>
							IF(NOT (INPC = PC)) THEN
								INPC := PC;
								STATE <= x"3";
							END IF;
							MAINSTATE <= x"3";
						--DRAW KEYB (IF NECESSARY)
						WHEN x"3" =>
							IF(NOT (INKEYB = KEYB)) THEN
								INKEYB := KEYB;
								STATE <= x"5";
							END IF;
							MAINSTATE <= x"4";
						--DRAW STATE HALTED (IF HALTED)
						WHEN x"4" =>
							IF(H_STATE = '1') THEN
								STATE <= x"9";
								MAINSTATE <= x"5";
							ELSE
								MAINSTATE <= x"1";
							END IF;
						WHEN OTHERS =>
					END CASE;
				--WAIT STATE FOR INSTRUCTIONS
				WHEN x"E" =>
					IF(COUNTER = 250000) THEN
						COUNTER := 0;
						LCD_ENABLE <= '0';
						STATE <= STATEA;
					ELSE
						COUNTER := COUNTER + 1;
					END IF;
				--WAIT STATE FOR DATA
				WHEN x"F" =>
					IF(COUNTER = 25000) THEN
						COUNTER := 0;
						LCD_ENABLE <= '0';
						STATE <= STATEA;
					ELSE
						COUNTER := COUNTER + 1;
					END IF;
				WHEN OTHERS =>
					STATE <= x"0";
			END CASE;
		END IF;
	END PROCESS;
END;