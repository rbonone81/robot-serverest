*** Settings ***
Resource    ../../setups/main.robot

*** Variables ***
${email_g}
${nome_g}
${senha_g}

*** Keywords ***
Criar massa de usuário
    ${temp}     Generate Random String  5   [LETTERS]    
    Set Global Variable    ${email_g}    testenovousuario${temp}@teste.com
    Set Global Variable    ${nome_g}    Teste Novo Usuário ${temp}
    Set Global Variable    ${senha_g}    testenovousuario${temp}

Dado que estou acessando a página de de cadastro de usuários
    Acessar o sistema
    Logar no sistema com dados válidos
    Validar acesso na home do sistema
    Acessar a página de cadastro de usuários

Quando cadastro um novo usuário admin
    Cadastrar usuário admin

Então vejo que o cadastro do usuário foi feito com sucesso
    Validar sucesso no cadastro do usuário

Cadastrar usuário admin
    Criar massa de usuário

    Wait Until Element Is Visible    ${Cad_Usuarios.input_nome}
    Input Text    ${Cad_Usuarios.input_nome}    ${nome_g}
    Wait Until Element Is Visible    ${Cad_Usuarios.input_email}
    Input Text    ${Cad_Usuarios.input_email}    ${email_g}
    Wait Until Element Is Visible    ${Cad_Usuarios.input_senha}
    Input Password    ${Cad_Usuarios.input_senha}    ${senha_g} 
    Wait Until Element Is Visible    ${Cad_Usuarios.chk_admin}
    Select Checkbox    ${Cad_Usuarios.chk_admin}
    Checkbox Should Be Selected    ${Cad_Usuarios.chk_admin}
    Wait Until Element Is Visible    ${Cad_Usuarios.btn_cadastrar}
    Click Button    ${Cad_Usuarios.btn_cadastrar}
    
Validar sucesso no cadastro do usuário
    Wait Until Element Is Visible    ${Cad_Usuarios.tab_usuarios}
    Sleep    1
    ${tabela_completa}    Get Text    ${Cad_Usuarios.tab_usuarios}
    Should Contain    ${tabela_completa}    ${email_g}
    Should Contain    ${tabela_completa}    ${nome_g}
    Should Contain    ${tabela_completa}    ${senha_g}

### API ###
Cadastrar um usuário admin pela API
    Criar massa de usuário
    ${administrador}    Set Variable    true
    ${status}    Set Variable    201

    ${RESPONSE}    Cadastrar usuário pela API com ${nome_g}, ${email_g}, ${senha_g}, ${administrador} e ${status}
    ${mensagem_val}    Set Variable    ${RESPONSE}[message]
    Should Be Equal    ${mensagem_val}    Cadastro realizado com sucesso

Cadastrar um usuário cliente pela API
    Criar massa de usuário
    ${administrador}    Set Variable    false
    ${status}    Set Variable    201

    ${RESPONSE}    Cadastrar usuário pela API com ${nome_g}, ${email_g}, ${senha_g}, ${administrador} e ${status}
    ${mensagem_val}    Set Variable    ${RESPONSE}[message]
    Should Be Equal    ${mensagem_val}    Cadastro realizado com sucesso

Cadastrar usuário pela API com ${nome}, ${email}, ${password}, ${administrador} e ${status}
    ${URL}             Format String        ${TESTE.urlPostCadUsuarios}
    ${HEADERS}         Create Dictionary    Content-Type=application/json
    ${BODY}            Format String        ${TESTE.bodyPostTeste}
        ...    nome=${nome}
        ...    email=${email}
        ...    password=${password}
        ...    administrador=${administrador}

    Create Session    alias=api_teste     url=${TESTE.host_teste}    headers=${HEADERS}    auth=None            disable_warnings=True
    ${RESPONSE}       Post On Session     alias=api_teste    url=${URL}            data=${BODY}         expected_status=${status}

    RETURN    ${RESPONSE.json()}

Buscar usuário pelo id ${id_usuario}

    ${URL}             Format String        ${TESTE.urlPostCadUsuarios}/${id_usuario}
    ${HEADERS}         Create Dictionary    Content-Type=application/json

    Create Session    alias=api_teste     url=${TESTE.host_teste}    headers=${HEADERS}    auth=None            disable_warnings=True
    ${RESPONSE}       Get On Session     alias=api_teste    url=${URL}        expected_status=200

    RETURN    ${RESPONSE.json()}