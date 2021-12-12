TITLE Odering Food

INCLUDE irvine32.inc
INCLUDE macros.inc

; |^^^^^^^^^^^^^^^^^^^^^ Chuan Yan ^^^^^^^^^^^^^^^^^^^^^|
; |^^^^^^^^^^^^^^^^^^^^^ Pin Chee ^^^^^^^^^^^^^^^^^^^^^|
; |^^^^^^^^^^^^^^^^^^^^^ Ler Shean ^^^^^^^^^^^^^^^^^^^^^|
; |^^^^^^^^^^^^^^^^^^^^^ Chun Shen ^^^^^^^^^^^^^^^^^^^^^|

; ================================================================ VARIABLES
.data
; |^^^^^^^^^^^^^^^^^^^^^ Chuan Yan ^^^^^^^^^^^^^^^^^^^^^|   | Data
    design          byte    "                   //////////////////////////////////////////" , 0
    design1         byte    "                   //                                      //" , 0
    design2         byte    "                   //      Signup / Login                  //" , 0
    design3         byte    "                   //      Sample User                     //" , 0
    design4         byte    "                   //      -----------                     //" , 0
    design5         byte    "                   //      Username: " , 0
    design6         byte    "                   //      Password: " , 0
    design7         byte    "       //" , 0
    design8         byte    "////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////" , 0
    design9         byte    "                   //      Sign Up Page                    //" , 0
    design10        byte    "                   //      Login Page                      //" , 0
    menu            byte    "                   //      1. Create User                  //" , 0
    menu1           byte    "                   //      2. Login                        //" , 0
    menu2           byte    "                   //  1. Move to New Username.            //" , 0
    menu3           byte    "                   //  2. Move to New Password.            //" , 0
    menu4           byte    "                   //  3. Move to Confirm Password.        //" , 0
    menu5           byte    "                   //  4. Move to Login.                   //" , 0
    menu6           byte    "                   //  1. Move to Create User.             //" , 0
    menu7           byte    "                   //  2. Move to Username.                //" , 0
    menu8           byte    "                   //  3. Move to Password.                //" , 0
    menu9           byte    "                   //  2. Move to Login.                   //" , 0
    menu10          byte    "                   //  3. Move to Login.                   //" , 0

    choose          byte    "Please enter 1 or 2: " , 0
    choose1         byte    "Please enter 1, 2, 3 or 4: " , 0
    choose2         byte    "Please enter 1, 2 or 3: " , 0
    new_user        byte    "New Username: " , 0
    new_pw          byte    "New Password: " , 0
    confirm_pw      byte    "Confirm Password: " , 0
    username        byte    "Username: " , 0
    password        byte    "Password: " , 0


    valid_ck        byte    "Invalid input. Please enter '1' or '2' only." , 0
    valid_ck1       byte    "Invalid input. Please enter '1', '2', '3' or '4' only." , 0
    valid_ck2       byte    "Invalid input. Please enter '1', '2' or '3' only." , 0
    invalid_length  byte    "Invalid length of username. Please create username with length of 5." , 0
    invalid_length1 byte    "Invalid length of password. Please create password with length of 8." , 0
    invalid_length2 byte    "Invalid length of username. Please enter username with length of 5." , 0
    invalid_length3 byte    "Invalid length of password. Please enter password with length of 8." , 0
    user_create     byte    "User successfully created. Please login now." , 0
    error_confirm   byte    "Wrong password. Please enter new password again." , 0
    invalid         byte    "Invalid Username." , 0
    invalid1        byte    "Invalid Password." , 0
    log_success     byte    "Iogin success." , 0

    decision        byte    ?
    test_user       byte    "test0" , 0
    test_pw         byte    "abc12345" , 0
    save_user       byte    6 DUP(?) , 0
    save_pw         byte    9 DUP(?) , 0
    temp0           byte    9 DUP(?) , 0
    user            byte    6 DUP(?) , 0
    temp1           byte    9 DUP(?) , 0
; |_____________________ Chuan Yan _____________________|   | Data

; |^^^^^^^^^^^^^^^^^^^^^ Pin Chee ^^^^^^^^^^^^^^^^^^^^^|    | Data
    MenuCounter         byte 0
    inputInvalid_Flag   byte 0
    lengthInvalid_Flag  byte 0
    orderList_Index     word -1
    ; Pointing array of order Detail by +2
    orderList_Counter   byte 0
    ; Count how many orders user input
    orderList           word 50 dup(0)
    ; Storing user choice in [NN XY]h
    ; n = item count, up to 255 decimal val
    ; X = menu, A = Value Meal ; B = Ala Carte ; C = Drinks
    ; Y = item, [1,2,3]
    userInput           byte 5 dup(0)
    dummy               byte 0
; |_____________________ Pin Chee _____________________|    | Data

; |^^^^^^^^^^^^^^^^^^^^^ Ler Shean ^^^^^^^^^^^^^^^^^^^^^|   | Data

; |_____________________ Ler Shean _____________________|   | Data

; |^^^^^^^^^^^^^^^^^^^^^ Chun Shen ^^^^^^^^^^^^^^^^^^^^^|   | Data
;   -----------Total---------

    totalPay        DWORD   50      ;------------------------------------------------------------ Ler Shean
    totalAmount     DWORD   ?
    balance         DWORD   ?

;   -----------Option--------

    optDlvr         BYTE    ?
    optMember       BYTE    ?
    optCont         BYTE    ?

;   -----------Cost----------

    discountCost    DWORD   ?
    deliveryCost    DWORD   ?

;   -----------Qty-----------

    qtyRM100        DWORD   ?
    qtyRM50         DWORD   ?
    qtyRM10         DWORD   ?
    qtyRM5          DWORD   ?
    qtyRM1          DWORD   ?

;   -----------Amount--------

    amountRM100     DWORD   ?
    amountRM50      DWORD   ?
    amountRM10      DWORD   ?
    amountRM5       DWORD   ?
    amountRM1       DWORD   ?

;   -----------Info----------

    Bank            BYTE    6 DUP (?)
    AccNum          BYTE    20 DUP (?)
    ExpireDate      BYTE    7 DUP (?)
    CVV             BYTE    5 DUP (?)
    RefNo           DWORD   ?

;   -----------Bank----------

    shortHLB        BYTE    "HLB" , 0
    shortPBB        BYTE    "PBB" , 0
    shortRHB        BYTE    "RHB" , 0
    shortCIMB       BYTE    "CIMB" , 0
    shortMAYB       BYTE    "MAYB" , 0
    shortAMB        BYTE    "AMB" , 0

    fullHLB         BYTE    "Hong Leong Bank" , 0
    fullPBB         BYTE    "Public Bank" , 0
    fullRHB         BYTE    "RHB Bank" , 0
    fullCIMB        BYTE    "CIMB Bank" , 0
    fullMAYB        BYTE    "MAY Bank" , 0
    fullAMB         BYTE    "AM Bank" , 0

;   -----------Repeat--------

    displayTitle    BYTE    0
    invalidData     BYTE    0
    request         BYTE    0

;   --------------------------------Title----------------------------------------

    titleSys        BYTE    "///                        Transaction of Food Ordering System                           ///" , 0
    titleBank       BYTE    "///                     Select Your Bank Name To Make The Payment                        ///" , 0
    titleCash       BYTE    "///                     Select Your Cash Digit To Do Your Payment                        ///" , 0
    titleRcpt       BYTE    "///                                 PAYMENT RECEIPT                                      ///" , 0

;   --------------------------------Output line----------------------------------

    line1           BYTE    "////////////////////////////////////////////////////////////////////////////////////////////" , 0
    line2           BYTE    "///                                                                                      ///" , 0
    line3           BYTE    "///--------------------------------------------------------------------------------------///" , 0
    line4           BYTE    "///                                          ----------------------------                ///" , 0
    line5           BYTE    "///                                          ============================                ///" , 0
    line6           BYTE    "///                                    ------------>> RM " , 0

;   --------------------------------Prompt---------------------------------------

    promptOpt       BYTE    "///                               Enter Your Option : " , 0
    promptBank      BYTE    "///                  Name of the Bank    (e.g. HLB) : " , 0
    promptAcc       BYTE    "///        1. Card Account Number (e.g. 1234 5678 9876 5432) : " , 0
    promptExpDate   BYTE    "///        2. Expiration Date     (e.g. 07/23)               : " , 0
    promptCVV       BYTE    "///        3. CV CODE             (e.g. 123)                 : " , 0
    promptMember    BYTE    "///         Member press (1) || Guest press (Any Key)  (Member discount RM 2.00)         ///" , 0
    promptDlvr      BYTE    "///         Delivery press (1) || Pick Up press (Any Key) (Delivery Fee RM 1.00)         ///" , 0
    promptCont      BYTE    "///           CONTINUE press any key || RESET press (R) || BACK press (B)                ///" , 0

