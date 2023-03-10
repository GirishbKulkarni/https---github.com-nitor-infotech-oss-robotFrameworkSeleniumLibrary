*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

Resource    ../statics/staticVariables.resource
Resource    ../ObjectRepository/OR_Web_AdminPortal.resource
Resource    ../ObjectRepository/OR_Web_CarAdvice.resource
Resource    commonFunctions.resource
Resource    ../baseFunctions/adminPortalFunctions.resource


*** Keywords ***
Cancel Appointment 
    Wait and Click web    ${static_waitXSmall}   ${cancel_Appointment}
    Wait and Click web    ${static_waitXSmall}   ${cancel_Appointment2}
    Click Left Navigation    Home


Login to Car Advice
    Setup Browser    ${static_urlCarAdvice}    ${static_browserChrome}
   # Log To Console    "Captcha Time started"
   # Sleep    ${static_waitXLarge}
   # Log To Console    "Captcha Time ended"
    Wait and input text web    ${static_waitSmall}    ${Web_Login_textBoxUserName}    ${static_carAdviceUsername}
    Wait and input text web    ${static_waitSmall}    ${Web_Login_textBoxPassword}    ${static_carAdvicepassword}
    Wait and Click web    ${static_waitXXLarge}    ${Web_Login_btnSignIn}
    Print the Log    Logged in to Car Advice.
    Home Page Skip Popup


Login to Admin Portal
    Setup Browser    ${static_urladminPortal}    ${static_browserChrome}


Home Page Skip Popup
    Print the Log    Skipping first popup
    Sleep    60s
    Wait and Click web    ${static_waitXLarge}    ${web_HomePagePopup_Skip}

Home Page Popup TrippleNext
    Print the Log    Tripple Next popup handling
    Wait and Click web    ${static_waitXLarge}    ${web_HomePagePopup_NextButton}
    Wait and Click web    ${static_waitXLarge}    ${web_HomePagePopup_NextButton}
    Wait and Click web    ${static_waitXLarge}    ${web_HomePagePopup_NextButton}

Choose Service
    Print the Log    In Choose service
    Check if Services selected
    Select Service    ${selectService}

Select Service
    [Arguments]    ${serviceName}
    Wait and Click web    ${static_waitSmall}    ${web_HomePage_ChooseService} 

    Run Keyword If    "${serviceName}"=="New Tires"    Select New Tires   
    Run Keyword If    "${serviceName}"=="Brake Pads"    Select Brake Pads

Browse and Select shop
    Check if Shop is Selected
    Wait and Click web    ${static_waitSmall}    ${web_ChooseService_BrowseShopsButton}
    Wait and Click web    ${static_waitSmall}    ${web_BrowseShops_InsertShopLocation}
    Wait and input text web    ${static_waitSmall}    ${web_BrowseShops_InsertShopLocation}    ${static_ShopLocation}
    Wait and Click web    ${static_waitSmall}    ${web_BrowseShops_SelectShop}
    Wait and Verify Element    ${static_waitSmall}    ${web_BrowseShops_Map}
    Wait and Click web    ${static_waitSmall}    ${web_BrowseShops_SelectShopButton} 
    Print the Log    "Shop Selected"

Book and Confirm the Appointment
    Select Date for service
    ${status}=    Run Keyword And Return Status    Quick Check if element is not present    ${webAppointment_NoTimeAvailable}
    Run Keyword If    '${status}'=='False'     Select Day after tomorrow for service
    Sleep    2s
    Wait and Click web    ${static_waitLarge}    ${web_BrowseShops_AppointmentType_Walkin}    
    Sleep    1s
    Wait and Click web    ${static_waitLarge}    ${Web_BookAppointmentButton1}    
    Sleep    1s
    Wait and Click web    ${static_waitLarge}    ${Web_BookAppointmentButton3}
    Wait and Click web    ${static_waitLarge}    ${Web_RequestAppointmentButton1}
    Wait and Verify Element    ${static_waitXLarge}    ${Web_AppointmentConfirmation}


