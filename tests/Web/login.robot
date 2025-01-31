*** Settings ***
Resource    ../../setups/main.robot

*** Test Cases ***
Validar login do usuário com dados válidos
    Dado que acesso a página de login
    Quando faço o login no sistema
    Então vejo que o usuário acessou a home do sistema

Validar o cadastro de um novo usuário admin pela tela de login
    Dado que acesso a página de login
    Quando cadastro um novo usuário admin pela tela de login
    Então vejo que o usuário admin foi cadastrado com sucesso

Validar o cadastro de um novo usuário cliente pela tela de login
    Dado que acesso a página de login
    Quando cadastro um novo usuário cliente pela tela de login
    Então vejo que o usuário cliente foi cadastrado com sucesso