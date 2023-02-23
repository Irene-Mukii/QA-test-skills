*** Settings ***

Library     RequestsLibrary
Library     Collections
Library     String
Suite Setup    Basic Auth Test



*** Variables ***
${URL}    https://petstore.swagger.io/


*** Test Cases ***


Quick Get Request for pets sold Test

    Create Session      session1    ${URL}    disable_warnings=1
    ${endpoint}    set variable    /v2/pet/findByStatus?status=sold  
    ${response}=    GET On Session    session1    ${endpoint}
    log To Console    ${response.json()}

    #validation
    Status Should Be    200

    ${body}=   convert to string    ${response.content}
    Should contain    ${body}    sold

    ${contentTypeValue}=    get from dictionary  ${response.headers}    Content-Type
    Should Be Equal  ${contentTypeValue}    application/json
    



*** Keywords ***
Basic Auth Test

    ${body}    Create Dictionary    username=irene    password=abc123
    ${response}=    POST    url=https://petstore.swagger.io/oauth/authorize    json=${body}
    log to console      ${response.status_code}