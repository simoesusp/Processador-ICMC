-- ASCII DECODER FOR ABNT2 KEYBOARDS

LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY KB_ASCII IS
	PORT(	CLK				: IN STD_LOGIC;
			RST				: IN STD_LOGIC;
			SCANCODE			: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			SCANEXTENDED	: IN STD_LOGIC;
			SCANPRESSING	: IN STD_LOGIC;
			
			ASCII				: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			HALT_REQ			: OUT STD_LOGIC;
			RESET_REQ		: OUT STD_LOGIC
		);
END KB_ASCII;

ARCHITECTURE main OF KB_ASCII IS

	SIGNAL CTRLpressed	: STD_LOGIC;
	SIGNAL SHIFTpressed	: STD_LOGIC;
	SIGNAL ALTpressed		: STD_LOGIC;
	SIGNAL CTRLcombos		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL SHIFTcombos	: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL NORMALpress	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
BEGIN
	PROCESS(CLK, RST)
	
		VARIABLE PRESSTATE : STD_LOGIC;
	
	BEGIN
		IF(RST = '1') THEN
			NORMALpress		<= x"FF";
			SHIFTpressed	<= '0';
			CTRLpressed		<= '0';
			PRESSTATE		:= '0';
		ELSIF(CLK'EVENT AND CLK = '1') THEN
			CASE PRESSTATE IS
				WHEN '0' =>
					-- Tratar todas as teclas iniciais (ou unicas)
					CASE SCANCODE IS
						-- [CTRL START] CTRL +  (N/A)
						WHEN x"14" =>
							CTRLpressed <= '1';
							PRESSTATE := '1';
						-- [LEFT SHIFT START] SHIFT +  (N/A)
						WHEN x"12" =>
							SHIFTpressed <= '1';
							PRESSTATE := '1';
						-- [RIGHT SHIFT START] SHIFT +  (N/A)
						WHEN x"59" =>
							SHIFTpressed <= '1';
							PRESSTATE := '1';
						-- [LINE FEED] ENTER (0x0A)
						WHEN x"5A" =>
							NORMALpress <= x"0A";
							PRESSTATE := '1';
						-- [BACKSPACE] BACKSPACE (0x08)
						WHEN x"66" =>
							NORMALpress <= x"08";
							PRESSTATE := '1';
						-- [HORIZONTAL TAB] TAB (0x09)
						WHEN x"0D" =>
							NORMALpress <= x"09";
							PRESSTATE := '1';
						-- [ESCAPE] ESC (0x1B)
						WHEN x"76" =>
							NORMALpress <= x"1B";
							PRESSTATE := '1';
						-- [SPACE] SPACE (0x20)
						WHEN x"29" =>
							NORMALpress <= x"20";
							PRESSTATE := '1';
						-- ['] ' (0x27)
						WHEN x"0E" =>
							NORMALpress <= x"27";
							PRESSTATE := '1';
						-- [,] , (0x2C)
						WHEN x"41" =>
							NORMALpress <= x"2C";
							PRESSTATE := '1';
						-- [-] - (0x2D)
						WHEN x"4E" =>
							NORMALpress <= x"2D";
							PRESSTATE := '1';
						-- [.] . (0x2E)
						WHEN x"49" =>
							NORMALpress <= x"2E";
							PRESSTATE := '1';
						-- [/] / (0x2F)
						WHEN x"51" =>
							NORMALpress <= x"2F";
							PRESSTATE := '1';
						-- [0] 0 (0x30)
						WHEN x"45" =>
							NORMALpress <= x"30";
							PRESSTATE := '1';
						-- [1] 1 (0x31)
						WHEN x"16" =>
							NORMALpress <= x"31";
							PRESSTATE := '1';
						-- [2] 2 (0x32)
						WHEN x"1E" =>
							NORMALpress <= x"32";
							PRESSTATE := '1';
						-- [3] 3 (0x33)
						WHEN x"26" =>
							NORMALpress <= x"33";
							PRESSTATE := '1';
						-- [4] 4 (0x34)
						WHEN x"25" =>
							NORMALpress <= x"34";
							PRESSTATE := '1';
						-- [5] 5 (0x35)
						WHEN x"2E" =>
							NORMALpress <= x"35";
							PRESSTATE := '1';
						-- [6] 6 (0x36)
						WHEN x"36" =>
							NORMALpress <= x"36";
							PRESSTATE := '1';
						-- [7] 7 (0x37)
						WHEN x"3D" =>
							NORMALpress <= x"37";
							PRESSTATE := '1';
						-- [8] 8 (0x38)
						WHEN x"3E" =>
							NORMALpress <= x"38";
							PRESSTATE := '1';
						-- [9] 9 (0x39)
						WHEN x"46" =>
							NORMALpress <= x"39";
							PRESSTATE := '1';
						-- [;] ; (0x3B)
						WHEN x"4A" =>
							NORMALpress <= x"3B";
							PRESSTATE := '1';
						-- [=] = (0x3D)
						WHEN x"55" =>
							NORMALpress <= x"3D";
							PRESSTATE := '1';
						-- [[] [ (0x5B)
						WHEN x"5B" =>
							NORMALpress <= x"5B";
							PRESSTATE := '1';
						-- [\] \ (0x5C)
						WHEN x"61" =>
							NORMALpress <= x"5C";
							PRESSTATE := '1';
						-- []] ] (0x5D)
						WHEN x"5D" =>
							NORMALpress <= x"5D";
							PRESSTATE := '1';
						-- [a] a (0x61)
						WHEN x"1C" =>
							NORMALpress <= x"61";
							PRESSTATE := '1';
						-- [b] b (0x62)
						WHEN x"32" =>
							NORMALpress <= x"62";
							PRESSTATE := '1';
						-- [c] c (0x63)
						WHEN x"21" =>
							NORMALpress <= x"63";
							PRESSTATE := '1';
						-- [d] d (0x64)
						WHEN x"23" =>
							NORMALpress <= x"64";
							PRESSTATE := '1';
						-- [e] e (0x65)
						WHEN x"24" =>
							NORMALpress <= x"65";
							PRESSTATE := '1';
						-- [f] f (0x66)
						WHEN x"2B" =>
							NORMALpress <= x"66";
							PRESSTATE := '1';
						-- [g] g (0x67)
						WHEN x"34" =>
							NORMALpress <= x"67";
							PRESSTATE := '1';
						-- [h] h (0x68)
						WHEN x"33" =>
							NORMALpress <= x"68";
							PRESSTATE := '1';
						-- [i] i (0x69)
						WHEN x"43" =>
							NORMALpress <= x"69";
							PRESSTATE := '1';
						-- [j] j (0x6A)
						WHEN x"3B" =>
							NORMALpress <= x"6A";
							PRESSTATE := '1';
						-- [k] k (0x6B)
						WHEN x"42" =>
							NORMALpress <= x"6B";
							PRESSTATE := '1';
						-- [l] l (0x6C)
						WHEN x"4B" =>
							NORMALpress <= x"6C";
							PRESSTATE := '1';
						-- [m] m (0x6D)
						WHEN x"3A" =>
							NORMALpress <= x"6D";
							PRESSTATE := '1';
						-- [n] n (0x6E)
						WHEN x"31" =>
							NORMALpress <= x"6E";
							PRESSTATE := '1';
						-- [o] o (0x6F)
						WHEN x"44" =>
							NORMALpress <= x"6F";
							PRESSTATE := '1';
						-- [p] p (0x70)
						WHEN x"4D" =>
							NORMALpress <= x"70";
							PRESSTATE := '1';
						-- [q] q (0x71)
						WHEN x"15" =>
							NORMALpress <= x"71";
							PRESSTATE := '1';
						-- [r] r (0x72)
						WHEN x"2D" =>
							NORMALpress <= x"72";
							PRESSTATE := '1';
						-- [s] s (0x73)
						WHEN x"1B" =>
							NORMALpress <= x"73";
							PRESSTATE := '1';
						-- [t] t (0x74)
						WHEN x"2C" =>
							NORMALpress <= x"74";
							PRESSTATE := '1';
						-- [u] u (0x75)
						WHEN x"3C" =>
							NORMALpress <= x"75";
							PRESSTATE := '1';
						-- [v] v (0x76)
						WHEN x"2A" =>
							NORMALpress <= x"76";
							PRESSTATE := '1';
						-- [w] w (0x77)
						WHEN x"1D" =>
							NORMALpress <= x"77";
							PRESSTATE := '1';
						-- [x] x (0x78)
						WHEN x"22" =>
							NORMALpress <= x"78";
							PRESSTATE := '1';
						-- [y] y (0x79)
						WHEN x"35" =>
							NORMALpress <= x"79";
							PRESSTATE := '1';
						-- [z] z (0x7A)
						WHEN x"1A" =>
							NORMALpress <= x"7A";
							PRESSTATE := '1';
						-- [~] ~ (0x7E)
						WHEN x"52" =>
							NORMALpress <= x"7E";
							PRESSTATE := '1';
						-- [ ] DEL (0x7F)
						WHEN x"71" =>
							NORMALpress <= x"7F";
							PRESSTATE := '1';
						WHEN OTHERS =>
							NORMALpress <= x"00";
							SHIFTpressed <= '0';
							CTRLpressed <= '0';
					END CASE;
				WHEN '1' =>
					IF(SCANPRESSING = '0') THEN
						SHIFTpressed <= '0';
						CTRLpressed <= '0';
						PRESSTATE := '0';
					END IF;
			END CASE;
		END IF;
	END PROCESS;

	PROCESS(CLK, RST)
	
		VARIABLE PRESSTATE : STD_LOGIC;
	
	BEGIN
		IF(RST = '1') THEN
			ALTpressed	<= '0';
			CTRLcombos	<= "00000";
			SHIFTcombos <= "0000000";
			PRESSTATE 	:= '0';
		ELSIF(CLK'EVENT AND CLK = '1' AND CTRLpressed = '1') THEN
			CASE PRESSTATE IS
				WHEN '0' =>
					CASE SCANCODE IS
						-- [ALT START] CTRL + ALT + (N/A)
						WHEN x"11" =>
							ALTpressed <= '1';
							PRESSTATE := '1';
						-- [START OF HEADER] CTRL + A (0x01)
						WHEN x"1C" =>
							CTRLcombos <= "00001";
							PRESSTATE := '1';
						-- [START OF TRANSMISSION] CTRL + B (0x02)
						WHEN x"32" =>
							CTRLcombos <= "00010";
							PRESSTATE := '1';
						-- [END OF TRANSMISSION] CTRL + C (0x03)
						WHEN x"21" =>
							CTRLcombos <= "00011";
							PRESSTATE := '1';
						-- [END OF TEXT] CTRL + D (0x04)
						WHEN x"23" =>
							CTRLcombos <= "00100";
							PRESSTATE := '1';
						-- [ENQUIRY] CTRL + E (0x05)
						WHEN x"24" =>
							CTRLcombos <= "00101";
							PRESSTATE := '1';
						-- [ACKNOWLEDGE] CTRL + F (0x06)
						WHEN x"2B" =>
							CTRLcombos <= "00110";
							PRESSTATE := '1';
						-- [BELL] CTRL + G (0x07)
						WHEN x"34" =>
							CTRLcombos <= "00111";
							PRESSTATE := '1';
						-- [BACKSPACE] CTRL + H (0x08)
						WHEN x"33" =>
							CTRLcombos <= "01000";
							PRESSTATE := '1';
						-- [HORIZONTAL TAB] CTRL + I (0x09)
						WHEN x"43" =>
							CTRLcombos <= "01001";
							PRESSTATE := '1';
						-- [LINE FEED] CTRL + J (0x0A)
						WHEN x"3B" =>
							CTRLcombos <= "01010";
							PRESSTATE := '1';
						-- [VERTICAL TAB] CTRL + K (0x0B)
						WHEN x"42" =>
							CTRLcombos <= "01011";
							PRESSTATE := '1';
						-- [FORM FEED] CTRL + L (0x0C)
						WHEN x"4B" =>
							CTRLcombos <= "01100";
							PRESSTATE := '1';
						-- [CARRIAGE RETURN] CTRL + M (0x0D)
						WHEN x"3A" =>
							CTRLcombos <= "01101";
							PRESSTATE := '1';
						-- FROM 0x0E to 0x1A and 0x1C to 0x1F WAS NOT MAPPED
						-- [ESCAPE] CTRL + [ (0x1B)
						WHEN x"5B" =>
							CTRLcombos <= "11011";
							PRESSTATE := '1';
						WHEN OTHERS =>
							ALTpressed <= '0';
							CTRLcombos <= "00000";
					END CASE;
				WHEN '1' =>
					IF(SCANPRESSING = '0') THEN
						ALTpressed <= '0';
						CTRLcombos <= "00000";
						PRESSTATE := '0';
					END IF;
			END CASE;
		ELSIF(CLK'EVENT AND CLK = '1' AND SHIFTpressed = '1') THEN
			CASE PRESSTATE IS
				WHEN '0' =>
					CASE SCANCODE IS
						-- [!] SHIFT + 1 (0x21)
						WHEN x"16" =>
							SHIFTcombos <= "0100001";
							PRESSTATE := '1';
						-- ["] SHIFT + ' (0x22)
						WHEN x"0E" =>
							SHIFTcombos <= "0100010";
							PRESSTATE := '1';
						-- [#] SHIFT + 3 (0x23)
						WHEN x"26" =>
							SHIFTcombos <= "0100011";
							PRESSTATE := '1';
						-- [$] SHIFT + 4 (0x24)
						WHEN x"25" =>
							SHIFTcombos <= "0100100";
							PRESSTATE := '1';
						-- [%] SHIFT + 5 (0x25)
						WHEN x"2E" =>
							SHIFTcombos <= "0100101";
							PRESSTATE := '1';
						-- [&] SHIFT + 7 (0x26)
						WHEN x"3D" =>
							SHIFTcombos <= "0100110";
							PRESSTATE := '1';
						-- [(] SHIFT + 9 (0x28)
						WHEN x"46" =>
							SHIFTcombos <= "0101000";
							PRESSTATE := '1';
						-- [)] SHIFT + 0 (0x29)
						WHEN x"45" =>
							SHIFTcombos <= "0101001";
							PRESSTATE := '1';
						-- [*] SHIFT + 8 (0x2A)
						WHEN x"3E" =>
							SHIFTcombos <= "0101010";
							PRESSTATE := '1';
						-- [+] SHIFT + = (0x2B)
						WHEN x"55" =>
							SHIFTcombos <= "0101011";
							PRESSTATE := '1';
						-- [:] SHIFT + ; (0x3A)
						WHEN x"4A" =>
							SHIFTcombos <= "0111010";
							PRESSTATE := '1';
						-- [<] SHIFT + , (0x3C)
						WHEN x"41" =>
							SHIFTcombos <= "0111100";
							PRESSTATE := '1';
						-- [>] SHIFT + . (0x3E)
						WHEN x"49" =>
							SHIFTcombos <= "0111110";
							PRESSTATE := '1';
						-- [?] SHIFT + / (0x3F)
						WHEN x"51" =>
							SHIFTcombos <= "0111111";
							PRESSTATE := '1';
						-- [@] SHIFT + 2 (0x40)
						WHEN x"1E" =>
							SHIFTcombos <= "1000000";
							PRESSTATE := '1';
						-- [A] SHIFT + a (0x41)
						WHEN x"1C" =>
							SHIFTcombos <= "1000001";
							PRESSTATE := '1';
						-- [B] SHIFT + b (0x42)
						WHEN x"32" =>
							SHIFTcombos <= "1000010";
							PRESSTATE := '1';
						-- [C] SHIFT + c (0x43)
						WHEN x"21" =>
							SHIFTcombos <= "1000011";
							PRESSTATE := '1';
						-- [D] SHIFT + d (0x44)
						WHEN x"23" =>
							SHIFTcombos <= "1000100";
							PRESSTATE := '1';
						-- [E] SHIFT + e (0x45)
						WHEN x"24" =>
							SHIFTcombos <= "1000101";
							PRESSTATE := '1';
						-- [F] SHIFT + f (0x46)
						WHEN x"2B" =>
							SHIFTcombos <= "1000110";
							PRESSTATE := '1';
						-- [G] SHIFT + g (0x47)
						WHEN x"34" =>
							SHIFTcombos <= "1000111";
							PRESSTATE := '1';
						-- [H] SHIFT + h (0x48)
						WHEN x"33" =>
							SHIFTcombos <= "1001000";
							PRESSTATE := '1';
						-- [I] SHIFT + i (0x49)
						WHEN x"43" =>
							SHIFTcombos <= "1001001";
							PRESSTATE := '1';
						-- [J] SHIFT + j (0x4A)
						WHEN x"3B" =>
							SHIFTcombos <= "1001010";
							PRESSTATE := '1';
						-- [K] SHIFT + k (0x4B)
						WHEN x"42" =>
							SHIFTcombos <= "1001011";
							PRESSTATE := '1';
						-- [L] SHIFT + l (0x4C)
						WHEN x"4B" =>
							SHIFTcombos <= "1001100";
							PRESSTATE := '1';
						-- [M] SHIFT + m (0x4D)
						WHEN x"3A" =>
							SHIFTcombos <= "1001101";
							PRESSTATE := '1';
						-- [N] SHIFT + n (0x4E)
						WHEN x"31" =>
							SHIFTcombos <= "1001110";
							PRESSTATE := '1';
						-- [O] SHIFT + o (0x4F)
						WHEN x"44" =>
							SHIFTcombos <= "1001111";
							PRESSTATE := '1';
						-- [P] SHIFT + p (0x50)
						WHEN x"4D" =>
							SHIFTcombos <= "1010000";
							PRESSTATE := '1';
						-- [Q] SHIFT + q (0x51)
						WHEN x"15" =>
							SHIFTcombos <= "1010001";
							PRESSTATE := '1';
						-- [R] SHIFT + r (0x52)
						WHEN x"2D" =>
							SHIFTcombos <= "1010010";
							PRESSTATE := '1';
						-- [S] SHIFT + s (0x53)
						WHEN x"1B" =>
							SHIFTcombos <= "1010011";
							PRESSTATE := '1';
						-- [T] SHIFT + t (0x54)
						WHEN x"2C" =>
							SHIFTcombos <= "1010100";
							PRESSTATE := '1';
						-- [U] SHIFT + u (0x55)
						WHEN x"3C" =>
							SHIFTcombos <= "1010101";
							PRESSTATE := '1';
						-- [V] SHIFT + v (0x56)
						WHEN x"2A" =>
							SHIFTcombos <= "1010110";
							PRESSTATE := '1';
						-- [W] SHIFT + w (0x57)
						WHEN x"1D" =>
							SHIFTcombos <= "1010111";
							PRESSTATE := '1';
						-- [X] SHIFT + x (0x58)
						WHEN x"22" =>
							SHIFTcombos <= "1011000";
							PRESSTATE := '1';
						-- [Y] SHIFT + y (0x59)
						WHEN x"35" =>
							SHIFTcombos <= "1011001";
							PRESSTATE := '1';
						-- [Z] SHIFT + z (0x5A)
						WHEN x"1A" =>
							SHIFTcombos <= "1011010";
							PRESSTATE := '1';
						-- [^] SHIFT + ~ (0x5E)
						WHEN x"52" =>
							SHIFTcombos <= "1011110";
							PRESSTATE := '1';
						-- [_] SHIFT + - (0x5F)
						WHEN x"4E" =>
							SHIFTcombos <= "1011111";
							PRESSTATE := '1';
						-- [`] SHIFT + ' (0x60)
						WHEN x"54" =>
							SHIFTcombos <= "1100000";
							PRESSTATE := '1';
						-- [{] SHIFT + [ (0x7B)
						WHEN x"5B" =>
							SHIFTcombos <= "1111011";
							PRESSTATE := '1';
						-- [|] SHIFT + \ (0x7C)
						WHEN x"61" =>
							SHIFTcombos <= "1111100";
							PRESSTATE := '1';
						-- [}] SHIFT + ] (0x7D)
						WHEN x"5D" =>
							SHIFTcombos <= "1111101";
							PRESSTATE := '1';
						WHEN OTHERS =>
							SHIFTcombos <= "0000000";
					END CASE;
				WHEN '1' =>
					IF(SCANPRESSING = '0') THEN
						SHIFTcombos <= "0000000";
						PRESSTATE := '0';
					END IF;
			END CASE;
		END IF;
	END PROCESS;

	PROCESS(CLK, RST)
	
		VARIABLE PRESSTATE : STD_LOGIC;
		VARIABLE COUNTDOWN : INTEGER RANGE 0 TO 10000000;
		
	BEGIN
		IF(RST = '1') THEN
			COUNTDOWN := 0;
			HALT_REQ <= '0';
			RESET_REQ <= '0';
			PRESSTATE := '0';
		ELSIF(CLK'EVENT AND CLK = '1' AND ALTpressed = '1') THEN
			CASE PRESSTATE IS
				WHEN '0' =>
					CASE SCANCODE IS
						-- [RESET] CTRL + ALT + DEL (Emit RESET_REQ)
						WHEN x"71" =>
							IF(COUNTDOWN = 10000000) THEN
								RESET_REQ <= '1';
								PRESSTATE := '1';
							ELSE
								COUNTDOWN := COUNTDOWN + 1;
							END IF;
						-- [HALT] CTRL + ALT + H (Emit HALT_REQ)
						WHEN x"33" =>
							HALT_REQ <= '1';
							PRESSTATE := '1';
						WHEN OTHERS =>
							COUNTDOWN := 0;
							RESET_REQ <= '0';
							HALT_REQ <= '0';
					END CASE;
				WHEN '1' =>
					IF(SCANPRESSING = '0') THEN
						COUNTDOWN := 0;
						RESET_REQ <= '0';
						HALT_REQ <= '0';
						PRESSTATE := '0';
					END IF;
			END CASE;
		END IF;
	END PROCESS;
	
	PROCESS(CLK, RST)
	BEGIN
		IF(RST = '1') THEN
			ASCII <= x"00";
		ELSIF(CLK'EVENT AND CLK = '1') THEN
			IF(NOT (CTRLcombos = "00000")) THEN
				ASCII <= "000" & CTRLcombos;
			ELSIF(NOT (NORMALpress = x"00")) THEN
				ASCII <= NORMALpress;
			ELSIF(NOT (SHIFTcombos = "0000000")) THEN
				ASCII <= '0' & SHIFTcombos;
			ELSE
				ASCII <= x"00";
			END IF;
		END IF;
	END PROCESS;
END main;