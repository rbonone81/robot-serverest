*** Variables ***
&{Login}
...    input_email=id=email
...    input_senha=id=password
...    input_nome=id=nome
...    button_entrar=xpath=//*[@class="btn btn-primary"]
...    lnk_cadastrar=xpath=//*[@data-testid="cadastrar"]
...    btn_cadastrar=xpath=//*[@data-testid="cadastrar"][contains(text(),'Cadastrar')]
...    chk_admin=id=administrador
...    msg_sucesso=xpath=//*[contains(text(), 'Cadastro realizado com sucesso')]  