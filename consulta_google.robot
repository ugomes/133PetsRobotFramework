*** Settings ***
Documentation    Testes de Consulta no buscador Google
...  abre o navegador Chrome
...  e realiza a consulta

Library     SeleniumLibrary
Library     OperatingSystem

*** Test Cases ***
Consulta Google

    [Tags]    rápido
    Acessar o Chrome na página <https://www.google.com.br>
    Digitar na pesquisa "Ovos de Páscoa" na pesquisa
    Validar se aparece no titulo da guia o resultado esperado
    Fechar o browser


*** Keywords ***
Acessar o ${browser} na página <${url}>
    open browser    ${url}      ${browser}

Digitar na pesquisa "${palavra_chave}" na pesquisa
    Set Test Variable   ${palavra_chave}
    input text      name = q        ${palavra_chave}
    press keys      name = q        ENTER

Validar se aparece no titulo da guia o resultado esperado
    ${titulo}   Get title
    should contain   ${titulo}   ${palavra_chave}

Fechar o browser
    close browser
