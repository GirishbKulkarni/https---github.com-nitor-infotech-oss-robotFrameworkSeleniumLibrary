*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

Resource    ../statics/staticVariables.resource
Resource    ../ObjectRepository/OR_Web_AdminPortal.resource
Resource    ../ObjectRepository/OR_WEB_Adminportal.resource
Resource    ../baseFunctions/carAdviceFunctions.resource
Resource    ../baseFunctions/randomeVinGenerator.resource
Resource    ../baseFunctions/adminPortalFunctions.resource

Suite Setup           Login to Car Advice
Suite Teardown        Close Browser and Clear Cache
Test Setup            Click Left Navigation    Home



*** Test Cases *** 
Create New Appointment
    [Tags]    Regression
    Choose Service
    Browse and Select shop
    Select Date for service
    Book and Confirm the Appointment
    
Cleanup code- Cancelling an appointment
    [Tags]    Smoke
    Cancel Appointment

Lets Fail this Test case
    [Tags]    Failed_TC
    Go to google
    Search Something
    Go to Images
    Do Something Else

*** Keywords ***    
Go to google 
    SeleniumLibrary.Go To    https://Google.com

Search Something
    Wait and input text web    ${static_waitSmall}    xpath=//input[@name='q']    happy funny
    SeleniumLibrary.Press Keys    xpath=//input[@name='q']    ENTER

Go to Images
    Wait and Click web    ${static_waitSmall}    xpath=//a[text()='Images']
    Click Element    xpath=//a[text()='Making Sure That This Will Fail']

Do Something Else
    Wait and Click web    ${static_waitSmall}    xpath=//a[text()='Images']
    Click Element    xpath=//a[text()='Making Sure That This Will Fail']