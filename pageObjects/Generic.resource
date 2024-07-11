*** Settings ***
Documentation    The generic elements in the liverpool page
Library    SeleniumLibrary

*** Variables ***
${browser_name}    chrome
${url}     https://www.liverpool.com.mx/tienda/home

*** Keywords ***
open liverpool page
    Open Browser    ${url}    ${browser_name}
    Maximize Browser Window
    Set Browser Implicit Wait    30

tear down
    Close All Browsers

Wait until Element passed is Located on page
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible    ${page_locator}    10s
