.relativeinclude off

.include card_info_file

// If 0, requires button press before transmission and
// gives the option to send again afterwards.
// If 1, acts just like official cards.
auto	equ	1

.gba
.create "out/card.01.mb",0x02000000
bin_start:

// switch to thumb mode
.arm
ldr	r1,=main | 1b
bx	r1
.pool



// Define var offsets
var_gameState		equ	var_start +  0	// length  1
var_string		equ	var_start +  1	// length  1
var_linkActive		equ	var_start +  2	// length  1
var_linkTimeout		equ	var_start +  3	// length  1
var_linkErrors		equ	var_start +  4	// length  1
var_gameCode		equ	var_start +  5	// length  1

var_transmitLength	equ	var_start +  6	// length  2
var_transmitPos		equ	var_start +  8	// length  2
var_timer		equ	var_start + 10	// length  2

var_transmitPtr		equ	var_start + 12	// length  4
var_transmitChecksum	equ	var_start + 16	// length  4
var_linkSend		equ	var_start + 20	// length 16
var_linkReceive		equ	var_start + 36	// length 16

var_end			equ	var_start + 52



.thumb
main:
// Input:	r0	bin_start
// Output:	r0	1 to restart, 2 to exit
	push	r4-r7,r14

	// set variables pointer register
	ldr	r7,=var_start - bin_start
	add	r7,r0,r7
rv equ r7

	// initialize variables
	mov	r0,0h
	mov	r1,((var_end - var_start + 3) / 4) * 4
@@initloop:
	str	r0,[rv,r1]
	sub	r1,4h
	bge	@@initloop

@@loop:
	// sleep one frame
	mov	r0,0FFh
	add	r0,1h
	mov	r1,1h
	bl	call_ERAPI_200

	// decrement timer
	ldrh	r0,[rv,var_timer - var_start]
	tst	r0,r0
	beq	@@link
	sub	r0,1h
	strh	r0,[rv,var_timer - var_start]

@@link:
	// if link is active, receive data
	ldrb	r0,[rv,var_linkActive - var_start]
	tst	r0,r0
	beq	@@state



	// call ERAPI_LinkSend()
	mov	r0,0C7h
	mov	r1,rv
	add	r1,var_linkSend - var_start
	bl	call_ERAPI_200

	// call ERAPI_LinkReceive()
	mov	r0,0C8h
	mov	r1,rv
	add	r1,var_linkReceive - var_start
	bl	call_ERAPI_200
	ldrb	r1,[rv,var_linkTimeout - var_start]
	tst	r0,r0
	bne	@@resetTimeout

	// if link error, increment timeout
	add	r1,1h
	b	@@storeTimeout

@@resetTimeout:
	mov	r1,0h

@@storeTimeout:
	strb	r1,[rv,var_linkTimeout - var_start]
	cmp	r1,3Ch
	bge	@@error
	ldrb	r1,[rv,var_linkErrors - var_start]
	cmp	r1,3Ch
	blt	@@state

@@error:
	// switch to error state
	mov	r0,STATE_LINK_ERROR
	strb	r0,[rv,var_gameState - var_start]



@@state:
	// call state routine
	ldrb	r0,[rv,var_gameState - var_start]
	add	r1,=state_ptrs
	ldrh	r0,[r1,r0]
	add	r0,r1,r0
	mov	r14,r15
	bx	r0

	// if r0 zero, continue
	tst	r0,r0
	beq	@@loop

@@exit:
	pop	r4-r7,r15



.align 4
state_ptrs:
.definelabel	STATE_INIT		,0
	.dh	s_init			- state_ptrs + 1
.definelabel	STATE_KEYWAIT		,2
	.dh	s_keyWait		- state_ptrs + 1
.definelabel	STATE_LINK_INIT		,4
	.dh	s_linkInit		- state_ptrs + 1
.definelabel	STATE_LINK_WAIT		,6
	.dh	s_linkWait		- state_ptrs + 1
.definelabel	STATE_LINK_CONNECT	,8
	.dh	s_linkConnect		- state_ptrs + 1
.definelabel	STATE_LINK_ERROR	,10
	.dh	s_linkError		- state_ptrs + 1
.definelabel	STATE_TRANSMIT		,12
	.dh	s_transmit		- state_ptrs + 1
.definelabel	STATE_FINISH		,14
	.dh	s_finish		- state_ptrs + 1
.definelabel	STATE_FADEOUT		,16
	.dh	s_fadeout		- state_ptrs + 1
.definelabel	STATE_POST		,18
	.dh	s_post			- state_ptrs + 1



call_ERAPI_300:
	add	r0,0FFh
	add	r0,1h
call_ERAPI_200:
	add	r0,0FFh
	add	r0,1h
call_ERAPI_100:
	add	r0,0FFh
	add	r0,1h

call_ERAPI_000:
// Input:	r0	API code
// Output:	depends on API call
	ldr	r6,=30075FCh
	ldr	r6,[r6]
	bx	r6



