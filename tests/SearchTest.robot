*** Settings ***
Resource    ../pageObjects/Generic.resource
Resource    ../pageObjects/HomePage.resource
Resource    ../pageObjects/CatalogPage.resource
Resource    ../pageObjects/ProductPage.resource
Library    SeleniumLibrary
Library    ../customLibraries/CatalogPage.py
Test Setup    Open Liverpool Page  
Test Teardown    Tear Down

*** Variables ***
@{suggestions}    PLAYSTATION    PS5    PS4
@{brandSuggestion}    SONY
${title}    Consola PlayStation 5 de 1 TB edición Bundle Spider-Man + audífonos
${price}    $10,999
${filter_price}    10000
${screen_size}    55
${expected_counting_list}    3

*** Test Cases ***
Scenario 1
    [Documentation]    Search a product in the search bar and verifies the product and his synonyms are matched in the product catalog.
    [Tags]    SMOKE
    HomePage.Searching Products    play station
    Verify Products Are In Catalog        @{suggestions}
    ${title}    Get First Product Name
    ${price}    Get First Product Price
    Click On First Product
    Check Product Title And Price    ${title}    ${price}

Scenario 2
    [Documentation]    Search a product by filters (Size, Price, Brand) and check the expected number of products in the catalog.
    [Tags]    SMOKE
    Searching Products    smart tv
    Filter By Size    ${screen_size}
    Filter By Price    ${filter_price}
    Filter By Brand    ${brandSuggestion}[0]    
    @{sizeList}    Create List    ${screen_size}
    @{priceList}    Create List    ${filter_price}
    Verify Products Are In Catalog    @{sizeList}
    Verify Price In Catalog    ${filter_price}
    Verify Products Are In Catalog    ${brandSuggestion}[0]
    Verify Counting list in catalog    ${expected_counting_list}

Scenario 3
    [Documentation]    Search a product in the category list and check the products are matched in the catalog.
    [Tags]    SMOKE
    Searching By Category    belleza    Perfumes Hombre    Dior
    Click View More Brands
    Filter By Brand    Dior
    @{suggestionList}    Create List    Dior
    Verify Products Are In Catalog    @{suggestionList}
