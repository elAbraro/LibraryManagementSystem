*** Settings ***
Documentation   Testing Add Student and View Students
Library    SeleniumLibrary

*** Variables ***
${SERVER}    http://127.0.0.1:8000
${BROWSER}   Chrome
${USERNAME}  user
${PASSWORD}  1234
${STUDENT_NAME}  Mr Invincible
${STUDENT_ID}    ST12345

*** Keywords ***
Login as Staff
    Open Browser    ${SERVER}/stafflogin/    ${BROWSER}
    Wait Until Page Contains Element    id=loginuname    timeout=15s
    Input Text      id=loginuname    ${USERNAME}
    Input Text      id=loginpassword    ${PASSWORD}
    Click Button    xpath=//input[@type='submit']
    Wait Until Page Contains Element    class=sidebar    timeout=15s
    ${error_message}=    Run Keyword And Return Status    Wait Until Page Contains    Error    timeout=5s
    Should Not Be True    ${error_message}    The login failed. Check the username and password.

Go to Add Student Page
    Go To    ${SERVER}/addstudent/

Submit Student Form
    Input Text    id=sname    ${STUDENT_NAME}
    Input Text    id=studentid    ${STUDENT_ID}
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains    Student added successfully    timeout=30s

Go to View Students Page
    Go To    ${SERVER}/viewstudents/

Verify Student in List
    Wait Until Page Contains    ${STUDENT_NAME}    timeout=30s

Verify Student Information
    Wait Until Page Contains    ${STUDENT_NAME}    timeout=30s
    Wait Until Page Contains    ${STUDENT_ID}    timeout=30s

Verify Login Status
    [Arguments]    ${username}    ${password}
    Open Browser    ${SERVER}/stafflogin/    ${BROWSER}
    Wait Until Page Contains Element    id=loginuname    timeout=15s
    Input Text      id=loginuname    ${username}
    Input Text      id=loginpassword    ${password}
    Click Button    xpath=//input[@type='submit']
    ${error_message}=    Run Keyword And Return Status    Wait Until Page Contains    Error    timeout=5s
    Should Not Be True    ${error_message}    The login failed for ${username}. Correct credentials required.

*** Test Cases ***
Test Add Student :: Add a new student after logging in
    Login as Staff
    Go to Add Student Page
    Submit Student Form
    Go to View Students Page
    Verify Student in List

Test View Student Information :: Verify student details after addition
    Login as Staff
    Go to View Students Page
    Verify Student Information

Test User Login Status :: Test login with various credentials
    Verify Login Status    ${USERNAME}    ${PASSWORD}    # Correct login
    Verify Login Status    wrong_user    ${PASSWORD}    # Wrong username
    Verify Login Status    ${USERNAME}    wrong_pass    # Wrong password
    Verify Login Status    wrong_user    wrong_pass    # Both wrong
