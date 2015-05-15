.include card_info_file

.gba
.create out\text2.bin,0

.if (game_code >> 8) != 0x423457		// if BN5 or BN6
	.db	0
	.dh	eof + 4
	.db	0
.endif

.headersize 0
header:
.dh	script_0 - header

script_0:
.if (game_code >> 8) == 0x423457		// if BN4
	.if (card_type == 0)
		.include text2_chip.asm
	.endif
	.if (card_type == 1)
		.include text2_mod.asm
	.endif
.endif
.if (game_code >> 8) == 0x425242		// if BN5
	.if (card_type == 0)
		.include text2_item.asm
	.endif
	.if (card_type == 1)
		.include text2_mod.asm
	.endif
	.if (card_type == 2)
		.include text2_chip.asm
	.endif
.endif
.if (game_code >> 8) == 0x425235		// if BN6
	.if (card_type == 0)
		.include text2_item.asm
	.endif
	.if (card_type == 1)
		.include text2_mod.asm
	.endif
	.if (card_type == 2)
		.include text2_chip.asm
	.endif
	.if (card_type == 4)
		.include text2_request.asm
	.endif
.endif

eof:
.close
