.include "defaults_item.asm"

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	21
card_no			equ	"021"
card_sub		equ	"Item Card 021"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Dr. Froid's Data"
card_desc_2		equ	"Filter"
card_desc_3		equ	""
card_name_jp_full	equ	"氷川さんのデータ整理"
card_name_jp_game	equ	"ひかわさんのデータせいり"
card_name_en_full	equ	"Dr. Froid's Data Filter"
card_name_en_game	equ	"Dr.Froid's Data Filter"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"ひかわさんのデータせいり!"
card_game_desc_jp_2	equ	"バブルラップY､アイスシード*"
card_game_desc_jp_3	equ	"オーシャンシード*を手に入れた!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Dr.Froid's data filter!"
card_game_desc_en_2	equ	"Got SeaSeed *,IceSeed *"
card_game_desc_en_3	equ	"and BblWrap Y!"