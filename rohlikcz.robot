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
    Logout

Přidání zboží do košíku
    Open URL
    Login               radek.tester@seznam.cz                  tajneheslotajneheslo
    Pridat Do Kosiku    banán
    Logout


*** Keywords ***

Open URL
    New Browser         chromium                                headless=false
    New Page            ${URL}
    Get Title           ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Cookie              AcceptAll
    Sleep               2

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END
    sleep               1

Login
    [Arguments]         ${username}                             ${password}
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email         ${username}
    Type Text           data-test=user-login-form-password      ${password}
    Click               data-test=btnSignIn
    Sleep               2

Logout
   Go To               ${URl}
   Click               id=headerUser
   Click               text=Odhlásit se
   Click               id=headerLogin
   ${Text}=            Get Text                                data-test=btnSignIn
   Should Be Equal     ${Text}                                 Přihlásit se

Pridat do kosiku
    [Arguments]         ${Zbozi}

    Type Text           \#searchGlobal          ${Zbozi}
    Sleep               5
    Click               "Hledat"
    Sleep               5
    Click               css=[data-test=btnAdd] >> nth=1
    Click               data-test=headerPrice

#    #ověří že je zboží v košíku
#    ${cart_text}=       Get Text                    id=cart
#    Log                 ${cart_text}