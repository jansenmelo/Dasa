*** Settings ***
Library           SeleniumLibrary 
Library           ScreenCapLibrary
Library           OperatingSystem    

*** Variables ***
${BROWSER}                  Chrome
${URL}                      https://dasa.com.br/
${CONSOLE_CLEAR}            add_experimental_option('excludeSwitches', ['enable-logging'])
${PAGE_TITLE_DASA}          Dasa - A maior rede de Saúde Integrada 
${PAGE_TITLE_DELBONI}       Delboni Auriemo | Laboratório de Exames e de Imagem 
${Somos_Dasa_Link}          (//div[contains(.,'Somos Dasa')])[10]
${OPTIONS}                  add_argument("--disable-dev-shm-usage"); add_argument("--no-sandbox"); add_argument("window-size=1920x1080") 

*** Keywords ***
###################################################################################################  
# Suite e Teardown
###################################################################################################  

Abrir Navegador
    Run Keyword if    '${BROWSER}'=='Chrome'          Abrir chrome
    Run Keyword if    '${BROWSER}'=='Firefox'         Abrir firefox
    Maximize Browser Window
    ScreenCapLibrary.Set Screenshot Directory     ${EXECDIR}/logs/Records/
    Empty Directory                               ${EXECDIR}/logs/Records/
    Start Video Recording                         name=${SUITE NAME}_${TEST NAME}       embed=True
    Set Selenium Timeout        15

Fechar Navegador
    Capture Page Screenshot     EMBED
    Stop Video Recording
    Close Browser

###################################################################################################  
#    Configuração do navegador
###################################################################################################  
Abrir chrome
    Open Browser    about:blank    ${BROWSER}       options=${OPTIONS};${CONSOLE_CLEAR}

Abrir firefox
    Open Browser    about:blank    ${BROWSER}
    Set Selenium Speed             0.5



###################################################################################################       
 # Acesso a páginas
################################################################################################### 

Acessar a página dasa
    Go To    ${URL}
    Wait Until Page Contains Element      ${Somos_Dasa_Link}  
    Title Should Be                       ${PAGE_TITLE_DASA}
