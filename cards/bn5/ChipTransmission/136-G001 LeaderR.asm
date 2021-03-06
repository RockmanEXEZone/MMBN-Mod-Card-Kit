﻿.include "defaults_chip.asm"

table_file_jp		equ	"exe5-utf8.tbl"
table_file_en		equ	"bn5-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252424A	// BRBJ
game_code_2		equ	0x42524245	// BRBE
game_code_3		equ	0x42524250	// BRBP
card_type		equ	2
card_id			equ	1
card_no			equ	"001"
card_sub		equ	"Rare Chip Data Distribution!"
card_sub_x		equ	20
card_name_jp_full	equ	"リーダーズレイド L"
card_name_jp_game	equ	"リーダーズレイド"
card_name_en_full	equ	"LeaderR L"
card_name_en_game	equ	"LeaderR"
card_desc_len		equ	1
card_desc_1		equ	"LeaderR L"
card_desc_2		equ	""
card_desc_3		equ	""

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"ブルースとカーネル"
card_game_desc_jp_2	equ	"リーダーどうしが"
card_game_desc_jp_3	equ	"ゆめのきょうえん!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"ProtoMan"
card_game_desc_en_2	equ	"& Colonel"
card_game_desc_en_3	equ	"together!"

card_chip_img		equ	"img_leaderr.bin"
card_chip_pal		equ	"pal_leaderr.bin"
card_chip_icon		equ	"dummy.bin"
card_chip_name_img	equ	"leaderr.img.bin"
card_chip_name_pal	equ	"leaderr.pal.bin"