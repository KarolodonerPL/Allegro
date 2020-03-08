*** Settings ***
Documentation    Library to set up map of Allegro page

*** Keywords ***
Set Page Objects For Robot
    # pop ups:
    set suite variable      ${pop_up}                   //*[@id="dialog-title"]
    set suite variable      ${accept_pop_up}            //button[@data-role="accept-consent"]

    # Main Page:
    set suite variable      ${search_button}            //button[@data-role="search-button"]
    set suite variable      ${input_search}             //input[@type="search"]
    set suite variable      ${go_to_busket_button}      //*[@class='_nem5f _1db0i _2xzg1 _d2aa8_3PflD']
    set suite variable      ${first_item}               //section[1]/section/article[1]/div/div

    # Filtr
    set suite variable      ${price_from}               //input[@id='price_from']
    set suite variable      ${used_checkbox}            //*[text() = 'używane']

    # Item Page:
    set suite variable      ${add_to_cart_button}       //button[@id='add-to-cart-button']
    set suite variable      ${close_button}             //*[@alt='zamknij']
    set suite variable      ${item_title}               //*[@class='_1sjrk']

    # Basket:
    set suite variable      ${item_in_the_busket}       //offer-title/div/div/a
