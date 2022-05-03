*** Settings ***
Library     Browser

*** Variables ***

${URL}      https://gymbeam.cz/

*** Test Cases ***

Pozitivní přihlášení
    Open URL
    Login           johnytester1@seznam.cz           Tajneheslo1!

Přidání zboží do košíku
    Open URL
    Login           johnytester1@seznam.cz           Tajneheslo1!
    Go To           ${URL}
    Nakup

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


Nakup
    Click              xpath=//*[@id="widget-homepage-categories"]/div/a[1]/img
    Sleep              1
    Set Strict Mode     False
    Click              css=.action[title="Přidat do košíku"] >> nth=1
    Click              text=PŘIDAT DO KOŠÍKU
    Sleep              2