Select Date for service
    ${day}=    Get Tomorrows Day
    Print the Log    Creating XPath for Day: ${day}
    ${selectDateXpath}=    Create DynamicXpath    ${web_BrowseShops_SelectDate}    ReplaceDay    ${day}
    Sleep    2s
    Wait and Click web    ${static_waitLarge}    ${selectDateXpath}

Select Day after tomorrow for service
    ${day}=    Get Day after Tomorrows Day
    Print the Log    Creating XPath for Day: ${day}
    ${selectDateXpath}=    Create DynamicXpath    ${web_BrowseShops_SelectDate}    ReplaceDay    ${day}
    Wait and Click web    ${static_waitSmall}    ${selectDateXpath}

Select New Tires
    Print the Log    Selecting service: New Tires
    Mouse over Mouse Down Mouse Up    ${web_ChooseService_ServiceNewTires1}
    #Wait and Click web    ${static_waitMed}    ${web_ChooseService_ServiceNewTires1}
    ${status}=    Check if element is not present    ${web_ChooseService_BrowseShopsButton}
    Run Keyword If    '${status}' == 'True'    Run Keyword And Continue On Failure    Wait and Click Using JavaScript    ${static_waitSmall}    ${web_ChooseService_ServiceNewTires2}
    ${status}=    Check if element is not present    ${web_ChooseService_BrowseShopsButton}
    Run Keyword If    '${status}' == 'True'    Run Keyword And Continue On Failure    Mouse over Mouse Down Mouse Up    ${web_ChooseService_ServiceNewTires3}

Select Brake Pads
    Print the Log    Selecting Brake Pads
    Mouse over Mouse Down Mouse Up    ${web_ChooseService_ServiceBrakePads}
    #Wait and Click web    ${static_waitMed}    ${web_ChooseService_ServiceBrakePads}
    Wait and Click web    ${static_waitMed}    ${web_ChooseService_ServiceBrakePads_All}

Cleanup code- Cancelling an appointment
    Print the Log    Cancelling an appointment
    ${status}=    Run Keyword And Return Status    Check if element is not present    ${web_cancelAppointment1} 
    Run Keyword If    '${status}'=='True'        Wait and Click web    ${static_waitXSmall}    ${web_cancelAppointment1} 
    Run Keyword If    '${status}'=='True'        Wait and Click web    ${static_waitXSmall}    ${web_cancelAppointment2}

Check if an appointment already exists
    Print the Log    checking if an appointment already exists
    ${status}    Check if element is not present    ${web_cancelAppointment1} 
    Run Keyword If    '${status}'=='false'    Run Keyword And Ignore Error     Wait and Click web    {static_waitXSmall}   ${Web_RemoveService}

    ${status}    Check if element is not present    ${web_cancelAppointment2}
    Run Keyword If    '${status}'=='false'    Run Keyword And Ignore Error     Wait and Click web    {static_waitXSmall}   ${Web_RemoveService}


Check if Services selected
    Print the Log    checking if service is already selected
    ${status}    Quick Check if Element is not present     ${Web_RemoveService}
    Print the Log    Status = ${status}
    Run Keyword If    '${status}'=='True'    Wait and Click web    ${static_waitXSmall}    ${Web_RemoveService}
    #Run Keyword If    '${status}'=='false'    Mouse over Mouse Down Mouse Up    ${Web_RemoveService}
    #Click Element    ${Web_RemoveService}


Check if Shop is Selected
    Print the Log    checking if shop is already selected
    ${status}    Quick Check if Element is not present    ${Web_RemoveShop}
    Print the Log    Status = ${status}
    Run Keyword If    '${status}'=='True'    Wait and Click web    ${static_waitXSmall}    ${Web_RemoveShop}
    #Run Keyword If    '${status}'=='false'    Mouse over Mouse Down Mouse Up    ${Web_RemoveService}
    #Click Element    ${Web_RemoveService}

Home Page Click Left Navigation
    [Arguments]    ${leftMenuName}
    Wait and Click web    ${static_waitXLarge}    xpath=//div[@class='leftNav']//a[text()='My Garage']

