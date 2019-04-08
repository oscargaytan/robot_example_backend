*** Settings ***
Documentation    Suite description
Library     RequestsLibrary
Library     json
Library     JSONSchemaLibrary

*** Variables ***
${api_host}     https://reqres.in/api/users?

*** Keywords ***
###==== Variables ====###
user has some data
    [Documentation]     Set variables
    set test variable    ${this}    hola

###==== Actions ====###
call to API
    [Documentation]     call to endpoint
    log to console    \n-URL: ${api_host} \n
    create session  getUser  ${api_host}    verify=True
    # ${headers}=  Create Dictionary   Content-Type=application/json     Authorization=Bearer
    # ${data}=  Create Dictionary   thaiId=${thaiId}  makroId=${makroId}  tmnId=${tmnId}   kycLevel=${kycLevel}    consentDiscloseInfo=${consentDiscloseInfo}  consentPayment=${consentPayment}    consentTermCondition=${consentTermCondition}     selfDeclare=${selfDeclare}  phoneNumber=${phoneNumber}    email=${email}
    ${response}=    Get Request     getUser  /   # data=${data}   headers=${headers}
    set test variable    ${response}    ${response}
    Log To Console     \n-Response:\n${response.json()}

###==== Validate And Asserts ====###
verify response schema '${schema}'
    [Documentation]     Verify response is equal to expected JSONschema
    ${response}=    To Json    ${response.text}
    Validate Json   ${schema}  ${response}

HTTP status should be '${expected_code}'
    [Documentation]    Verify response http ststus with expected code
    should be equal as integers    ${response.status_code}    ${expected_code}
