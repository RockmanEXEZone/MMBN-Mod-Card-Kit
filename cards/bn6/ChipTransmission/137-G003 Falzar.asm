.include defaults_chip.asm

table_file_jp		equ	"exe6-utf8.tbl"
table_file_en		equ	"bn6-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252354A	// BR5J
game_code_2		equ	0x42523545	// BR5E
game_code_3		equ	0x42523550	// BR5P
card_type		equ	2
card_id			equ	3
card_no			equ	"003"
card_sub		equ	"Rare Chip Data Distribution!"
card_sub_x		equ	20
card_name_jp_full	equ	"ファルザー X"
card_name_jp_game	equ	"ファルザー"
card_name_en_full	equ	"Falzar X"
card_name_en_game	equ	"Falzar"
card_desc_len		equ	1
card_desc_1		equ	"Falzar X"
card_desc_2		equ	""
card_desc_3		equ	""

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"電脳獣ファルザーが"
card_game_desc_jp_2	equ	"トルネード攻撃!"
card_game_desc_jp_3	equ	"すべてをふきとばす"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Falzar's"
card_game_desc_en_2	equ	"storming"
card_game_desc_en_3	equ	"tornado!"

card_chip_img		equ	img_falzar.bin
card_chip_pal		equ	pal_falzar.bin
card_chip_icon		equ	dummy.bin
card_chip_name_img	equ	falzar.img.bin
card_chip_name_pal	equ	falzar.pal.bin