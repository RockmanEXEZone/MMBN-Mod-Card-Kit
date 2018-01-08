.include "defaults_item.asm"

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	12
card_no			equ	"012"
card_sub		equ	"Item Card 012"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Viddy Narcy's"
card_desc_2		equ	"Costume Fees"
card_desc_3		equ	""
card_name_jp_full	equ	"ナルシー・ヒデの衣装代"
card_name_jp_game	equ	"ナルシー･ヒデのいしょうだい"
card_name_en_full	equ	"Viddy's Narcy Costume Fees"
card_name_en_game	equ	"Viddy's Narcy Costume Fees"

card_game_desc_jp_len	equ	2
card_game_desc_jp_1	equ	"ナルシー･ヒデのいしょうだい!"
card_game_desc_jp_2	equ	"8000Zを手に入れた!"
card_game_desc_jp_3	equ	""
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Viddy Narcy's"
card_game_desc_en_2	equ	"costume fees!"
card_game_desc_en_3	equ	"Got 8000 Zennys!"