;   --------------------------------Output---------------------------------------

    outputInvalid   BYTE    "///                          Invalid Data Please Try Again!!!                            ///" , 0
    outputHP        BYTE    "///             HONG LEONG BANK   -   HLB    ||   PUBLIC BANK   -   PBB" , 0
    outputRC        BYTE    "///             RHB BANK          -   RHB    ||   CIMB BANK     -   CIMB" , 0
    outputMA        BYTE    "///             MAY BANK          -   MAYB   ||   AM BANK       -   AMB" , 0
    outputDis       BYTE    "///            Discount Fee             (RM) :         RM " , 0
    outputDlvr      BYTE    "///            Delivery Fee             (RM) :         RM " , 0
    outputTotPay    BYTE    "///            Total Payment            (RM) :         RM " , 0
    outputRM100     BYTE    "///            RM 100.00    x      " , 0
    outputRM50      BYTE    "///            RM 50.00     x      " , 0
    outputRM10      BYTE    "///            RM 10.00     x      " , 0
    outputRM5       BYTE    "///            RM 5.00      x      " , 0
    outputRM1       BYTE    "///            RM 1.00      x      " , 0
    outputTotAmt    BYTE    "///            Total Amount             (RM) :         RM " , 0
    outputBalance   BYTE    "///            Balance Amount           (RM) :         RM " , 0
    outputUnsuccess BYTE    "///                      Transaction Unsuccessfull Please Try Again!!!                   ///" , 0
    outputSuccess   BYTE    "///                              Transaction Successfull !!!                             ///" , 0
    outputDateTime  BYTE    "///                   Transaction Date/Time     : 13 Dec 2021 11:59:59 PM" , 0
    outputName      BYTE    "///                   Recipient's Reference     : " , 0
    outputRefNo     BYTE    "///                   Reference Number          : " , 0
    outputBank      BYTE    "///                   Name of the Bank          : " , 0
    outputAcc       BYTE    "///                   Card Account Number       : " , 0
    outputStatus    BYTE    "///                   Satus                     : Successful" , 0
    outputAmt       BYTE    "///                   Amount (RM)               : RM " , 0
    outputRcpt      BYTE    "///                   Recipient Name            : Food Ordering System" , 0
    outputThank     BYTE    "///                              THANK YOU FOR YOUR ORDER!!!                             ///" , 0
; |_____________________ Chun Shen _____________________|   | Data


; ================================================================ MAIN
.code
; |^^^^^^^^^^^^^^^^^^^^^ Chuan Yan ^^^^^^^^^^^^^^^^^^^^^|   | UDF

; |_____________________ Chuan Yan _____________________|   | UDF

; |^^^^^^^^^^^^^^^^^^^^^ Pin Chee ^^^^^^^^^^^^^^^^^^^^^|    | UDF
updateMenuCounter proc
    push eax             ; Save al to stack
    mov al, userInput        ; Move source to al
    mov MenuCounter,al       ; Move al to destination
    pop eax              ; Restore al
    ret
updateMenuCounter endp
updateQty proc
    cmp dummy, 2        ; If it is Double Digit
    je  Digit_Double    ; Goto Digit_Double
Digit_Single:
    ; convert char to integer
    xor eax,eax
    sub userInput, 30h
    mov al, userInput
    ; Update Orderlist With Qty
    inc orderList_Index                     ; Increase Index Counter
    xor esi,esi                             ; Clear Index Counter
    mov si, orderList_Index                 ; Set Index Counter
    mov byte ptr [orderList + esi], al   ; Record the selected item
    jmp finish
Digit_Double:
    ; convert char 1 to integer
    mov eax, 10
    sub userInput[0], 30h
    mul userInput[0]
    ; convert char 2 to integer
    sub userInput[1], 30h
    add al, userInput[1]
    mov userInput, al
    ; Update Orderlist With Qty
    inc orderList_Index                     ; Increase Index Counter
    xor esi,esi                             ; Clear Index Counter
    mov si, orderList_Index                 ; Set Index Counter
    mov byte ptr [orderList + esi], al   ; Record the selected item
finish:
    ret
updateQty endp
copyByte proc, dVar:BYTE, sVar:BYTE
    push eax             ; Save al to stack
    mov al, sVar        ; Move source to al
    mov dVar,al       ; Move al to destination
    pop eax              ; Restore al
    ret
copyByte endp
chkQty proc USES EAX EBX ECX EDX
    lea edx, userInput          ; Load user input address
    mov ecx, 4                  ; Read up to 4 char
    call ReadString             ; Read User input as string
    cmp eax, 1                  ; If user input 1 char
    je validLength1             ; Goto 1 char
    cmp eax, 2                  ; If user input 2 char
    je validLength2             ; Goto 2 char
    jmp invalidLength           ; More than 2 char goto invalid
validLength1: ; ValindLength and 1 char to check
        mov al, userInput           ; Load user input for checking
        call IsDigit                ; If it is not digit
        jnz  invalidLength          ; Jump to invalid
        cmp al, 30h                 ; If input is '0'
        je  invalidLength           ; Goto Invalid
        mov lengthInvalid_Flag,0    ; Reset Error Flag
        mov dummy,1                 ; Indicates single digit value
        jmp finish                  ; Goto finish
validLength2: ; ValindLength and 2 char to check
        mov ecx, 2                  ; Set loop count
        mov esi, -1                 ; Set index
L1:
        inc esi                     ; Increase index
        mov al, userInput[esi]      ; Get value from userInput[index]
        call IsDigit                ; If it is not digit
        jnz  invalidLength          ; Goto invalid
        cmp al, 30h                 ; If input is '0'
        je  invalidLength           ; Goto Invalid
        loop L1                     ; Else check next digit
        mov lengthInvalid_Flag,0    ; Reset Error Flag
        mov dummy,2                 ; Indicates double digit value
        jmp finish                  ; Goto finish

invalidLength:
    mov lengthInvalid_Flag,1
    call crlf
    mWriteLn "! ERROR ! Invalid Input detected. Please enter quantity between 1-99. ! ERROR !"
    call crlf
    call crlf
    jmp finish

finish:
    ret
chkQty endp
chkLength proc USES EAX EDX ECX
    lea edx, userInput
    mov ecx, 3                  ; Read 2 Character Max + 1 ending null
    call ReadString             ; Read User input as string
    cmp eax, 1                  ; Check size of input
    je validLength              ; If size is 1 then jump to check value
invalidLength:
    call Crlf                   ; else show error message
    mWriteLn "! ERROR ! Please enter one value only ! ERROR !"
    call Crlf
    call Crlf
    mov  lengthInvalid_Flag, 1
    jmp finish
validLength:
    mov  lengthInvalid_Flag, 0
finish:
    ret
chkLength endp
chkInput proc, menuOption:BYTE, inputVal:BYTE
; Check Menu Option
    cmp         menuOption,'0'      ; If menuOption = A
    je          c_Menu0               ; Goto Menu 0

    cmp         menuOption,'1'      ; If menuOption = 1
    je          c_Menu1               ; Goto Menu 1

    cmp         menuOption,'2'      ; If menuOption = 2
    je          c_Menu2               ; Goto Menu 2

    cmp         menuOption,'3'      ; If menuOption = 3
    je          c_Menu3               ; Goto Menu 3

    jmp         invalidOption       ; Else goto invalid option
; Check Input Range for Different Menu Option
c_Menu0:
    cmp         inputVal,'1'        ; If inputVal = 1
    je          validOption         ; Goto finish

    cmp         inputVal,'2'        ; If inputVal = 2
    je          validOption         ; Goto finish

    cmp         inputVal,'3'        ; If inputVal = 3
    je          validOption         ; Goto finish

    cmp         inputVal,'A'        ; If inputVal = A
    je          validOption         ; Goto finish

    cmp         inputVal,'a'        ; If inputVal = a
    je          validOption         ; Goto finish

    cmp         inputVal,'B'        ; If inputVal = B
    je          validOption         ; Goto finish

    cmp         inputVal,'b'        ; If inputVal = b
    je          validOption         ; Goto finish

    cmp         inputVal,'C'        ; If inputVal = C
    je          validOption         ; Goto finish

    cmp         inputVal,'c'        ; If inputVal = c
    je          validOption         ; Goto finish

    jmp         invalidOption       ; Else goto invalid option
c_Menu1:
    cmp         inputVal,'1'        ; If inputVal = 1
    je          validOption         ; Goto finish

    cmp         inputVal,'2'        ; If inputVal = 2
    je          validOption         ; Goto finish

    cmp         inputVal,'3'        ; If inputVal = 3
    je          validOption         ; Goto finish

    cmp         inputVal,'A'        ; If inputVal = A
    je          validOption         ; Goto finish

    cmp         inputVal,'a'        ; If inputVal = a
    je          validOption         ; Goto finish

    cmp         inputVal,'B'        ; If inputVal = B
    je          validOption         ; Goto finish

    cmp         inputVal,'b'        ; If inputVal = b
    je          validOption         ; Goto finish

    jmp         invalidOption       ; Else goto invalid option
c_Menu2:
    cmp         inputVal,'1'        ; If inputVal = 1
    je          validOption         ; Goto finish

    cmp         inputVal,'2'        ; If inputVal = 2
    je          validOption         ; Goto finish

    cmp         inputVal,'3'        ; If inputVal = 3
    je          validOption         ; Goto finish

    cmp         inputVal,'A'        ; If inputVal = A
    je          validOption         ; Goto finish

    cmp         inputVal,'a'        ; If inputVal = a
    je          validOption         ; Goto finish

    cmp         inputVal,'B'        ; If inputVal = B
    je          validOption         ; Goto finish

    cmp         inputVal,'b'        ; If inputVal = b
    je          validOption         ; Goto finish

    jmp         invalidOption       ; Else goto invalid option
c_Menu3:
    cmp         inputVal,'1'        ; If inputVal = 1
    je          validOption         ; Goto finish

    cmp         inputVal,'2'        ; If inputVal = 2
    je          validOption         ; Goto finish

    cmp         inputVal,'3'        ; If inputVal = 3
    je          validOption         ; Goto finish

    cmp         inputVal,'A'        ; If inputVal = A
    je          validOption         ; Goto finish

    cmp         inputVal,'a'        ; If inputVal = a
    je          validOption         ; Goto finish

    cmp         inputVal,'B'        ; If inputVal = B
    je          validOption         ; Goto finish

    cmp         inputVal,'b'        ; If inputVal = b
    je          validOption         ; Goto finish

    jmp         invalidOption       ; Else goto invalid option

