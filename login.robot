*** Settings ***
Library    Browser
#Click     //button
Set Browser Timeout    ${old_timeout}

*** Variables ***

${URL} =    https://the-internet.herokuapp.com
${USERNAME}=    tomsmith
${PASSWORD}=    SuperSecretPassword!
${old_timeout} =    Set Browser Timeout    1m 30 seconds

*** Keywords ***

Open Browser To Login Page
    New Browser    headless=${FALSE}
    New Page    ${URL}/login

Enter Username
    [Arguments]    ${username}
    Fill Text    id=username    ${username}

Enter Password
    [Arguments]    ${password}
    Fill Secret    input#password    $password

Submit Login Form
    Click    button.radius

Verify That Welcome Page Is Visible
    Get Text    body    contains    Welcome 
    Get Url    ==    ${URL}/secure
    

Do Successful Login
    Open Browser To Login Page
    Enter Username    ${USERNAME}
    Enter Password    ${PASSWORD}
    Submit Login Form

Do Successful Logout
    Click    a.button

Verify That Login Page Is Visible
    Get Url    ==    ${URL}/login 


*** Test Cases ***

Welcome page should be visible after successful login
    Open Browser To Login Page
    Enter Username    ${USERNAME}
    Enter Password    ${PASSWORD}
    Submit Login Form
    Verify That Welcome Page Is Visible
    [Teardown]    Do Successful Logout

Login Form Should Be Visible After Successful Logout
    [Setup]    Do Successful Login
    Verify That Welcome Page Is Visible
    Do Successful Logout
    Verify That Login Page Is Visible