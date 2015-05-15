.include defaults_item.asm

table_file_jp		equ	"exe6-utf8.tbl"
table_file_en		equ	"bn6-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252354A	// BR5J
game_code_2		equ	0x42523545	// BR5E
game_code_3		equ	0x42523550	// BR5P
card_type		equ	0
card_id			equ	16
card_no			equ	"016"
card_sub		equ	"Item Card 016"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Shuko's Teaching"
card_desc_2		equ	"License"
card_desc_3		equ	""
card_name_jp_full	equ	"舟子の教育実習"
card_name_jp_game	equ	"舟子のきょういくじっしゅう"
card_name_en_full	equ	"Shuko's Teaching License"
card_name_en_game	equ	"Shuko's Teaching License"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"舟子のきょういくじっしゅう!"
card_game_desc_jp_2	equ	"アクアマンのナビチップ"
card_game_desc_jp_3	equ	"3しゅるい を手に入れた!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Shuko's teaching"
card_game_desc_en_2	equ	"license! Got 3 types"
card_game_desc_en_3	equ	"of ",0xFA,0x00,0x06,0x08," NaviChips!"