*** Settings ***
Documentation    Elements in the catalog page in liverpool site
Resource    ../pageObjects/Generic.resource
Library    ../customLibraries/CatalogPage.py
Library    SeleniumLibrary
Library    String

*** Variables ***
${product_title_locator}    XPATH://h1[@class='a-product__information--title']
${product_price_discount_locator}    XPATH://p[contains(@class,'DiscountPrice')]

*** Keywords ***
Check product title and price
    [Arguments]    ${title}    ${price}
    Wait Until Element Passed Is Located On Page    ${product_title_locator}
    ${actualTitle}    Get Text    ${product_title_locator}
    ${actualPrice}    Get Text    ${product_price_discount_locator}
    ${actualPrice}    Get Substring    ${actualPrice}	0	-2
    ${actualPrice}     Strip String    ${SPACE}${actualPrice}${SPACE}
    Should Be Equal    ${title}    ${actualTitle}
    Should Be Equal    ${price}    ${actualPrice}
