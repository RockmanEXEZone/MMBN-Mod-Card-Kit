.include defaults_item.asm

table_file_jp		equ	"exe6-utf8.tbl"
table_file_en		equ	"bn6-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252354A	// BR5J
game_code_2		equ	0x42523545	// BR5E
game_code_3		equ	0x42523550	// BR5P
card_type		equ	0
card_id			equ	22
card_no			equ	"022"
card_sub		equ	"Item Card 022"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Mamoru's Get Well"
card_desc_2		equ	"Gift"
card_desc_3		equ	""
card_name_jp_full	equ	"まもるのお見舞い"
card_name_jp_game	equ	"まもるのおみまい"
card_name_en_full	equ	"Mamoru's Get Well Gift"
card_name_en_game	equ	"Mamoru's Get Well Gift"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"まもるのおみまい!"
card_game_desc_jp_2	equ	"すべてのサブチップを1コずつ"
card_game_desc_jp_3	equ	"手に入れた!"
card_game_desc_en_len	equ	2
card_game_desc_en_1	equ	"Mamoru's get well gift!"
card_game_desc_en_2	equ	"Got 1 of every SubChip!"
card_game_desc_en_3	equ	""