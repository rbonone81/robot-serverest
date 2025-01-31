*** Settings ***
Resource    ../../setups/main.robot

*** Test Cases ***
CT001 - Validar cadastro de um usuário admin pela API
    Cadastrar um usuário admin pela API

CT002 - Validar cadastro de um usuário cliente pela API
    Cadastrar um usuário cliente pela API