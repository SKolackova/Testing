*** Settings ***
Library     Browser
*** Variables ***

${URL}    https://edalnice.cz/index.html#/validation
*** Test Cases ***

Nakup známky
    New Browser         chromium                                headless=false
    New Page            ${URL}
    Click               xpath=//*[@id="root"]/div/div[1]/a
    Take Screenshot