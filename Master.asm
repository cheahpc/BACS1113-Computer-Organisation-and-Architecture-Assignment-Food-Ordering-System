TITLE Odering Food

INCLUDE irvine32.inc
INCLUDE macros.inc

; ================================================================ VARIABLES
.data
; |^^^^^^^^^^^^^^^^^^^^^ Chuan Yan ^^^^^^^^^^^^^^^^^^^^^|   | Data

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

; |_____________________ Chun Shen _____________________|   | Data


; ================================================================ MAIN
.code

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

; |_____________________ Ler Shean _____________________|   | Data

; |^^^^^^^^^^^^^^^^^^^^^ Chun Shen ^^^^^^^^^^^^^^^^^^^^^|   | Data

; |_____________________ Chun Shen _____________________|   | Data
quit:
    exit
main endp

end main