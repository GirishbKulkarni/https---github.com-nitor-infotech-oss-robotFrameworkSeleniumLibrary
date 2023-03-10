*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

Resource    ../statics/staticVariables.resource
Resource    ../ObjectRepository/OR_Web_AdminPortal.resource
Resource    ../ObjectRepository/OR_Web_CarAdvice.resource
Resource    ../baseFunctions/carAdviceFunctions.resource

*** Keywords ***
Random VIN Generator
    Open Browser    https://randomvin.com    ${static_browserChrome}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@value='Random Valid VIN']
    Click Element    xpath=//input[@value='Random Valid VIN']
    Wait Until Element Is Visible    xpath=//h2
    Sleep    5s
    ${vin}=    Get Text    xpath=//h2
    Log To Console    VIN: ${vin}
    Close Browser
    [Return]    ${vin}