printString:
// Input:	r0	index of string to print
// Output:	-
	push	r4,r14

	// Abort if the string is already visible
	ldrb	r1,[rv,var_string - var_start]
	cmp	r0,r1
	beq	@@end
	strb	r0,[rv,var_string - var_start]

	// Get string pointer
	ldr	r1,=str_table
	ldrh	r0,[r1,r0]
	add	r4,r1,r0

	// call ERAPI_ClearRegion
	mov	r0,92h
	mov	r1,2h		// region
	bl	call_ERAPI_200

	// call ERAPI_DrawText
	mov	r0,99h
	mov	r1,2h		// region
	mov	r2,8h		// x-pos
	lsl	r2,r2,8h
	add	r2,4h		// y-pos
	mov	r3,r4
	bl	call_ERAPI_200

@@end:
	pop	r4,r15



calcChecksum:
// Input:	r0	pointer to data block
//		r1	length of data block in bytes
// Output:	r0	checksum of data block
	push	r14
	mov	r2,0h

@@loop:
	cmp	r1,0h
	ble	@@end

	ldrb	r3,[r0]
	add	r2,r2,r3

	add	r0,1h
	sub	r1,1h
	b	@@loop

@@end:
	mov	r0,r2
	pop	r15



s_init:
	push	r4-r5,r14

	// call ERAPI_BL_IRQ_SIO_DMA3
	// I think it allocates more memory somehow?
	// needed to prevent a crash when 3 text regions are used
	mov	r0,0EAh
	//mov	r1,38h	// causes crash when restarting e-card
	mov	r1,30h
	bl	call_ERAPI_200

	// load the background
	// call ERAPI_SetBackgroundMode
	mov	r0,19h
	mov	r1,1h
	bl	call_ERAPI_200

	// call ERAPI_LoadBackgroundCustom
	mov	r0,2Dh
	mov	r1,1h
	ldr	r2,=struct_bg
	bl	call_ERAPI_200

	// call ERAPI_LayerShow
	mov	r0,20h
	mov	r1,1h
	bl	call_ERAPI_200

.if ((game_code >> 8) == 0x423457 && card_type == 0) || card_type == 2
	ldr	r4,=struct_sprite

	// call ERAPI_LoadSpriteCustom
	mov	r0,4Dh
	ldrb	r1,[r4,10h]
	mov	r2,r4
	bl	call_ERAPI_200

	// call ERAPI_MoveSprite
	mov	r1,r0
	mov	r0,32h
	ldrb	r2,[r4,11h]
	ldrb	r3,[r4,12h]
	bl	call_ERAPI_200

	add	r4,14h

	// call ERAPI_LoadSpriteCustom
	mov	r0,4Dh
	ldrb	r1,[r4,10h]
	mov	r2,r4
	bl	call_ERAPI_200

	// call ERAPI_MoveSprite
	mov	r1,r0
	mov	r0,32h
	ldrb	r2,[r4,11h]
	ldrb	r3,[r4,12h]
	bl	call_ERAPI_200
.endif

	// Load text palette
	// call ERAPI_SetBackgroundPalette
	mov	r0,7Eh
	ldr	r1,=data_strpal
	mov	r2,0
	ldrb	r3,[r1]
	add	r1,2h
	bl	call_ERAPI_200

	// Create three text regions
	ldr	r4,=struct_region
	mov	r5,3h



@@loop:
	push	r5

	// call ERAPI_CreateRegion
	mov	r0,90h
	mov	r1,0h		// palette bank
	ldrh	r2,[r4]		// position
	ldrh	r3,[r4,2h]	// dimensions
	bl	call_ERAPI_200

	mov	r5,r0

	// Set text region background transparent
	// US e-Reader bug (?) workaround
	ldr	r0,=2024D04h
	sub	r1,r5,1h
	lsl	r1,r1,2h
	ldr	r1,[r1,r0]
	mov	r0,0h
	strb	r0,[r1,0Bh]

	// call ERAPI_SetTextColor
	mov	r0,98h
	mov	r1,r5		// region
	ldrb	r2,[r4,4h]	// text color
	lsl	r2,r2,8h
	bl	call_ERAPI_200

	// call ERAPI_SetTextSize
	mov	r0,9Ah
	mov	r1,r5		// region
	lsl	r1,r1,8h
	ldrb	r2,[r4,5h]	// size
	add	r1,r1,r2
	bl	call_ERAPI_200



	add	r4,6h
	pop	r5
	sub	r5,1h
	bhi	@@loop

	// Draw title text
	// call ERAPI_DrawText
	mov	r0,99h
	mov	r1,1h		// region
	mov	r2,17h		// x-pos
	lsl	r2,r2,8h
	add	r2,4h		// y-pos
	ldr	r3,=str_title
	bl	call_ERAPI_200

	mov	r0,99h
	mov	r1,1h		// region
	mov	r2,card_sub_x	// x-pos
	lsl	r2,r2,8h
	add	r2,10h		// y-pos
	ldr	r3,=str_subtitle
	bl	call_ERAPI_200

