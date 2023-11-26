*** Settings ***
Library           RequestsLibrary
Library           Collections

Suite Setup       Set Up Suite
Suite Teardown    Tear Down Suite

*** Variables ***
${BASE_URL}       https://reqres.in/api/
${USER_ID}        1  # Przykładowe ID użytkownika
${NAME}           Jan Kowalski
${JOB}            Developer

*** Test Cases ***
Get User List Should Return 200 And Contains Data
    Create Session    reqres    ${BASE_URL}
    ${response}=      GET On Session    reqres    /users    params=page=1
    Should Be Equal As Strings    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    data

Update User Should Return 200 With Updated Information
    ${data}=    Create Dictionary    name=${NAME}    job=${JOB}
    ${response}=    PUT On Session    reqres    /users/${USER_ID}    json=${data}
    Should Be Equal As Strings    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    updatedAt

*** Keywords ***
Set Up Suite
    Log    SetUp done

Tear Down Suite
    Log    TearDown done
