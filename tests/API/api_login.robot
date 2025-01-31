*** Settings ***
Resource    ../../setups/main.robot

*** Test Cases ***
CT001 - Validar a tentativa de login via API sem informar as credenciais
    Validar a tentativa de login via API sem informar as credenciais

CT002 - Validar login pela API
    Validar login pela API