.include "defaults_mod.asm"

table_file_jp		equ	"exe4-utf8.tbl"
table_file_en		equ	"bn4-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4234574A	// B4WJ
game_code_2		equ	0x42345745	// B4WE
game_code_3		equ	0x42345750	// B4WP
card_type		equ	1
card_id			equ	107
card_no			equ	"107"
card_sub		equ	"Mod Card 107"
card_sub_x		equ	64
card_desc_len		equ	2
card_desc_1		equ	"Address 0A"
card_desc_2		equ	"Buster Flower"
card_desc_3		equ	""
card_name_jp_full	equ	"バスターフラワー"
card_name_jp_game	equ	"バスターフラワー"
card_name_en_full	equ	"Buster Flower"
card_name_en_game	equ	"Buster Flower"

card_address		equ	"0A"
card_address_id		equ	0
card_bug		equ	0
card_wrote_en		equ	"Buster Flower"
card_wrote_jp		equ	"バスターフラワー"