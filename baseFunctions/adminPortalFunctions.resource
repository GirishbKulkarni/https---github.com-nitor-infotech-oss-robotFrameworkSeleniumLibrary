*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

Resource    ../statics/staticVariables.resource
Resource    ../ObjectRepository/OR_Web_AdminPortal.resource
Resource    ../ObjectRepository/OR_Web_CarAdvice.resource
Resource    ../baseFunctions/carAdviceFunctions.resource

*** Keywords ***
Admin Portal Enter Credentials
    #Sleep    ${static_waitXLarge}
    #Log To Console    Captcha Wait completed
    Wait and input text web    ${static_waitSmall}    ${Web_AdminPortaluserName}    ${static_adminPortalUsername}
    Wait and input text web    ${static_waitSmall}    ${web_AdminPortalPassword}    ${static_adminPortalPassword}
    Sleep    5s
    
    #SeleniumLibrary.Select Frame    //iframe[@title='reCAPTCHA']
    #SeleniumLibrary.Unselect Frame
    #Wait and Click web    ${static_waitSmall}    xpath=//div[@class='recaptcha-checkbox-border']            #//div[@class='rc-anchor-content']            #//span[@class='recaptcha-checkbox goog-inline-block recaptcha-checkbox-unchecked rc-anchor-checkbox']    #//div[@class='recaptcha-checkbox-spinner']            #//div[@class='recaptcha-checkbox-border']

    Wait and Click web    ${static_waitSmall}    ${web_AdminPortalLoginButton}

Admin Portal Delete First Appointment
    Wait and Click web    ${static_waitSmall}    ${web_vehile_firstAppointmentDelete}

Admin Portal Searh vehicle by Vin
    ${status}    Run Keyword And Return Status    Wait and Click web    ${static_waitSmall}    ${web_ShopOrderLink}
    
    Wait and Click web    ${static_waitSmall}    ${web_ShopOrderLink}
    Wait and input text web    ${static_waitSmall}    ${web_vinInputBox}    ${static_vin}
    Press Keys    ${web_vinInputBox}    ENTER