validOption:
    mov         inputInvalid_Flag,0
    jmp         finish
invalidOption:
    call Crlf
    mWriteLn    "! ERROR ! Option Not Available, the input is invalid. ! ERROR !"
    call Crlf
    call Crlf
    mov         inputInvalid_Flag,1
finish:
    ret
chkInput endp
printMenu proc, menuOption:BYTE
; Header
    Call        Clrscr
    mWriteLn    "////////////////////////////////////////////////////////////"
    mWriteLn    "////                                                    ////"
    mWriteLn    "////               FOOD ORDERING SYSTEM                 ////"
    mWriteLn    "////                                                    ////"
    mWriteLn    "////////////////////////////////////////////////////////////"
; Check Menu
    cmp         menuOption,'0'      ; If menuOption = 1
    je          c_Menu0               ; Goto Menu 1
    cmp         menuOption,'B'      ; If menuOption = 1
    je          c_Menu0               ; Goto Menu 1
    cmp         menuOption,'b'      ; If menuOption = 1
    je          c_Menu0               ; Goto Menu 1

    cmp         menuOption,'1'      ; If menuOption = 2
    je          c_Menu1               ; Goto Menu 2

    cmp         menuOption,'2'      ; If menuOption = 3
    je          c_Menu2               ; Goto Menu 3

    cmp         menuOption,'3'      ; If menuOption = 4
    je          c_Menu3               ; Goto Menu 4

    jmp         finish
; Menus
c_Menu0:
    mWriteLn    "                      MENU OPTIONS"
    mWriteLn    "------------------------------------------------------------"
    mWriteLn    ">>      1. Value Meal"
    mWriteLn    ">>      2. Ala Carte"
    mWriteLn    ">>      3. Drinks"
    mWriteLn    ">>"
    mWriteLn    ">>      A. Reset All"
    mWriteLn    ">>      B. Checkout"
    mWriteLn    ">>      C. Exit"
    mWriteLn    "============================================================"
    jmp         finish
c_Menu1:
    mWriteLn    "                       Value Meal"
    mWriteLn    "------------------------------------------------------------"
    mWriteLn    ">>      1. Soloman                                 RM  14.50"
    mWriteLn    ">>         - Drum Delux                x1"
    mWriteLn    ">>         - Fries (Large)             x1"
    mWriteLn    ">>         - Soda (400ml)              x1"
    mWriteLn    ">>"
    mWriteLn    ">>      2. Dual Fun                                RM  18.90"
    mWriteLn    ">>         - Fish n Chips              x2"
    mWriteLn    ">>         - Salted Fish Skin 3oz      x2"
    mWriteLn    ">>         - Tafan (800ml)             x2"
    mWriteLn    ">>"
    mWriteLn    ">>      3. Family Bis!                             RM  32.70"
    mWriteLn    ">>         - Roti Kamung               x4"
    mWriteLn    ">>         - HamShroom                 x2"
    mWriteLn    ">>         - Sprute (800ml)            x2"
    mWriteLn    ">>"
    mWriteLn    ">>      A. Back"
    mWriteLn    ">>      B. Next Page (*Under Maintenance)"
    mWriteLn    "============================================================"
    jmp         finish
c_Menu2:
    mWriteLn    "                       Ala Carte"
    mWriteLn    "------------------------------------------------------------"
    mWriteLn    ">>      1. Drum Delux                              RM   9.50"
    mWriteLn    ">>"
    mWriteLn    ">>      2. Fish n Chips                            RM   6.80"
    mWriteLn    ">>"
    mWriteLn    ">>      3. Roti Kamung                             RM   5.30"
    mWriteLn    ">>"
    mWriteLn    ">>      A. Back"
    mWriteLn    ">>      B. Next Page (*Under Maintenance)"
    mWriteLn    "============================================================"
    jmp         finish
c_Menu3:
    mWriteLn    "                         Drink"
    mWriteLn    "------------------------------------------------------------"
    mWriteLn    ">>      1. Soda                                    RM   3.50"
    mWriteLn    ">>"
    mWriteLn    ">>      2. Tafan                                   RM   4.80"
    mWriteLn    ">>"
    mWriteLn    ">>      3. Sprute                                  RM   3.80"
    mWriteLn    ">>"
    mWriteLn    ">>      A. Back"
    mWriteLn    ">>      B. Next Page (*Under Maintenance)"
    mWriteLn    "============================================================"
    jmp         finish
finish:
    ret
printMenu endp
; |_____________________ Pin Chee _____________________|    | UDF
main proc

; |^^^^^^^^^^^^^^^^^^^^^ Chuan Yan ^^^^^^^^^^^^^^^^^^^^^|   | Proc
;---------------Display Title-----------------------
title:
    ; mWriteString design
    lea     edx , design
    call    WriteString
    call    Crlf
    lea     edx , design1
    call    WriteString
    call    Crlf
    lea     edx , design2
    call    WriteString
    call    Crlf
    lea     edx , design1
    call    WriteString
    call    Crlf
    lea     edx , design
    call    WriteString
    call    Crlf

;---------------Display Menu----------------------
menu_0:
    call    crlf                ; new line
    lea     edx , design        ; the offset adress of design is loaded to edx register
    call    WriteString         ; perform the write string function
    call    Crlf
    lea     edx , menu
    call    WriteString
    call    Crlf
    lea     edx , menu1
    call    WriteString
    call    Crlf
    lea     edx , design
    call    WriteString
    call    Crlf

;---------------Make Decision-------------------------
decide:
    call    Crlf
    lea     edx , design8
    call    WriteString
    call    Crlf
    call    Crlf
    mov     edx , OFFSET choose
    call    WriteString
    call    ReadChar                ; Read user input
    call    WriteChar               ; Display user input
    mov     decision , al
    call    Crlf
    jmp     check                   ; Force jump to check

;------------------Validate Check User Decision-----------------------------
check:
    cmp     decision , '1'               ; Compare user input decision = '1'
    je      clear_scr                    ; Jump to clear_scr if equal to '1'

    cmp     decision , '2'               ; Compare user input decision = '2'
    je      clear_scr1                   ; Jump to clear_scr if equal to '2'

    lea     edx , valid_ck
    call    WriteString                  ; Display Invalid if not '1' or '2'

    call    Crlf                         ; New line
    jmp     decide                       ; Force jump to decide if not '1' or '2'

;------------------To Clear Screen Before Force Jump-----------------------------
clear_scr:
    call    Clrscr          ; Clear screen
    jmp     create      ; Force jump to create

clear_scr1:
    call    Clrscr      ; Clear screen
    jmp     login       ; Force jump to login

;--------------------Create New User-----------------------------
create:
    ;----------------For Design----------------------
    lea     edx , design
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design9
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design
    call    WriteString
    call    crlf
    call    crlf
    lea     edx , design8
    call    WriteString
    call    crlf
    call    crlf

    ;---------------Display to Ask User Input Username-----------------
    lea     edx , new_user
    call    WriteString

    ;---------------Read User Input Username--------------------
    lea     edx , save_user
    mov     ecx , LENGTHOF save_user
    call    ReadString
    jmp     valid_length

;----------------Create new password--------------------
create1:
    lea     edx , new_pw
    call    WriteString

    lea     edx , save_pw
    mov     ecx , LENGTHOF save_pw
    call    ReadString
    jmp     valid_length1

;-----------------Confirm Password---------------------
create2:
    lea     edx , confirm_pw
    call    WriteString

    lea     edx , temp0
    mov     ecx , LENGTHOF temp0
    call    ReadString
    jmp     valid_length2

;----------------Validation Check Length of Username------------------
valid_length:
    cmp     EAX , 5
    je      create1

    lea     edx , invalid_length
    call    WriteString
    call    crlf
    call    crlf
    jmp     menu_1

;---------------Display Menu-----------------------------
menu_1:
    lea     edx , design
    call    WriteString
    call    Crlf
    lea     edx , menu2
    call    WriteString
    call    Crlf
    lea     edx , menu9
    call    WriteString
    call    Crlf
    lea     edx , design
    call    WriteString
    call    Crlf

;-----------------------Read User Desision--------------------
decide1:
    call    Crlf
    mov     edx , OFFSET choose
    call    WriteString
    mov     al , 0
    call    ReadChar
    call    WriteChar
    mov     decision , al
    call    Crlf
    jmp     check1

;-----------------------Validation Check User Desision--------------------
check1:
    cmp     decision , '1'
    je      clear_scr

    cmp     decision , '2'
    je      clear_scr1

    lea     edx , valid_ck
    call    WriteString
    call    Crlf
    jmp     decide1

;----------------Validation Check Length of Password------------------
valid_length1:
    cmp     EAX , 8
    je      create2

    lea     edx , invalid_length1
    call    WriteString
    call    crlf
    call    crlf
    jmp     menu_2

;---------------Display Menu-----------------------------
menu_2:
    lea     edx , design
    call    WriteString
    call    Crlf
    lea     edx , menu2
    call    WriteString
    call    Crlf
    lea     edx , menu3
    call    WriteString
    call    Crlf
    lea     edx , menu10
    call    WriteString
    call    Crlf
    lea     edx , design
    call    WriteString
    call    Crlf

;-----------------------Read User Desision--------------------
decide2:
    call    Crlf
    mov     edx , OFFSET choose2
    call    WriteString
    mov     al , 0
    call    ReadChar
    call    WriteChar
    mov     decision , al
    call    Crlf
    jmp     check2

