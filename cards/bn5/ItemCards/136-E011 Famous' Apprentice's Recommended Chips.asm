.include defaults_item.asm

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	0
card_id			equ	11
card_no			equ	"011"
card_sub		equ	"Item Card 011"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Famous' Apprentice's"
card_desc_2		equ	"Recommended Chips"
card_desc_3		equ	""
card_name_jp_full	equ	"名人見習いのオススメチップ"
card_name_jp_game	equ	"名人みならいのオススメチップ"
card_name_en_full	equ	"Famous' Apprentice's Recommended Chips"
card_name_en_game	equ	"Famous' Apprentice's Recommended Chips"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"名人みならいのオススメチップ!"
card_game_desc_jp_2	equ	"トップウ*､パネルリターン*､"
card_game_desc_jp_3	equ	"ホーリーパネル*を手に入れた!"
card_game_desc_en_len	equ	3
// oh god, why
card_game_desc_en_1	equ	"Famous' apprentice's"
card_game_desc_en_2	equ	"recommended chips!"
card_game_desc_en_3	equ	"Got Wind *,PnlRetrn *,",0xE7,0x00,0xF2,"and HolyPanl *!"