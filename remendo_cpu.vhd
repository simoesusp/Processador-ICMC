-- Maquina de Controle
process(clk, reset)

	--Register Declaration:	
	variable PC		: STD_LOGIC_VECTOR(15 downto 0);		-- Program Counter
	variable IR		: STD_LOGIC_VECTOR(15 downto 0);		-- Instruction Register
	variable SP		: STD_LOGIC_VECTOR(15 downto 0);		-- Stack Pointer
	variable MAR	: STD_LOGIC_VECTOR(15 downto 0);		-- Memory address Register
	VARIABLE	TECLADO	:STD_LOGIC_VECTOR(15 downto 0);		-- Registrador para receber dados do teclado -- nao tinha
	
	variable reg : Registers;
	
	-- Mux dos barramentos de dados internos	
	VARIABLE	M2				:STD_LOGIC_VECTOR(15 downto 0);	-- Mux dos barramentos de dados internos para os Registradores
	VARIABLE M3, M4		:STD_LOGIC_VECTOR(15 downto 0);	-- Mux dos Registradores para as entradas da ULA
	VARIABLE	M6				:STD_LOGIC_VECTOR(15 downto 0);	-- Mux do Flag Register
	
	-- Novos Sinais da Versao 2: Controle dos registradores internos (Load-Inc-Dec)
	variable LoadReg		: LoadRegisters; 
	variable LoadIR		: std_LOGIC;
	variable LoadMAR		: std_LOGIC;
	variable LoadPC		: std_LOGIC;
	variable IncPC 		: std_LOGIC;
	VARIABLE LoadSP		: STD_LOGIC;
	variable IncSP 		: std_LOGIC;
	variable DecSP			: std_LOGIC;
	variable LoadFR		: std_LOGIC;
		
	-- Selecao dos Mux 2 e 6
	variable selM2 		: STD_LOGIC_VECTOR(2 downto 0); 
	variable selM6 		: STD_LOGIC_VECTOR(2 downto 0); 
	
	VARIABLE BreakFlag	: STD_LOGIC;  -- Para sinalizar a mudanca para Clock manual/Clock Automatico para  a nova instrucao Break
	
	variable state : STATES;  -- Estados do processador: fetch, decode, exec, halted
	
	-- Seletores dos registradores para execussao das instrucoes
	variable RX : integer;   
	variable RY : integer;
	variable RZ : integer;
	
	
begin

	if(reset = '1') then
	
		state := fetch;		-- inicializa o estado na busca!
		M1(15 downto 0) <=	x"0000";  -- inicializa na linha Zero da memoria -> Programa tem que comecar na linha Zero !!
		videoflag <= '0';
		
		RX := 0;
		RY := 0;
		RZ := 0;
		
		RW <= '0';
		
		LoadIR	:= '0';
		LoadMAR	:= '0';
		LoadPC	:= '0';
		IncPC		:= '0';
		IncSP		:= '0';
		DecSP		:= '0';
		LoadSP	:= '0';
		LoadFR	:= '0';
		selM2		:= sMem;
		selM6		:= sULA;
		
		LoadReg(0) := '0';
		LoadReg(1) := '0';
		LoadReg(2) := '0';
		LoadReg(3) := '0';
		LoadReg(4) := '0';
		LoadReg(5) := '0';
		LoadReg(6) := '0';
		LoadReg(7) := '0';
		
		REG(0)  := x"0000";
		REG(1)  := x"0000";	
		REG(2)  := x"0000";
		REG(3)  := x"0000";
		REG(4)  := x"0000";
		REG(5)  := x"0000";
		REG(6)  := x"0000";
		REG(7)  := x"0000";
		
		PC := x"0000";  -- inicializa na linha Zero da memoria -> Programa tem que comecar na linha Zero !!
		SP := x"7ffc";  -- Inicializa a Pilha no final da mem�ria: 7ffc
		IR := x"0000";
		MAR := x"0000";
			
		 BreakFlag:= '0';	-- Break Point Flag
		 BREAK <= '0'; 	-- Break Point output to switch to manual clock	

		 -- Novo na Versao 3
		HALT_ack <= '0';
			
	elsif(clk'event and clk = '1') then
	
		if(LoadIR = '1')	then IR := Mem; 				end if;
	
		if(LoadPC = '1')	then PC := Mem; 				end if;
	
		if(IncPC = '1')	then PC := PC + x"0001"; 	end if;
	
		if(LoadMAR = '1') then MAR := Mem; 				end if;
	
		if(LoadSP = '1') 	then SP := M4; 				end if;
	
		if(IncSP = '1')	then SP := SP + x"0001"; 	end if;
	
		if(DecSP = '1')	then SP := SP - x"0001"; 	end if;
	
		-- Selecao do Mux6
		if (selM6 = sULA) THEN M6 := auxFR;				-- Sempre recebe flags da ULA
		ELSIF (selM6 = sMem) THEN M6 := Mem; END IF;	-- A menos que seja POP FR, quando recebe da Memoria
		
		-- So' carrega o FR quando for Pop FR, Cmp, aritmethic, ou logic.
		if(LoadFR = '1') 	then FR <= M6; 				end if;

		
		-- Atualiza o nome dos registradores!!!
		RX := conv_integer(IR(9 downto 7));
		RY := conv_integer(IR(6 downto 4));
		RZ := conv_integer(IR(3 downto 1));
	
		-- Selecao do Mux2
		if (selM2 = sULA) 		THEN M2 := RESULT;
		ELSIF (selM2 = sMem) 	THEN M2 := Mem;
		ELSIF (selM2 = sM4) 		THEN M2 := M4;
		ELSIF (selM2 = sTECLADO)THEN M2 := TECLADO;
		ELSIF (selM2 = sSP) 		THEN M2 := SP; 
		END IF;			
		
		-- Carrega dados do Mux 2 para os registradores
		if(LoadReg(RX) = '1') then reg(RX) := M2; end if;
	
		-- Reseta os sinais de controle APOS usa-los acima
		-- Zera todos os sinais de controle, para depois ligar um por um nas instrucoes a medida que for necessario: a ultima atribuicao e' a que vale no processo!!!
		LoadIR  := '0';
		LoadMAR := '0';
		LoadPC  := '0';	
		IncPC   := '0';
		IncSP   := '0';
		DecSP   := '0';
		LoadSP  := '0';
		LoadFR  := '0';
		selM6	  := sULA;	-- Sempre atualiza o FR da ULA, a nao ser que a instrucao seja POP FR

		LoadReg(0) := '0';
		LoadReg(1) := '0';
		LoadReg(2) := '0';
		LoadReg(3) := '0';
		LoadReg(4) := '0';
		LoadReg(5) := '0';
		LoadReg(6) := '0';
		LoadReg(7) := '0';

		videoflag <= '0';	-- Abaixa o sinal para a "Placa de Video" : sobe a cada OUTCHAR

		RW <= '0';  -- Sinal de Letura/Ecrita da mem�ria em Leitura  (0 - ler, 1 - escrever)

		-- Novo na Versao 3
		if(halt_req = '1') then state := halted; end if;

		-- Novo na Versao 3: para escrever PC no LCD da placa
		PC_data <= PC;