;-----------------------Validation Check User Desision--------------------
check2:
    cmp     decision , '1'
    je      clear_scr

    cmp     decision , '2'
    je      clear_scr2

    cmp     decision , '3'
    je      clear_scr1

    lea     edx , valid_ck2
    call    WriteString
    call    Crlf
    jmp     decide2

;------------------To Clear Screen Before Force Jump-----------------------------
clear_scr2:
    call    Clrscr

    ;-----------------Design-----------------
    lea     edx , design
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design9
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design
    call    WriteString
    call    crlf
    call    crlf
    lea     edx , design8
    call    WriteString
    call    crlf
    call    crlf
    lea     edx , new_user
    call    WriteString
    lea     edx , save_user
    call    WriteString
    call    crlf

    jmp     create1

;----------------Validation Check Length of Password------------------
valid_length2:
    cmp     EAX , 8
    je      valid_confirm2

    lea     edx , invalid_length3
    call    WriteString
    call    crlf
    call    crlf
    jmp     menu_3

;--------------------Validation Check--------------------
valid_confirm2:
    mov     ESI , 0
    mov     AL , 0
    mov     ecx , 8

here:
    mov     AL , save_pw[ESI]
    cmp     AL , temp0[ESI]
    jne     error
    inc     ESI
    loop    here
    jmp     success_create

error:
    lea     edx , error_confirm
    call    WriteString
    call    Crlf
    call    Crlf
    jmp     menu_3

;---------------Display Menu-----------------------------
menu_3:
    lea     edx , design
    call    WriteString
    call    Crlf
    lea     edx , menu2
    call    WriteString
    call    Crlf
    lea     edx , menu3
    call    WriteString
    call    Crlf
    lea     edx , menu4
    call    WriteString
    call    Crlf
    lea     edx , menu5
    call    WriteString
    call    Crlf
    lea     edx , design
    call    WriteString
    call    Crlf

;-----------------------Read User Desision--------------------
decide3:
    call    Crlf
    mov     edx , OFFSET choose1
    call    WriteString
    mov     al , 0
    call    ReadChar
    call    WriteChar
    mov     decision , al
    call    Crlf
    jmp     check3

;-----------------------Validation Check User Desision--------------------
check3:
    cmp     decision , '1'
    je      clear_scr

    cmp     decision , '2'
    je      clear_scr2

    cmp     decision , '3'
    je      clear_scr3

    cmp     decision , '4'
    je      clear_scr1

    lea     edx , valid_ck1
    call    WriteString
    call    Crlf
    jmp     decide3

;------------------To Clear Screen Before Force Jump-----------------------------
clear_scr3:
    call Clrscr

    ;------------------Design----------------------
    lea     edx , design
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design9
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design
    call    WriteString
    call    crlf
    call    crlf
    lea     edx , design8
    call    WriteString
    call    crlf
    call    crlf
    lea     edx , new_user
    call    WriteString
    lea     edx , save_user
    call    WriteString
    call    crlf
    lea     edx , new_pw
    call    WriteString
    lea     edx , save_pw
    call    WriteString
    call    crlf

    jmp     create2

;-----------------Display if User Create Success-----------------
success_create:
    call    Clrscr
    mov     dl,39                   ;column
    mov     dh,2                    ;row
    call    Gotoxy
    lea     edx , user_create
    call    WriteString
    call    Crlf
    call    crlf
    jmp     login

;---------------Input User Username-------------
login:

    ;-----login page design--------
    lea     edx , design
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design10
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design
    call    WriteString
    call    crlf
    call    crlf
    lea     edx , design
    call    WriteString
    call    Crlf
    lea     edx , design3
    call    WriteString
    call    crlf
    lea     edx , design4
    call    WriteString
    call    crlf
    lea     edx , design5
    call    WriteString
    mov     dl,-1               ;column
    mov     dh,3                ;row
    call    Gotoxy
    lea     edx , test_user
    call    WriteString
    lea     edx , design7
    call    WriteString
    call    crlf
    lea     edx , design6
    call    WriteString
    mov     dl,-1               ;column
    mov     dh,4                ;row
    call    Gotoxy
    lea     edx , test_pw
    call    WriteString
    lea     edx , design7
    call    WriteString
    call    crlf
    lea     edx , design
    call    WriteString
    call    Crlf
    call    crlf
    lea     edx , design8
    call    WriteString
    call    Crlf
    call    crlf

    ;-----read user input username-------
    lea     edx , username
    call    WriteString
    lea     edx , user
    mov     ecx , LENGTHOF user
    call    ReadString

    jmp     valid_length3

;----------------Validation Check Length of Password------------------
valid_length3:
    cmp     EAX , 5
    je      valid_user

    lea     edx , invalid_length2
    call    WriteString
    call    crlf
    call    crlf
    jmp     menu_4

;----------------------User Input Username Validation Check---------------------
valid_user:
    mov     ESI , 0
    mov     AL , 0
    mov     ecx , 5
    jmp     here2

here2:
    mov     AL , save_user[ESI]
    cmp     AL , user[ESI]
    jne     valid_confirm3
    inc     ESI
    loop    here2
    jmp     login2

valid_confirm3:
    mov     ESI , 0
    mov     AL , 0
    mov     ecx , 5
    jmp     here3

here3:
    mov     AL , test_user[ESI]
    cmp     AL , user[ESI]
    jne     error1
    inc     ESI
    loop    here3
    jmp     login2

;----------------Display if Error Occur------------------
error1:
    lea     edx , invalid
    call    WriteString
    call    Crlf
    jmp     menu_4

;---------------Display Menu-----------------------------
menu_4:
    lea     edx , design
    call    WriteString
    call    Crlf
    lea     edx , menu6
    call    WriteString
    call    Crlf
    lea     edx , menu7
    call    WriteString
    call    Crlf
    lea     edx , design
    call    WriteString
    call    Crlf

;-----------------------Read User Desision--------------------
decide4:
    call    Crlf
    mov     edx , OFFSET choose
    call    WriteString
    mov     al , 0
    call    ReadChar
    call    WriteChar
    mov     decision , al
    call    Crlf
    jmp     check4

;-----------------------Validation Check User Desision--------------------
check4:
    cmp     decision , '1'
    je      clear_scr

    cmp     decision , '2'
    je      clear_scr1

    lea     edx , valid_ck
    call    WriteString
    call    Crlf
    jmp     decide4

;------------Input Password-----------------
login2:
    lea     edx , password
    call    WriteString

    mov     temp1 , 0
    lea     edx , temp1
    mov     ecx , LENGTHOF temp1
    call    ReadString
    jmp     valid_length4

;----------------Validation Check Length of Password------------------
valid_length4:
    cmp     EAX , 8
    je      valid_pw

    lea     edx , invalid_length3
    call    WriteString
    call    crlf
    call    crlf
    jmp     menu_5

;-----------------Password Validation Check----------------
valid_pw:
    mov     ESI , 0
    mov     AL , 0
    mov     ecx , 8
    jmp     here4

here4:
    mov     AL , save_pw[ESI]
    cmp     AL , temp1[ESI]
    jne     valid_confirm4
    inc     ESI
    loop    here4
    jmp     success_log

valid_confirm4:
    mov     ESI , 0
    mov     AL , 0
    mov     ecx , 8
    jmp     here5

here5:
    mov     AL , test_pw[ESI]
    cmp     AL , temp1[ESI]
    jne     error2
    inc     ESI
    loop    here5
    jmp     success_log

;----------------Display if Error Occur------------------
error2:
    lea     edx , invalid1
    call    WriteString
    call    Crlf
    jmp     menu_5

;---------------Display Menu-----------------------------
menu_5:
    lea     edx , design
    call    WriteString
    call    Crlf
    lea     edx , menu6
    call    WriteString
    call     Crlf
    lea     edx , menu7
    call    WriteString
    call    Crlf
    lea     edx , menu8
    call    WriteString
    call    Crlf
    lea     edx , design
    call    WriteString
    call     Crlf

;-----------------------Read User Desision--------------------
decide5:
    call Crlf
    mov     edx , OFFSET choose2
    call    WriteString
    mov     al , 0
    call    ReadChar
    call    WriteChar
    mov     decision , al
    call    Crlf
    jmp     check5

;-----------------------Validation Check User Desision--------------------
check5:
    cmp     decision , '1'
    je      clear_scr

    cmp     decision , '2'
    je      clear_scr1

    cmp     decision , '3'
    je      clear_scr4

    lea     edx , valid_ck2
    call    WriteString
    call    Crlf
    jmp     decide5

;------------------To Clear Screen Before Force Jump-----------------------------
clear_scr4:
    call    Clrscr

    ;-----login page design--------
    lea     edx , design
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design10
    call    WriteString
    call    crlf
    lea     edx , design1
    call    WriteString
    call    crlf
    lea     edx , design
    call    WriteString
    call    crlf
    call    crlf
    lea     edx , design
    call    WriteString
    call    Crlf
    lea     edx , design3
    call    WriteString
    call    crlf
    lea     edx , design4
    call    WriteString
    call    crlf
    lea     edx , design5
    call    WriteString
    mov     dl,-1               ;column
    mov     dh,3                ;row
    call    Gotoxy
    lea     edx , test_user
    call    WriteString
    lea     edx , design7
    call    WriteString
    call    crlf
    lea     edx , design6
    call    WriteString
    mov     dl,-1               ;column
    mov     dh,4                ;row
    call    Gotoxy
    lea     edx , test_pw
    call    WriteString
    lea     edx , design7
    call    WriteString
    call    crlf
    lea     edx , design
    call    WriteString
    call    Crlf
    call    crlf
    lea     edx , design8
    call    WriteString
    call    Crlf
    call    crlf
    lea     edx , username
    call    WriteString
    lea     edx , user
    call    WriteString
    call    crlf

    jmp     login2

