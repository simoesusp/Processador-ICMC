--SETCARRY NEEDS TO BE FIXED!!!

---------------------------------------------------
--APx-ARCH AP9 Micro-processor---------------------
--16-bits width bus--------------------------------
--External clock-----------------------------------
--Builded by MicroENIX, copyright (r) 2011---------
--For detailed description about this--------------
--architechture, please refer to the AP9 reference--
--manual.------------------------------------------
---------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY AP9_cpu IS
	PORT(
			CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			HALT_REQ : IN STD_LOGIC;
			KEY : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			MEM_DATA : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			MEM_WDATA : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			MEM_ADDR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			MEM_RW : OUT STD_LOGIC;
			VGA_DRAW : OUT STD_LOGIC;
			VGA_POS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			VGA_CC : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			PC_DATA : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			HALT_ACK : OUT STD_LOGIC
		);
END AP9_cpu;

ARCHITECTURE main OF AP9_cpu IS
TYPE STATES IS (fetch, decode, exec, halted);
TYPE REGISTERS IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
TYPE LOADREGISTERS IS ARRAY(0 TO 7) OF STD_LOGIC;

CONSTANT LOAD : STD_LOGIC_VECTOR(5 DOWNTO 0) := "110000";
CONSTANT STORE : STD_LOGIC_VECTOR(5 DOWNTO 0) := "110001";
CONSTANT LOADIMED : STD_LOGIC_VECTOR(5 DOWNTO 0) := "111000";
CONSTANT LOADINDEX : STD_LOGIC_VECTOR(5 DOWNTO 0) := "111100";
CONSTANT STOREINDEX : STD_LOGIC_VECTOR(5 DOWNTO 0) := "111101";
CONSTANT MOV : STD_LOGIC_VECTOR(5 DOWNTO 0) := "110011";

CONSTANT OUTCHAR : STD_LOGIC_VECTOR(5 DOWNTO 0) := "110010";
CONSTANT INCHAR : STD_LOGIC_VECTOR(5 DOWNTO 0) := "110101";

CONSTANT ARITH : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";
CONSTANT ADD : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
CONSTANT SUB : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
CONSTANT MULT : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
CONSTANT DIV : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";
CONSTANT INC : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";
CONSTANT LMOD : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";
CONSTANT CMP : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0110";

CONSTANT LOGIC : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
CONSTANT LAND : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
CONSTANT LOR : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";
CONSTANT LXOR : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";
CONSTANT LNOT : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";
CONSTANT SHIFT : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

CONSTANT JMP : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";
CONSTANT CALL : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000011";
CONSTANT RTS : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";
CONSTANT PUSH : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";
CONSTANT POP : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000110";

CONSTANT NOP : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
CONSTANT SETC : STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";
CONSTANT HALT : STD_LOGIC_VECTOR(5 DOWNTO 0) := "001111";

CONSTANT sULA : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
CONSTANT sMEM : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
CONSTANT sM4 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";
CONSTANT sKEY : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";

CONSTANT FRGREATER : INTEGER := 0;
CONSTANT FRLESSER : INTEGER := 1;
CONSTANT FREQUAL : INTEGER := 2;
CONSTANT FRZERO : INTEGER := 3;
CONSTANT FRCARRY : INTEGER := 4;
CONSTANT FRARITHOF : INTEGER := 5;
CONSTANT FRDIVZERO : INTEGER := 6;
CONSTANT FRSTACKOF : INTEGER := 7;
CONSTANT FRSTACKUF : INTEGER := 8;

CONSTANT IF1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
CONSTANT IFE : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
CONSTANT IFNE : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
CONSTANT IFZ : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";
CONSTANT IFNZ : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";
CONSTANT IFC : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";
CONSTANT IFNC : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";
CONSTANT IFGR : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";
CONSTANT IFLE : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1000";
CONSTANT IFEG : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001";
CONSTANT IFEL : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1010";
CONSTANT IFOV : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1011";
CONSTANT IFNOV : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1100";

