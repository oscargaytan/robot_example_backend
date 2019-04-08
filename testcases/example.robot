*** Settings ***
Documentation    Example
Resource    ./../keywords/example_keywords.robot

*** Variables ***
${schema_example}    example_schema.json

*** Test Cases ***
TC_00001 Call to api
    [Documentation]     call to api - success
    When call to API 
    Then HTTP status should be '200'
    And verify response schema '${schema_example}'