Create new Vehicle no VIN
    Wait and Click web    ${static_waitSmall}    xpath=//span[text()='Add Vehicle']
    Wait and Click web    ${static_waitSmall}    xpath=//option[text()='Select Year']/..    
    Wait and Click web    ${static_waitSmall}    xpath=//option[text()='2022']

    Wait and Click web    ${static_waitSmall}    xpath=//option[text()='Select Make']/..
    Wait and Click web    ${static_waitSmall}    xpath=//option[@value='BMW']

    Wait and Click web    ${static_waitSmall}    xpath=//option[text()='Select Model']/..
    Wait and Click web    ${static_waitSmall}    xpath=//option[@value='X1']

    Wait and Click web    ${static_waitSmall}    xpath=//option[text()='Select Sub Model']/..
    Wait and Click web    ${static_waitSmall}    xpath=//option[@value='sDrive18i']

    Wait and Click web    ${static_waitSmall}    xpath=//option[text()='Select Engine']/..
    Wait and Click web    ${static_waitSmall}    xpath=//option[@value='N/A']
    
    Wait and input text web    ${static_waitSmall}    xpath=//input[@placeholder='How many miles?']    1000

    Wait and Click web    ${static_waitSmall}    xpath=//span[text()='Next']

Create new Vehicle using VIN
    [Arguments]    ${vin}
    
P1 Testcases:

Login to the signup screen
    Open Browser    https://app.development.caradvise.com/#/sign_up/1     Chrome
    Maximize Browser Window

Login to the onboarding screen
    Open Browser    https://app.development.caradvise.com/#/no_vehicle    Chrome
    Maximize Browser Window
    Home Page Popup TrippleNext

Login to the sigin screen
    Open Browser    https://app.development.caradvise.com/#/signIn    headlessChrome
    Maximize Browser Window


Signin screen

1.
Enter valid username and invalid password
    Input Text    ${Web_Login_textBoxUserName}     ${static_carAdviceUsername}
    Input Text    ${Web_Login_textBoxPassword}     12345
   
Click on signin button
    Sleep    20s
    Click Element    ${Web_Login_btnSignIn}
    Sleep    5s
Print to the console
    ${Errormessage}    Get Text    //div[@class='notification-message']
    Sleep    2s
    Log To Console    ${Errormessage} 

2.
Email field is blank and enter password
    Input Text    ${Web_Login_textBoxUserName}    .....
    Input Text    ${Web_Login_textBoxPassword}     12345
 
Print to the console1
    ${Errormessage1}    Get Text    //div[text()='Invalid username or password']
    Sleep    2s
    Log To Console    ${Errormessage1} 

3.
Click on create an account here
    Click Element    //a[text()='Create an Account Here']
