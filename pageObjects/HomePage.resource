*** Settings ***
Documentation    Elements in the homePage in liverpool page
Resource    ../pageObjects/Generic.resource
Library    SeleniumLibrary
Library    String

*** Variables ***
${search_bar_locator}    XPATH:(//input[@id='mainSearchbar'])[1]
${category_hamburger_menu_locator}    XPATH://span//i[contains(@class,'hammenu')]
${category_link_locator}    XPATH:(//li[contains(@class,'category')]//a[contains(@href,'REPLACE')])[2]
${sub_category_link_locator}    XPATH://a[contains(text(),'REPLACE')]

*** Keywords ***
Searching products
    [Arguments]    ${product}
    Wait Until Element Passed Is Located On Page    ${search_bar_locator}
    Input Text    ${search_bar_locator}    ${product}
    Press Keys    ${search_bar_locator}    ENTER

Searching by category
    [Arguments]    ${category}    ${subcategory}    ${brand}
    Wait Until Element Passed Is Located On Page    ${category_hamburger_menu_locator}
    Click Element    ${category_hamburger_menu_locator}
    ${category_link_locator}    Replace String    ${category_link_locator}    REPLACE    ${category}
    ${sub_category_link_locator}    Replace String    ${sub_category_link_locator}    REPLACE    ${subcategory}
    Mouse Over    ${category_link_locator}
    Click Link    ${sub_category_link_locator}
    Sleep    5S
    
        





    
