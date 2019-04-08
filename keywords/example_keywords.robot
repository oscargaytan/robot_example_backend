*** Settings ***
Documentation    Suite description

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
    log to console    URL: ${api_host} \n
    create session  getUser  ${api_host}
    # ${headers}=  Create Dictionary   Content-Type=application/json     Authorization=Bearer
    # ${data}=  Create Dictionary   thaiId=${thaiId}  makroId=${makroId}  tmnId=${tmnId}   kycLevel=${kycLevel}    consentDiscloseInfo=${consentDiscloseInfo}  consentPayment=${consentPayment}    consentTermCondition=${consentTermCondition}     selfDeclare=${selfDeclare}  phoneNumber=${phoneNumber}    email=${email}
    ${response}=    Get Request     getUser  /   # data=${data}   headers=${headers}
    log to console    Response:     ${response}
    set test variable    ${response}    ${response}

###==== Validate And Asserts ====###
verify response schema '${schema}'
    [Documentation]     Verify response is equal to expected JSONschema
    ${response}=    To Json    ${response.text}
    Validate Json   ${schema}  ${response}

HTTP status should be '${expected_code}'
    [Documentation]    Verify response http ststus with expected code
    should be equal as integers    ${response.status_code}    ${expected_code}
