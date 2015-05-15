.include defaults_chip.asm

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	2
card_id			equ	2
card_no			equ	"002"
card_sub		equ	"Rare Chip Data Distribution!"
card_sub_x		equ	20
card_name_jp_full	equ	"ロードオブカオス X"
card_name_jp_game	equ	"ロードオブカオス"
card_name_en_full	equ	"ChaosL X"
card_name_en_game	equ	"ChaosL"
card_desc_len		equ	1
card_desc_1		equ	"ChaosL X"
card_desc_2		equ	""
card_desc_3		equ	""

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"にくしみのパワーが"
card_game_desc_jp_2	equ	"フォルテにへんしん"
card_game_desc_jp_3	equ	"カオスナイトメア!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Hatred"
card_game_desc_en_2	equ	"formed"
card_game_desc_en_3	equ	"into Bass"

card_chip_img		equ	img_chaosl.bin
card_chip_pal		equ	pal_chaosl.bin
card_chip_icon		equ	dummy.bin
card_chip_name_img	equ	chaosl.img.bin
card_chip_name_pal	equ	chaosl.pal.bin