.if lang == 0						// if JP
	.table table_file_jp

	.if card_game_desc_jp_len >= 1
		.strn	card_game_desc_jp_1
	.endif

	.if card_game_desc_jp_len >= 2
		.if (game_code >> 8) == 0x423457	// if BN4
			.db	0xE8
		.else					// if BN5 or BN6
			.db	0xE9
		.endif
		.strn	card_game_desc_jp_2
	.endif

	.if card_game_desc_jp_len >= 3
		.if (game_code >> 8) == 0x423457	// if BN4
			.db	0xE8
		.else					// if BN5 or BN6
			.db	0xE9
		.endif
		.strn	card_game_desc_jp_3
	.endif
.else							// if EN
	.table table_file_en

	.if card_game_desc_jp_len >= 1
		.strn	card_game_desc_en_1
	.endif

	.if card_game_desc_en_len > 1
		.if (game_code >> 8) == 0x423457	// if BN4
			.db	0xE8
		.else					// if BN5 or BN6
			.db	0xE9
		.endif
		.strn	card_game_desc_en_2
	.endif

	.if card_game_desc_en_len > 2
		.if (game_code >> 8) == 0x423457	// if BN4
			.db	0xE8
		.else					// if BN5 or BN6
			.db	0xE9
		.endif
		.strn	card_game_desc_en_3
	.endif
.endif

.if (game_code >> 8) == 0x423457			// if BN4
	.db	0xE5
.else							// if BN5 or BN6
	.db	0xE6
.endif
