*** Variables ***
&{Home}
...    label1=xpath=//*[@class="lead"][contains(text(), 'Este é seu sistema para administrar seu ecommerce.')]
...    button_logout=xpath=//*[@data-testid="logout"]
...    btn_pesquisar=xpath=//*[@data-testid="botaoPesquisar"]
...    btn_cad_usu=xpath=//*[@data-testid="cadastrarUsuarios"]
...    btn_cad_prod=xpath=//*[@data-testid="cadastrarProdutos"]
...    label_card_cad_usuarios=xpath=//*[@class="card-title"][contains(text(), 'Cadastrar Usuários')]
...    label_card_lista_usuarios=xpath=//*[@class="card-title"][contains(text(), 'Listar Usuários')]
...    label_card_cad_produtos=xpath=//*[@class="card-title"][contains(text(), 'Cadastrar Produtos')]
...    label_card_lista_produtos=xpath=//*[@class="card-title"][contains(text(), 'Listar Produtos')]
...    label_card_relatorios=xpath=//*[@class="card-title"][contains(text(), 'Relatórios')]
...    input_pesquisar=xpath=//*[@data-testid="pesquisar"]  