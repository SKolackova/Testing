*** Settings ***
Library     Browser

*** Variables ***

${URL}      https://gymbeam.cz/

*** Test Cases ***

Přihlášení
    Open URL
    Login           johnytester1@seznam.cz           Tajneheslo1!


*** Keywords ***

Open URL
    New Browser     chromium        headless=false
    New Page        ${URL}
    Cookies         AcceptAll
    Sleep           2
Cookies
    [Arguments]     ${type}
    IF  "${type}" == "AcceptAll"
         Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
         Click           id=CybotCookiebotDialogBodyLevelButtonCustomize
    END

Login
    [Arguments]         ${username}     ${password}
    Go To               https://gymbeam.cz/customer/account/login/
    Type Text           id=email        ${username}
    Type Text           id=pass         ${password}
    Click               id=send2
    Sleep               5
    ${Text}             Get Text        xpath=//*[@id="maincontent"]/div[2]/div[1]/div[1]/h1/span
    Should Be Equal     ${Text}         Můj účet
