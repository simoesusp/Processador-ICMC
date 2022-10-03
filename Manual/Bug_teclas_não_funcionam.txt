Na execução do simulador as teclas do “Home” e “End” não funcionam em teclados onde as teclas de “Home” e “End” não são próprias (estão com o teclado numérico ou são ativadas por meio do Fn)

Como resolver:
	→ Ir no arquivo View.cpp. Procurar pela função gboolean View::teclado (atualmente na linha 549 do código) e descomentar a parte “cout << tecla << endl;”. Isso fará que o simulador imprima no terminal o nome de todas as teclas que são utilizadas durante a execução do simulador.
	→ Assim, compile o simulador novamente e execute-o. Durante esse tempo clique nas teclas “Home” e “End”, o que fara aparecer no terminal o nome delas. Outra coisa que pode ser feita é escolher outras teclas para realizar as funções do “Home” e “End”, nesse caso, descubra qual o nome delas.
	→ Após isso, ir no arquivo Controller.cpp e encontrar a função “bool Controller::userInput”. Nessa função localizar a parte do código que possui “Home” e trocar por “[nome_impresso_no_terminal]” e depois localizar o “End” e trocar por “[outro_nome_impresso]”.
	→ Recompilar o simulador e ele estará funcionando
