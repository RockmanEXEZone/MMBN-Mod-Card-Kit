.if (game_code >> 8) == 0x423457		// if BN4
	.db	0xF6,0x02,0x39,0x6C,0x03
	.db	0xF0,0x00,0x00
.else						// if BN5 or BN6
	.db	0xF7,0x02,0x39,0x6C,0x03
	.db	0xF1,0x00,0x00
.endif

.if lang == 0					// if JP
	.table	table_file_jp
	.strn	"改造ナンバー",card_no
.else						// if EN
	.table	table_file_en
	.strn	"Mod "

	.if (game_code >> 8) == 0x423457	// if BN4
		.db	0x66			// '#'
	.else
		.strn	"No."
	.endif

	.strn	card_no
.endif

.if (game_code >> 8) == 0x423457		// if BN4
	.db	0xE8

	.if lang == 0				// if JP
		.table	table_file_jp
		.strn	card_name_jp_game
	.else					// if EN
		.table	table_file_en
		.strn	card_name_en_game
	.endif

	.if (card_bug != 0)
		.db	0xE8

		.if lang == 0			// if JP
			.table	table_file_jp
			.strn	"バグあり"
		.else				// if EN
			.table	table_file_en
			.strn	"Buggy"
		.endif
	.endif

	.db	0xED,0xFF,0x00,0x00
.else						// if BN5 or BN6
	.db	0xEE,0xFF,0x00,0x00
.endif
