*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

Resource    ../statics/staticVariables.resource
Resource    ../ObjectRepository/OR_Web_AdminPortal.resource
Resource    ../ObjectRepository/OR_Web_CarAdvice.resource

*** Keywords ***
Open Browser and Login
    Open Browser    ${static_urlCarAdvice}    ${static_browserChrome}
    Maximize Browser Window
    Set Browser Implicit Wait    ${static_waitXLarge}
    Sleep    ${static_waitXLarge}
    Log To Console    "Captcha time completed"
    Input Text    ${Web_Login_textBoxUserName}    ${static_carAdviceUsername}
    Input Text    ${Web_Login_textBoxPassword}    ${static_carAdvicepassword}
    Click Element    ${Web_Login_btnSignIn}

Setup Browser
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    ${static_waitXLarge}

Close Browser and Clear Cache
    SeleniumLibrary.Close All Browsers

Wait and Click web
    [Arguments]    ${waitTime}    ${locator}
    
    Log To Console    Looking for element - ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${waitTime}
    Sleep    3s
    SeleniumLibrary.Click Element    ${locator}
    Log To Console    Element - ${locator} Found and Clicked

Wait and Click Using JavaScript
    [Arguments]    ${waitTime}    ${locator}
    Sleep    1s
    Log To Console    Looking for element - ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${waitTime}
    ${element}    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${element}     
    Log To Console    Element - ${locator} Found and Clicked using JavaScript

Wait and input text web
    [Arguments]    ${waitTime}    ${locator}    ${inputText}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${waitTime}
    SeleniumLibrary.Input Text    ${locator}    ${inputText}
    Log To Console    Inserted text '${inputText}' in to ${locator} 

Wait and Verify Element
    [Arguments]    ${waitTime}    ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${static_waitSmall}
    SeleniumLibrary.Element Should Be Visible    ${locator}

Check element and Return status 
    [Arguments]    ${locator}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${locator}    ${static_waitSmall}
    [Return]    ${status}

Check if element is not present
    [Arguments]    ${locator}
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    ${locator}
    Run Keyword If    '${status}'=='True'        Log To Console    Element with locator ${locator} is not present.
    Run Keyword If    '${status}'=='False'        Log To Console    Element with locator ${locator} is present.
    [Return]    ${status}
Select From DropDown by Label
    [Arguments]    ${waitTime}    ${dropDown}    ${label}
    Select From List By Label    ${label}

Print the Log 
    [Arguments]    ${stringMessageToBePrinted}
    Log    ${stringMessageToBePrinted}
    Log To Console    ${stringMessageToBePrinted}

Get Todays Day
    ${date} =	Get Current Date
    [Return]    ${date}

Get Tomorrows Day
    ${date} =	Get Current Date
    ${tomorrow}=    Add Time To Date    ${date}    1days
    ${day}=    Get Substring    ${tomorrow}    8    10
    ${intDays}=    Convert To Integer    ${day}
    ${day}=    Convert To String    ${intDays}    
    Print the Log    Tomorrows Day= ${day} 
    [Return]    ${day}

Get Day after Tomorrows Day
    ${date} =	Get Current Date
    ${tomorrow}=    Add Time To Date    ${date}    2days
    ${day}=    Get Substring    ${tomorrow}    8    10
    ${intDays}=    Convert To Integer    ${day}
    ${day}=    Convert To String    ${intDays}
    Print the Log    Tomorrows Day= ${day}
    [Return]    ${day}

Create DynamicXpath
    [Arguments]    ${xpath}    ${textToBeReplaced}    ${replacementText}
    Print the Log    Original Xpath = ${xpath}
    ${newXpath}=    Replace String    ${xpath}    ${textToBeReplaced}    ${replacementText}
    Print the Log    Xpath to use = ${newXpath}
    [Return]    ${newXpath}


Mouse over Mouse Down Mouse Up
    [Arguments]    ${locator}
    SeleniumLibrary.Mouse Over    ${locator}
    Sleep    2
    SeleniumLibrary.Mouse Down    ${locator}
    SeleniumLibrary.Mouse Up    ${locator}

Quick Check if Element is not present 
    [Arguments]    ${locator}
    ${status}=    Run Keyword And Return Status    Click Element    1s    ${locator}
    Run Keyword If    '${status}'=='True'        Log To Console    Element with locator ${locator} is present.
    Run Keyword If    '${status}'=='False'        Log To Console    Element with locator ${locator} is not present.
    [Return]    ${status}