.if ((game_code >> 8) != 0x423457 || card_type != 0) && (card_type != 2)
	// Draw card text
	// call ERAPI_DrawText
	mov	r0,99h
	mov	r1,3h		// region
	mov	r2,8h		// x-pos
	lsl	r2,r2,8h
	add	r2,5h		// y-pos
	ldr	r3,=str_card
	bl	call_ERAPI_200
.endif

.if (card_type == 1)
	// Start sprite animation
	// call ERAPI_AnimatePalette
	mov	r0,78h
	ldr	r1,=struct_anim
	bl	call_ERAPI_200
.endif
.if ((game_code >> 8) == 0x423457 && card_type == 0) || card_type == 2
	// Start sprite animation
	// call ERAPI_AnimatePalette
	mov	r0,78h
	ldr	r1,=struct_anim
	bl	call_ERAPI_200
.endif

	// call ERAPI_FadeIn
	mov	r0,0h
	mov	r1,10h
	bl	call_ERAPI_200

	// go to next state
.if auto == 0
	mov	r0,STATE_KEYWAIT
.else
	mov	r0,STATE_LINK_INIT
.endif
	strb	r0,[rv,var_gameState - var_start]

	mov	r0,0h
	pop	r4-r5,r15



s_keyWait:
	push	r4,r14

	// Print interface message
	mov	r0,STRING_KEYWAIT
	bl	printString

	// if B pressed, exit
	mov	r4,2h
	mov	r0,1h
	bl	call_ERAPI_300

	mov	r1,2h
	tst	r0,r1
	bne	@@end

	// if A pressed, go to next state
	mov	r4,0h
	mov	r1,1h
	tst	r0,r1
	beq	@@end

	mov	r0,STATE_LINK_INIT
	strb	r0,[rv,var_gameState - var_start]

@@end:
	mov	r0,r4
	pop	r4,r15



s_linkInit:
	push	r4,r14

	mov	r0,STRING_LINKINIT
	bl	printString

	// call ERAPI_2C6()
	mov	r0,0C6h
	bl	call_ERAPI_200

	// call ERAPI_2C4(0x8, 0x69, 0xA6C0, 0x2)
	mov	r0,0C4h
	mov	r1,8h
	mov	r2,69h
.if (game_code >> 8) == 0x423457
	ldr	r3,=0A3D0h
.else
	ldr	r3,=0A6C0h
.endif
	mov	r4,2h
	push	r4
	bl	call_ERAPI_200
	add	r13,4h

	mov	r0,STATE_LINK_WAIT
	strb	r0,[rv,var_gameState - var_start]

	mov	r0,0h
	pop	r4,r15



s_linkWait:
	push	r14

	// if B pressed, exit
	mov	r0,1h
	bl	call_ERAPI_300
	mov	r1,2h
	tst	r0,r1
	bne	@@quit

	// call ERAPI_2DB()
	mov	r0,0DBh
	bl	call_ERAPI_200
	cmp	r0,1h
	bgt	@@checkDone

	// call ERAPI_2C5()
	mov	r0,0C5h
	bl	call_ERAPI_200
	b	@@end

@@checkDone:
	cmp	r0,4h
	bne	@@end

	mov	r0,STRING_LINKCONNECT
	bl	printString

	mov	r0,STATE_LINK_CONNECT
	strb	r0,[rv,var_gameState - var_start]

@@end:
	mov	r0,0h
	pop	r15

@@quit:
	mov	r0,2h
	pop	r15



s_linkConnect:
	push	r4-r5,r14

	// send data
	mov	r4,rv
	add	r4,var_linkSend - var_start

	// Set data type
	ldr	r0,=10000060h|card_type<<20
	str	r0,[r4]
	// Set game code
	ldrb	r0,[rv,var_gameCode - var_start]
	ldr	r2,=data_gameCodes
	ldr	r0,[r2,r0]
	str	r0,[r4,4h]

	// Set transmission variables
	lsl	r0,r0,18h
	lsr	r0,r0,18h
	cmp	r0,4Ah
	bne	@@english_before

@@japanese_before:
	ldr	r0,=data_transmit_jp
	ldr	r1,=data_transmit_jp_end - data_transmit_jp
	b	@@setvars_before

@@english_before:
	ldr	r0,=data_transmit_en
	ldr	r1,=data_transmit_en_end - data_transmit_en

@@setvars_before:
	str	r0,[rv,var_transmitPtr - var_start]
	strh	r1,[rv,var_transmitLength - var_start]
	bl	calcChecksum
	str	r0,[rv,var_transmitChecksum - var_start]

	// Set transmission length
	ldrh	r0,[rv,var_transmitLength - var_start]
	str	r0,[r4,8h]

	// Set transmission checksum
	ldr	r0,[rv,var_transmitChecksum - var_start]
	str	r0,[r4,0Ch]

	mov	r0,1h
	strb	r0,[rv,var_linkActive - var_start]

	// check response
	mov	r5,rv
	add	r5,var_linkReceive - var_start

