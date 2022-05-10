*** Settings ***
Library         Browser
Resource        TestData.robot

*** Variables ***


*** Test Cases ***

Pozitivní přihlášení
    Open URL
    Login               ${USER1_NAME}                           ${USER1_PASSWORD}
    Click               id=headerUser
    ${Text}=            Get Text                                data-test=my-account-button
    Should Be Equal     ${Text}                                 Můj účet
    Logout

Negativní přihlášení- špatné heslo
    Open URL
    Login               ${USER1_NAME}                          spatneheslo
    Overeni Chybove Hlasky

Negativní přihlášení- heslo z velkých písmen
    Open URL
    Login               ${USER1_NAME}                          TAJNEHESLO
    Overeni Chybove Hlasky

Negativní přihllášení- špatný email, správný formát
    Open URL
    Login               spatny@email.cz                         ${USER1_PASSWORD}
    Overeni Chybove Hlasky

Negativní přihlášení- špatný email, špatný formát
    Open URL
    Login               spatnyformatemmail                      ${USER1_PASSWORD}
    Overeni Chybove Hlasky Na Email

Odhlášení
    Open URL
    Login               ${USER1_NAME}                           ${USER1_PASSWORD}
    Logout

Přidání zboží do košíku
    Open URL
    Login               ${USER1_NAME}                           ${USER1_PASSWORD}
    Pridat Do Kosiku    ${ZBOZI01_NAME}
    Logout

Odebrání zboží z košíku
    Open URL
    Login               ${USER1_NAME}                  ${USER1_PASSWORD}
#    Pridat Do Kosiku    ${ZBOZI01_NAME}             - zakomentova řádek, pokud se v košíku už z předchozáho testu objevuje zboží
    Odebrani Z Kosiku
    Logout

*** Keywords ***

Open URL
    New Browser         chromium                                headless=false
    New Page            ${URL}
    Get Title           ==    ${TEXT_MainTitle}
    Cookies             AcceptAll
    Sleep               2

Cookies
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END
    sleep               1

Login
    [Arguments]         ${username}                             ${password}
    Click               ${SEL_HeaderLogin}
    Type Text           ${SEL_LoginFormEmail}         ${username}
    Type Text           ${SEL_LoginFormPwd}      ${password}
    Click               data-test=btnSignIn
    Sleep               2

Logout
   Go To               ${URl}
   Click               id=headerUser
   Click               ${SEL_UserBoxLogoutBtn}
   Click               ${SEL_HeaderLogin}
   ${Text}=            Get Text                                data-test=btnSignIn
   Should Be Equal     ${Text}                                 Přihlásit se

Overeni chybove hlasky
    ${Text2}           Get Text                                data-test=notification-content
    Should Be Equal    ${Text2}                                ${ERROR_TEXT_IncorrectEmailOrPwd}

Overeni chybove hlasky na email
    ${Text3}           Get Text                                data-test=user-login-form-email-message
    Should Be Equal    ${Text3}                                ${ERROR_TEXT_FillCorrectEmail}

Pridat do kosiku
    [Arguments]         ${Zbozi}
    Type Text           \#searchGlobal          ${Zbozi}
    Sleep               5
    Click               "Hledat"
    Sleep               5
    Click               css=[${SEL_BtnAdd}] >> nth=1
    Click               data-test=headerPrice
    Click               ${SEL_Cart}

Odebrani z kosiku
    Click              data-test=headerPrice
    Click              css=.sc-14bk3kj-0 >> [${SEL_BtnMinus}]
    Sleep              2
    ${Text4}           Get Text                     id=cartReviewMainTitle
    Should Be Equal    ${Text4}                     ${ERROR_TEXT_EmptyCart}
