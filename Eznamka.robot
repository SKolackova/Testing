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
    Cookie              AcceptAll
    Sleep               2

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           xpath=/html/body/footer/div[2]/div/div/div[2]/div/button[3]
    ELSE
        Click           xpath=/html/body/footer/div[2]/div/div/div[2]/div/button[2]
    END
    sleep               2