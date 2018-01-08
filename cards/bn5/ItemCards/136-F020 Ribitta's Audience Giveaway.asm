.include "defaults_item.asm"

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	40
card_no			equ	"040"
card_sub		equ	"Item Card 040"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Ribitta's Audience"
card_desc_2		equ	"Giveaway"
card_desc_3		equ	""
card_name_jp_full	equ	"ケロの視聴者プレゼント"
card_name_jp_game	equ	"ケロのしちょうしゃプレゼント"
card_name_en_full	equ	"Ribitta's Audience Giveaway"
card_name_en_game	equ	"Ribitta's Audience Giveaway"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"ケロのしちょうしゃプレゼント!"
card_game_desc_jp_2	equ	"トードマンのナビチップ"
card_game_desc_jp_3	equ	"3しゅるいを手に入れた!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Ribitta's audience"
card_game_desc_en_2	equ	"giveaway! Got 3 types"
card_game_desc_en_3	equ	"of ToadMan NaviChips!"