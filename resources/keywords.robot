*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${input_username}    //input[contains(@placeholder, 'Username')]
${input_password}    //input[contains(@placeholder, 'Password')]
${button_login}    //input[contains(@data-test, 'login-button')]
${xpath_users}    //div[@id = "login_credentials"][1]
${xpath_password}    //div[@class='login_password']
@{priceList}

*** Keywords ***
Get users credentials
    ${all_users}    Get Text    ${xpath_users}
    ${password_txt}    Get Text    ${xpath_password}
    ${STANDARD_USER_LOGIN}    Get Line    ${all_users}    1
    ${LOCKED_OUT_USER_LOGIN}    Get Line    ${all_users}    2
    ${PROBLEM_USER_LOGIN}    Get Line    ${all_users}    3
    ${PERFORMANCE_GLITCH_USER_LOGIN}    Get Line    ${all_users}    4
    ${PASSWORD}    Get Line    ${password_txt}    1
    Set Test Variable    ${STANDARD_USER_LOGIN}
    Set Test Variable    ${LOCKED_OUT_USER_LOGIN}
    Set Test Variable    ${PROBLEM_USER_LOGIN}
    Set Test Variable    ${PERFORMANCE_GLITCH_USER_LOGIN}
    Set Test Variable    ${PASSWORD}

Log into
    [Arguments]    ${login_username}    ${login_password}
    Input Text    ${input_username}    ${login_username}
    Input Text    ${input_password}    ${login_password}
    ClickElement    ${button_login}

Sorting high to low
    Click Element    //select[contains(@class,'product_sort_container')]
    Click Element    //option[contains(@value,'hilo')]

Price sorting control
  #Create List of prices
    ${ListCount}    Get Element Count    //div[contains(@class,'inventory_item_price')] 
    ${prices}    Get WebElements    //div[contains(@class,'inventory_item_price')]
  
       FOR    ${price}    IN    @{prices}
           ${price_txt}    Get Text    ${price}
           ${price_txt2}    Get Substring    ${price_txt}    1
           ${price_num}    Convert To Number    ${price_txt2}
           Append To List    ${priceList}    ${price_num}
       END

    #Price sorting control
    ${ListCount-1}=    Evaluate    ${ListCount}-1
       FOR    ${counter}    IN RANGE    0    ${ListCount}    1
           ${counter+1}=    Evaluate    ${counter}+1
           IF    $counter == ${ListCount-1}    BREAK
           ${ListItem1}=    Get From List    ${priceList}    ${counter}
           ${ListItem2}=    Get From List    ${priceList}    ${counter+1}
           Should Be True    ${ListItem1}>=${ListItem2}
           Log To Console    ${ListItem1}' and '${ListItem2}
       END 

Add items to basket
#Add 3 most expensive items to basket 
    [Arguments]    ${num_of_items}                      
    FOR    ${counter}    IN RANGE    ${num_of_items}
        Click Element    //button[contains(@data-test,'add-to-cart')]
    END

Open basket
    Click Element    //a[contains(@class,'shopping_cart_link')]

Delete from basket
    [Arguments]    ${num_delete}
    FOR    ${counter}    IN RANGE    ${num_delete}
        Click Element    //button[contains(@name,'remove')]
    END

Chceckout and fill data
    Click Element    //button[contains(@id,'checkout')]
    Input Text    //input[contains(@id,'first-name')]    x
    Input Text    //input[contains(@id,'last-name')]    xx
    Input Text    //input[contains(@id,'postal-code')]    00000
    Click Element    //input[contains(@id,'continue')]
    Click Element    //button[contains(@id,'finish')]