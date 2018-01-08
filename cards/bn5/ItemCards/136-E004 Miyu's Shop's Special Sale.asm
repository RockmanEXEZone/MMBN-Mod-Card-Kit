.include "defaults_item.asm"

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	4
card_no			equ	"004"
card_sub		equ	"Item Card 004"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Miyu's Shop's"
card_desc_2		equ	"Special Sale"
card_desc_3		equ	""
card_name_jp_full	equ	"みゆきの店の特売日"
card_name_jp_game	equ	"みゆきのみせのとくばいび"
card_name_en_full	equ	"Miyu's Shop's Special Sale"
card_name_en_game	equ	"Miyu's Shop's Special Sale"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"みゆきのみせのとくばいび!"
card_game_desc_jp_2	equ	"スカルチェーン1C､"
card_game_desc_jp_3	equ	"スカルチェーン2A､",0xE7,0x00,0xF2,"スカルチェーン3Gを手に入れた!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Miyu's shop's special"
card_game_desc_en_2	equ	"sale! Got Skully1 C,"
card_game_desc_en_3	equ	"Skully2 A and Skully3 G!"