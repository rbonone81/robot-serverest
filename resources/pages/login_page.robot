*** Settings ***
Resource    ../../setups/main.robot

*** Variables ***
${nome_usu}    Teste Novo Usuário
${email_usu}    testenovousuario
${senha_usu}    testenovousuario

*** Keywords ***
Dado que acesso a página de login
    Acessar o sistema

Quando faço o login no sistema
    Logar no sistema com dados válidos

Quando cadastro um novo usuário ${tipo_usuario} pela tela de login
    Acessar a tela de cadastro de usuário pela página de login
    Cadastrar novo usuário ${tipo_usuario}



Logar no sistema com dados válidos
    Wait Until Element Is Visible     ${Login.input_email}
    Input Text    ${Login.input_email}    user1738239866375@testing.com
    Input Text    ${Login.input_senha}    teste
    Click Button    ${Login.button_entrar}

Acessar o sistema
    Open Browser    https://front.serverest.dev/    browser=Chrome    
    Maximize Browser Window

Acessar a tela de cadastro de usuário pela página de login
    Wait Until Element Is Visible    ${Login.lnk_cadastrar}
    Click Element    ${Login.lnk_cadastrar}
    Validar tela de cadastro de usuário

Validar tela de cadastro de usuário
    Wait Until Element Is Visible    ${Login.input_nome}
    Wait Until Element Is Visible    ${Login.input_email}
    Wait Until Element Is Visible    ${Login.input_senha}
    Wait Until Element Is Visible    ${Login.btn_cadastrar}
    Wait Until Element Is Visible    ${Login.chk_admin}

Cadastrar novo usuário ${tipo_usuario}
    ${temp}     Generate Random String  5   [LETTERS]

    Wait Until Element Is Visible    ${Login.input_nome}
    Input Text    ${Login.input_nome}    ${nome_usu} ${temp}
    Wait Until Element Is Visible    ${Login.input_email}
    Input Text    ${Login.input_email}    ${email_usu}${temp}@teste.com
    Wait Until Element Is Visible    ${Login.input_senha}
    Input Text    ${Login.input_senha}    ${senha_usu}${temp}

    Run Keyword If    '${tipo_usuario}' == 'admin'    Select Checkbox    ${Login.chk_admin}
    Click Button    ${Login.btn_cadastrar}
    Wait Until Element Is Visible    ${Login.msg_sucesso}

Então vejo que o usuário ${tipo_usuario} foi cadastrado com sucesso
    IF    '${tipo_usuario}' == 'admin'
        Validar acesso na home do sistema
    ELSE
        Validar acesso na home do cliente
    END

### API ###

Validar login pela API
    ${email}    Set Variable    user1738239866375@testing.com
    ${password}    Set Variable    teste
    ${status}    Set Variable    200

    ${RESPONSE}    Fazer login com ${email}, ${password} e ${status}

    Should Be Equal As Strings    ${RESPONSE}[message]    Login realizado com sucesso

Fazer login com ${email}, ${password} e ${status}
    ${URL}             Format String        ${TESTE.urlGetLogin}
    ${HEADERS}         Create Dictionary    Content-Type=application/json
    ${BODY}            Format String        ${TESTE.bodyGetLogin}
        ...    email=${email}
        ...    password=${password}

    Create Session    alias=api_teste     url=${TESTE.host_teste}    headers=${HEADERS}    auth=None            disable_warnings=True
    ${RESPONSE}       Post On Session     alias=api_teste    url=${URL}            data=${BODY}         expected_status=${status}
    
    RETURN    ${RESPONSE.json()}

Validar a tentativa de login via API sem informar as credenciais
    ${email}    Set Variable    ''
    ${password}    Set Variable    
    ${status}    Set Variable    400
    ${RESPONSE}    Fazer login com ${email}, ${password} e ${status}

    ${nome_val}    Set Variable    ${RESPONSE}[email]
    ${senha_val}    Set Variable    ${RESPONSE}[password]
    Should Be Equal    ${nome_val}    email deve ser um email válido
    Should Be Equal    ${senha_val}    password não pode ficar em branco