@@checkDeclined:
	ldrh	r0,[r5]
	cmp	r0,62h
	bne	@@checkAccepted

	// Print declined message
	mov	r0,STRING_LINKDECLINED
	bl	printString

	// Disable link
	mov	r0,0h
	strb	r0,[rv,var_linkActive - var_start]

	// Set timer for 60 frames
	mov	r0,3Ch
	strh	r0,[rv,var_timer - var_start]

	// Switch to fadeout state
	mov	r0,STATE_FADEOUT
	strb	r0,[rv,var_gameState - var_start]

	b	@@resetErrors

@@checkAccepted:
	ldrh	r2,[r5,4h]
	lsl	r2,r2,10h
	add	r0,r0,r2
	ldrh	r1,[r5,8h]
	ldrh	r2,[r5,0Ch]
	lsl	r2,r2,10h
	add	r1,r1,r2

	// check if modification accepted
	ldr	r2,=10000060h|card_type<<20
	cmp	r0,r2
	bne	@@checkWaiting

	// Set transmission variables again
	lsl	r0,r1,18h
	lsr	r0,r0,18h
	cmp	r0,4Ah
	bne	@@english_after

@@japanese_after:
	ldr	r0,=data_transmit_jp
	ldr	r1,=data_transmit_jp_end - data_transmit_jp
	b	@@setvars_after

@@english_after:
.if (game_code >> 8) != 0x425235				// if BN4 or BN5
	ldr	r0,=data_transmit_en
	ldr	r1,=data_transmit_en_end - data_transmit_en
.else								// if BN6
	ldr	r0,=data_transmit_jp
	ldr	r1,=data_transmit_jp_end - data_transmit_jp
.endif

@@setvars_after:
	str	r0,[rv,var_transmitPtr - var_start]
	strh	r1,[rv,var_transmitLength - var_start]
	bl	calcChecksum
	str	r0,[rv,var_transmitChecksum - var_start]

	mov	r0,STRING_LINKACCEPTED
	bl	printString

	mov	r0,STATE_TRANSMIT
	strb	r0,[rv,var_gameState - var_start]

	b	@@resetErrors

@@checkWaiting:
	ldr	r2,=20000060h
	cmp	r0,r2
	beq	@@resetErrors

@@error:
	ldrb	r0,[rv,var_linkErrors - var_Start]
	add	r0,1h
	strb	r0,[rv,var_linkErrors - var_Start]
	b	@@end

@@resetErrors:
	// Continue waiting
	mov	r0,0h
	strb	r0,[rv,var_linkErrors - var_Start]

	// Cycle game code
	ldrb	r0,[rv,var_gameCode - var_start]
	add	r0,4h
	cmp	r0,game_code_len * 4h
	bne	@@saveCode
	mov	r0,0h

@@saveCode:
	strb	r0,[rv,var_gameCode - var_start]

@@end:
	mov	r0,0h
	pop	r4-r5,r15



s_linkError:
	push	r14

	mov	r0,STRING_LINKERROR
	bl	printString

	// Disable link
	mov	r0,0h
	strb	r0,[rv,var_linkActive - var_start]

.if auto == 0
	mov	r0,STATE_POST
	strb	r0,[rv,var_gameState - var_start]
.else
	// Set timer for 60 frames
	mov	r0,3Ch
	strh	r0,[rv,var_timer - var_start]

	// Switch to fadeout state
	mov	r0,STATE_FADEOUT
	strb	r0,[rv,var_gameState - var_start]
.endif

	mov	r0,0h
	pop	r15



s_transmit:
	push	r4,r14

	// Load current position and length
	ldrh	r0,[rv,var_transmitPos - var_start]
	ldrh	r2,[rv,var_transmitLength - var_start]

	// Check if already done
	cmp	r0,r2
	bne	@@sendNext

	// Set timer for 15 frames
	// to send finish command multiple times
	mov	r0,0Ch
	strh	r0,[rv,var_timer - var_start]

	// Continue to next state after this
	mov	r1,STATE_FINISH
	strb	r1,[rv,var_gameState - var_start]
	b	@@end

@@sendNext:
	// Set end byte to current position + 14
	mov	r1,r0
	add	r1,0Eh

	// Check if end exceeded
	cmp	r1,r2
	ble	@@sendBytes

	// If so, read until end
	mov	r1,r2

@@sendBytes:
	// Set end position as current position
	strh	r1,[rv,var_transmitPos - var_start]

	// Load pointers and set initial bytes
	mov	r2,rv
	add	r2,var_linkSend - var_start
	ldr	r3,[rv,var_transmitPtr - var_start]
	mov	r4,61h
	strh	r4,[r2]
	add	r2,2h

