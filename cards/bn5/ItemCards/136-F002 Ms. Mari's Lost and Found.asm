.include "defaults_item.asm"

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	22
card_no			equ	"022"
card_sub		equ	"Item Card 022"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Ms. Mari's Lost and"
card_desc_2		equ	"Found"
card_desc_3		equ	""
card_name_jp_full	equ	"まり子先生の忘れ物"
card_name_jp_game	equ	"まり子先生のわすれもの"
card_name_en_full	equ	"Ms. Mari's Lost and Found"
card_name_en_game	equ	"Ms.Mari's Lost and Found"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"まり子先生のわすれもの!"
card_game_desc_jp_2	equ	"すべてのサブチップを1コずつ"
card_game_desc_jp_3	equ	"手に入れた!"
card_game_desc_en_len	equ	2
card_game_desc_en_1	equ	"Ms.Mari's lost and found!"
card_game_desc_en_2	equ	"Got 1 of every SubChip!"
card_game_desc_en_3	equ	""