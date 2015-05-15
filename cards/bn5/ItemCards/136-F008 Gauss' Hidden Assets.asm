.include defaults_item.asm

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	28
card_no			equ	"028"
card_sub		equ	"Item Card 028"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Gauss' Hidden"
card_desc_2		equ	"Assets"
card_desc_3		equ	""
card_name_jp_full	equ	"ガウスの隠し資産"
card_name_jp_game	equ	"ガウスのかくししさん"
card_name_en_full	equ	"Gauss' Hidden Assets"
card_name_en_game	equ	"Gauss' Hidden Assets"

card_game_desc_jp_len	equ	2
card_game_desc_jp_1	equ	"ガウスのかくししさん!"
card_game_desc_jp_2	equ	"30000Zを手に入れた!"
card_game_desc_jp_3	equ	""
card_game_desc_en_len	equ	2
card_game_desc_en_1	equ	"Gauss' hidden assets!"
card_game_desc_en_2	equ	"Got 30000 Zennys!"
card_game_desc_en_3	equ	""