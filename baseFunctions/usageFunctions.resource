*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

Resource    ../statics/staticVariables.resource
Resource    commonFunctions.resource

*** Keywords ***
Launch Browser and Navigate to url
    Setup Browser    ${static_applicationURL}    ${static_browserChrome}
    #Add Other Browser setup steps (Ex, accpting cache and cookies OR basic checks post logging in)

Browser closure and tear down actions
    Close All Browsers