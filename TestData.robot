#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***

${URL}      https://www.rohlik.cz/vitejte#_=_

#uživatel
${USER1_NAME}               johnytester1@seznam.cz
${USER1_PASSWORD}           tajneheslo
${USER1_SHORT}              JT

#zboží
${ZBOZI01_NAME}             mouka
${ZBOZI01_ID}               1316775

#Strings
${TEXT_MainTitle}                   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_MyAccount}                   Můj účet


#ror strings
${ERROR_TEXT_FillCorrectEmail}      Zadejte platný email
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#SELEKTORY pro Login

${SEL_HeaderLogin}          id=headerLogin
${SEL_UserBoxLogoutBtn}     data-test=user-box-logout-button
${SEL_LoginFormEmail}       data-test=user-login-form-email
${SEL_LoginFormPwd}         data-test=user-login-form-password
${SEL_BtnSignIn}            data-test=btnSignIn
${SEL_MyAccountBtn}         data-test=my-account-button

#SELEKTORY pro Header
${SEL_HeaderLogo}           id=logo
${SEL_SearchGlobal}         id=searchGlobal
${SEL_BtnSearchGlobal}      text=Hledat

#SELEKTORY pro zboží

${SEL_BtnPlus}              data-test=btnPlus
${SEL_ProductID}            data-product-id
${SEL_CssForRemove}         .sc-14bk3kj-0
${SEL_BtnAdd}               data-test=btnAdd
${SEL_BtnMinus}             data-test=btnMinus

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart
${SEL_CartContent}          data-test=headerPrice
${SEL_CartReview}           id=cartReviewMainTitle

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
${SEL_Cookie_Decline}       id=CybotCookiebotDialogBodyButtonDecline