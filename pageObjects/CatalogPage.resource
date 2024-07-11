*** Settings ***
Documentation    Elements in the catalog page in liverpool site
Resource    ../pageObjects/Generic.resource
Library    ../customLibraries/CatalogPage.py
Library    SeleniumLibrary
Library    String

*** Variables ***
${product_names_locator}    XPATH://h5[contains(@class, 'card-title a-card-description')]
${view_more_size_locator}    XPATH://a[@id='Tamao']
${check_box_size_locator}    XPATH:(//div[contains(@id,'Tamaocount')]//label[contains(text(),'REPLACE')]/parent::div//div)[1]
${check_box_brand_locator}    XPATH:(//div[contains(@id,'Marcascount')]//label[contains(text(),'REPLACE')]/parent::div//div)[1]
${radio_button_price_locator}    XPATH://div[contains(@class,'fiterl-prices')]//input[contains(@id,'sortPrice-REPLACE')]
${view_more_brand_locator}    XPATH://a[@id='Marcas']
${product_price_locator}    XPATH://p[@class='a-card-discount']

*** Keywords ***
Verify products are in catalog
    [Arguments]    @{suggestions}
    Wait Until Element Passed Is Located On Page    ${product_names_locator}
    ${match}    check_expected_product_is_in_catalog    ${suggestions}
    Should Be True    ${match}

Click on first product
    Click Element    ${product_names_locator}
    
Get first product name
    ${productName}    Get Text    ${product_names_locator}
    RETURN    ${productName}
    
Get first product price
    ${productPrice}    Get Text    ${product_price_locator}
    ${productPrice}    Get Substring    ${productPrice}	0	-2
    RETURN    ${productPrice}
    
Filter By Size
    [Arguments]    ${size}
    Click Element    ${view_more_size_locator}
    ${check_box_size_locator}    Replace String    ${check_box_size_locator}    REPLACE    ${size}
    ${checkboxSize}    Get Webelement    ${check_box_size_locator}
    Click Element      ${checkboxSize}
    Sleep    2

Filter By Price
    [Arguments]    ${price}
    ${radio_button_price_locator}   Replace String    ${radio_button_price_locator}     REPLACE    ${price}
    ${radio_button_element}   Get Webelement    ${radio_button_price_locator}
    Click Element      ${radio_button_element}
    Sleep    2

Filter By Brand
    [Arguments]    ${brand}
    ${brand}    Convert To Upper Case    ${brand}
    ${check_box_brand_locator}    Replace String    ${check_box_brand_locator}    REPLACE    ${brand}
    ${checkboxBrand}    Get Webelement    ${check_box_brand_locator}
    Click Element      ${checkboxBrand}
    Sleep    2

Verify Price in catalog
    [Arguments]    ${price}
    ${match}    check_price_in_product_catalog_is_more_than_expected_filter    ${price}    ${product_price_locator}
    Should Be True    ${match}
    
Verify Counting list in catalog
    [Arguments]    ${count}
    ${match}    check_count_results_in_catalog    ${count}
    Should Be True    ${match}

Click View More Brands
    ${c} =   Get Element Count   ${view_more_brand_locator}
    Run Keyword If   ${c}>0    Click Link    ${view_more_brand_locator}
