*** Settings ***
Library                        SeleniumLibrary
Library                        
Resource                       ../baseFunctions/commonFunctions.resource
Resource                       ../ObjectRepository/OR_Web_AppName.resource

Suite Setup                    Open Browser and Login
Suite Teardown                 Close Browser and Clear Cache


*** Test Cases ***

Registration Test Case
    [Tags]    Smoke
    Wait and input text web    ${static_waitMed}    ${RegForm_firstName}    $inputText

Simple Test case 1
    [Tags]    Smoke
    #Should Be Equal As Strings    ${a}    ${b}
    Log To Console    This keyword is executed	

Simple Test case 2
    [Tags]    Smoke
    #Should Be Equal As Strings    ${a}    ${b}
    Log To Console    This keyword is executed	


Regression
    [Tags]    Regression
    Log To Console    Regression 1

Regression 1
    [Tags]    Regression
    Log To Console    Regression 1

Regression 2
    [Tags]    Regression
    Log To Console    Regression 1

Test case
    Open Browser    url="https:\\www.google.com"    browser=firefix    