@@loop:
	// Load until target reached
	cmp	r0,r1
	bge	@@end

	// Copy 1 byte from transmitPtr to linkSend
	ldrb	r4,[r3,r0]
	strb	r4,[r2]
	add	r0,1h
	add	r2,1h
	b	@@loop

@@end:
	mov	r0,0h
	strb	r0,[rv,var_linkErrors - var_Start]

	mov	r0,0h
	pop	r4,r15



s_finish:
	push	r14

	// Send transmission finished command
	ldr	r1,=10000062h|card_type<<20
	str	r1,[rv,var_linkSend - var_start]

	ldrh	r0,[rv,var_timer - var_start]
	cmp	r0,0h
	bgt	@@end

	// Check response
	ldrh	r0,[rv,var_linkReceive - var_start]
	ldrh	r1,[rv,var_linkReceive - var_start + 4]
	lsl	r1,r1,10h
	add	r0,r0,r1
	ldr	r1,=10000062h|card_type<<20
	cmp	r0,r1
	bne	@@error

	// Disable link
	mov	r0,0h
	strb	r0,[rv,var_linkActive - var_start]
	strb	r0,[rv,var_linkErrors - var_start]

	// Print finish message
	mov	r0,STRING_LINKFINISH
	bl	printString

.if auto == 0
	mov	r0,STATE_POST
	strb	r0,[rv,var_gameState - var_start]
.else
	// Set timer for 60 frames
	mov	r0,3Ch
	strh	r0,[rv,var_timer - var_start]

	// Switch to fadeout state
	mov	r0,STATE_FADEOUT
	strb	r0,[rv,var_gameState - var_start]
.endif

	b	@@end

@@error:
	// Add error
	ldrb	r0,[rv,var_linkErrors - var_Start]
	add	r0,1h
	strb	r0,[rv,var_linkErrors - var_Start]

@@end:
	mov	r0,0h
	pop	r15



s_fadeout:
	push	r14
	mov	r1,0h

	// If timer > 0, wait; otherwise, restart or quit
	ldrh	r0,[rv,var_timer - var_start]
	cmp	r0,0h
	bgt	@@end
.if auto == 0
	mov	r1,1h
.else
	mov	r1,2h
.endif

@@end:
	mov	r0,r1
	pop	r15



s_post:
	push	r14

	// if B pressed, exit
	mov	r0,1h
	bl	call_ERAPI_300
	mov	r1,2h
	tst	r0,r1
	beq	@@checkA

	mov	r0,2h
	b	@@end

@@checkA:
	// if A pressed, restart
	mov	r1,1h
	tst	r0,r1
	beq	@@wait

	mov	r0,1h
	b	@@end

@@wait:
	mov	r0,0h

@@end:
	pop	r15



	.pool



.align 4
struct_bg:
	dw	data_tileset
	dw	data_palettes
	dw	data_tilemap
	dh	(data_tileset_end - data_tileset + 0x1F) / 0x20
	dh	(data_palettes_end - data_palettes + 0x1F) / 0x20



struct_region:
	db	1	// y-position
	db	2	// x-position
	db	4	// tile height
	db	28	// tile width
	db	2	// text color
	db	2	// text size

.if (game_code >> 8) == 0x423457 && card_type == 0		// if BN4 chip
	db	15	// y-position
.else								// if BN4 mod or BN5 or BN6
	db	14	// y-position
.endif
	db	1	// x-position
	db	4	// tile height
	db	28	// tile width
	db	1	// text color
	db	2	// text size

	db	7	// y-position
.if (game_code >> 8) != 0x423457 && (card_type == 0 || card_type == 4)
	db	6	// x-position
.else
	db	10	// x-position
.endif
	db	6	// tile height
	db	19	// tile width
	db	1	// text color
	db	2	// text size

.align 4
struct_anim:
.if (card_type == 1)
	db	0
	db	4
	db	1
	db	1
	dw	struct_anim_pal
.endif
.if ((game_code >> 8) == 0x423457 && card_type == 0) || card_type == 2
	db	1
	db	1
	db	3
	db	1
	dw	struct_anim_pal
.endif

struct_anim_pal:
.if (card_type == 1)
	dh	0x401E
	dh	0x300F
	dh	0x2000
.endif
.if ((game_code >> 8) == 0x423457 && card_type == 0) || card_type == 2
	dh	0x4008
	dh	0x3004
	dh	0x2000
.endif

.align 4
struct_sprite:
.if ((game_code >> 8) == 0x423457 && card_type == 0) || card_type == 2
	.dw	data_chip_img
	.dw	data_chip_pal
	db	7	// width
	db	6	// height
	db	1
	db	1
	db	0
	db	0
	db	1
	db	0

	db	0x80
	.if (game_code >> 8) == 0x423457
		db	116	// x
	.else
		db	120	// x
	.endif
	db	72	// y

