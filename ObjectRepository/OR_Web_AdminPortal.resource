*** Variables ***
${Web_AdminPortaluserName}                xpath=//label[text()='Email']/..//input
${web_AdminPortalPassword}                xpath=//label[text()='Password']/..//input
${web_AdminPortalLoginButton}             xpath=//input[@type='submit' and @id='admin_login_submit_button']
${web_ShopOrderLink}                      xpath=//a[text()='Shop Orders']
${web_vinInputBox}                        xpath=//input[@id='q_vin']
${web_vehile_firstAppointmentDelete}      xpath=(//a[text()='Delete'])[1]
${Vin}                                    1N4AL3AP9FC159413