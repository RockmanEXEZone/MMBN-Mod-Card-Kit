.include "defaults_chip.asm"

table_file_jp		equ	"exe4-utf8.tbl"
table_file_en		equ	"bn4-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4234574A	// B4WJ
game_code_2		equ	0x42345745	// B4WE
game_code_3		equ	0x42345750	// B4WP
card_type		equ	0
card_id			equ	1
card_no			equ	"001"
card_sub		equ	"Rare Chip Data Distribution!"
card_sub_x		equ	20
card_name_jp_full	equ	"グランプリパワー G"
card_name_jp_game	equ	"グランプリパワー"
card_name_en_full	equ	"PrixPowr G"
card_name_en_game	equ	"PrixPowr"
card_desc_len		equ	1
card_desc_1		equ	"PrixPowr G"
card_desc_2		equ	""
card_desc_3		equ	""

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"グランプリをとった"
card_game_desc_jp_2	equ	"3体のナビたちの"
card_game_desc_jp_3	equ	"ゆめのきょうえん!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"GrandPrix"
card_game_desc_en_2	equ	"3 Navis"
card_game_desc_en_3	equ	"atk tgthr"

card_chip_img		equ	"img_prixpowr.bin"
card_chip_pal		equ	"pal_prixpowr.bin"
card_chip_icon		equ	"icon_prixpowr.bin"
card_chip_name_img	equ	"prixpowr.img.bin"
card_chip_name_pal	equ	"prixpowr.pal.bin"