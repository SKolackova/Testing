*** Settings ***
Library     Browser

*** Variables ***

${URL}      https://gymbeam.cz/

*** Test Cases ***

Přihlášení
    Open URL

# johnytester1@seznam.cz  Tajneheslo1!
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

