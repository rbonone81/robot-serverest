*** Settings ***
Resource    ../../setups/main.robot

*** Test Cases ***
Validar cadastro de um novo usuário admin
    Dado que estou acessando a página de de cadastro de usuários
    Quando cadastro um novo usuário admin
    Então vejo que o cadastro do usuário foi feito com sucesso
    