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
Consulta Produto
    [Tags]    rapido
    Dado que acesso o site como cliente
    Quando escrevo "Ração" na barra de pesquisa
    E clico no botão da lupa
    Entao exibe um grid e a frase do resultado esperado com "RAÇÃO"



*** Keywords ***

Dado que acesso o site como cliente
    open browser    ${url}  ${browser}

Quando escrevo "${palavra_chave}" na barra de pesquisa
    set test variable       ${palavra_chave}
    input text                      name = q    ${palavra_chave}

E clico no botão da lupa
    click button      class = button-search

Entao exibe um grid e a frase do resultado esperado com ${palavra_chave}
    wait until element is visible  css = h1.h2Categoria.nomeCategoria   10000ms
    ${palavra_chave_upper}  convert to upper case  ${palavra_chave}
    element should contain          css = h1.h2Categoria.nomeCategoria    RESULTADOS PARA  "${palavra_chave_upper}"

