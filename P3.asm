INCLUDE Irvine32.inc

.data
	a1h_cost byte 14
	a2h_cost byte 19
	a3h_cost byte 33
	b1h_cost byte 10
	b2h_cost byte 7
	b3h_cost byte 5
	c1h_cost byte 3
	c2h_cost byte 5
	c3h_cost byte 4
	record_total_cost byte 0
	record_sub_total_cost byte 0
	a1h byte 'Soloman -Drum Delux*1 -Fries (Large)*1 -Soda(400ml)*1', 0
	a2h byte 'Dual Fun -Fish n Chips*2 -Salted Fish Skin 3oz*2 -Tafan (800ml)*2', 0
	a3h byte 'Family Bis! -Roti Kampung*4 - Hamshroom*2 - Spute (800ml)*2', 0
	b1h byte 'Drum Delux', 0
	b2h byte 'Fish n Chips', 0
	b3h byte 'Roti Kamung', 0
	c1h byte 'Soda', 0
	c2h byte 'Tafan', 0
	c3h byte 'Sprute', 0

	design_line byte 126 dup('#'), 0
	summary byte 'SUMMARY OF THE ORDER LIST', 0
	order_no byte 'Order Number', 0
	food_id byte 'Food ID', 0
	food_name byte 'Food Name', 0
	cost byte 'Cost (RM)', 0
	qty byte 'Quantity', 0
	total_cost byte 'Total Cost(RM)', 0
	line_1 byte 126 dup('-'), 0
	line_2 byte 126 dup('='), 0
	dh_value byte 11, 0

	orderList_Index word -1
	orderList_Counter dword 0
	orderList word 50 dup(0)
	
	cost_desc byte ' The total cost for the order is ', 0
	cost_summary byte ?
	ask_input byte '-', 0
	cust_name byte ' CUSTOMER NAME', 0
	line_6 byte '****************', 0
	address1 byte ' ADDRESS', 0
	line_3 byte '**********', 0
	address2 byte ' 2, Lebuh Carnarvon, George Town, 10100 George Town, Pulau Pinang', 0
	contact_no1 byte ' CONTACT NUMBER', 0
	line_4 byte '****************', 0
	contact_no2 byte ' If you have any suggestions or feedback, please contact the phone number below: ', 0
	contact_no3 byte ' Restaurant Number: 04-5782 4322', 0
	contact_no4 byte ' Mr. Tan: 012-345 6789', 0
	contact_no5 byte ' Ms. Goh: 017-986 5432', 0
	direction byte ' DIRECTION', 0
	line_5 byte '***********', 0
	forward byte ' 1. Enter 1 for switch to Payment Interface.', 0
	backward byte ' 2. Enter 2 for back to Menu.', 0
	ask_direction_input byte ' Enter a direction: ', 0
	store_direction_user byte ?
	goto_invalid byte ' Invalid, please enter again!!!:', 0

.code
	main proc

	call clrscr

	call crlf							;leave a blank row

	mov edx, offset design_line				;
	call writestring					;call the function to output the 'design_line'

	mov dl, 50							;set columns
	mov dh, 4							;set rows
	call gotoxy							;call the function to adjust the rows and columns

	mov edx, offset summary				;
	call writestring					;call the function to output the 'summary'

	call crlf							;leave a blank row
	call crlf							;leave a blank row
	call crlf							;leave a blank row

	mov edx, offset design_line				;
	call writestring					;write the function to output the 'design_line'

	call crlf							;leave a blank row
	call crlf							;leave a blank row

	mov dl, 1							;set columns
	mov dh, 9							;set rows
	call gotoxy							;call the function to adjust the rows and columns

	mov edx, offset order_no
	call writestring					;write the function to output the 'order_no'

	mov dl, 16							;set columns
	mov dh, 9							;set rows
	call gotoxy							;call the function to adjust the rows and columns

	mov edx, offset food_name
	call writestring					;write the function to output the 'food_name'

	mov dl, 85							;set columns
	mov dh, 9							;set rows
	call gotoxy							;call the function to adjust the rows and columns

	mov edx, offset cost
	call writestring					;write the function to output the 'cost'

	mov dl, 100							;set columns
	mov dh, 9							;set rows
	call gotoxy							;call the function to adjust the rows and columns

	mov edx, offset qty
	call writestring					;write the function to output the 'qty'

	mov dl, 112							;set columns
	mov dh, 9							;set rows
	call gotoxy							;call the function to adjust the rows and columns

	mov edx, offset total_cost			
	call writestring					;write the function to output the 'total_cost'
	call crlf							;jump to next row

	mov edx, offset line_1
	call writestring
	call crlf

;store user input

store:
	mov ecx, 50
	mov esi, 0

loop1:
	cmp byte ptr orderList[esi], 0a1h
	je a1
	cmp byte ptr orderList[esi], 0a2h
	je a2
	cmp byte ptr orderList[esi], 0a3h
	je a3
	cmp byte ptr orderList[esi], 0b1h
	je b1
	cmp byte ptr orderList[esi], 0b2h
	je b2
	cmp byte ptr orderList[esi], 0b3h
	je b3
	cmp byte ptr orderList[esi], 0c1h
	je c1
	cmp byte ptr orderList[esi], 0c2h
	je c2
	cmp byte ptr orderList[esi], 0c3h
	je c3
	inc esi
	
	loop loop1

	jmp flw
	
a1:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 16
	mov dh, dh_value
	call gotoxy

	mov edx, offset a1h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, a1h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

a2:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 16
	mov dh, dh_value
	call gotoxy

	mov edx, offset a2h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, a2h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

a3:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 20
	mov dh, dh_value
	call gotoxy

	mov edx, offset a3h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, a3h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

