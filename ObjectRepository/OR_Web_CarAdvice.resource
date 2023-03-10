*** Variables ***
${recaptcha}                                    xpath=//div[@class='recaptcha-checkbox-spinner']
${loginPage_AdCloseButton}                      xpath=//button/*[name()='svg' and @aria-labelledby='close-form-1']
${Web_Login_textBoxUserName}                    xpath=//input[@class='inputFld']
${Web_Login_textBoxPassword}                    xpath=//input[@type='password']
${Web_Login_btnSignIn}                          xpath=//b[text()='Sign In']//ancestor::a
${web_HomePagePopup_NextButton}                 xpath=//button[text()='Next']
${web_HomePagePopup_Skip}                       xpath=//div[@class='web-skip']/a[text()='Skip']
${web_HomePage_ChooseService}                   xpath=(.//span[text()='Choose Services'])[2]

${web_HomePage_HomeIcon}                        xpath=//div[@class='mainContainer dashScreen']//a[normalize-space(text())='Dashboard']


${web_ChooseService_ServiceNewTires1}           xpath=//div[text()='New Tires']/preceding-sibling::img     
${web_ChooseService_ServiceNewTires2}           xpath=//div[text()='New Tires']/ancestor::a/*[name()='svg' and @aria-hidden='true' and @style="visibility: hidden;"]        
${web_ChooseService_ServiceNewTires3}           xpath=//div[text()='New Tires']/ancestor::a

${web_ChooseService_ServiceBrakePads}           xpath=//div[text()='Brake Pads']/preceding-sibling::img
${web_ChooseService_ServiceBrakePads_All}       xpath=//div[text()='All']
${web_ChooseService_ServiceNewTires_Selected}   xpath=//div[text()='New Tires']/ancestor::a/*[name()='svg' and @aria-hidden='true' and not(@style="visibility: hidden;")]
${web_ChooseService_BrowseShopsButton}          xpath=(.//span[text()='Browse Shops & Prices'])[2]
${web_BrowseShops_InsertShopLocation}           xpath=//input[@id='geosuggest__input']
${web_BrowseShops_SelectShop}                   xpath=//span[normalize-space()='Chicago, IL, USA']
${web_BrowseShops_Map}                          xpath=//div[@class='mapContainer']
${web_BrowseShops_SelectShopButton}             xpath=(//span[text()='Select']/ancestor::a)[2]
${web_BrowseShops_SelectDate}                   xpath=//div[text()='ReplaceDay' and not(@aria-disabled='true')]
${web_BrowseShops_AppointmentType_Walkin}       xpath=//div[text()='Walk In']
${webAppointment_NoTimeAvailable}               xpath=//div[contains(text(),'No times available for this')]
${Web_BookAppointmentButton1}                   xpath=(//span[text()='Book Walk In']/ancestor::a)[1]
${Web_BookAppointmentButton3}                   xpath=(//span[text()='Book Walk In']/ancestor::a)[3]
${Web_RequestAppointmentButton1}                xpath=(//span[text()='Request Appointment']/ancestor::a)[1]
${Web_AppointmentConfirmation}                  xpath=//p[contains(text(),'Thank you for your order')]
${Web_RemoveService}                            xpath=//div[@class='dashRight']//div[@class='review-table']//td/span[@class='primary-button-color gtm-cart-remove-service']
${Web_RemoveShop}                               xpath=//div[@class='dashRight']//strong[text()='Shop Location']/ancestor::p/span/*[name()='svg']
${web_cancelAppointment1}                       xpath=(//a[text()='Cancel Order'])[2]
${web_cancelAppointment2}                       xpath=//span[text()='Cancel Order']

${Web_mygarage}                                 xpath=(//a[@href='#/managevehicles'])[2]
${web_signup}                                   Sign Up
${dropDown}                                     xpath=//div[@class='ui fluid search selection dropdown']
${label}                                        American Samoa

${cancel_Appointment}                           xpath=(//a[text()='Cancel Order'])[2]
${cancel_Appointment2}                          xpath=//span[text()='Cancel Order']

${leftPane_HomeIcon}                            xpath=//ul//*[name()='svg' and @data-icon='home']