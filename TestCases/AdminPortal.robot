*** Settings ***
Library    SeleniumLibrary

Resource    ../statics/staticVariables.resource
Resource    ../baseFunctions/randomeVinGenerator.resource
Resource    ../baseFunctions/adminPortalFunctions.resource


*** Test Cases ***
Clean Up - From Admin Portal
    [Tags]    CleanUp
    Setup Browser    ${static_urladminPortal}    ${static_browserChrome}
    Admin Portal Enter Credentials
    Admin Portal Searh vehicle by Vin
    Run Keyword And Continue On Failure    Admin Portal Delete First Appointment