Print to the console2
    ${Screen_name}    Get Text    (//h1[text()='Sign Up'])[1]
    Log To Console    ${Screen_name} 
    
4.
Enter credentials
    Input Text    ${Web_Login_textBoxUserName}    ${static_carAdviceUsername}
    Input Text    ${Web_Login_textBoxPassword}   ${static_carAdvicepassword}
    #Click Element    ${Web_Login_btnSignIn} 
    Sleep    5s

Enter email and password is blank
    Input Text    ${Web_Login_textBoxUserName}    ${static_carAdviceUsername}
    Sleep    5s
    #Input Text    ${Web_Login_textBoxPassword}    
   # Click Element    ${Web_Login_btnSignIn}
    
10
Get the name of the screen and print it to console
    ${name_signin}    Get Text    //h1[text()='SIGN IN']
    Log To Console    ${name_signin}

Verify when user click on forgot password link on sign in screen
Click on forgotpassword 
    Click Link    //a[@href='/#/password']
Enter valid email and click on submit button
    Input Text    //input[@placeholder='Enter Your Email']    test1322@gmail.com
    Click Element    //span[text()='Submit']

Verify the success message when user click on forgot passowrd link
Verify and print the success message 
    Sleep    3S
    ${Success_message}    Get Text    //div[@class='notification-message']
    Log To Console    ${Success_message}

Sign up screen

Enter valid email of user
    Sleep    10s
    Input Text    (//input[@name='email'])[2]    test1322@gmail.com
Enter first name and lastname
    Sleep    5s
    Input Password    (//input[@class='inputFld'])[9]    demo
    Input Text    (//input[@class='inputFld'])[10]    tester
Enter telephone number and postal code
    Sleep    5s
    Input Text    (//input[@type='tel'])[2]    1234567890
    Input Text    (//input[@name='postal-code'])[2]    60602
Enter valid password and confirm password
    Sleep    5s
    Input Text    (//input[@type='password'])[3]    1234567
    Input Text    (//input[@type='password'])[4]    1234567
    Sleep    3s
14.
Click on already a customer
    Sleep    10s
    Click Element    (//a[text()='Click Here'])[2]

38.
Click on text and verify
    Sleep    10s
    ${caradvise_text}    Get Text    (//div[text()='By signing up, you agree to the CarAdvise'])[2]
    Log To Console    ${caradvise_text} 


39.
Enter password and confirm password
    Sleep    10s
    Input Text    (//input[@type='password'])[3]    1234567
    Input Text    (//input[@type='password'])[4]    6543421
Click on next button on sign up screen
    Sleep    5s
    Click Element    (//span[text()='Next'])[2]
Print the error message
    ${password_error}    Get Text    (//span[@class='error-message'])[2]
    Log To Console    ${password_error}

41.
Verify the screen and print to console
    ${Name_sign up}    Get Text    (//h1[text()='Sign Up'])[2]
    Log To Console     ${Name_sign up}

45.

    Sleep    20s
    #Click Element    (//span[text()='Next'])[2]
Verify error message for email
    Sleep    8s
    ${error_email}    Get Text    (//span[@class='error-message'])[7]
    Log To Console     ${error_email} 
Verify error message for firstname
    ${error_firstname}    Get Text    (//span[@class='error-message'])[8]
    Log To Console     ${error_firstname} 
Verify error message for lastname
    ${error_lastname}    Get Text    (//span[@class='error-message'])[9]
    Log To Console     ${error_lastname} 
Verify error message for phonenumber
    ${error_phone number}    Get Text    (//span[@class='error-message'])[10]
    Log To Console    ${error_phone number}
Verify error message for postal code
    ${error_postalcode}    Get Text     (//span[@class='error-message'])[11]
    Log To Console    ${error_postalcode} 
Verify error message for password
    ${error_password}    Get Text     (//span[@class='error-message'])[12]
    Log To Console     ${error_password} 

Onboarding screen
    
Verify the text "How would you like to add your car?" on onboarding screen
Get text and verify
    ${initial text}    Get Text    //p[text()='How would you like to add your car?']
    Log To Console    ${initial text} 

Verify three options to add the car manually, ViN and licence plate
Verify License plate and print to the comsole
    ${Onboarding licence plate}    Get Text    //div[text()='License Plate']
    Log To Console    ${Onboarding licence plate}
Verify VIN and print 
    Sleep    3s
    ${onboarding_VIN}    Get Text    //div[text()='VIN Number']
    Log To Console    ${onboarding_VIN}
Verify manually and print 
    Sleep    3s
    ${onboarding_manual}    Get Text    //div[text()='Manually']
    Log To Console    ${onboarding_manual} 

Verify when user tap on "Save my car" button after VIN is entered on onboarding screen
Click and enter VIN
    Click Element    //div[text()='VIN Number']
    Input Text    //input[@name='vin']    SCBFU7ZA8FC884489
Enter miles
    Input Text    //input[@name='miles']    10000
Click on save my car
    Click Element    //button[text()='Save My Car']

Verify when user tap on "Save my car" button using "licence plate number" on onboarding screen
Click and enter licence plate
    Click Element    //div[text()='License Plate']
    Input Text    //input[@name='plateNumber']    123f
Enter state
    Click Element    //i[@class='dropdown icon']
    Sleep    5s
    Select From List By Index     3

Verify when user tap on "Save my car" button using "manually" on onboarding screen
    Click Element    //div[text()='Manually']
    Select From DropDown by Label    $static_waitSmall   //div[@class='visible menu transition']    2024  

Verify the "sign in" screen when user tap on "Already have an account" link on "Onboarding" screen 
Click on click here
    Click Link    //a[text()='Click Here']

OrderBooking Flow

Verify when user tap on "Diagnose a problem" on dashboard screen
Click on diagnose a problem
    Sleep    8s
    Click Link    //span[text()='Diagnose a Problem']

Click on Maintenance remainder
    Click Link    //a[@href='#/suggestedMaintenance']
Click on Membership
    Click Link    (//a[@href='#/membership'])[1]
Click on Glovebox
    Click Link    //a[@href='#/gloveboxComponent']
Click on Invite friends
    Click Link    //a[@href='#/invite-friends']
Click on Partner offers
    Click Link    //a[@href='#/offers']
Click on FAQ
    Click Link    (//a[@href='https://caradvise.com/faq/'])[2]
Click on Maintenance history
    Click Link    (//a[@href='#/vehicles/31345/history'])[2]

Verify name of the default vehicle on dashboard screen
Get the name of the default and print to the console
    ${Vehicle name}    Get Text    //div[@class='vehicle'  
    Log To Console    ${Vehicle name}

Verify when user tap on "select shop" link on Common Services screen
Click on select shop and get it printed in to the console
    Click Element    //span[text()='Select Shop']
    ${shop_screen}    Get Text    //div[text()='Select Shop']
    Log To Console    ${shop_screen} 

Verify user is able to see "My Garage" screen
Click on my garage and get it printed in to the console
    Sleep    5s
    Click Link     ${Web_mygarage}   
    ${Mygarage_name}    Get Text    (//span[text()='My Garage'])[2] 
    Log To Console    ${Mygarage_name} 

Verify user is able to search service using "Search services..." search bar
Click on search all services
Enter new tire
    Sleep    5s
    Click Element    //input[@class='search']
    Input Text    //input[@class='search']    New Tires

Verify user is able to add vehicle after adding VIN
Click on my garage
    Sleep    5s
    Click Link    xpath=(//a[@href='#/managevehicles'])[2]
Click on add vehicle
    Sleep    5s
    Click Element    //span[text()='Add Vehicle']
    #Click Element    //span[text()='Add Vehicle']  
Enter VIN and miles
    Sleep    10s
    Click Element    //span[text()='Enter Vin']
    Input Text    //input[@placeholder='VIN']    DFRT67HNB89OK6543
    Input Text    //input[@placeholder='How Many Miles?']    15000
Click on next button
    Click Element    //a[@class=" classic-ca-button orange-button"]


Verify when user taps on Vehicle name on "my Garage" screen
Verify name of the vehicle and get it printed in console
    ${Name of default vehicle}    Get Text    (//div[@class='vehicle-ymm'])[1]  
    Log To Console    ${Name of default vehicle} 

Verify the user is able to navigate back to the "Add Vehicle" screen from the "Enter VIN" screen using the back button arrow on the screen 
    Sleep    5s
    Click Element    //span[text()='Add Vehicle']
    Sleep    5s
    #Click Element    //span[text()='Add Vehicle']  
    Sleep    10s
    Click Element    //span[text()='Enter Vin']
    Go Back

Verify Your selected services on "Selectshops" screen
Print the name of the service selected
    ${Selected_service}    Get Text    //span[@class='OrderServicePriceRow-name']
    Log To Console    ${Selected_service} 

verify when order status is "Approved" then message should be display like "The shop will proceed with all approved work. You will be notified when work is complete to pick up your vehicle."
    Sleep    5S   
    Setup Browser    ${static_urladminPortal}    ${static_browserChrome}
    Admin Portal Enter Credentials
    Wait and Click web    ${static_waitSmall}    ${web_ShopOrderLink}
    Wait and input text web    ${static_waitSmall}    ${web_vinInputBox}    ${Vin}  
    Click Element    ${web_vinInputBox}
    Input Text    ${web_vinInputBox}    SCBFU7ZA8FC884489
    Sleep    10s
    Click Element    //a[@href='/admin/shop_orders/13454/edit']
    Select From List By Label    //span[@title='approval']
    Click Element    (//input[@value='Update Shop order'])[1]
    Sleep    3s
    Login to Car Advice
    Sleep    3s
    ${Notification}    Get Text    //div[@class='generic-panel']   
    ${Notification}    Get Text    //div[@class='generic-panel']   
    Log To Console     ${Notification}

Verify when the user select a service which is at the beginning of "horizontal services" on the "Shop Map" screen 
Click on Choose service 
    Check if Services selected
    Click Element    ${web_HomePage_ChooseService} 
Enter Oil chnage and select it
    Sleep    3s
    Input Text    //input[@class='search']    Oil Change
    Sleep    2s
    Click Element    (//div[text()='Oil Change'])[1]
Click on add services and continue shopping 
    Sleep    8s
    Click Element    //span[text()='Add Service & Continue Shopping']

Verify user is able to see shop name and address on "select date and time" screen
Verify the selected shop and print to the console
    ${shopname}     Get Text    //div[@class='yourShopInfo']
    Log To Console    ${shopname} 

Verify user is able to see "Request appointment screen"
Click on book walkin
    ${status}=    Run Keyword And Return Status    Check if element is not present    ${webAppointment_NoTimeAvailable}
    Run Keyword If    '${status}'=='False'     Select Day after tomorrow for service
    Sleep    2s
    Wait and Click web    ${static_waitLarge}    ${web_BrowseShops_AppointmentType_Walkin} 
    Wait and Click web    ${static_waitLarge}    ${Web_BookAppointmentButton1}    
    Sleep    1s
    Wait and Click web    ${static_waitLarge}    ${Web_BookAppointmentButton3}
Verify and print request appointment
    ${RA}    Get Text    ${Web_RequestAppointmentButton1}
    Log To Console    ${RA}

Book walk is displayed    
    ${status}=    Run Keyword And Return Status    Check if element is not present    ${webAppointment_NoTimeAvailable}
    Run Keyword If    '${status}'=='False'     Select Day after tomorrow for service
    Sleep    2s
    Wait and Click web    ${static_waitLarge}    ${web_BrowseShops_AppointmentType_Walkin} 

Verify dash board screen
Get the name of the screen in console
    ${Screen}    Get Text    //span[text()='Dashboard']
    Log To Console    ${Screen}

Verify user entered VIN only and do not enter "how many miles" then warning message is displayed 
    Sleep    5s
    Click Link    //a[text()='Go To Garage']
    Sleep    5s
    Click Element    //span[text()='Add Vehicle']
    Sleep    5s
    #Click Element    //span[text()='Add Vehicle']  
Enter VIN only 
    Sleep    10s
    Click Element    //span[text()='Enter Vin']
    Input Text    //input[@placeholder='VIN']    DFRT67HNB89OK6543
    Input Text    //input[@placeholder='How Many Miles?']    0
Get the warning message and print to the console
    ${warning_message}    Get Text    //div[@class='notification-message']
    Log To Console    ${warning_message} 


To verify that warning message is displayed if user enters invalid and less than 17 characters VIN
    Sleep    5s
    Click Link    //a[text()='Go To Garage']
    Sleep    5s
    Click Element    //span[text()='Add Vehicle']
    Sleep    5s
    #Click Element    //span[text()='Add Vehicle']  
Enter invalid VIN and valid miles
    Sleep    10s
    Click Element    //span[text()='Enter Vin']
    Input Text    //input[@placeholder='VIN']    DFRT67HNB89OK654
    Input Text    //input[@placeholder='How Many Miles?']    10000
   # Click Element    //a[@class=" classic-ca-button orange-button"]
Get printed the notification 
    ${warning_message}    Get Text    //div[@class='notification-message']
    Log To Console    ${warning_message} 

Verify the user is able to navigate back to the "Select Date & Time" screen from the "Request appointment" screen using the back button of the device 
User is on "Request appointment" screen 
    ${status}=    Run Keyword And Return Status    Check if element is not present    ${webAppointment_NoTimeAvailable}
    Run Keyword If    '${status}'=='False'     Select Day after tomorrow for service
    Sleep    2s
    Wait and Click web    ${static_waitLarge}    ${web_BrowseShops_AppointmentType_Walkin} 
    Wait and Click web    ${static_waitLarge}    ${Web_BookAppointmentButton1}    
    Sleep    1s
    Wait and Click web    ${static_waitLarge}    ${Web_BookAppointmentButton3}

Verify when the user tap on the cross symbol on the Edit Vehicle screen
    Sleep    5s
    Click Link    //a[text()='Go To Garage']
Click on edit vehicle
    Sleep    5s
    Click Element    (//span[text()='Edit Vehicle'])[1]
Click on edit and X 
    Click Element    //div[text()='Edit']
    Click Element    //a[@class='modal-header-close-button']

Verify user is able to click on "Use this vehicle" screen
    Sleep    5s
    Click Link    //a[text()='Go To Garage']
    Sleep    5s
    Click Element    (//span[text()='Edit Vehicle'])[1]
Click on use this vehicle
    Click Element    //div[text()='Use this vehicle']

Verify user details on right hand side of the dashboard screen 
Click on User profile
    Click Element    //span[text()='TU']
    Sleep    5S
Click on My Account
    Click Link    (//a[contains(text(),'My Account')])[2]
    #Select From List By Value    'MyAccount'
Get firstname and print it
    ${myaccount_firstname}    Get Text    //input[@name='firstName']   
    Log To Console    ${myaccount_firstname} 
Get lastname and print it
    ${myaccount_Lastname}    Get Text   //input[@name='lastName']  
    Log To Console     ${myaccount_Lastname}  
Get cellphone and print it
    ${myaccount_cellphone}    Get Text   //input[@name='cellPhone']  
    Log To Console    ${myaccount_cellphone}  
Get email and print it
    ${myaccount_email}    Get Text    //input[@name='email']
    Log To Console    ${myaccount_email}
Get zip and print it
    ${myaccount_zip}    Get Text    //input[@name='zip']
    Log To Console    ${myaccount_zip} 

Verify details of Vehicle on "My Garage" screen which is set as "Default"
    Sleep    5s
    Click Link    //a[text()='Go To Garage']
    Sleep    5s
Get details of the default vehicle and print to the console
    ${default_name}    Get Text    (//div[@class='vehicle-ymm'])[1]
    Log To Console    ${default_name} 
    ${default_VIN}    Get text    //span[text()='SCBFU7ZA8FC884489']
    Log To Console      ${default_VIN}
    ${default_millage}    Get Text    (//span[@class='vehicle-title-details'])[2]
    Log To Console    ${default_millage}
    ${current_millage}    Get Text    (//span[@class='vehicle-title-details'])[3]
    Log To Console    ${current_millage}
    ${estimated_millage}    Get Text    (//span[@class='vehicle-title-details'])[4]
    Log To Console     ${estimated_millage} 
    ${next_maintenance}    Get Text    (//span[@class='vehicle-title-details'])[6]
    Log To Console     ${next_maintenance} 

Verify user is able to view selected shop and services
Get shop and service name in console which is selected
    ${shop_name}    Get Text    //div[@class='yourShopInfo']
    Log To Console     ${shop_name} 
    ${service_name}    Get Text    //span[text()='New Tires']
    Log To Console     ${service_name}

Verify user is able to select shop.


Verify user is able to deselect service which is selected 
Enter service in search all services
    Sleep    5S
    Input Text     //input[@class='search']     NewTires
Clear selected service
    Sleep    5s
    Clear Element Text    //input[@class='search']  

Verify when user tap on Search all services and shop search bar when no services selected
No service is selected
    Click Element    //input[@class='search']
    Input Text    //input[@class='search']    .....

Verify when user tap on "Search all services" on search bar when more than one service is selected 
Enter new tires on select all service
    Click Element    //input[@class='search']
    Input Text    //input[@class='search']    New
    Sleep    3s
    Click Element    (//div[text()='New Tires'])[1] 
    Sleep    20s
   # Click Element    //span[text()='Add Service & Continue Shopping']
Clear the text from serach bar
    Sleep    20
    Clear Element Text    //input[@class='search'] 
Enter another service oil change
    Sleep    10s
    Input Text    //input[@class='search']    Oil Change
    Sleep    5s
    Click Element    (//div[contains(text(),'Oil Change')])[1]
Click on see prices & schedule now
    Sleep    20s
    Click Element    //span[text()='See Prices & Schedule Now']
Get the selected services and print it to console
    Sleep    5s
    ${services_selected}    Get Text    //div[@class='cart-summary']
    Log To Console    ${services_selected}

Verify when user tap on "X' button on cancle Appointments screen. 
Click on cancle order and X 
    Click Element    (//a[text()='Cancel Order'])[2]
    Click Element    //a[@class='modal-header-close-button']

Verify that user has successfully signed out.
    Click Element    //span[text()='TU']
Click on sign out
    Click Element    (//a[text()='Sign Out'])[2]

Verify when user clear service enterd from search all services 
Click element and enter service
    Click Element    //input[@class='search']
    Input Text    //input[@class='search']    New
Select service like new tire
    Sleep    3s
    Click Element    (//div[text()='New Tires'])[1] 

    Sleep    5s
   # Click Element    //span[text()='Add Service & Continue Shopping']
Clear service name
    Sleep    20
    Clear Element Text    //div[text()='Search all Services'] 

Verify user is able to cancel order when user click on "No, keep my appointment" button present on "cancel order" popup
Click on cancle order
    Click Element    //a[text()='Cancel Order']
Click on No
    Click Element    //span[contains(text(),'No, keep my appointment')]


Verify user should navigate to "select shop" screen when tap on "Change shop"
Click on change shop and print it to the console
    Click Link    //a[text()='Change Shop']  
    ${screen _name1}    Get Text    //div[text()='Select Shop']
    Log To Console    ${screen _name1}

Verify when the user tap on the "Approval" on dashboard screen 
Click on Approvals
    Click Link    (//a[@href='#/approvals'])[1]

Verify user is able to select shop and service
Get selected shop and service print to console
    ${shop_name1}    Get Text    //span[@class='OrderServicePriceRow-name']
    Log To Console    ${shop_name1} 
    ${Shop_name2}    Get Text    //div[@class='yourShopInfo']
    Log To Console    ${Shop_name2} 

Click on change date /time
    Click Link    //a[text()='Change Date/Time']

Click on Add or change services
    Click Link    //a[text()='Add or Change Services']
    ${Common services_screen}    Get Text    //div[contains(text(),'Common Services')]
    Log To Console    ${Common services_screen} 

Click on Add to calender
    Wait and Click web    $static_waitMed    (//div[text()='Add to Calendar'])[2]
    Wait and Click web    $static_waitSmall    //a[text()='iCal']

Get text of order booked and print in console
    ${Orderbooked}    Get Text    //p[@class='caradvise-electric-blue']
    Log To Console    ${Orderbooked} 

    #Click Element    //span[text()='TU']
Get printed the membership of user
    ${Membership}    Get Text    //span[@class='tier-banner']
    Log To Console     ${Membership}

Get the price and verify
    ${price}    Get Text    //span[text()='Discount Price at Shop']
    Log To Console    ${price} 

Click Left Navigation
    [Arguments]    ${NavigationMenuName}
    Run Keyword If    "${NavigationMenuName}"=="Home"    Wait and Click web    ${static_waitSmall}    ${leftPane_HomeIcon}
