﻿.include "defaults_item.asm"

table_file_jp		equ	"exe6-utf8.tbl"
table_file_en		equ	"bn6-utf8.tbl"
game_code_len		equ	3
game_code		equ	0x4252354A	// BR5J
game_code_2		equ	0x42523545	// BR5E
game_code_3		equ	0x42523550	// BR5P
card_type		equ	0
card_id			equ	5
card_no			equ	"005"
card_sub		equ	"Item Card 005"
card_sub_x		equ	62
card_desc_len		equ	2
card_desc_1		equ	"Yai's Prized Rare"
card_desc_2		equ	"Chips"
card_desc_3		equ	""
card_name_jp_full	equ	"やいとの自慢のレアチップ"
card_name_jp_game	equ	"やいとのじまんのレアチップ"
card_name_en_full	equ	"Yai's Prized Rare Chips"
card_name_en_game	equ	"Yai's Prized Rare Chips"

card_game_desc_jp_len	equ	3
card_game_desc_jp_1	equ	"やいとのじまんのレアチップ!"
card_game_desc_jp_2	equ	"リュウセイグン･オジゾウサン"
card_game_desc_jp_3	equ	"フルカスタム を手に入れた!"
card_game_desc_en_len	equ	3
card_game_desc_en_1	equ	"Yai's prized rare"
card_game_desc_en_2	equ	"chips! Got Meteors,"
card_game_desc_en_3	equ	"Guardian and FullCust!"