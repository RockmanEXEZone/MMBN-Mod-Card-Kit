.include "defaults_request.asm"

table_file_jp		equ	"exe6-utf8.tbl"
table_file_en		equ	"bn6-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252354A	// BR5J
game_code_2		equ	0x42523545	// BR5E
game_code_3		equ	0x42523550	// BR5P
card_type		equ	4
card_id			equ	4
card_no			equ	"004"
card_sub		equ	"Request Event Card 004"
card_sub_x		equ	32
card_name_jp_full	equ	"ペンギンが逃げ出した!"
card_name_jp_game	equ	"ペンギンがにげだした!"
card_name_en_full	equ	"Penguins Ran Away"
card_name_en_game	equ	"PenguinsRanAway"
card_desc_len		equ	1
card_desc_1		equ	"Penguins Ran Away"
card_desc_2		equ	""
card_desc_3		equ	""