;------------------Display if Login Success----------------
success_log:
    call    Clrscr

    call    crlf
    lea     edx , design8
    call    WriteString
    call    Crlf
    call    crlf
    mov     dl,52                   ;column
    mov     dh,4                    ;row
    call    Gotoxy
    lea     edx , log_success
    call    WriteString
    call    Crlf
    call    crlf
    call    crlf
    lea     edx , design8
    call    WriteString
    call    crlf

; |_____________________ Chuan Yan _____________________|   | Proc

; |^^^^^^^^^^^^^^^^^^^^^ Pin Chee ^^^^^^^^^^^^^^^^^^^^^|    | Proc
resetVar:
    mov MenuCounter, 0
    mov inputInvalid_Flag, 0
    mov lengthInvalid_Flag, 0
    mov userInput, 0
    mov orderList_Index, -1
    mov orderList_Counter, 0
    mov orderList, 0
    mov dummy, 0
LM:
    mov MenuCounter, '0'
    INVOKE printMenu, MenuCounter                             ; Print Initial Menu
; L stage check input Length, if length is 1 then proceed to check value range, the check value
L0: ; Main Menu | Food Ordering Systeem
    mWrite "Enter a value: "                                  ; Ask for menu number

    INVOKE chkLength                                ; Check for User Input Length
    cmp lengthInvalid_Flag, 1                       ; If Length is valid
    jne checkValue                                  ; Goto checkValue
    jmp L0                                          ; Else Loop back to L1

L1: ; Menu 1 | Value Meal
    mWrite "Enter a value: "                      ; Ask for menu number

    ; INVOKE chkLength, userInput                     ; Check for User Input Length
    INVOKE chkLength                                ; Check for User Input Length
    cmp lengthInvalid_Flag, 1                       ; If Length is valid
    jne checkValue                                  ; Goto checkValue
    jmp L1                                          ; Else Loop back to

L2: ; Menu 2 | Ala Carte
    mWrite "Enter a value: "                      ; Ask for menu number

    ; INVOKE chkLength, userInput                     ; Check for User Input Length
    INVOKE chkLength                                ; Check for User Input Length
    cmp lengthInvalid_Flag, 1                       ; If Length is valid
    jne checkValue                                  ; Goto checkValue
    jmp L2                                          ; Else Loop back to

L3: ; Menu 3 | Drinks
    mWrite "Enter a value: "                      ; Ask for menu number

    ; INVOKE chkLength, userInput                     ; Check for User Input Length
    INVOKE chkLength                                ; Check for User Input Length
    cmp lengthInvalid_Flag, 1                       ; If Length is valid
    jne checkValue                                  ; Goto checkValue
    jmp L3                                          ; Else Loop back to

; Check the Range of input
checkValue:

    INVOKE chkInput, MenuCounter, userInput     ; Check if user input is in range
    cmp inputInvalid_Flag, 1                    ; If user input is in range
    je invalidInput                             ; If input is invalid goto ivalidInput

validInput:
    ; Check Menu
M0:
    cmp MenuCounter, '0'                            ; If it is main menu
    jne M1                                          ; If it is not equal then goto M1
        INVOKE updateMenuCounter                    ; Update user input to MenuCounter

        INVOKE printMenu, MenuCounter               ; Print the menu first
        cmp MenuCounter, '1'                        ; User choose to go Value Meal
        je  L1                                      ; Goto L1
        cmp MenuCounter, '2'                        ; User choose to go Ala Carte Menu
        je  L2                                      ; Goto L2
        cmp MenuCounter, '3'                        ; User choose to go Drinks Menu
        je  L3                                      ; Goto L2

        cmp MenuCounter, 'A'                        ; User choose reset
        je  resetVar
        cmp MenuCounter, 'a'                        ; User choose reset
        je  resetVar
        cmp MenuCounter, 'B'                        ; User choose to go check out
        je  checkOut
        cmp MenuCounter, 'b'                        ; User choose to go check out
        je  checkOut
        cmp MenuCounter, 'C'                        ; User choose to go quit
        je  quit
        cmp MenuCounter, 'c'                        ; User choose to go quit
        je  quit
M1:     ; Menu | Value Meal
    cmp MenuCounter, '1'                            ; If it is Value Meal
    jne M2                                          ; If it is not equal then goto M2
M1_1:   ; Menu | Value Meal | Option 1
        cmp userInput,'1'                           ; Check if it is option 1
        jne M1_2
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0A1h   ; Record the selected item

            call crlf
M1_1_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M1_1_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L1

M1_2:   ; Menu | Value Meal | Option 2
        cmp userInput,'2'                           ; Check if it is option 2
        jne M1_3
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0A2h   ; Record the selected item

            call crlf
M1_2_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M1_1_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L1

M1_3:   ; Menu | Value Meal | Option 3
        cmp userInput,'3'                           ; Check if it is option 3
        jne M1_A1
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0A3h   ; Record the selected item

            call crlf
M1_3_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M1_1_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L1
M1_A1:  cmp userInput,'A'
        jne M1_A2
            jmp LM
M1_A2:  cmp userInput,'a'
        jne M1_B1
            jmp LM
M1_B1:  cmp userInput,'B'
        jne M1_B2
            call crlf
            mWriteLn "# NOTICE # Sorry, It is under maintenance # NOTICE #"
            call crlf
            call crlf

            jmp L1
M1_B2:  cmp userInput,'b'
        jne quit
            call crlf
            mWriteLn "# NOTICE # Sorry, It is under maintenance # NOTICE #"
            call crlf
            call crlf
            jmp L1

M2: ; Menu 2 | Ala Carte
    cmp MenuCounter, '2'                       ; If it is Ala Carte Menu
    jne M3                                          ; If it is not equal then goto M3
M2_1:   ; Menu | Ala Carte | Option 1
        cmp userInput,'1'                           ; Check if it is option 1
        jne M2_2
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0B1h   ; Record the selected item

            call crlf
M2_1_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M2_1_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L2

M2_2:   ; Menu | Ala Carte | Option 1
        cmp userInput,'2'                           ; Check if it is option 1
        jne M2_3
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0B2h   ; Record the selected item

            call crlf
M2_2_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M2_2_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L2
M2_3:   ; Menu | Ala Carte | Option 3
        cmp userInput,'3'                           ; Check if it is option 1
        jne M2_A1
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0B3h   ; Record the selected item

            call crlf
M2_3_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M2_2_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L2
M2_A1:  cmp userInput,'A'
        jne M2_A2
            jmp LM
M2_A2:  cmp userInput,'a'
        jne M2_B1
            jmp LM
M2_B1:  cmp userInput,'B'
        jne M2_B2
            call crlf
            mWriteLn "# NOTICE # Sorry, It is under maintenance # NOTICE #"
            call crlf
            call crlf
            jmp L2
M2_B2:  cmp userInput,'b'
        jne quit
            call crlf
            mWriteLn "# NOTICE # Sorry, It is under maintenance # NOTICE #"
            call crlf
            call crlf
            jmp L2
M3: ; Menu 2 | Drinks
    ; cmp MenuCounter, '3'                       ; If it is Drinks Menu
    ; jne M4
M3_1:   ; Menu | Drinks | Option 1
        cmp userInput,'1'                           ; Check if it is option 1
        jne M3_2
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0C1h   ; Record the selected item

            call crlf
M3_1_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M3_1_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L3

M3_2:   ; Menu | Drinks | Option 1
        cmp userInput,'2'                           ; Check if it is option 1
        jne M3_3
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0C2h   ; Record the selected item

            call crlf
M3_2_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M3_2_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L3

M3_3:   ; Menu | Drinks | Option 1
        cmp userInput,'3'                           ; Check if it is option 1
        jne M3_A1
            inc orderList_Counter                   ; Increase Order Counter
            inc orderList_Index                     ; Increase Index Counter
            xor esi,esi                             ; Clear Index Counter
            mov si, orderList_Index                 ; Set Index Counter
            mov byte ptr [orderList + esi], 0C3h   ; Record the selected item

            call crlf
M3_3_Loop:
            mWriteLn "How many set would you like?"            ; Ask for quantity
            mWrite "Enter a value: "

            INVOKE chkQty                       ; Check input quantity
            cmp lengthInvalid_Flag,1            ; If quantity input invalid
            je M3_3_Loop                        ; Goto M1_1_Loop
            INVOKE updateQty                    ; Else Store Quantity
            INVOKE printMenu, MenuCounter       ; Refresh menu screen
            jmp L3

M3_A1:  cmp userInput,'A'
        jne M3_A2
            jmp LM
M3_A2:  cmp userInput,'a'
        jne M3_B1
            jmp LM
M3_B1:  cmp userInput,'B'
        jne M3_B2
            call crlf
            mWriteLn "# NOTICE # Sorry, It is under maintenance # NOTICE #"
            call crlf
            call crlf
            jmp L3
M3_B2:  cmp userInput,'b'
        jne quit
            call crlf
            mWriteLn "# NOTICE # Sorry, It is under maintenance # NOTICE #"
            call crlf
            call crlf
            jmp L3

invalidInput:
    cmp MenuCounter, '0'                       ; If it is main menu
        jmp L0
    cmp MenuCounter, '1'                       ; If it is Value Meal
        jmp L1
    cmp MenuCounter, '2'                       ; If it is Ala Carte Menu
        jmp L2
    cmp MenuCounter, '3'                       ; If it is Drinks Menu
        jmp L3

