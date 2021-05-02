*** Settings ***
Resource          ../Resources/Resource_Jornada.robot
Resource          ../Resources/Resource.robot    
Test Setup        Abrir Navegador
Test Teardown     Fechar Navegador
Documentation


*** Test Cases ***
###################################################################################################  
Cenario 01 - Jornada Paciente
    [Documentation]     O Teste abaixo verifica se o usuário consegue fazer login com uma conta já criada. 
    ...                 Os dados utilizados no teste (EMAIL & Senha_Email) estão no arquivo JSON chamado dados.json.                    
    [Tags]  Acesso laboratorios

    Dado que o usuário acesse a página Nossas Marcas
    Quando pesquisar pela região de ${REGIONS}
    E selecionar o laboratório ${LABORATORY}
    Então o usuário deve ser encaminhado para a nova página
###################################################################################################  