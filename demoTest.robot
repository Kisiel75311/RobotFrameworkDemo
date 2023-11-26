*** Settings ***
Library           RequestsLibrary
Library           Collections

Suite Setup       Set Up Suite
Suite Teardown    Tear Down Suite

*** Variables ***
${BASE_URL}       https://reqres.in/api/
${USER_ID}        1
${USERNAME}       demo
${PASSWORD}       password123

*** Test Cases ***
Get User List Should Return 200 And Contains Data
    [Tags]   Get User List Should Return 200 And Contains Data
    Create Session    reqres    ${BASE_URL}
    ${response}=      GET On Session    reqres    /users    params=page=1
    Should Be Equal As Strings    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    data

Update User Should Return 200
    [Tags]   Update User Should Return 200
    ${data}=    Create Dictionary    name=demo    job=developer
    ${response}=    PUT On Session    reqres    /users/${USER_ID}    json=${data}
    Should Be Equal As Strings    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    updatedAt

Login Should Return 200 And Token
    [Tags]   Login Should Return 200 And Token
    ${data}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}=    POST On Session    reqres    /login    json=${data}
    Should Be Equal As Strings    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token

*** Keywords ***
Set Up Suite
    Log    SetUp done

Tear Down Suite
    Log    TearDown done
