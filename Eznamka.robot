*** Settings ***
Library     Browser
*** Variables ***

${URL}    https://edalnice.cz/index.html#/validation
*** Test Cases ***

Nakup známky
    Open URL
    Click               xpath=//*[@id="root"]/div/div[1]/a
    Take Screenshot



*** Keywords ***

Open URL
    New Browser         chromium                                headless=false
    New Page            ${URL}

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           # přidat lokator
    ELSE
        Click           # přidat lokator
    END
    sleep               1