.align 4
	.dw	data_chip_name_img
	.dw	data_chip_name_pal
	db	12	// width
	db	2	// height
	db	1
	db	1
	db	0
	db	0
	db	1
	db	0

	db	0x81
	.if (game_code >> 8) == 0x423457
		db	112	// x
	.else
		db	120	// x
	.endif
	db	105
.endif
	


.align 2
str_table:
.definelabel	STRING_NONE			,0
	.dh	str_none			- str_table
.definelabel	STRING_TITLE			,2
	.dh	str_title			- str_table
.definelabel	STRING_SUBTITLE			,4
	.dh	str_subtitle			- str_table
.definelabel	STRING_CARD			,6
	.dh	str_card			- str_table
.definelabel	STRING_KEYWAIT			,8
	.dh	str_keyWait			- str_table
.definelabel	STRING_LINKINIT			,10
	.dh	str_linkInit			- str_table
.definelabel	STRING_LINKCONNECT		,12
	.dh	str_linkConnect			- str_table
.definelabel	STRING_LINKACCEPTED		,14
	.dh	str_linkConnect_accepted	- str_table
.definelabel	STRING_LINKDECLINED		,16
	.dh	str_linkConnect_declined	- str_table
.definelabel	STRING_LINKERROR		,18
	.dh	str_linkError			- str_table
.definelabel	STRING_LINKFINISH		,20
	.dh	str_linkFinish			- str_table

str_none:
	.ascii 0x00

str_title:
.if (game_code >> 8) == 0x423457				// if BN4
	.ascii "Mega Man Battle Network 4",0x00
.endif
.if (game_code >> 8) == 0x425242				// if BN5
	.ascii "Mega Man Battle Network 5",0x00
.endif
.if (game_code >> 8) == 0x425235				// if BN6
	.ascii "Mega Man Battle Network 6",0x00
.endif

str_subtitle:
	.ascii card_sub,0x00

str_card:
.if card_desc_len > 0
	.ascii card_desc_1
.endif
.if card_desc_len > 1
	.ascii 0x0A,card_desc_2
.endif
.if card_desc_len > 2
	.ascii 0x0A,card_desc_3
.endif
.ascii 0x00

str_keyWait:
.if auto == 0
	.ascii "Connect the Link Cable",0x0A
	.ascii "and press A to continue.",0x00
.else
	.ascii 0x00
.endif

str_linkInit:
.if auto == 0
	.if (game_code >> 8) == 0x423457			// if BN4
		.ascii "Connecting... In MMBN4, go",0x0A
		.ascii "to the MegaMan screen.",0x00
	.endif
	.if (game_code >> 8) == 0x425242			// if BN5
		.ascii "Connecting... In MMBN5, go",0x0A
		.ascii "to the MegaMan screen.",0x00
	.endif
	.if (game_code >> 8) == 0x425235			// if BN6
		.ascii "Connecting... in MMBN6, go",0x0A
		.ascii "to the MegaMan screen.",0x00
	.endif
.else
	.if (game_code >> 8) == 0x423457			// if BN4
		.ascii "Connect the Link Cable, then go",0x0A
		.ascii "to the MegaMan screen in MMBN4.",0x00
	.endif
	.if (game_code >> 8) == 0x425242			// if BN5
		.ascii "Connect the Link Cable, then go",0x0A
		.ascii "to the MegaMan screen in MMBN5.",0x00
	.endif
	.if (game_code >> 8) == 0x425235			// if BN6
		.ascii "Connect the Link Cable, then go",0x0A
		.ascii "to the MegaMan screen in MMBN6.",0x00
	.endif
.endif

str_linkConnect:
.if card_type == 1
	.if (game_code >> 8) == 0x423457			// if BN4
		.ascii "In Mega Man Battle Network 4,",0x0A
		.ascii "select \"Modify\".",0x00
	.endif
	.if (game_code >> 8) == 0x425242			// if BN5
		.ascii "In Mega Man Battle Network 5,",0x0A
		.ascii "select \"Modify\".",0x00
	.endif
	.if (game_code >> 8) == 0x425235			// if BN6
		.ascii "In Mega Man Battle Network 6,",0x0A
		.ascii "select \"Modify\".",0x00
	.endif
.else
	.if (game_code >> 8) == 0x423457			// if BN4
		.ascii "In Mega Man Battle Network 4,",0x0A
		.ascii "select \"Receive data\".",0x00
	.endif
	.if (game_code >> 8) == 0x425242			// if BN5
		.ascii "In Mega Man Battle Network 5,",0x0A
		.ascii "select \"Receive data\".",0x00
	.endif
	.if (game_code >> 8) == 0x425235			// if BN6
		.ascii "In Mega Man Battle Network 6,",0x0A
		.ascii "select \"Receive data\".",0x00
	.endif
.endif

str_linkConnect_accepted:
.if (game_code >> 8) != 0x423457 && card_type == 0
	.ascii "Sending item data...",0x00
.elseif ((game_code >> 8) == 0x423457 && card_type == 0) || card_type == 2
	.ascii "Sending chip data...",0x00
