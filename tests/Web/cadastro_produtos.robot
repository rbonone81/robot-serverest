*** Settings ***
Resource    ../../setups/main.robot

*** Test Cases ***
CT001 - Validar cadastro de um novo produto
    Dado que estou acessando a página de de cadastro de Produtos
    Quando cadastro um novo produto
    Então vejo que o cadastro do produto foi feito com sucesso
