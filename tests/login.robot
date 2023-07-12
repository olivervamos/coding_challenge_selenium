*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    OpenBrowser    about:blank    chrome    options=add_experimental_option("detach", True)
Suite Teardown    CloseAllBrowsers

*** Test Cases ***

login
    [Documentation]    Verifies that login works
   GoTo   https://www.saucedemo.com/
   Get users credentials
   Log into    ${STANDARD_USER_LOGIN}    ${PASSWORD}