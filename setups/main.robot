*** Settings ***
Library    SeleniumLibrary
Library    String
Library    RequestsLibrary

### Pages ###
Resource    ../resources/pages/login_page.robot
Resource    ../resources/pages/home_page.robot
Resource    ../resources/pages/cadastro_usuarios_page.robot
Resource    ../resources/pages/cadastro_produtos_page.robot

### Data ###
Variables    ../resources/data/teste.yml

### Locators ###
Resource    ../resources/locators/login_locators.resource
Resource    ../resources/locators/home_locators.resource
Resource    ../resources/locators/cadastro_usuarios_locators.resource
Resource    ../resources/locators/cadastro_produtos_locators.resource

*** Keywords ***
Buscar token
    ${temp}     Generate Random String  5   [LETTERS]
    ${nome}    Set Variable    Teste Novo Usuário ${temp}
    ${email}    Set Variable    testenovousuario${temp}@teste.com
    ${password}    Set Variable    testenovousuario${temp}
    ${administrador}    Set Variable    true
    ${status}    Set Variable    201

    Cadastrar usuário pela API com $nome, ${email}, ${password}, ${administrador} e ${status}
    ${RESPONSE}    Fazer login com ${email}, ${password} e 200
    ${token}    Set Variable    ${RESPONSE}[authorization]
    
    RETURN    ${token}