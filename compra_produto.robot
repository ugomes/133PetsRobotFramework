*** Settings ***
Documentation    Consultas no site da Petz

Library  SeleniumLibrary
Library  OperatingSystem
Library  String

Test Teardown   close browser

*** Variables ***
${browser}       Chrome
${url}           https://www.petz.com.br

*** Test Cases ***

Compra de Produto
    [Tags]    rapido
    Dado que acesso o site como cliente
    Quando escrevo "Pote" na barra de pesquisa
    E aperto a tecla ENTER
    Entao exibe um grid e a frase do resultado esperado
    Quando seleciona o produto "Porta Ração Petz Rosa 1kg"
    Então exibe o produto como o preco de "R$ 59,99"
    Quando mudo a quantidade do produto para "2"
    E clico no botao Adicionar no carrinho
    Entao exibe a pagina do carrinho com o total e "R$ 119,98"


*** Keywords ***

Dado que acesso o site como cliente
    open browser    ${url}  ${browser}

Quando escrevo "${palavra_chave}" na barra de pesquisa
    set test variable       ${palavra_chave}
    input text                      name = q    ${palavra_chave}

E aperto a tecla ENTER
    press keys     name = q     ENTER

Entao exibe um grid e a frase do resultado esperado
    ${palavra_chave_upper}  convert to upper case  ${palavra_chave}
    wait until element is visible   css = h1.h2Categoria.nomeCategoria
    element should contain          css = h1.h2Categoria.nomeCategoria      RESULTADOS PARA "${palavra_chave_upper}"

Quando seleciona o produto "${produto}"
    set test variable               ${produto}
    wait until element is enabled   xpath = //a[@data-nomeproduto="${produto}"]      30000ms
    click element                   xpath = //a[@data-nomeproduto="${produto}"]

Então exibe o produto como o preco de "${preco}"
    wait until element is visible   xpath = //h1
    element should contain           xpath = //h1               ${produto}
    element should contain          class = current-price-left  ${preco}


Quando mudo a quantidade do produto para "2"
    click button    xpath = //button[@onclick="changeQuantity('plus')"]

E clico no botao Adicionar no carrinho
    click button    id = adicionarAoCarrinho

Entao exibe a pagina do carrinho com o total e "${preco_total}"
    #wait until element is visible    css = cart-item-detail flex col cont-center align-itstart   30000ms
    #element should contain           css = cart-item-detail flex col cont-center align-itstart ${produto}

    wait until element is visible    class = tx-blue money   30000ms
    element should contain           xpath = tx-blue money                 ${preco_total}
