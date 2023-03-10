*** Settings ***
Library    SeleniumLibrary
Library    SeleniumLibrary    firef
Library    String
Resource    ../baseFunctions/commonFunctions.resource

*** Variables ***
${a}=    "abc"
${b}=    "pqr"

*** Test Cases ***

Simple Test case 
    [Tags]    Smoke
    #Should Be Equal As Strings    ${a}    ${b}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${a}    ${b}
    Log To Console    This keyword is executed	

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
    #desired_capabilities=firefox_binary:"C:\Users\Girish.Kulkarni\Downloads\geckodriver-v0.32.0-win32.exe"
    #url: str | None = None, 
    #browser: str = firefox, 
    #alias: str | None = None, 
    #remote_url: bool | str = False, ff_profile_dir: FirefoxProfile   
    #desired_capabilities: dict | None | str = None, 
    #f_profile_dir: FirefoxProfile | str | None = None, 
    #options: Any | None = None, 
    #service_log_path: str | None = None, executable_path: str | None = None
    #C:\Program Files\Mozilla Firefox\firefox.exe


    Check if element is not present    ${web_HomePagePopup_NextButton}