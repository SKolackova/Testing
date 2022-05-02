*** Settings ***
Library     Browser

*** Variables ***

${URL}      https://gymbeam.cz/

*** Test Cases ***

Test jedna
    Open URL

*** Keywords ***

Open URL
    New Browser     chromium        headless=false
    New Page        ${URL}

Cookies