.elseif card_type == 4
	.ascii "Sending event data...",0x00
.else
	.ascii "Sending mod command...",0x00
.endif

str_linkConnect_declined:
	.ascii "Transmission aborted.",0x00

str_linkError:
.if auto == 0
	.ascii "Communication error!",0x0A
	.ascii "Press A to retry.",0x00
.else
	.ascii "Communication error!",0x00
.endif

str_linkFinish:
.if auto == 0
	.ascii "Transmission complete!",0x0A
	.ascii "Press A to send again.",0x00
.else
	.ascii "Transmission complete!",0x00
.endif



.align 2
data_strpal:
	.dh	3
	.dh	0x0000
	.dh	0x7FFF
.if (game_code >> 8) == 0x423457			// if BN4
	.dh	0x039F
.endif
.if (game_code >> 8) == 0x425242			// if BN5
	.dh	0x039F
.endif
.if (game_code >> 8) == 0x425235			// if BN6
	.dh	0x516D
.endif




.align 4
data_tileset:
.if (game_code >> 8) == 0x423457			// if BN4
	.if (card_type == 0)
		.import "include/tileset_bn4_chip.bin"
	.endif
	.if (card_type == 1)
		.import "include/tileset_bn4_mod.bin"
	.endif
.endif
.if (game_code >> 8) == 0x425242			// if BN5
	.if (card_type == 0)
		.import "include/tileset_bn5_item_chip.bin"
	.endif
	.if (card_type == 1)
		.import "include/tileset_bn5_mod.bin"
	.endif
	.if (card_type == 2)
		.import "include/tileset_bn5_item_chip.bin"
	.endif
.endif
.if (game_code >> 8) == 0x425235			// if BN6
	.if (card_type == 0)
		.import "include/tileset_bn6_item_chip_request.bin"
	.endif
	.if (card_type == 1)
		.import "include/tileset_bn6_mod.bin"
	.endif
	.if (card_type == 2)
		.import "include/tileset_bn6_item_chip_request.bin"
	.endif
	.if (card_type == 4)
		.import "include/tileset_bn6_item_chip_request.bin"
	.endif
.endif
.align 4
data_tileset_end:



.align 4
data_palettes:
.if (game_code >> 8) == 0x423457			// if BN4
	.if (card_type == 0)
		.import "include/palette_bn4_chip.bin"
	.endif
	.if (card_type == 1)
		.import "include/palette_bn4_mod.bin"
	.endif
.endif
.if (game_code >> 8) == 0x425242			// if BN5
	.if (card_type == 0)
		.import "include/palette_bn5_item_mod_chip.bin"
	.endif
	.if (card_type == 1)
		.import "include/palette_bn5_item_mod_chip.bin"
	.endif
	.if (card_type == 2)
		.import "include/palette_bn5_item_mod_chip.bin"
	.endif
.endif
.if (game_code >> 8) == 0x425235			// if BN6
	.if (card_type == 0)
		.import "include/palette_bn6_item_mod_chip_request.bin"
	.endif
	.if (card_type == 1)
		.import "include/palette_bn6_item_mod_chip_request.bin"
	.endif
	.if (card_type == 2)
		.import "include/palette_bn6_item_mod_chip_request.bin"
	.endif
	.if (card_type == 4)
		.import "include/palette_bn6_item_mod_chip_request.bin"
	.endif
.endif
.align 4
data_palettes_end:



.align 4
data_tilemap:
.if (game_code >> 8) == 0x423457			// if BN4
	.if (card_type == 0)
		.import "include/tilemap_bn4_chip.bin"
	.endif
	.if (card_type == 1)
		.import "include/tilemap_bn4_mod.bin"
	.endif
.endif
.if (game_code >> 8) == 0x425242			// if BN5
	.if (card_type == 0)
		.import "include/tilemap_bn5_item.bin"
	.endif
	.if (card_type == 1)
		.import "include/tilemap_bn5_mod.bin"
	.endif
	.if (card_type == 2)
		.import "include/tilemap_bn5_chip.bin"
	.endif
.endif
.if (game_code >> 8) == 0x425235			// if BN6
	.if (card_type == 0)
		.import "include/tilemap_bn6_item_request.bin"
	.endif
	.if (card_type == 1)
		.import "include/tilemap_bn6_mod.bin"
	.endif
	.if (card_type == 2)
		.import "include/tilemap_bn6_chip.bin"
	.endif
	.if (card_type == 4)
		.import "include/tilemap_bn6_item_request.bin"
	.endif
.endif



.align 4
data_gameCodes:
	.dw	game_code
.if game_code_len >= 2
	.dw	game_code_2
.endif
.if game_code_len >= 3
	.dw	game_code_3
.endif



