*** Settings ***
Documentation       Test suite for Akkergo tests by Karol Odoner
Resource            ../Lib/allegro_page_map.robot
Library             SeleniumLibrary
Library             REST    https://jsonplaceholder.typicode.com

Suite Setup     Set Page Objects For Robot

*** Test Cases ***
Check If Item Can be Added In To The Basked
    Open Allegro Page
    Look For Used Item More Expensive Then   ${200}
    ${object_title} =   Enter The Item Page
    Add Item To Basket
    Check If Item Is In The Basked  ${object_title}
    [Teardown]      Close Browser

Testing Endpoints
    Endpoint Post
    Endpoint Comment

*** Keywords ***
Add Item To Basket
    [Documentation]     Keyword for adding item in to the basked
    Click Button    ${add_to_cart_button}
    Wait Until Element Is Visible   ${close_button}    10s
    Click Element   ${close_button}

Check If Item Is In The Basked
    [Documentation]     Keyword for going to basket page and checking if item with given name is in the basket
    ...                 object_title - given name of the item
    [Arguments]     ${object_title}
    Click Element   ${go_to_busket_button}
    Wait Until Element Is Visible	${item_in_the_busket}    10s
    ${shopping_title} =   Get Text    ${item_in_the_busket}
    Should Be Equal     ${object_title}     ${shopping_title}       Item was not added in to the basked

Endpoint Post
    GET         /posts
    Integer     response status           200
    GET	        /posts/1/comments
    Integer     response status           200
    GET	        /comments?postId=1
    Integer     response status           200
    GET	        /posts?userId=1
    Integer     response status           200
    POST	    /posts
    Integer     response status           201
    PUT	        /posts/1
    Integer     response status           200
    PATCH	    /posts/1
    Integer     response status           200
    DELETE	    /posts/1
    Integer     response status           200

Endpoint Comment
    GET	        /comments
    Integer     response status           200
    GET	        /comments/1
    Integer     response status           200
    GET	        /comments?userId=1
    Integer     response status           200
    POST	    /comments
    Integer     response status           201
    PUT	        /comments/1
    Integer     response status           200
    PATCH	    /comments/1
    Integer     response status           200
    DELETE	    /comments/1
    Integer     response status           200

Enter The Item Page
    [Documentation]     Keyword which adding first item in to the basked and return item name
    sleep   5s
    Click Element   ${first_item}
    Wait Until Element Is Visible	${item_title}    10s
    ${object_title} =   Get Text    ${item_title}
    [Return]  ${object_title}

Look For Used Item More Expensive Then
    [Documentation]     Keyword to look for a used item by a word, and pricec from given price
    ...                 price = Variable for minimum price of item, must be int
    ...                 item = word from which item will be look for, automaticly = 'przedmiot'
    [Arguments]     ${price}    ${item}=przedmiot
    Input Text   ${input_search}    ${item}
    Click Button    ${search_button}
    Wait Until Element Is Visible	${used_checkbox}     10s
    Click Element   ${used_checkbox}
    # sleep due to bug on Allegro page, When user click Używane and enter price for 'Price From' it can  reload
    # and remove all price in that field or just partial what giving incorect results. Bug repeted manually.
    sleep   1s
    Input Text   ${price_from}  ${price}

Open Allegro Page
    [Documentation]     Openingn Chrome browser on Allegro Main page
    ...                 Checking if there is pop up and if there is - closing it
    Open Browser    https://allegro.pl/     chrome
    Maximize Browser Window
    ${pop_up_existance} =   Run Keyword And Return Status   Page Should Contain Element   ${pop_up}
    Run Keyword If  '${pop_up_existance}'=='${True}'   Click Button    ${accept_pop_up}
