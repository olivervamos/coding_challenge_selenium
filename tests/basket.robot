*** Settings ***
Resource    ../resources/keywords.robot
Test Setup    OpenBrowser    about:blank    chrome
Test Teardown    CloseBrowser

*** Variables ***
${checkout_txt}    Checkout: Complete

*** Test Cases ***
Basket delete
   [Documentation]    delete all the items and check they were deleted
   GoTo    https://www.saucedemo.com/
   Get users credentials
   Log into    ${STANDARD_USER_LOGIN}    ${PASSWORD}
   Sorting high to low
   Price sorting control
   Add items to basket    3
   Open basket
   Delete from basket    3
   Page Should Not Contain Element    //button[contains(@name,'remove')]

Checkout
   [Documentation]
   GoTo    https://www.saucedemo.com/
   Get users credentials
   Log into    ${STANDARD_USER_LOGIN}    ${PASSWORD}
   Sorting high to low
   Price sorting control
   Add items to basket    3
   Open basket
   Chceckout and fill data
   Page Should Contain    ${checkout_txt}  