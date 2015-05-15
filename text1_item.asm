.db	0xF7,0x02,0x39,0x6C,0x03
.db	0xF1,0x00,0x00

.if lang == 0					// if JP
	.table	table_file_jp
	.strn	"アイテムナンバー",card_no
.else						// if EN
	.table	table_file_en
	.strn	"Item No.",card_no
.endif

.if (game_code >> 8) == 0x425242		// if BN5
	.db	0xE9
	.if lang == 0				// if JP
		.table	table_file_jp
		.strn	card_name_jp_game
	.else					// if EN
		.table	table_file_en
		.strn	card_name_en_game
	.endif
.endif

.db	0xEE,0xFF,0x00,0x00
