.if (game_code >> 8) == 0x425242			// if BN5
	.db	0xE8,0x02
.else							// if BN6
	.db	0xE8,0x0A
.endif

.db	0xF1,0x00,0x00
.db	0xF7,0x02,0x33,0x6C,0x03
.db	0xF1,0x00,0x00

.if (game_code >> 8) == 0x425235			// if BN6
	// Exploit script handler
	.db	0xF9,0x01,0x00,0x05 + (@@asm & 1b)
	.db	0xF9,0x01,0x01,0x34
	.db	0xF9,0x01,0x02,0x20
	.db	0xF9,0x01,0x03,0x47

	//.db	0xFC,0x03,0x41,0x00	// BN5
	.db	0xFC,0x03,0x5A,0x00	// BN6

	@@asm:
	.align 2
	add	r4,@@japanese-.-5
	
	// Check region
	ldr	r1,=80000A0h
	ldrb	r0,[r1,0Fh]
	cmp	r0,4Ah
	bne	@@setEnglish

	// Detect EXE6 fan translation
	ldr	r1,=87FF4FCh
	ldr	r0,[r1]
	ldr	r2,=52414345h	// ECAR
	cmp	r0,r2
	bne	@@end

	ldr	r0,[r1,4h]
	ldr	r2,=4E455F44h	// D_EN
	cmp	r0,r2
	bne	@@end

	@@setEnglish:
	add	r4,@@english-@@japanese

	@@end:
	mov	r15,r14
	.pool
.endif

@@japanese:
.if lang == 0 || (game_code >> 8) == 0x425235		// if JP or BN6
	.table table_file_jp

	.if card_game_desc_jp_len >= 1
		.strn	card_game_desc_jp_1
	.endif

	.if card_game_desc_jp_len >= 2
		.db	0xE9
		.strn	card_game_desc_jp_2
	.endif

	.if card_game_desc_jp_len >= 3
		.db	0xE9
		.strn	card_game_desc_jp_3
	.endif
.endif

.if (game_code >> 8) == 0x425235			// if BN6
	.db	0xE7,0x00
	.db	0xEE,0xFF,0x00,0x00
.endif

@@english:
.if lang != 0 || (game_code >> 8) == 0x425235		// if EN or BN6
	.table table_file_en

	.if card_game_desc_en_len >= 1
		.strn	card_game_desc_en_1
	.endif

	.if card_game_desc_en_len >= 2
		.db	0xE9
		.strn	card_game_desc_en_2
	.endif

	.if card_game_desc_en_len >= 3
		.db	0xE9
		.strn	card_game_desc_en_3
	.endif
.endif

.db	0xE7,0x00
.db	0xEE,0xFF,0x00,0x00
