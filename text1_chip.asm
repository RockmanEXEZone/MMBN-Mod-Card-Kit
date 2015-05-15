.if lang == 0				// if JP
	.table	table_file_jp
	.strn	card_name_jp_game
.else					// if EN
	.table	table_file_en
	.strn	card_name_en_game
.endif

.if (game_code >> 8) == 0x423457	// if BN4
	.db	0xE5
.else					// if BN5 or BN6
	.db	0xE6
.endif