b1:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 20
	mov dh, dh_value
	call gotoxy

	mov edx, offset b1h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, b1h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

b2:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 20
	mov dh, dh_value
	call gotoxy

	mov edx, offset b2h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, b2h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

b3:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 20
	mov dh, dh_value
	call gotoxy

	mov edx, offset b3h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, b3h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

c1:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 20
	mov dh, dh_value
	call gotoxy

	mov edx, offset c1h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, c1h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

c2:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 20
	mov dh, dh_value
	call gotoxy

	mov edx, offset c2h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, c2h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

c3:
	mov dl, 1
	mov dh, dh_value
	call gotoxy

	mov eax, esi
	call writeint

	mov dl, 20
	mov dh, dh_value
	call gotoxy

	mov edx, offset c3h
	call writestring
	call crlf

	mov dl, 85
	mov dh, dh_value
	call gotoxy

	mov eax, 0
	mov al, c3h_cost
	call writedec
	call crlf

	mov dl, 100
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	call writedec
	call crlf

	mov dl, 112
	mov dh, dh_value
	call gotoxy

	mov al, byte ptr orderList[esi+1]
	mul a1h_cost
	mov record_total_cost, al
	mov al, record_total_cost
	call writeint
	call crlf

	mov dh, dh_value
	inc dh
	mov dh_value, dh

	jmp subtotal

subtotal:
	mov al, record_sub_total_cost
	add al, record_total_cost
	mov record_sub_total_cost, al

	jmp loop1

flw:
	mov edx, offset line1							;move the 'line1' address to edx
	call writestring								;call the function to display 'line1'

	mov edx, offset cost_desc						;move the 'cost_desc' address to edx
	call writestring								;call the function to display 'cost_desc'

	mov al, record_sub_total_cost
	call writeint
	call crlf

	mov edx, offset line_2							;move the 'line_2' address to edx
	call writestring								;call the function to display 'line_2'
	call crlf										;jump to next row
	call crlf										;leave a blank row

	mov edx, offset cust_name						;move the 'cust_name' address to edx
	call writestring								;call the function to display 'cust_name'
	call crlf										;jump to next row

	mov edx, offset line_6							;move the 'line_6' address to edx
	call writestring								;call the function to display 'line_6'
	call crlf										;jump to next row

	;mov edx, offset store_cust_name				;move the 'store_cust_name' address to edx
	;call writestring								;call the function to display 'store_cust_name'
	;call crlf										;jump to next row
	;call crlf										;leave a blank row

	mov edx, offset address1						;move the 'address1' address to edx
	call writestring								;call the function to display 'address1'
	call crlf										;jump to next row

	mov edx, offset line_3							;move the 'line_3' address to edx
	call writestring								;call the function to display 'line_3'
	call crlf										;jump to next row

	mov edx, offset address2						;move the 'address2' address to edx
	call writestring								;call the function to display 'address2'
	call crlf										;jump to next row
	call crlf										;leave a blank row

	mov edx, offset contact_no1						;move the 'contact_no1' address to edx
	call writestring								;call the function to display 'contact_no1'
	call crlf										;jump to next row

	mov edx, offset line_4							;move the 'line_4' address to edx
	call writestring								;call the function to display 'line_4'
	call crlf										;jump to next row

	mov edx, offset contact_no2						;move the 'contact_no2' address to edx
	call writestring								;call the function to display 'contact_no2'
	call crlf										;jump to next row

	mov edx, offset contact_no3						;move the 'contact_no3' address to edx
	call writestring								;call the function to display 'contact_no3'
	call crlf										;jump to next row

	mov edx, offset contact_no4						;move the 'contact_no4' address to edx
	call writestring								;call the function to display 'contact_no4'
	call crlf										;jump to next row

	mov edx, offset contact_no5						;move the 'contact_no5' address to edx
	call writestring								;call the function to display 'contact_no5'
	call crlf										;jump to next row

	mov edx, offset design_line							;move the 'design_line' address to edx
	call writestring								;call the function to display 'design_line'
	call crlf										;jump to next row

	mov edx, offset direction						;move the 'direction' address to edx
	call writestring								;call the function to display 'direction'
	call crlf										;jump to next row

	mov edx, offset line_5							;move the 'line_5' address to edx
	call writestring								;call the function to display 'line_5'
	call crlf										;jump to next row

	mov edx, offset forward							;move the 'foward' address to edx
	call writestring								;call the function to display 'foward'
	call crlf										;jump to next row

	mov edx, offset backward						;move the 'backward' address to edx
	call writestring								;call the function to display 'backward'
	call crlf										;jump to next row
	call crlf										;leave a blank row

	mov edx, offset ask_direction_input				;move the 'ask_direction_input' address to edx
	call writestring								;call the function to display 'ask_direction_input'
	
input:
	mov eax, offset store_direction_user			;move the 'store_direction_user' address to eax
	call readint									; call the function to read user input

again:
	cmp eax, 1										;compare eax and 1
	je sysMenu										;jump to 'transaction' if eax equal 1
	jmp here										;else jump to 'here'

here:
	cmp eax, 2										;compare eax and 2
	je menu											;jump to 'menu' if eax equal 2
	jmp invalid										;else jump to 'invalid'

invalid:
	call crlf										;leave a blank row
	mov edx, offset goto_invalid					;move the 'goto_invalid' address to edx
	call writestring								;call the function to display 'goto_invalid'
	jmp input										;jump to 'input'

	mov edx, offset design_line							;move the 'design_line' address to edx
	call writestring								;call the function to display 'design_line'
	call crlf										;leave a blank row

	call waitmsg									;press any key to continue

	main endp

end main