checkOut:
    cmp orderlist_counter, 0    ; If Cart is not empty
    jne proceed_CheckOut        ; Goto proceed_CheckOut
    mov MenuCounter, '0'
    call crlf
    mWriteLn "! ERROR ! Your cart is empty. Checkout Not Available. ! ERROR !"
    call crlf
    call crlf
    jmp L0
; |_____________________ Pin Chee _____________________|    | Proc


proceed_CheckOut:

; |^^^^^^^^^^^^^^^^^^^^^ Ler Shean ^^^^^^^^^^^^^^^^^^^^^|   | Data
    lea edx,orderList
    mov eax,0;

; |_____________________ Ler Shean _____________________|   | Data

; |^^^^^^^^^^^^^^^^^^^^^ Chun Shen ^^^^^^^^^^^^^^^^^^^^^|   | Data
;---------------------------------------------TITLE----------------------------------------------

sysMenu:

    CALL    Clrscr                          ; clear screen
    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET titleSys           ; LEA EDX , titleSys
    CALL    WriteString                     ; display titleSys
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 /////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    ;----------------Use to Display the SysMenu Repeated------------------------

    MOV     AL , 1                          ; move 1 into AL
    CMP     AL , displayTitle               ; compare  displayTitle to AL
    JE      backInputAcc                    ; jump to backInputAcc if displayTitle equal to AL

    MOV     AL , 2                          ; else move 1 into AL
    CMP     AL , displayTitle               ; compare  displayTitle to AL
    JE      cash                            ; jump to cash if displayTitle equal to AL
    JMP     inputBank                       ; else jump to inputBank

backInputAcc:

    CMP     optCont , 'B'                   ; compare optCont to 'B'
    JE      inputBank                       ; jump to bank if optCont equal 'B' as back
    JMP     inputAcc                        ; else jump to inputAcc as reset

;--------------------------------PROMPT THE USER ENTER NAME OF BANK------------------------------

inputBank:

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET titleBank          ; LEA EDX , titleBank
    CALL    WriteString                     ; display prompt the user select name of bank
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line3              ; LEA EDX , line3
    CALL    WriteString                     ; display line3 ///--------///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputHP           ; LEA EDX , outputHP
    CALL    WriteString                     ; display Hong Leong Bank and Public Bank
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputRC           ; LEA EDX , outputRC
    CALL    WriteString                     ; display RHB bank and CIMB bank
    CALL    Crlf

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputMA           ; LEA EDX , outputMA
    CALL    WriteString                     ; display May Bank and AM bank
    CALL    Crlf

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET promptBank         ; LEA EDX , promptBank
    CALL    WriteString                     ; prompt the user enter name of the bank

    MOV     ECX , LENGTHOF bank             ; set counter for read string purpose
    LEA     EDX ,  bank                     ; store the bank value into EDX as buffer
    CALL    ReadString                      ; read the user input name of the bank

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    MOV     request , 0                     ; move 1 value into request variable to display continue or reset or  back

;---------------------------------CHECK VALIDATION UPPERCASE-------------------------------------

    CMP     bank , 65                       ; compare EAX to 65
    JB      invalidCmnt                     ; jump to invalidCmnt if the EAX is below 65
    JMP     uppercase                       ; else force jump tp uppercase

uppercase:

    CMP     bank , 90                       ; compare EAX to 90
    JA      invalidCmnt                     ; jump to invalidCmnt if the EAX is above 90
    JMP     inputCont                       ; else force jump tp inputCont

;-----------------------------------------------INVALID COMMENT----------------------------------

invalidCmnt:

    CALL    Crlf                            ; go new line
    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputInvalid      ; LEA EDX , outputInvalid
    CALL    WriteString                     ; display invalid comment to let the user re-enter again
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    CALL    WaitMsg                         ; display waits for the user to press the Enter key

    CALL    Clrscr                          ; clear screen

    MOV     AL , 1                          ; move value 1 into AL
    CMP     invalidData , AL                ; compare invalidData to AL
    JE      inputMenu                       ; jump to inputMenu if invalidData equal to 1

    MOV     AL , 2                          ; move value 2 into AL
    CMP     invalidData , AL                ; compare invalidData to AL
    JE      inputMenu                       ; jump to inputMenu if invalidData equal to 2

    MOV     AL , 3                          ; move value 3 into AL
    CMP     invalidData , AL                ; compare invalidData to AL
    JE      inputMenu                       ; jump to inputMenu if invalidData equal to 3
    JMP     sysMenu                         ; else jump to sysMenu

;-----------------------------------------------CONTINUE OR RESET--------------------------------

inputCont:

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET promptCont         ; LEA EDX , promptCont
    CALL    WriteString                     ; display prompt the user enter the option continue or reset or back
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line


    CALL    ReadChar                        ; read the user input the option continue or reset or back
    MOV     optCont , AL

    CALL    Clrscr                          ; clear screen

    CMP     AL , 'R'                        ; compare reset value 'R' to AL
    JE      reset                           ; jump to reset if 'R' is equal to AL
    JMP     back                            ; else jump to the back

reset:

    MOV     AL , 1                          ; move 1 value to AL to reset the value for the input credit card info
    CMP     request , AL                    ; compare request to AL
    JE      inputMenu                       ; jump to inputMenu if request is equal to AL

    MOV     AL , 2                          ; else move 2 value to AL to reset the value for select cash digit
    CMP     request , AL                    ; compare request to AL
    JE      selectCash                      ; jump to selectCash if request is equal to AL
    JMP     inputBank                       ; else jump to the inputBank

back:

    CMP     AL , 'B'                        ; compare back value 'B' to AL
    JE      back1                           ; jump to back1 if 'B'' is equal to AL

    MOV     AL , 1                          ; else move 1 value to AL to determine which menu
    CMP     request , AL                    ; compare request to AL
    JE      selectCash                      ; jump to selectCash force if request equal to AL

back1:

    MOV     AL , 1                          ; move 1 value to AL to go back to input bank
    CMP     request , AL                    ; compare request to AL
    JE      sysMenu                         ; jump to inputBank if request is equal to AL

    MOV     AL , 2                          ; else move 2 value to AL to reset the value for select cash digit
    CMP     request , AL                    ; compare request to AL
    JE      inputMenu                       ; jump to inputMenu if request is equal to AL
    JMP     inputMenu                       ; else jump to the sysMenu -------------------------------------------------(LerShean)

;------------------------------PROMPT THE USER ENTER CARD ACCOUNT NUMBER-------------------------

inputMenu:

    MOV     displayTitle , 1                ; to display the title
    JMP     sysMenu                         ; force jump to sysMenu

inputAcc:

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET promptAcc          ; LEA EDX , promptAcc
    CALL    WriteString                     ; prompt the user enter card account number

    MOV     ECX , LENGTHOF AccNum           ; set counter for read string purpose
    LEA     EDX ,  AccNum                   ; store the AccNum value into EDX as buffer
    CALL    ReadString                      ; read the user input card account number

;---------------------------------CHECK VALIDATION SPACE AND DIGIT-------------------------------

    MOV     invalidData , 1                 ; move value 1 into invalidData variable to display invalid comment

    CMP     AccNum[4] , " "                 ; check validation user input account number space
    JNE     invalidCmnt                     ; jump to invalidCmnt if not equal to AccNum

    CMP     AccNum[9] , " "                 ; check validation user input account number space
    JNE     invalidCmnt                     ; jump to invalidCmnt if not equal to AccNum

    CMP     AccNum[14] , " "                ; check validation user input account number space
    JNE     invalidCmnt                     ; jump to invalidCmnt if not equal to AccNum

    CMP     EAX , 19                        ; check validation user input account number digit
    JNE     invalidCmnt                     ; jump to invalidCmnt if not equal to AccNum
    JMP     inputDate                       ; else jump to inputDate

;------------------------------PROMPT THE USER ENTER EXPIRATION DATE-----------------------------

inputDate:

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET promptExpDate      ; LEA EDX , promptExpDate
    CALL    WriteString                     ; display prompt the user enter expiration date

    MOV     ECX , LENGTHOF ExpireDate       ; set counter for read string purpose
    LEA     EDX ,  ExpireDate               ; store the ExpireDate value into EDX as buffer
    CALL    ReadString                      ; read the user input expiration date

;---------------------------------CHECK VALIDATION BACK SLASH AND DIGIT--------------------------

    MOV     invalidData , 2                 ; move value 2 into invalidData variable to display invalid comment
    CMP     ExpireDate[2],"/"               ; check validation
    JNE     invalidCmnt                     ; jump to invalidCmnt if not equal to ExpireDate

    CMP     EAX , 5                         ; check validation user input ExpireDate digit
    JNE     invalidCmnt                     ; jump to invalidCmnt if not equal to ExpireDate
    JMP     inputCVV                        ; else jump to inputCVV

;------------------------------PROMPT THE USER ENTER THE CV CODE---------------------------------

inputCVV:

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET promptCVV          ; LEA EDX , promptCVV
    CALL    WriteString                     ; display prompt the user enter CV Code

    MOV     ECX , LENGTHOF CVV              ; set counter for read string purpose
    LEA     EDX ,  CVV                      ; store the CVV value into EDX as buffer
    CALL    ReadString                      ; read the user input CV code

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

