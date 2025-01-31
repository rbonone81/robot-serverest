*** Settings ***
Resource    ../../setups/main.robot

*** Keywords ***
### WEB ###
Então vejo que o usuário acessou a home do sistema
    Validar acesso na home do sistema
    Fazer logout
    
Validar acesso na home do sistema
    Wait Until Element Is Visible    ${Home.label1}
    Element Should Be Visible    ${Home.button_logout}
    Element Should Be Visible    ${Home.label_card_cad_usuarios}
    Element Should Be Visible    ${Home.label_card_lista_usuarios}
    Element Should Be Visible    ${Home.label_card_cad_produtos}
    Element Should Be Visible    ${Home.label_card_lista_produtos}
    Element Should Be Visible    ${Home.label_card_relatorios}

Validar acesso na home do cliente
    Wait Until Element Is Visible    ${Home.btn_pesquisar}
    Element Should Be Visible    ${Home.button_logout}     

Acessar a página de cadastro de usuários
    Wait Until Element Is Visible    ${Home.btn_cad_usu}
    Click Element    ${Home.btn_cad_usu}

Acessar a página de cadastro de produtos
    Wait Until Element Is Visible    ${Home.btn_cad_prod}
    Click Element    ${Home.btn_cad_prod}

Fazer logout
    Wait Until Element Is Visible    ${Home.button_logout}
    Click Button    ${Home.button_logout}
    Validar página de login