SIGNAL OP : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL X, Y, RESULT: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL FR : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL auxFR : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	PROCESS(CLK, RST)
	VARIABLE STATE : STATES;
	VARIABLE PC : STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE SP : STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE IR : STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE MAR : STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE M2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE M4 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE RX : INTEGER;
	VARIABLE RY : INTEGER;
	VARIABLE RZ : INTEGER;
	VARIABLE selM2 : STD_LOGIC_VECTOR(1 DOWNTO 0);
	VARIABLE selM6 : STD_LOGIC_VECTOR(1 DOWNTO 0);
	VARIABLE IncPC : STD_LOGIC;
	VARIABLE IncSP : STD_LOGIC;
	VARIABLE DecSP : STD_LOGIC;
	VARIABLE LoadPC : STD_LOGIC;
	VARIABLE LoadMAR : STD_LOGIC;
	VARIABLE LoadIR : STD_LOGIC;
	VARIABLE LoadREG : LOADREGISTERS;
	VARIABLE COND : STD_LOGIC;
	VARIABLE REG : REGISTERS;
	BEGIN
		IF(RST = '1') THEN
			STATE := fetch;
			PC := x"0000";
			SP := x"3FFC";
			IR := x"0000";
			MAR := x"0000";
			selM2 := sMEM;
			selM6 := sULA;
			IncPC := '0';
			IncSP := '0';
			DecSP := '0';
			LoadPC := '0';
			LoadMAR := '0';
			LoadIR := '0';
			LoadREG := x"00";
			COND := '0';
			MEM_RW <= '0';
			VGA_DRAW <= '0';
			HALT_ACK <= '0';
		ELSIF(CLK'EVENT AND CLK = '1') THEN
			IF(HALT_REQ = '1') THEN
				STATE := halted;
			END IF;
			IF(LoadPC = '1') THEN
				PC := MEM_DATA;
				LoadPC := '0';
			END IF;
			CASE selM2 IS
				WHEN sMEM =>
					M2 := MEM_DATA;
				WHEN sM4 =>
					M2 := M4;
				WHEN sKEY =>
					M2(15 DOWNTO 8) := x"00";
					M2(7 DOWNTO 0) := KEY;
				WHEN sULA =>
					M2 := RESULT;
				WHEN OTHERS =>
			END CASE;
			IF(LoadMAR = '1') THEN
				MAR := MEM_DATA;
				LoadMAR := '0';
			END IF;
			IF(IncSP = '1') THEN
				SP := SP + x"1";
				IncSP := '0';
			END IF;
			IF(DecSP = '1') THEN
				SP := SP - x"1";
				DecSP := '0';
			END IF;
			IF(LoadIR = '1') THEN
				IR := MEM_DATA;
				LoadIR := '0';
			END IF;
			IF(LoadREG(RX) = '1') THEN
				REG(RX) := M2;
				LoadREG(RX) := '0';
			END IF;
			IF(IncPC = '1') THEN
				PC := PC + x"1";
				IncPC := '0';
			END IF;
			CASE selM6 IS
				WHEN sULA =>
					FR <= auxFR;
				WHEN sMEM =>
					FR <= MEM_DATA;
				WHEN OTHERS =>
			END CASE;
			selM6 := sULA;
			PC_DATA <= PC;
			COND := '0';
			MEM_RW <= '0';
			VGA_DRAW <= '0';
			RX := conv_integer(IR(9 DOWNTO 7));
			RY := conv_integer(IR(6 DOWNTO 4));
			RZ := conv_integer(IR(3 DOWNTO 1));
			CASE STATE IS
				WHEN fetch =>
					MEM_ADDR <= PC;
					LoadIR := '1';
					IncPC := '1';
					STATE := decode;
				WHEN decode =>
					IF(IR(15 DOWNTO 14) = ARITH) THEN
						CASE IR(13 DOWNTO 10) IS
							WHEN INC =>
								X <= REG(RX);
								M4 := x"0001";
								Y <= M4;
								IF(IR(6) = '0') THEN
									OP <= '0' & ARITH & ADD;
								ELSE
									OP <= '0' & ARITH & SUB;
								END IF;
								selM2 := sULA;
								LoadREG(RX) := '1';
								STATE := fetch;
							WHEN OTHERS =>
								X <= REG(RY);
								M4 := REG(RZ);
								Y <= M4;
								OP <= IR(0) & ARITH & IR(13 DOWNTO 10);
								selM2 := sULA;
								LoadREG(RX) := '1';
								STATE := fetch;
						END CASE;
					ELSIF(IR(15 DOWNTO 14) = LOGIC) THEN
						CASE IR(13 DOWNTO 10) IS
							WHEN LNOT =>
								M4 := REG(RY);
								Y <= M4;
								OP <= '0' & LOGIC & LNOT;
								selM2 := sULA;
								LoadREG(RX) := '1';
								STATE := fetch;
							WHEN CMP =>
								X <= REG(RX);
								M4 := REG(RY);
								Y <= M4;
								OP <= '0' & LOGIC & CMP;
								STATE := fetch;
							WHEN SHIFT =>
								CASE IR(6 DOWNTO 4) IS
									WHEN "000" =>
										M4 := TO_STDLOGICVECTOR(TO_BITVECTOR(REG(RX)) SLL conv_integer(IR(3 DOWNTO 0)));
									WHEN "001" =>
										M4 := NOT TO_STDLOGICVECTOR(NOT TO_BITVECTOR(REG(RX)) SLL conv_integer(IR(3 DOWNTO 0)));
									WHEN "010" =>
										M4 := TO_STDLOGICVECTOR(TO_BITVECTOR(REG(RX)) SRL conv_integer(IR(3 DOWNTO 0)));
									WHEN "011" =>
										M4 := NOT TO_STDLOGICVECTOR(NOT TO_BITVECTOR(REG(RX)) SRL conv_integer(IR(3 DOWNTO 0)));
									WHEN "100" =>
										M4 := TO_STDLOGICVECTOR(TO_BITVECTOR(REG(RX)) ROL conv_integer(IR(3 DOWNTO 0)));
									WHEN "110" =>
										M4 := TO_STDLOGICVECTOR(TO_BITVECTOR(REG(RX)) ROR conv_integer(IR(3 DOWNTO 0)));
									WHEN OTHERS =>
								END CASE;
								selM2 := sM4;
								LoadREG(RX) := '1';
								STATE := fetch;
							WHEN OTHERS =>
								X <= REG(RY);
								M4 := REG(RZ);
								Y <= M4;
								OP <= '0' & LOGIC & IR(13 DOWNTO 10);
								selM2 := sM4;
								LoadREG(RX) := '1';
								STATE := fetch;
						END CASE;
					ELSE
						CASE IR(15 DOWNTO 10) IS
							WHEN LOAD =>
								MEM_ADDR <= PC;
								LoadMAR := '1';
								IncPC := '1';
								STATE := exec;
							WHEN STORE =>
								MEM_ADDR <= PC;
								LoadMAR := '1';
								IncPC := '1';
								STATE := exec;
							WHEN LOADIMED =>
								MEM_ADDR <= PC;
								selM2 := sMEM;
								LoadREG(RX) := '1';
								IncPC := '1';
								STATE := fetch;
							WHEN LOADINDEX =>
								M4 := REG(RY);
								MEM_ADDR <= M4;
								selM2 := sMEM;
								LoadREG(RX) := '1';
								STATE := fetch;
							WHEN STOREINDEX =>
								MEM_ADDR <= REG(RX);
								M4 := REG(RY);
								MEM_WDATA <= M4;
								MEM_RW <= '1';
								STATE := fetch;
							WHEN MOV =>
								M4 := REG(RY);
								selM2 := sM4;
								LoadREG(RX) := '1';
								STATE := fetch;
							WHEN OUTCHAR =>
								VGA_CC <= REG(RX);
								M4 := REG(RY);
								VGA_POS <= M4;
								VGA_DRAW <= '1';
								STATE := fetch;
							WHEN INCHAR =>
								selM2 := sKEY;
								LoadReg(RX) := '1';
								STATE := fetch;
							WHEN JMP =>
								MEM_ADDR <= PC;
								CASE IR(9 DOWNTO 6) IS
									WHEN IF1 =>
										COND := '1';
									WHEN IFE =>
										COND := FR(FREQUAL);
									WHEN IFNE =>
										COND := NOT FR(FREQUAL);
									WHEN IFZ =>
										COND := FR(FRZERO);
									WHEN IFNZ =>
										COND := NOT FR(FRZERO);
									WHEN IFC =>
										COND := FR(FRCARRY);
									WHEN IFNC =>
										COND := NOT FR(FRCARRY);
									WHEN IFGR =>
										COND := FR(FRGREATER);
									WHEN IFLE =>
										COND := FR(FRLESSER);
									WHEN IFEG =>
										COND := FR(FREQUAL) OR FR(FRGREATER);
									WHEN IFEL =>
										COND := FR(FREQUAL) OR FR(FRLESSER);
									WHEN IFOV =>
										COND := FR(FRARITHOF); --OR FR(FRSTACKOV);
									WHEN IFNOV =>
										COND := NOT FR(FRARITHOF); --OR NOT FR(FRSTACKOF);
									WHEN OTHERS =>
								END CASE;
								IF(COND = '1') THEN
									LoadPC := '1';
								ELSE
									IncPC := '1';
								END IF;
								STATE := fetch;
							WHEN CALL =>
								CASE IR(9 DOWNTO 6) IS
									WHEN IF1 =>
										COND := '1';
									WHEN IFE =>
										COND := FR(FREQUAL);
									WHEN IFNE =>
										COND := NOT FR(FREQUAL);
									WHEN IFZ =>
										COND := FR(FRZERO);
									WHEN IFNZ =>
										COND := NOT FR(FRZERO);
									WHEN IFC =>
										COND := FR(FRCARRY);
									WHEN IFNC =>
										COND := NOT FR(FRCARRY);
									WHEN IFGR =>
										COND := FR(FRGREATER);
									WHEN IFLE =>
										COND := FR(FRLESSER);
									WHEN IFEG =>
										COND := FR(FREQUAL) OR FR(FRGREATER);
									WHEN IFEL =>
										COND := FR(FREQUAL) OR FR(FRLESSER);
									WHEN IFOV =>
										COND := FR(FRARITHOF); --OR FR(FRSTACKOV);
									WHEN IFNOV =>
										COND := NOT FR(FRARITHOF); --OR NOT FR(FRSTACKOF);
									WHEN OTHERS =>
								END CASE;
								IF(COND = '1') THEN
									MEM_WDATA <= PC;
									MEM_ADDR <= SP;
									MEM_RW <= '1';
									DecSP := '1';
									STATE := exec;
								ELSE
									IncPC := '1';
									STATE := fetch;
								END IF;
							WHEN RTS =>
								IncSP := '1';
								STATE := exec;
							WHEN PUSH =>
								IF(IR(6) = '0') THEN
									MEM_WDATA <= REG(RX);
								ELSE
									MEM_WDATA <= FR;
								END IF;
								MEM_ADDR <= SP;
								MEM_RW <= '1';
								DecSP := '1';
								STATE := fetch;
							WHEN POP =>
								IncSP := '1';
								STATE := exec;
							WHEN NOP =>
								STATE := fetch;
							WHEN SETC =>
								selM6 := sULA;
								FR(FRCARRY) <= IR(9);
								STATE := fetch;
							WHEN HALT =>
								STATE := halted;
							WHEN OTHERS =>
								STATE := fetch;
						END CASE;
					END IF;
				WHEN exec =>
					CASE IR(15 DOWNTO 10) IS
						WHEN LOAD =>
							MEM_ADDR <= MAR;
							selM2 := sMEM;
							LoadReg(RX) := '1';
							STATE := fetch;
						WHEN STORE =>
							MEM_ADDR <= MAR;
							MEM_WDATA <= REG(RX);
							MEM_RW <= '1';
							STATE := fetch;
						WHEN CALL =>
							MEM_ADDR <= PC;
							LoadPC := '1';
							STATE := fetch;
						WHEN RTS =>
							MEM_ADDR <= SP;
							LoadPC := '1';
							IncPC := '1';
							STATE := fetch;
						WHEN POP =>
							MEM_ADDR <= SP;
							selM2 := sMEM;
							IF(IR(6) = '0') THEN
								LoadREG(RX) := '1';
							ELSE
								selM6 := sMEM;
							END IF;
							STATE := fetch;
						WHEN OTHERS =>
							STATE := fetch;
					END CASE;
				WHEN halted =>
					HALT_ACK <= '1';
				WHEN OTHERS =>
			END CASE;
		END IF;
	END PROCESS;

	PROCESS(OP, X, Y, RST)
	VARIABLE AUX : STD_LOGIC_VECTOR(15 DOWNTO 0);
	VARIABLE RESULT32 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	BEGIN
		IF(RST = '1') THEN
			auxFR <= x"0000";
			RESULT <= x"0000";
		ELSE
			auxFR <= FR;
			IF(OP(5 DOWNTO 4) = ARITH) THEN
				CASE OP(3 DOWNTO 0) IS
					WHEN ADD =>
						IF(OP(6) = '1') THEN
							AUX := X + Y + FR(FRCARRY);
							RESULT32 := (x"00000000" + X + Y + FR(FRCARRY));
						ELSE
							AUX := X + Y;
							RESULT32 := (x"00000000" + X + Y);					
						END IF;
						IF(RESULT32 > "01111111111111111") THEN
							auxFR(FRCARRY) <= '1';
						ELSE
							auxFR(FRCARRY) <= '0';
						END IF;
					WHEN SUB =>
						AUX := X - Y;
					WHEN MULT =>
						RESULT32 := X * Y;
						AUX := RESULT32(15 DOWNTO 0);
						IF(RESULT32 > x"0000FFFF") THEN
							auxFR(FRARITHOF) <= '1';
						ELSE
							auxFR(FRARITHOF) <= '0';
						END IF;
					WHEN DIV =>
						IF(Y = x"0000") THEN
							AUX := x"0000";
							auxFR(FRDIVZERO) <= '1';
						ELSE
							AUX := CONV_STD_LOGIC_VECTOR(CONV_INTEGER(X)/CONV_INTEGER(Y), 16);
							auxFR(FRDIVZERO) <= '0';
						END IF;
					WHEN LMOD =>
						AUX := CONV_STD_LOGIC_VECTOR(CONV_INTEGER(X) MOD CONV_INTEGER(Y), 16);
					WHEN OTHERS =>
						AUX := X;
				END CASE;
				IF(AUX = x"0000") THEN
					auxFR(3) <= '1';
				ELSE
					auxFR(3) <= '0';
				END IF;
				RESULT <= AUX;
			ELSIF(OP (5 DOWNTO 4) = LOGIC) THEN
				IF(OP (3 DOWNTO 0) = CMP) THEN
					result <= x;
					IF(X > Y) THEN
						auxFR(2 DOWNTO 0) <= "001";
					ELSIF (X < Y) THEN
						auxFR(2 DOWNTO 0) <= "010";
					ELSIF (X = Y) THEN
						auxFR(2 DOWNTO 0) <= "100";
					END IF;
				ELSE
					CASE OP (3 DOWNTO 0) IS
						WHEN LAND =>
							RESULT <= X AND Y;
						WHEN LXOR =>
							RESULT <= X XOR Y;
						WHEN LOR =>
							RESULT <= X OR Y;
						WHEN LNOT =>
							RESULT <= NOT Y;
						WHEN OTHERS =>
							RESULT <= X;
					END CASE;
					IF(RESULT = x"0000") THEN
						auxFR(FRZERO) <= '1';
					ELSE
						auxFR(FRZERO) <= '0';
					END IF;	
				END IF;
			END IF;
		END IF;
	END PROCESS;
END main;