;---------------------------------CHECK VALIDATION CVV AND DIGIT---------------------------------

    MOV     invalidData , 3                 ; move value 3 into invalidData variable to display invalid comment
    CMP     EAX , 3                         ; check validation user input ExpireDate digit
    JNE     invalidCmnt                     ; jump to invalidCmnt if CVV is not equal 3 digit

    MOV     AL , CVV                        ; move CVV value into AL
    CALL    IsDigit                         ; determines whether the character in EAX is a valid decimal digit
    JNE     invalidCmnt                     ; jump to invalidCmnt if CVV is not decimal digit
    JMP     inputDlvr                       ; else jump to inputDlvr

;------------------------------PROMPT THE USER ENTER OPTION DELIVERY-----------------------------

inputDlvr:

    CALL    Crlf                            ; go new line
    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET promptDlvr         ; LEA EDX , promptDlvr
    CALL    WriteString                     ; prompt the user enter the option of delivery or take away
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX, OFFSET promptOpt           ; LEA EDX , promptOpt
    CALL    WriteString                     ; prompt the user enter the option of delivery or take away
    MOV     AL , optDlvr                    ; move optionDlvr to EAX
    CALL    ReadInt                         ; read the user input option of delivery or take away
    MOV     optDlvr , AL                    ; store the AL value into optDlvr

    MOV     EDX , OFFSET line3              ; LEA EDX , line3
    CALL    WriteString                     ; display line3 ///--------///
    CALL    Crlf                            ; go new line

;-------------------------Compare the User Input Option Delivery or Take Away--------------------

    MOV     BL , 1                          ; move BL with 1 as delivery option
    CMP     BL , optDlvr                    ; compare optDlvr to BL
    JE      delivery                        ; jump to delivery if optDlvr is equal to EAX
    MOV     deliveryCost , 0                ; esle move 0 into deliveryCost as RM 0
    JMP     inputMember                     ; and force jump tp inputMember

delivery:

    MOV     deliveryCost , 1                ; move 1 into deliveryCost as RM 1
    JMP     inputMember                     ; and force jump tp inputMember

;------------------------------PROMPT THE USER ENTER OPTION MEMBER OR GUEST----------------------

inputMember:

    MOV     EDX , OFFSET promptMember       ; LEA EDX , promptMember
    CALL    WriteString                     ; display prompt the user enter option of member or guest
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX, OFFSET promptOpt           ; LEA EDX , promptOpt
    CALL    WriteString                     ; display prompt the user enter option of member or guest
    MOV     AL, optMember                   ; move optionMember to AL
    CALL    ReadInt                         ; read the user input option of member or guest
    MOV     optMember , AL                  ; store the AL value into optMember

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

;--------------------Compare the User Input Option Member or Guest-------------------------------

    MOV     BL , 1                          ; move BL with 1 as member option
    CMP     BL , optMember                  ; compare optMember to BL
    JE      member                          ; jump to member if optMember is equal to EAX
    MOV     discountCost , 0                ; esle move 0 into discountCost as RM 0
    JMP     displayDis                      ; and force jump tp displayDis

member:

    MOV     discountCost , 2                ; move 1 into discountCost as RM 2
    JMP     displayDis                      ; and force jump to displayDis

;------------------------------Display Discount Fee----------------------------------------------

displayDis:

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputDis          ; LEA EDX , outputDis
    CALL    WriteString                     ; display output discount fee

    MOV     EAX , discountCost              ; move discountCost value into EAX
    CALL    WriteDec                        ; display discountCost
    CALL    Crlf                            ; go new line

;------------------------------Display Delivery Fee----------------------------------------------

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputDlvr         ; LEA EDX , outputDlvr
    CALL    WriteString                     ; display output delivery fee

    MOV     EAX , deliveryCost              ; move deliveryCost value into EAX
    CALL    WriteDec                        ; display deliveryCost
    CALL    Crlf                            ; go new line

;----------------------------------CALCULATE ADD TOTAL WITH DELIVERY FEE-------------------------

    MOV     EAX , deliveryCost              ; move delivery value into EAX
    ADD     totalPay , EAX                  ; add total with delivery fee

;---------------------------------CALCULATE SUB TOTAL WITH DISCOUNT------------------------------

    MOV     EAX , discountCost              ; move discount value into AL
    SUB     totalPay , EAX                  ; minus price with discount

;----------------------------------DISPLAY TOTAL PAYMENT-----------------------------------------

    MOV     EDX , OFFSET line4              ; LEA EDX , line4
    CALL    WriteString                     ; display line4 ///    ------- ///
    CALL    Crlf

    MOV     EDX , OFFSET outputTotPay       ; LEA EDX , outputTotPay
    CALL    WriteString                     ; display total payment

    MOV     EAX , totalPay                  ; move totalPay value into EAX
    CALL    WriteDec                        ; display totalPay
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line5              ; LEA EDX , line5
    CALL    WriteString                     ; display line5 ///   ======= ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    MOV     request , 1                     ; move 1 value into request variable
    JMP     inputCont                       ; force jump to inputCont to let user continue or reset or back

;--------------------------------PROMPT USER SELECT DIGIT OF CASH VALUE--------------------------

selectCash:

    MOV     displayTitle , 2                ; move 1 into displayTitle
    JMP     sysMenu                         ; and force jump to sysMenu in order to display sysMenu

cash:

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET titleCash          ; LEA EDX , titleCash
    CALL    WriteString                     ; display prompt the user select cash digit
    CALL    Crlf

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line3              ; LEA EDX , line3
    CALL    WriteString                     ; display line3 ///--------///
    CALL    Crlf                            ; go new line

;-------------------------PROMPT THE USER ENTER QUANTITY OF RM 100.00----------------------------

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputRM100        ; LEA EDX , outputRM100
    CALL    WriteString                     ; prompt the user enter quantity of RM 100

    MOV     EAX, qtyRM100                   ; move qtyRM100 into EAX
    CALL    ReadInt                         ; read the user input the quantity of RM 100

    MOV     EDX , OFFSET line6              ; LEA EDX , line6
    CALL    WriteString                     ; display line 6 --------->> RM

;------------------------CALCULATE MUL THE QTY OF THE RM 100.00----------------------------------

    MOV     EBX , 100                       ; move 100 into EBX , EBX = multiplier (operand)
    MUL     EBX                             ; EAX = qtyRM100 , EBX * EAX => EDX:EAX
    MOV     amountRM100 , EAX               ; store EAX value into amountRM100 variable

    CALL    WriteDec                        ; display the quantity of amountRM100
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;-------------------------PROMPT THE USER ENTER QUANTITY OF RM 50.00-----------------------------

    MOV     EDX , OFFSET outputRM50         ; LEA EDX , outputRM50
    CALL    WriteString                     ; prompt the user enter quantity of RM 50

    MOV     EAX, qtyRM50                    ; move qtyRM50 into EAX
    CALL    ReadInt                         ; read the user input the quantity of RM 50

    MOV     EDX , OFFSET line6              ; LEA EDX , line6
    CALL    WriteString                     ; display line 6 --------->> RM

;---------------------------CALCULATE MUL THE QTY OF THE RM 50.00--------------------------------

    MOV     EBX , 50                        ; move 50 into EBX , EBX = multiplier (operand)
    MUL     EBX                             ; EAX = qtyRM50 , EAX * EAX => EDX:EAX
    MOV     amountRM50 , EAX                ; store EAX value into amountRM50 variable

    CALL    WriteDec                        ; display the quantity of amountRM50
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;-------------------------PROMPT THE USER ENTER QUANTITY OF RM 10.00-----------------------------

    MOV     EDX , OFFSET outputRM10         ; LEA EDX , outputRM10
    CALL    WriteString                     ; prompt the user enter quantity of RM 10

    MOV     EAX, qtyRM10                    ; move qtyRM50 into EAX
    CALL    ReadInt                         ; read the user input the quantity of RM 10

    MOV     EDX , OFFSET line6              ; LEA EDX , line6
    CALL    WriteString                     ; display line 6 --------->> RM


;----------------------------CALCULATE MUL THE QTY OF THE RM 10.00-------------------------------

    MOV     EBX , 10                        ; move 10 into EBX , EBX = multiplier (operand)
    MUL     EBX                             ; EAX = qtyRM10 , EAX * EAX => EDX:EAX
    MOV     amountRM10 , EAX                ; store EAX value into amountRM10 variable

    CALL    WriteDec                        ; display the quantity of amountRM10
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;-------------------------PROMPT THE USER ENTER QUANTITY OF RM 5.00------------------------------

    MOV     EDX , OFFSET outputRM5          ; LEA EDX , outputRM5
    CALL    WriteString                     ; prompt the user enter quantity of RM 5

    MOV     EAX, qtyRM5                     ; move qtyRM50 into EAX
    CALL    ReadInt                         ; read the user input the quantity of RM 5

    MOV     EDX , OFFSET line6              ; LEA EDX , line6
    CALL    WriteString                     ; display line 6 --------->> RM

;----------------------------CALCULATE MUL THE QTY OF THE RM 5.00--------------------------------

    MOV     EBX , 5                         ; move 5 into EBX , EBX = multiplier (operand)
    MUL     EBX                             ; EAX = qtyRM5 , EAX * EAX => EDX:EAX
    MOV     amountRM5 , EAX                 ; store EAX value into amountRM5 variable

    CALL    WriteDec                        ; display the quantity of amountRM5
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

; -------------------------PROMPT THE USER ENTER QUANTITY OF RM 1.00-----------------------------

    MOV     EDX , OFFSET outputRM1          ; LEA EDX , outputRM1
    CALL    WriteString                     ; prompt the user enter quantity of RM 1

    MOV     EBX, qtyRM1                     ; move qtyRM50 into EAX
    CALL    ReadInt                         ; read the user input the quantity of RM 1

    MOV     EDX , OFFSET line6              ; LEA EDX , line6
    CALL    WriteString                     ; display line 6 --------->> RM

