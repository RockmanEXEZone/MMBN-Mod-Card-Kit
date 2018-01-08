.include "defaults_item.asm"

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	13
card_no			equ	"013"
card_sub		equ	"Item Card 013"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Atsuki's Festival"
card_desc_2		equ	"of Flames"
card_desc_3		equ	""
card_name_jp_full	equ	"火村アツキのメラメラ祭り"
card_name_jp_game	equ	"ひむらアツキのメラメラまつり"
card_name_en_full	equ	"Atsuki's Festival of Flames"
card_name_en_game	equ	"Atsuki's Festival of Flames"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"ひむらアツキのメラメラまつり!"
card_game_desc_jp_2	equ	"ブラックボムZ､"
card_game_desc_jp_3	equ	"メテオアース1T､",0xE7,0x00,0xF2,"カキゲンキン*を手に入れた!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Atsuki's Festival of"
card_game_desc_en_2	equ	"Flames! Got BlkBomb Z,"
card_game_desc_en_3	equ	"Astroid1 T & AntiFire *!"