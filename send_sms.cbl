*> Program: SENDSMS
*> Description: send text messages using textbelt.com
*> Author: Rebecca Ann Coles
*> Date: 11/12/2022
*> Tectonics: cobc (GnuCOBOL)
*>
*> Notes:
*>   1) Use the -free flag to compile with the
*>      free source format:
*>        cobc -free -x -o sendsms send_sms.cbl
*>   2) textbelt allows one free text a day
*>      when using 'textbelt' as your API key
*>   3) Your log will be saved to 'send_sms_log.out'
*>      It will contain info from textbelt about
*>      the status of your text:
*>        "success"       : if your sms was successfully 
*>                          sent (not if it was
*>                          successfully delivered)
*>        "textId"        : ID number needed to track
*>                          your sms. For example, if
*>                          your "textId":"12345" you 
*>                          can get your sms status using:
*>                            curl https://textbelt.com/status/12345
*>        "quotaRemaining": your remaining quota. if you 
*>                          use key=textbelt to use your
*>                          daily free text then you will
*>                          see "quotaRemaining":0
*>        "error"         : any sending errors 

IDENTIFICATION DIVISION.
PROGRAM-ID. SENDSMS.
DATA DIVISION.

WORKING-STORAGE SECTION.
*> curl -X POST https://textbelt.com/text \
*>    --data-urlencode phone='5555555555' \
*>    --data-urlencode message='HELLO FROM COBOL' \
*>    -d key=textbelt     
01  WS-COMMAND.
    02 FILLER PIC X(13) VALUE "curl -X POST ".
    02 FILLER PIC X(25) VALUE "https://textbelt.com/text".
    02 FILLER PIC X(25) VALUE " --data-urlencode phone='".
    02 WS-TO-NUMBER PIC X(10).
    02 FILLER PIC X(28) VALUE "' --data-urlencode message='".
    02 WS-MESSAGE PIC X(120).
    02 FILLER PIC X(10) VALUE "' -d key='".
    02 WS-APIKEY PIC X(65).
    02 FILLER PIC X(24) VALUE "' | tee send_sms_log.out".
           
PROCEDURE DIVISION.
MAIN-PROCEDURE.
    MOVE "5555555555" TO WS-TO-NUMBER.
    MOVE "HELLO FROM COBOL" TO WS-MESSAGE.
    MOVE "textbelt" TO WS-APIKEY
    CALL "SYSTEM" USING WS-COMMAND.
    STOP RUN.
END PROGRAM SENDSMS.