;----------------------------CALCULATE MUL THE QTY OF THE RM 1.00--------------------------------

    MOV     EBX , 1                         ; move 1 into EBX , EBX = multiplier (operand)
    MUL     EBX                             ; EAX = qtyRM1 , EAX * EAX => EDX:EAX
    MOV     amountRM1 , EAX                 ; store EAX value into amountRM1 variable

    CALL    WriteDec                        ; display the quantity of amountRM5
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------------DISPLAY OUTPUT TOTAL AMOUNT-----------------------------

    MOV     EDX , OFFSET line4              ; LEA EDX , line4
    CALL    WriteString                     ; display line4 ///    ------- ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputTotAmt       ; LEA EDX , outputTotAmt
    CALL    WriteString                     ; display output total amount RM

;-----------------------------CALCULATE ADD ALL THE CASH VALUE-----------------------------------

    MOV     EAX , totalAmount               ; move totalAmount into totalAmount
    ADD     EAX , amountRM100               ; ADD amountRM100 value into totalAmount
    ADD     EAX , amountRM50                ; ADD amountRM50 value into totalAmount
    ADD     EAX , amountRM10                ; ADD amountRM10 value into totalAmount
    ADD     EAX , amountRM5                 ; ADD amountRM5 value into totalAmount
    ADD     EAX , amountRM1                 ; ADD amountRM1 value into totalAmount

    CALL    WriteDec                        ; display the final totalAmount
    MOV     totalAmount , EAX               ; store the EAX value into totalAmount
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///         ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputTotPay       ; LEA EDX , outputTotPay
    CALL    WriteString                     ; display output total payment

    MOV     EAX , totalPay                  ; MOV totalPay value into totalPay
    CALL    WriteDec                        ; display output total payment
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line4              ; LEA EDX , line4
    CALL    WriteString                     ; display line4 ///    ------- ///
    CALL    Crlf                            ; go new line

;------------------------------CALCULATE SUB TOTAL AMOUNT AND PAYMENT----------------------------

    MOV     EAX , totalAmount               ; move totalAmount into totalAmount
    SUB     EAX , totalPay                  ; minus total payment with total amount
    MOV     balance , EAX                   ; store EAX value into balance

    LEA     EDX , outputBalance             ; MOV EDX , OFFSET outputBalance
    CALL    WriteString                     ; display output balance

    MOV     EAX , balance                   ; MOV balance value into EAX
    CALL    WriteInt                        ; display balance amount
    CALL    Crlf

    MOV     EDX , OFFSET line5              ; LEA EDX , line5
    CALL    WriteString                     ; display line5 ///   ======= ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;-------------------------------COMPARE THE PAYMENT AMOUNT VALUE---------------------------------

    CMP     EAX , 0                         ; compare totalPay with 0
    JGE     success                         ; jump to success if greater or equal to 0
    JMP     unsuccess                       ; else jump to unsuccess

unsuccess:

    MOV     EDX , OFFSET outputUnsuccess    ; LEA EDX , outputUnsuccess
    CALL    WriteString                     ; display transaction not successfull
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    CALL    WaitMsg                         ; display waits for the user to press the Enter key
    JMP     selectCash                      ; force jump to selectCash

success:

    MOV     EDX , OFFSET outputsuccess      ; LEA EDX , outputsuccess
    CALL    WriteString                     ; display transaction successfull
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    CALL    WaitMsg                         ; display waits for the user to press the Enter key
    JMP     receipt                         ; force jump to receipt

;---------------------------------------------PAYMENT RECEIPT------------------------------------

receipt:

    CALL Clrscr                             ; clear screen
    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET titleRcpt          ; LEA EDX , titleRcpt
    CALL    WriteString                     ; display titleRcpt
    CALL    Crlf

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------DISPLAY TRANSACTION DATE--------------------------------------

    MOV     EDX , OFFSET outputDateTime     ; LEA EDX , outputDateTime
    CALL    WriteString                     ; display output transaction date and time
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------DISPLAY CASHIER NAME------------------------------------------

    MOV     EDX , OFFSET outputName         ; LEA EDX , outputName
    CALL    WriteString                     ; display output cashier name

    MOV EDX , OFFSET user                   ; LEA EDX , user
    CALL    WriteString                     ; display the cashier name
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------DISPLAY REFERENCE NUMBER--------------------------------------

    MOV     EDX , OFFSET outputRefNo        ; LEA EDX , outputRefNo
    CALL    WriteString                     ; display output reference number

    MOV     EAX, 100000                     ; get random 0 to 99999
    call    RandomRange                     ; display the user reference number for the receipt for user easily review back
    INC     EAX                             ; make range 1 to 100000
    MOV     RefNo , EAX                     ; store EAX value into RefNo
    CALL    WriteDec                        ; display the value of RefNo
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------DISPLAY NAME OF THE BANK--------------------------------------

    MOV     EDX , OFFSET outputBank         ; LEA EDX , outputBank
    CALL    WriteString                     ; display output bank

    MOV     AL , shortHLB                   ; move "HLB" into AL
    CMP     bank , AL                       ; string compare bank to 'HLB'
    JE      HLB_bank                        ; jump to HLB_bank if bank equal to 'HLB'

    MOV     AL , shortPBB                   ; move "PBB" into AL
    CMP     bank , AL                       ; else compare bank to 'PBB'
    JE      PBB_bank                        ; jump to PBB_bank if bank equal to 'PBB'

    MOV     AL , shortRHB                   ; move "RHB" into AL
    CMP     bank , AL                       ; else compare bank to 'RHB'
    JE      RHB_bank                        ; jump to RHB_bank if bank equal to 'RHB'

    MOV     AL , shortCIMB                  ; move "CIMB" into AL
    CMP     bank , AL                       ; else compare bank to 'CIMB'
    JE      CIMB_bank                       ; jump to RHB_bank if bank equal to 'CIMB'

    MOV     AL , shortMAYB                  ; move "MAYB" into AL
    CMP     bank , AL                       ; else compare bank to 'MAYB'
    JE      MAY_bank                        ; jump to MAY_bank if bank equal to 'MAYB'

    MOV     AL , shortAMB                   ; move "MAYB" into AL
    CMP     bank , AL                       ; else compare bank to 'AMB'
    JE      AM_bank                         ; jump to AM_bank if bank equal to 'AMB'
    JMP     displayBank                     ; else jump to displayBank

HLB_bank:

    MOV     EDX , OFFSET fullHLB            ; LEA EDX , fullHLB
    CALL    WriteString                     ; display full name Hong Leong Bank
    JMP     displayBank                     ; force jump to displayBank

PBB_bank:

    MOV     EDX , OFFSET fullPBB            ; LEA EDX , fullPB
    CALL    WriteString                     ; display full name Public Bank
    JMP     displayBank                     ; force jump to displayBank

RHB_bank:

    MOV     EDX , OFFSET fullRHB            ; LEA EDX , fullRHB
    CALL    WriteString                     ; display full name RHB Bank
    JMP     displayBank                     ; force jump to displayBank

CIMB_bank:

    MOV     EDX , OFFSET fullCIMB           ; LEA EDX , fullCIMBB
    CALL    WriteString                     ; display full name CIMB Bank
    JMP     displayBank                     ; force jump to displayBank

MAY_bank:

    MOV     EDX , OFFSET fullMAYB           ; LEA EDX , fullMAYB
    CALL    WriteString                     ; display full name MAY Bank
    JMP     displayBank                     ; force jump to displayBank

AM_bank:

    MOV     EDX , OFFSET fullAMB            ; LEA EDX , fullAMB
    CALL    WriteString                     ; display full name AM Bank
    JMP     displayBank                     ; force jump to displayBank

displayBank:

    CALL    Crlf                            ; go new line
    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------DISPLAY CARD ACCOUNT NUMBER-----------------------------------

    MOV     EDX , OFFSET outputAcc          ; LEA EDX , outputAcc
    CALL    WriteString                     ; display output card account number

    MOV     EDX , OFFSET AccNum             ; LEA EDX , AccNum
    CALL    WriteString                     ; display the user card account number
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------DISPLAY TRANSACTION STATUS------------------------------------

    MOV     EDX , OFFSET outputStatus       ; LEA EDX , outputStatus
    CALL    WriteString                     ; display output Status
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------DISPLAY TOTAL AMOUNT------------------------------------------

    MOV     EDX , OFFSET outputAmt          ; LEA EDX , outputAmt
    CALL    WriteString                     ; display output total amount RM

    MOV     EAX , totalAmount               ; move totalAmount value into EAX
    CALL    WriteDec                        ; display output total amount
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

;----------------------------------DISPLAY Recipient Name----------------------------------------

    MOV     EDX , OFFSET outputRcpt         ; LEA EDX , outputRcpt
    CALL    WriteString                     ; display output Recipient Name
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

;-----------------------------------------------Display Thank------------------------------------

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET outputThank        ; LEA EDX , outputThank
    CALL    WriteString                     ; display output Thank you
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line2              ; LEA EDX , line2
    CALL    WriteString                     ; display line2 ///        ///
    CALL    Crlf                            ; go new line

    MOV     EDX , OFFSET line1              ; LEA EDX , line1
    CALL    WriteString                     ; display line1 ///////////////
    CALL    Crlf                            ; go new line
    CALL    Crlf                            ; go new line

    CALL    WaitMsg                         ; display waits for the user to press the Enter key
; |_____________________ Chun Shen _____________________|   | Data
quit:
    exit
main endp

end main