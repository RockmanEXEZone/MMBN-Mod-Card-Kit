.include defaults_item.asm

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	29
card_no			equ	"029"
card_sub		equ	"Item Card 029"
card_sub_x		equ	62
card_desc_len		equ	1
card_desc_1		equ	"Tamako's Souvenirs"
card_desc_2		equ	""
card_desc_3		equ	""
card_name_jp_full	equ	"たま子のおみやげ"
card_name_jp_game	equ	"たま子のおみやげ"
card_name_en_full	equ	"Tamako's Souvenirs"
card_name_en_game	equ	"Tamako's Souvenirs"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"たま子のおみやげ!"
card_game_desc_jp_2	equ	"ホウガン*､エアホッケーS"
card_game_desc_jp_3	equ	"アースクエイク1Pを手に入れた!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Tamako's souvenirs!"
card_game_desc_en_2	equ	"Got CannBall *,AirHoc S"
card_game_desc_en_3	equ	"and Quake1 P!"