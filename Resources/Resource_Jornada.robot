*** Settings ***
Resource          ../Resources/Resource.robot  


*** Variables ***
${REGIONS}                      São Paulo
@{Laboptions}                   alta    delboni    labsim    cpclin    innova    insitus    cerpe    vital  salomao    oswaldo
...                             lavoisier    previlab    vale    ribeirao    itulab    santapaula    h9j    hemat
${LABORATORY}                   //img[@src='/static/646a3092b248c1c4f8f78a7290f7c0c3/28598/delboni.png']
${Nossas_Marcas_Link}           //a[contains(text(),'Nossas Marcas')] 
${Nossas_Marcas_Page}           //h2[contains(.,'Nossas Marcas')]
${Opções_Regiões}               //select[@name='locations'] 
${Região_Selecionada}           //h3[contains(.,'${REGIONS}')]
${Delboni_Home}                 //img[contains(@alt,'Home')]

            
    


*** Keywords ***

################################################################################################### 
#Cenarios para o teste de Jornada Paciente
################################################################################################### 
Dado que o usuário acesse a página Nossas Marcas
    Acessar a página dasa
    Acessar link Nossas Marcas


Quando pesquisar pela região de ${REGIONS}
    Pesquisar pela região ${REGIONS}

E selecionar o laboratório ${LABORATORY}
   Selecionar laboratório ${LABORATORY}


Então o usuário deve ser encaminhado para a nova página
    Switch Window                       NEW
    Wait until page contains            ${PAGE_TITLE_DELBONI}   
    Click Element                       ${Delboni_Home} 
    Title Should be                     ${PAGE_TITLE_DELBONI}


################################################################################################### 
#Ações para o teste de jornada paciente
################################################################################################### 


Acessar link Nossas Marcas
    Mouse Over                          ${Somos_Dasa_Link} 
    Click Element                       ${Nossas_Marcas_Link} 
             

Pesquisar pela região ${REGIONS}
    Wait until Element is Visible       ${Nossas_Marcas_Page}  
    Select From List By Value           ${Opções_Regiões}        ${REGIONS}
    Repeat Keyword                      3 times                  Acessar próximo campo
    Wait until Element is Visible       ${Região_Selecionada} 
    Remove File                         ${EXECDIR}/Resources/Fixtures/Laboratorios/Labs.json         
    Append to File                      ${EXECDIR}/Resources/Fixtures/Laboratorios/Labs.json                 {   
    Pecorrer laboratorios
    Append to File                      ${EXECDIR}/Resources/Fixtures/Laboratorios/Labs.json                 "Labs": "Final"}


Selecionar laboratório ${LABORATORY}
    Click Element                       ${LABORATORY}     


Acessar próximo campo
    Press Keys                              None        TAB

Pecorrer laboratorios
    ${COUNT} =    Set Variable    ${0}
     FOR    ${Laboratories}    IN    @{Laboptions}
            ${labs}                Get Element Attribute                //a[contains(@href, '${Laboratories}')]         href
            Log to Console                ${Labs}
            ${COUNT} =    Set Variable    ${COUNT + 1}
            Append to File                ${EXECDIR}/Resources/Fixtures/Laboratorios/Labs.json                "Laboratorio ${COUNT}": "${Laboratories}", "link": "${Labs}",\n
            Run Keyword If               '${Laboratories}' == 'hemat'    Log to Console    Esses são os laboratórios!!! 
     END 

