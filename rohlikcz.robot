*** Settings ***
Library          Browser
Resource         TestData.robot
Resource         Configuration.robot

*** Variables ***


*** Test Cases ***

Pozitivní přihlášení
    Open URL
    Login               ${USER1_NAME}                           ${USER1_PASSWORD}
    Click               ${SEL_HEaderUser}
    ${Text}=            Get Text                                ${SEL_MyAccountBtn}
    Should Be Equal     ${Text}                                 ${TEXT_MyAccount}
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
    Sleep               ${TIMEOUT_BROWSER2}

Cookies
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END
    sleep               ${TIMEOUT_BROWSER2}

Login
    [Arguments]         ${username}                             ${password}
    Click               ${SEL_HeaderLogin}
    Type Text           ${SEL_LoginFormEmail}         ${username}
    Type Text           ${SEL_LoginFormPwd}      ${password}
    Click               ${SEL_BtnSignIn}
    Sleep               ${TIMEOUT_BROWSER2}

Logout
   Go To               ${URl}
   Click               ${SEL_HEaderUser}
   Click               ${SEL_UserBoxLogoutBtn}
   Click               ${SEL_HeaderLogin}
   ${Text}=            Get Text                                ${SEL_BtnSignIn}
   Should Be Equal     ${Text}                                 Přihlásit se

Overeni chybove hlasky
    ${Text2}           Get Text                                ${GET_NotContent}
    Should Be Equal    ${Text2}                                ${ERROR_TEXT_IncorrectEmailOrPwd}

Overeni chybove hlasky na email
    ${Text3}           Get Text                                ${GET_MessEmail}
    Should Be Equal    ${Text3}                                ${ERROR_TEXT_FillCorrectEmail}

Pridat do kosiku
    [Arguments]         ${Zbozi}
    Type Text           ${SEL_SearchGlobal}          ${Zbozi}
    Sleep               ${TIMEOUT_BROWSER}
    Click               "Hledat"
    Sleep               ${TIMEOUT_BROWSER}
    Click               css=[${SEL_BtnAdd}] >> nth=1
    Click               ${SEL_CartContent}
    Click               ${SEL_Cart}

Odebrani z kosiku
    Click              ${SEL_CartContent}
    Click              css=${SEL_CssForRemove} >> [${SEL_BtnMinus}]
    Sleep              ${TIMEOUT_BROWSER2}
    ${Text4}           Get Text                     ${SEL_CartReview}
    Should Be Equal    ${Text4}                     ${ERROR_TEXT_EmptyCart}
