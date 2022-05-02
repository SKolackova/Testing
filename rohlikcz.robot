*** Settings ***
Library  Browser

*** Variables ***

${URL}      https://www.rohlik.cz/vitejte#_=_

*** Test Cases ***

Pozitivní přihlášení
    Open URL
    Login               johnytester1@seznam.cz                  tajneheslo
    Click               id=headerUser
    ${Text}=            Get Text                                data-test=my-account-button
    Should Be Equal     ${Text}                                 Můj účet
    Logout

Negativní přihlášení- špatné heslo
    Open URL
    Login               johnytester1@seznam.cz                  spatneheslo
    Overeni Chybove Hlasky

Negativní přihlášení- heslo z velkých písmen
    Open URL
    Login               johnytester1@seznam.cz                  TAJNEHESLO
    Overeni Chybove Hlasky

Negativní přihllášení- špatný email, správný formát
    Open URL
    Login               spatny@email.cz                         tajneheslo
    Overeni Chybove Hlasky

Negativní přihlášení- špatný email, špatný formát
    Open URL
    Login               spatnyformatemmail                      tajneheslo
    Overeni Chybove Hlasky Na Email

Odhlášení
    Open URL
    Login               johnytester1@seznam.cz                  tajneheslo
    Logout

Přidání zboží do košíku
    Open URL
    Login               johnytester1@seznam.cz                  tajneheslo
    Pridat Do Kosiku    mouka
    Logout

Odebrání zboží z košíku
    Open URL
    Login               johnytester1@seznam.cz                  tajneheslo
#    Pridat Do Kosiku    mouka             - zakomentova řádek, pokud se v košíku už z předchozáho testu objevuje zboží
    Odebrani Z Kosiku
    Logout

*** Keywords ***

Open URL
    New Browser         chromium                                headless=false
    New Page            ${URL}
    Get Title           ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Cookies             AcceptAll
    Sleep               2

Cookies
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

Overeni chybove hlasky
    ${Text2}           Get Text                                data-test=notification-content
    Should Be Equal    ${Text2}                                Zadal(a) jste nesprávný e-mail nebo heslo.

Overeni chybove hlasky na email
    ${Text3}           Get Text                                data-test=user-login-form-email-message
    Should Be Equal    ${Text3}                                Zadejte platný email

Pridat do kosiku
    [Arguments]         ${Zbozi}
    Type Text           \#searchGlobal          ${Zbozi}
    Sleep               5
    Click               "Hledat"
    Sleep               5
    Click               css=[data-test=btnAdd] >> nth=1
    Click               data-test=headerPrice
    Click               id=cart

Odebrani z kosiku
    Click              data-test=headerPrice
    Click              css=.sc-14bk3kj-0 >> [data-test="btnMinus"]
    Sleep              2
    ${Text4}           Get Text                     id=cartReviewMainTitle
    Should Be Equal    ${Text4}                     Košík funguje i jako nákupní seznam
