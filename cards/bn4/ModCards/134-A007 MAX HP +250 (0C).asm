﻿.include "defaults_mod.asm"

table_file_jp		equ	"exe4-utf8.tbl"
table_file_en		equ	"bn4-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4234574A	// B4WJ
game_code_2		equ	0x42345745	// B4WE
game_code_3		equ	0x42345750	// B4WP
card_type		equ	1
card_id			equ	7
card_no			equ	"007"
card_sub		equ	"Mod Card 007"
card_sub_x		equ	64
card_desc_len		equ	2
card_desc_1		equ	"Address 0C"
card_desc_2		equ	"MAX HP +250"
card_desc_3		equ	""
card_name_jp_full	equ	"マックスHP+250"
card_name_jp_game	equ	"マックスHP+250"
card_name_en_full	equ	"MAX HP +250"
card_name_en_game	equ	"MAX HP +250"

card_address		equ	"0C"
card_address_id		equ	2
card_bug		equ	0
card_wrote_en		equ	"MAX HP +250"
card_wrote_jp		equ	"マックスHPが+250された"