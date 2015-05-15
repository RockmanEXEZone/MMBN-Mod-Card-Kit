.include defaults_item.asm

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	34
card_no			equ	"034"
card_sub		equ	"Item Card 34"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Shuko's Wallet"
card_desc_2		equ	"Contents"
card_desc_3		equ	""
card_name_jp_full	equ	"城戸舟子の財布の中身"
card_name_jp_game	equ	"きどふなごのさいふのなかみ"
card_name_en_full	equ	"Shuko's Wallet Contents"
card_name_en_game	equ	"Shuko's Wallet Contents"

card_game_desc_jp_len	equ	2
card_game_desc_jp_1	equ	"きどふなごのさいふのなかみ!"
card_game_desc_jp_2	equ	"300Zを手に入れた!"
card_game_desc_jp_3	equ	""
card_game_desc_en_len	equ	2
card_game_desc_en_1	equ	"Shuko's wallet contents!"
card_game_desc_en_2	equ	"Got 300 Zennys!"
card_game_desc_en_3	equ	""