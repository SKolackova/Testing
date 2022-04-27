*** Settings ***
Library  Browser

*** Variables ***

${URL}      https://www.rohlik.cz/vitejte#_=_

*** Test Cases ***

Pozitivní přihlášení
    Open URL
    Login               radek.tester@seznam.cz                  tajneheslotajneheslo
    Click               id=headerUser
    ${Text}=            Get Text                                data-test=my-account-button
    Should Be Equal     ${Text}                                 Můj účet

Odhlášení
    Open URL
    Login               radek.tester@seznam.cz                  tajneheslotajneheslo
    Click               id=headerUser
    Click               text=Odhlásit se
    Click               id=headerLogin
    ${Text}=            Get Text                                data-test=btnSignIn
    Should Be Equal     ${Text}                                 Přihlásit se

*** Keywords ***

Open URL
    New Browser         chromium                                headless=false
    New Page            ${URL}
    Get Title           ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep               2

Login
    [Arguments]         ${username}                             ${password}
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email         ${username}
    Type Text           data-test=user-login-form-password      ${password}
    Click               data-test=btnSignIn