.include defaults_item.asm

table_file_jp		equ	"exe6-utf8.tbl"
table_file_en		equ	"bn6-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252354A	// BR5J
game_code_2		equ	0x42523545	// BR5E
game_code_3		equ	0x42523550	// BR5P
card_type		equ	0
card_id			equ	27
card_no			equ	"027"
card_sub		equ	"Item Card 027"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Yuika's Show Tour"
card_desc_2		equ	"Fee"
card_desc_3		equ	""
card_name_jp_full	equ	"チロルのショー見物料"
card_name_jp_game	equ	"チロルのショーけんぶつりょう"
card_name_en_full	equ	"Yuika's Show Tour Fee"
card_name_en_game	equ	"Yuika's Show Tour Fee"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"チロルのショーけんぶつりょう!"
card_game_desc_jp_2	equ	"500ゼニー"
card_game_desc_jp_3	equ	"を手に入れた!"
card_game_desc_en_len	equ	2
card_game_desc_en_1	equ	"Yuika's show tour fee!"
card_game_desc_en_2	equ	"Got 500 Zennys!"
card_game_desc_en_3	equ	""