.include defaults_item.asm

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	37
card_no			equ	"037"
card_sub		equ	"Item Card 037"
card_sub_x		equ	62
card_desc_len		equ	1
card_desc_1		equ	"Higsby's Bargain Bin"
card_desc_2		equ	""
card_desc_3		equ	""
card_name_jp_full	equ	"日暮さんのワゴンセール"
card_name_jp_game	equ	"日暮さんのワゴンセール"
card_name_en_full	equ	"Higsby's Bargain Bin"
card_name_en_game	equ	"Higsby's Bargain Bin"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"日暮さんのワゴンセール!"
card_game_desc_jp_2	equ	"ナンバーマンのナビチップ"
card_game_desc_jp_3	equ	"3しゅるいを手に入れた!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Higsby's bargain bin!"
card_game_desc_en_2	equ	"Got 3 types of"
card_game_desc_en_3	equ	"NumberMan NaviChips!"