.align 4
data_transmit_jp:
.dh	data_transmit_jp_0 - data_transmit_jp
.dh	data_transmit_jp_1 - data_transmit_jp
.dh	data_transmit_jp_2 - data_transmit_jp
.if (game_code >> 8) == 0x423457 && card_type == 0
	.dh	data_transmit_jp_3 - data_transmit_jp
	.dh	data_transmit_jp_4 - data_transmit_jp
	.dh	data_transmit_jp_5 - data_transmit_jp
.elseif (game_code >> 8) != 0x423457 && card_type == 2
	.dh	data_transmit_jp_3 - data_transmit_jp
	.dh	data_transmit_jp_4 - data_transmit_jp
.endif
.dh	data_transmit_jp_end - data_transmit_jp

.align 4
data_transmit_jp_0:
db	card_id
.if (game_code >> 8) == 0x423457
	db	card_address_id
.elseif (game_code >> 8) == 0x425242
	//db	card_mb
	db	0x00
.else
	db	0x00
.endif

.align 4
data_transmit_jp_1:
.import "out/text1_jp.lz"

.align 4
data_transmit_jp_2:
.import "out/text2_jp.lz"

.align 4
data_transmit_jp_3:
.if (game_code >> 8) == 0x423457 && card_type == 0
data_chip_img:
	.import "include/"+card_chip_img
.elseif (game_code >> 8) != 0x423457 && card_type == 2
data_chip_pal:
	.import "include/"+card_chip_pal
.endif

.align 4
data_transmit_jp_4:
.if (game_code >> 8) == 0x423457 && card_type == 0
data_chip_pal:
	.import "include/"+card_chip_pal
.elseif (game_code >> 8) != 0x423457 && card_type == 2
// Don't need to actually include chip image for BN5/BN6, but do it just in case
data_chip_img:
	.import "include/"+card_chip_img
.endif

.align 4
data_transmit_jp_5:
.if (game_code >> 8) == 0x423457 && card_type == 0
	.import "include/"+card_chip_icon
.endif

.align 4
data_transmit_jp_end:



.align 4
data_transmit_en:
.if (game_code >> 8) != 0x425235
	.dh	data_transmit_en_0 - data_transmit_en
	.dh	data_transmit_en_1 - data_transmit_en
	.dh	data_transmit_en_2 - data_transmit_en
	.if (game_code >> 8) == 0x423457 && card_type == 0
		.dh	data_transmit_en_3 - data_transmit_en
		.dh	data_transmit_en_4 - data_transmit_en
		.dh	data_transmit_en_5 - data_transmit_en
	.elseif (game_code >> 8) != 0x423457 && card_type == 2
		.dh	data_transmit_en_3 - data_transmit_en
		.dh	data_transmit_en_4 - data_transmit_en
	.endif
	.dh	data_transmit_en_end - data_transmit_en
.endif

.align 4
data_transmit_en_0:
.if (game_code >> 8) != 0x425235
	db	card_id
	.if (game_code >> 8) == 0x423457
		db	card_address_id
	.elseif (game_code >> 8) == 0x425242
		//db	card_mb
		db	0x00
	.else
		db	0x00
	.endif
.endif

.align 4
data_transmit_en_1:
.if (game_code >> 8) != 0x425235
	.import "out/text1_en.lz"
.endif

.align 4
data_transmit_en_2:
.if (game_code >> 8) != 0x425235
	.import "out/text2_en.lz"
.endif

.align 4
data_transmit_en_3:
.if (game_code >> 8) == 0x423457 && card_type == 0
	.import "include/"+card_chip_img
.elseif (game_code >> 8) != 0x423457 && card_type == 2
	.import "include/"+card_chip_pal
.endif

.align 4
data_transmit_en_4:
.if (game_code >> 8) == 0x423457 && card_type == 0
	.import "include/"+card_chip_pal
.elseif (game_code >> 8) == 0x425242 && card_type == 2
// Don't need to actually include chip image for BN5/BN6, but do it just in case
	.import "include/"+card_chip_img
.endif

.align 4
data_transmit_en_5:
.if (game_code >> 8) == 0x423457 && card_type == 0
	.import "include/"+card_chip_icon
.endif

.align 4
data_transmit_en_end:



// Include BN5/BN6 chip image
// commented out because it's included in the transmission now anyway
//.if (game_code >> 8) != 0x423457 && card_type == 2
//.align 4
//data_chip_img:
//	.import "include/"+card_chip_img
//.endif



.align 4
data_chip_name_img:
.if (game_code >> 8) == 0x423457 && card_type == 0
	.import "out/"+card_chip_name_img
.elseif (game_code >> 8) != 0x423457 && card_type == 2
	.import "out/"+card_chip_name_img
.endif

.align 4
data_chip_name_pal:
.if (game_code >> 8) == 0x423457 && card_type == 0
	.import "out/"+card_chip_name_pal
	.fill	0x12
.elseif (game_code >> 8) != 0x423457 && card_type == 2
	.import "out/"+card_chip_name_pal
	.fill	0x12
.endif



.align 4
var_start:



.close