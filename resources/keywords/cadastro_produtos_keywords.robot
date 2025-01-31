*** Settings ***
Resource    ../../setups/main.robot

*** Variables ***
${nome_prod_g}
${descr_g}

*** Keywords ***
Criar massa de produto
    ${temp}     Generate Random String  5   [LETTERS]    
    Set Global Variable    ${nome_prod_g}    Teste Novo Produto ${temp}
    Set Global Variable    ${descr_g}    Descrição do novo produto ${nome_prod_g}

Dado que estou acessando a página de de cadastro de Produtos
    Acessar o sistema
    Logar no sistema com dados válidos
    Validar acesso na home do sistema
    Acessar a página de cadastro de produtos
    
Quando cadastro um novo produto
    Cadastrar novo produto

Cadastrar novo produto
    Criar massa de produto

    Wait Until Element Is Visible    ${Cad_Produtos.input_nome_prod}
    Input Text    ${Cad_Produtos.input_nome_prod}    ${nome_prod_g}
    Wait Until Element Is Visible    ${Cad_Produtos.input_preco}
    Input Text    ${Cad_Produtos.input_preco}    300
    Wait Until Element Is Visible    ${Cad_Produtos.input_descr}
    Input Text    ${Cad_Produtos.input_descr}    ${descr_g} 
    Wait Until Element Is Visible    ${Cad_Produtos.input_qtd}
    Input Text    ${Cad_Produtos.input_qtd}    400
    Wait Until Element Is Visible    ${Cad_Produtos.btn_cadastrar}
    Click Button    ${Cad_Produtos.btn_cadastrar}

Então vejo que o cadastro do produto foi feito com sucesso
    Validar sucesso no cadastro do produto

Validar sucesso no cadastro do produto
    Wait Until Element Is Visible    ${Cad_Produtos.tab_produtos}
    Sleep    1
    ${tabela_completa}    Get Text    ${Cad_Produtos.tab_produtos}
    Should Contain    ${tabela_completa}    ${nome_prod_g}
    Should Contain    ${tabela_completa}    ${descr_g}

### API ###
Validar cadastro de um novo produto via API
    ${token}    Buscar token
    Cadastrar um produto pela API ${token}

Cadastrar um produto pela API ${token}
    Criar massa de produto
    
    ${URL}             Format String        ${TESTE.urlProdutos}
    ${HEADERS}         Create Dictionary    authorization=${token}    Content-Type=application/json
    ${BODY}            Format String        ${TESTE.bodyCardProd}
        ...    nome=${nome_prod_g}
        ...    descricao=${descr_g}
    Create Session    alias=api_teste     url=${TESTE.host_teste}    headers=${HEADERS}    auth=None            disable_warnings=True
    ${RESPONSE}       Post On Session     alias=api_teste    url=${URL}            data=${BODY}         expected_status=201

    Should Be Equal As Strings    ${RESPONSE.json()['message']}    Cadastro realizado com sucesso