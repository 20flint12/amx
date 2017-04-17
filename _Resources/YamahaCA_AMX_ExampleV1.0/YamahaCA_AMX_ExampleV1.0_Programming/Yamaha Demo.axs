PROGRAM_NAME='Yamaha Demo'
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

#INCLUDE 'Queue_and_Threshold_Sizes.axi'
#INCLUDE 'UnicodeLib.axi'

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvDebug					= 0:1:0					// programming port

dvIP01					= 0:5:0
dvIP02					= 0:6:0
dvIP03					= 0:7:0
dvIP04					= 0:8:0

dvMIDI					= 90:1:0				// AXB-MIDI

dvSerial1				= 5001:1:0				// NI-700
dvSerial2				= 5001:2:0
dvIR					= 5001:3:0
dvIO					= 5001:4:0
dvIRIn					= 5001:5:0

dvPanel					= 10001:1:0
dvPanelProduct1			= 10001:2:0
dvPanelProduct2			= 10001:3:0
dvPanelProduct3			= 10001:4:0
dvPanelProduct4			= 10001:5:0
dvPanelProduct5			= 10001:6:0
dvPanelProduct6			= 10001:7:0
dvPanelProduct7			= 10001:8:0
dvPanelProduct8			= 10001:9:0
dvPanelProduct9			= 10001:10:0
dvPanelProduct10		= 10001:11:0
dvPanelProduct11		= 10001:12:0
dvPanelProduct12		= 10001:13:0
dvPanelProduct13		= 10001:14:0
dvPanelProduct14		= 10001:15:0
dvPanelProduct15		= 10001:16:0

vdvProduct1				= 33001:1:0
vdvProduct1Parameter1	= 33001:2:0
vdvProduct1Parameter2	= 33001:3:0
vdvProduct1Parameter3	= 33001:4:0
vdvProduct1Parameter4	= 33001:5:0
vdvProduct1Parameter5	= 33001:6:0
vdvProduct1Parameter6	= 33001:7:0
vdvProduct1Parameter7	= 33001:8:0
vdvProduct1Parameter8	= 33001:9:0
vdvProduct1Parameter9	= 33001:10:0
vdvProduct1Parameter10	= 33001:11:0
vdvProduct1Parameter11	= 33001:12:0
vdvProduct1Parameter12	= 33001:13:0
vdvProduct1Parameter13	= 33001:14:0
vdvProduct1Parameter14	= 33001:15:0
vdvProduct1Parameter15	= 33001:16:0
vdvProduct1Parameter16	= 33001:17:0
vdvProduct1Parameter17	= 33001:18:0
vdvProduct1Parameter18	= 33001:19:0
vdvProduct1Parameter19	= 33001:20:0
vdvProduct1Parameter20	= 33001:21:0
vdvProduct1Parameter21	= 33001:22:0
vdvProduct1Parameter22	= 33001:23:0
vdvProduct1Parameter23	= 33001:24:0
vdvProduct1Parameter24	= 33001:25:0
vdvProduct1Parameter25	= 33001:26:0
vdvProduct1Parameter26	= 33001:27:0
vdvProduct1Parameter27	= 33001:28:0
vdvProduct1Parameter28	= 33001:29:0
vdvProduct1Parameter29	= 33001:30:0
vdvProduct1Parameter30	= 33001:31:0
vdvProduct1Parameter31	= 33001:32:0
vdvProduct1Parameter32	= 33001:33:0
vdvProduct1Parameter33	= 33001:34:0
vdvProduct1Parameter34	= 33001:35:0
vdvProduct1Parameter35	= 33001:36:0
vdvProduct1Parameter36	= 33001:37:0
vdvProduct1Parameter37	= 33001:38:0
vdvProduct1Parameter38	= 33001:39:0
vdvProduct1Parameter39	= 33001:40:0
vdvProduct1Parameter40	= 33001:41:0
vdvProduct1Parameter41	= 33001:42:0
vdvProduct1Parameter42	= 33001:43:0
vdvProduct1Parameter43	= 33001:44:0
vdvProduct1Parameter44	= 33001:45:0
vdvProduct1Parameter45	= 33001:46:0
vdvProduct1Parameter46	= 33001:47:0
vdvProduct1Parameter47	= 33001:48:0
vdvProduct1Parameter48	= 33001:49:0
vdvProduct1Parameter49	= 33001:50:0
vdvProduct1Parameter50	= 33001:51:0
vdvProduct1Parameter51	= 33001:52:0
vdvProduct1Parameter52	= 33001:53:0
vdvProduct1Parameter53	= 33001:54:0
vdvProduct1Parameter54	= 33001:55:0
vdvProduct1Parameter55	= 33001:56:0
vdvProduct1Parameter56	= 33001:57:0
vdvProduct1Parameter57	= 33001:58:0
vdvProduct1Parameter58	= 33001:59:0
vdvProduct1Parameter59	= 33001:60:0
vdvProduct1Parameter60	= 33001:61:0
vdvProduct1Parameter61	= 33001:62:0
vdvProduct1Parameter62	= 33001:63:0
vdvProduct1Parameter63	= 33001:64:0
vdvProduct1Parameter64	= 33001:65:0
vdvProduct1Parameter65	= 33001:66:0
vdvProduct1Parameter66	= 33001:67:0
vdvProduct1Parameter67	= 33001:68:0
vdvProduct1Parameter68	= 33001:69:0
vdvProduct1Parameter69	= 33001:70:0
vdvProduct1Parameter70	= 33001:71:0
vdvProduct1Parameter71	= 33001:72:0
vdvProduct1Parameter72	= 33001:73:0
vdvProduct1Parameter73	= 33001:74:0
vdvProduct1Parameter74	= 33001:75:0
vdvProduct1Parameter75	= 33001:76:0
vdvProduct1Parameter76	= 33001:77:0
vdvProduct1Parameter77	= 33001:78:0
vdvProduct1Parameter78	= 33001:79:0
vdvProduct1Parameter79	= 33001:80:0
vdvProduct1Parameter80	= 33001:81:0
vdvProduct1Parameter81	= 33001:82:0
vdvProduct1Parameter82	= 33001:83:0
vdvProduct1Parameter83	= 33001:84:0
vdvProduct1Parameter84	= 33001:85:0
vdvProduct1Parameter85	= 33001:86:0
vdvProduct1Parameter86	= 33001:87:0
vdvProduct1Parameter87	= 33001:88:0
vdvProduct1Parameter88	= 33001:89:0
vdvProduct1Parameter89	= 33001:90:0
vdvProduct1Parameter90	= 33001:91:0
vdvProduct1Parameter91	= 33001:92:0
vdvProduct1Parameter92	= 33001:93:0
vdvProduct1Parameter93	= 33001:94:0
vdvProduct1Parameter94	= 33001:95:0
vdvProduct1Parameter95	= 33001:96:0
vdvProduct1Parameter96	= 33001:97:0
vdvProduct1Parameter97	= 33001:98:0
vdvProduct1Parameter98	= 33001:99:0
vdvProduct1Parameter99	= 33001:100:0
vdvProduct1Parameter100	= 33001:101:0
vdvProduct1Parameter101	= 33001:102:0
vdvProduct1Parameter102	= 33001:103:0
vdvProduct1Parameter103	= 33001:104:0
vdvProduct1Parameter104	= 33001:105:0
vdvProduct1Parameter105	= 33001:106:0
vdvProduct1Parameter106	= 33001:107:0
vdvProduct1Parameter107	= 33001:108:0
vdvProduct1Parameter108	= 33001:109:0
vdvProduct1Parameter109	= 33001:110:0
vdvProduct1Parameter110	= 33001:111:0
vdvProduct1Parameter111	= 33001:112:0
vdvProduct1Parameter112	= 33001:113:0
vdvProduct1Parameter113	= 33001:114:0
vdvProduct1Parameter114	= 33001:115:0
vdvProduct1Parameter115	= 33001:116:0
vdvProduct1Parameter116	= 33001:117:0
vdvProduct1Parameter117	= 33001:118:0
vdvProduct1Parameter118	= 33001:119:0
vdvProduct1Parameter119	= 33001:120:0
vdvProduct1Parameter120	= 33001:121:0
vdvProduct1Parameter121	= 33001:122:0
vdvProduct1Parameter122	= 33001:123:0
vdvProduct1Parameter123	= 33001:124:0
vdvProduct1Parameter124	= 33001:125:0
vdvProduct1Parameter125	= 33001:126:0
vdvProduct1Parameter126	= 33001:127:0
vdvProduct1Parameter127	= 33001:128:0
vdvProduct1Parameter128	= 33001:129:0
vdvProduct1Parameter129	= 33001:130:0
vdvProduct1Parameter130	= 33001:131:0
vdvProduct1Parameter131	= 33001:132:0
vdvProduct1Parameter132	= 33001:133:0
vdvProduct1Parameter133	= 33001:134:0
vdvProduct1Parameter134	= 33001:135:0
vdvProduct1Parameter135	= 33001:136:0
vdvProduct1Parameter136	= 33001:137:0
vdvProduct1Parameter137	= 33001:138:0
vdvProduct1Parameter138	= 33001:139:0
vdvProduct1Parameter139	= 33001:140:0
vdvProduct1Parameter140	= 33001:141:0
vdvProduct1Parameter141	= 33001:142:0
vdvProduct1Parameter142	= 33001:143:0
vdvProduct1Parameter143	= 33001:144:0
vdvProduct1Parameter144	= 33001:145:0
vdvProduct1Parameter145	= 33001:146:0
vdvProduct1Parameter146	= 33001:147:0
vdvProduct1Parameter147	= 33001:148:0
vdvProduct1Parameter148	= 33001:149:0
vdvProduct1Parameter149	= 33001:150:0
vdvProduct1Parameter150	= 33001:151:0

vdvProduct2				= 33002:1:0
vdvProduct2Parameter1	= 33002:2:0
vdvProduct2Parameter2	= 33002:3:0
vdvProduct2Parameter3	= 33002:4:0
vdvProduct2Parameter4	= 33002:5:0
vdvProduct2Parameter5	= 33002:6:0
vdvProduct2Parameter6	= 33002:7:0
vdvProduct2Parameter7	= 33002:8:0
vdvProduct2Parameter8	= 33002:9:0
vdvProduct2Parameter9	= 33002:10:0
vdvProduct2Parameter10	= 33002:11:0
vdvProduct2Parameter11	= 33002:12:0
vdvProduct2Parameter12	= 33002:13:0
vdvProduct2Parameter13	= 33002:14:0
vdvProduct2Parameter14	= 33002:15:0
vdvProduct2Parameter15	= 33002:16:0
vdvProduct2Parameter16	= 33002:17:0
vdvProduct2Parameter17	= 33002:18:0
vdvProduct2Parameter18	= 33002:19:0
vdvProduct2Parameter19	= 33002:20:0
vdvProduct2Parameter20	= 33002:21:0
vdvProduct2Parameter21	= 33002:22:0
vdvProduct2Parameter22	= 33002:23:0
vdvProduct2Parameter23	= 33002:24:0
vdvProduct2Parameter24	= 33002:25:0
vdvProduct2Parameter25	= 33002:26:0
vdvProduct2Parameter26	= 33002:27:0
vdvProduct2Parameter27	= 33002:28:0
vdvProduct2Parameter28	= 33002:29:0
vdvProduct2Parameter29	= 33002:30:0
vdvProduct2Parameter30	= 33002:31:0
vdvProduct2Parameter31	= 33002:32:0
vdvProduct2Parameter32	= 33002:33:0
vdvProduct2Parameter33	= 33002:34:0
vdvProduct2Parameter34	= 33002:35:0
vdvProduct2Parameter35	= 33002:36:0
vdvProduct2Parameter36	= 33002:37:0
vdvProduct2Parameter37	= 33002:38:0
vdvProduct2Parameter38	= 33002:39:0
vdvProduct2Parameter39	= 33002:40:0
vdvProduct2Parameter40	= 33002:41:0
vdvProduct2Parameter41	= 33002:42:0
vdvProduct2Parameter42	= 33002:43:0
vdvProduct2Parameter43	= 33002:44:0
vdvProduct2Parameter44	= 33002:45:0
vdvProduct2Parameter45	= 33002:46:0
vdvProduct2Parameter46	= 33002:47:0
vdvProduct2Parameter47	= 33002:48:0
vdvProduct2Parameter48	= 33002:49:0
vdvProduct2Parameter49	= 33002:50:0
vdvProduct2Parameter50	= 33002:51:0
vdvProduct2Parameter51	= 33002:52:0
vdvProduct2Parameter52	= 33002:53:0
vdvProduct2Parameter53	= 33002:54:0
vdvProduct2Parameter54	= 33002:55:0
vdvProduct2Parameter55	= 33002:56:0
vdvProduct2Parameter56	= 33002:57:0
vdvProduct2Parameter57	= 33002:58:0
vdvProduct2Parameter58	= 33002:59:0
vdvProduct2Parameter59	= 33002:60:0
vdvProduct2Parameter60	= 33002:61:0
vdvProduct2Parameter61	= 33002:62:0
vdvProduct2Parameter62	= 33002:63:0
vdvProduct2Parameter63	= 33002:64:0
vdvProduct2Parameter64	= 33002:65:0
vdvProduct2Parameter65	= 33002:66:0
vdvProduct2Parameter66	= 33002:67:0
vdvProduct2Parameter67	= 33002:68:0
vdvProduct2Parameter68	= 33002:69:0
vdvProduct2Parameter69	= 33002:70:0
vdvProduct2Parameter70	= 33002:71:0
vdvProduct2Parameter71	= 33002:72:0
vdvProduct2Parameter72	= 33002:73:0
vdvProduct2Parameter73	= 33002:74:0
vdvProduct2Parameter74	= 33002:75:0
vdvProduct2Parameter75	= 33002:76:0
vdvProduct2Parameter76	= 33002:77:0
vdvProduct2Parameter77	= 33002:78:0
vdvProduct2Parameter78	= 33002:79:0
vdvProduct2Parameter79	= 33002:80:0
vdvProduct2Parameter80	= 33002:81:0
vdvProduct2Parameter81	= 33002:82:0
vdvProduct2Parameter82	= 33002:83:0
vdvProduct2Parameter83	= 33002:84:0
vdvProduct2Parameter84	= 33002:85:0
vdvProduct2Parameter85	= 33002:86:0
vdvProduct2Parameter86	= 33002:87:0
vdvProduct2Parameter87	= 33002:88:0
vdvProduct2Parameter88	= 33002:89:0
vdvProduct2Parameter89	= 33002:90:0
vdvProduct2Parameter90	= 33002:91:0
vdvProduct2Parameter91	= 33002:92:0
vdvProduct2Parameter92	= 33002:93:0
vdvProduct2Parameter93	= 33002:94:0
vdvProduct2Parameter94	= 33002:95:0
vdvProduct2Parameter95	= 33002:96:0
vdvProduct2Parameter96	= 33002:97:0
vdvProduct2Parameter97	= 33002:98:0
vdvProduct2Parameter98	= 33002:99:0
vdvProduct2Parameter99	= 33002:100:0
vdvProduct2Parameter100	= 33002:101:0
vdvProduct2Parameter101	= 33002:102:0
vdvProduct2Parameter102	= 33002:103:0
vdvProduct2Parameter103	= 33002:104:0
vdvProduct2Parameter104	= 33002:105:0
vdvProduct2Parameter105	= 33002:106:0
vdvProduct2Parameter106	= 33002:107:0
vdvProduct2Parameter107	= 33002:108:0
vdvProduct2Parameter108	= 33002:109:0
vdvProduct2Parameter109	= 33002:110:0
vdvProduct2Parameter110	= 33002:111:0
vdvProduct2Parameter111	= 33002:112:0
vdvProduct2Parameter112	= 33002:113:0
vdvProduct2Parameter113	= 33002:114:0
vdvProduct2Parameter114	= 33002:115:0
vdvProduct2Parameter115	= 33002:116:0
vdvProduct2Parameter116	= 33002:117:0
vdvProduct2Parameter117	= 33002:118:0
vdvProduct2Parameter118	= 33002:119:0
vdvProduct2Parameter119	= 33002:120:0
vdvProduct2Parameter120	= 33002:121:0
vdvProduct2Parameter121	= 33002:122:0
vdvProduct2Parameter122	= 33002:123:0
vdvProduct2Parameter123	= 33002:124:0
vdvProduct2Parameter124	= 33002:125:0
vdvProduct2Parameter125	= 33002:126:0
vdvProduct2Parameter126	= 33002:127:0
vdvProduct2Parameter127	= 33002:128:0
vdvProduct2Parameter128	= 33002:129:0
vdvProduct2Parameter129	= 33002:130:0
vdvProduct2Parameter130	= 33002:131:0
vdvProduct2Parameter131	= 33002:132:0
vdvProduct2Parameter132	= 33002:133:0
vdvProduct2Parameter133	= 33002:134:0
vdvProduct2Parameter134	= 33002:135:0
vdvProduct2Parameter135	= 33002:136:0
vdvProduct2Parameter136	= 33002:137:0
vdvProduct2Parameter137	= 33002:138:0
vdvProduct2Parameter138	= 33002:139:0
vdvProduct2Parameter139	= 33002:140:0
vdvProduct2Parameter140	= 33002:141:0
vdvProduct2Parameter141	= 33002:142:0
vdvProduct2Parameter142	= 33002:143:0
vdvProduct2Parameter143	= 33002:144:0
vdvProduct2Parameter144	= 33002:145:0
vdvProduct2Parameter145	= 33002:146:0
vdvProduct2Parameter146	= 33002:147:0
vdvProduct2Parameter147	= 33002:148:0
vdvProduct2Parameter148	= 33002:149:0
vdvProduct2Parameter149	= 33002:150:0
vdvProduct2Parameter150	= 33002:151:0

vdvProduct3				= 33003:1:0
vdvProduct3Parameter1	= 33003:2:0
vdvProduct3Parameter2	= 33003:3:0
vdvProduct3Parameter3	= 33003:4:0
vdvProduct3Parameter4	= 33003:5:0
vdvProduct3Parameter5	= 33003:6:0
vdvProduct3Parameter6	= 33003:7:0
vdvProduct3Parameter7	= 33003:8:0
vdvProduct3Parameter8	= 33003:9:0
vdvProduct3Parameter9	= 33003:10:0
vdvProduct3Parameter10	= 33003:11:0
vdvProduct3Parameter11	= 33003:12:0
vdvProduct3Parameter12	= 33003:13:0
vdvProduct3Parameter13	= 33003:14:0
vdvProduct3Parameter14	= 33003:15:0
vdvProduct3Parameter15	= 33003:16:0
vdvProduct3Parameter16	= 33003:17:0
vdvProduct3Parameter17	= 33003:18:0
vdvProduct3Parameter18	= 33003:19:0
vdvProduct3Parameter19	= 33003:20:0
vdvProduct3Parameter20	= 33003:21:0
vdvProduct3Parameter21	= 33003:22:0
vdvProduct3Parameter22	= 33003:23:0
vdvProduct3Parameter23	= 33003:24:0
vdvProduct3Parameter24	= 33003:25:0
vdvProduct3Parameter25	= 33003:26:0
vdvProduct3Parameter26	= 33003:27:0
vdvProduct3Parameter27	= 33003:28:0
vdvProduct3Parameter28	= 33003:29:0
vdvProduct3Parameter29	= 33003:30:0
vdvProduct3Parameter30	= 33003:31:0
vdvProduct3Parameter31	= 33003:32:0
vdvProduct3Parameter32	= 33003:33:0
vdvProduct3Parameter33	= 33003:34:0
vdvProduct3Parameter34	= 33003:35:0
vdvProduct3Parameter35	= 33003:36:0
vdvProduct3Parameter36	= 33003:37:0
vdvProduct3Parameter37	= 33003:38:0
vdvProduct3Parameter38	= 33003:39:0
vdvProduct3Parameter39	= 33003:40:0
vdvProduct3Parameter40	= 33003:41:0
vdvProduct3Parameter41	= 33003:42:0
vdvProduct3Parameter42	= 33003:43:0
vdvProduct3Parameter43	= 33003:44:0
vdvProduct3Parameter44	= 33003:45:0
vdvProduct3Parameter45	= 33003:46:0
vdvProduct3Parameter46	= 33003:47:0
vdvProduct3Parameter47	= 33003:48:0
vdvProduct3Parameter48	= 33003:49:0
vdvProduct3Parameter49	= 33003:50:0
vdvProduct3Parameter50	= 33003:51:0
vdvProduct3Parameter51	= 33003:52:0
vdvProduct3Parameter52	= 33003:53:0
vdvProduct3Parameter53	= 33003:54:0
vdvProduct3Parameter54	= 33003:55:0
vdvProduct3Parameter55	= 33003:56:0
vdvProduct3Parameter56	= 33003:57:0
vdvProduct3Parameter57	= 33003:58:0
vdvProduct3Parameter58	= 33003:59:0
vdvProduct3Parameter59	= 33003:60:0
vdvProduct3Parameter60	= 33003:61:0
vdvProduct3Parameter61	= 33003:62:0
vdvProduct3Parameter62	= 33003:63:0
vdvProduct3Parameter63	= 33003:64:0
vdvProduct3Parameter64	= 33003:65:0
vdvProduct3Parameter65	= 33003:66:0
vdvProduct3Parameter66	= 33003:67:0
vdvProduct3Parameter67	= 33003:68:0
vdvProduct3Parameter68	= 33003:69:0
vdvProduct3Parameter69	= 33003:70:0
vdvProduct3Parameter70	= 33003:71:0
vdvProduct3Parameter71	= 33003:72:0
vdvProduct3Parameter72	= 33003:73:0
vdvProduct3Parameter73	= 33003:74:0
vdvProduct3Parameter74	= 33003:75:0
vdvProduct3Parameter75	= 33003:76:0
vdvProduct3Parameter76	= 33003:77:0
vdvProduct3Parameter77	= 33003:78:0
vdvProduct3Parameter78	= 33003:79:0
vdvProduct3Parameter79	= 33003:80:0
vdvProduct3Parameter80	= 33003:81:0
vdvProduct3Parameter81	= 33003:82:0
vdvProduct3Parameter82	= 33003:83:0
vdvProduct3Parameter83	= 33003:84:0
vdvProduct3Parameter84	= 33003:85:0
vdvProduct3Parameter85	= 33003:86:0
vdvProduct3Parameter86	= 33003:87:0
vdvProduct3Parameter87	= 33003:88:0
vdvProduct3Parameter88	= 33003:89:0
vdvProduct3Parameter89	= 33003:90:0
vdvProduct3Parameter90	= 33003:91:0
vdvProduct3Parameter91	= 33003:92:0
vdvProduct3Parameter92	= 33003:93:0
vdvProduct3Parameter93	= 33003:94:0
vdvProduct3Parameter94	= 33003:95:0
vdvProduct3Parameter95	= 33003:96:0
vdvProduct3Parameter96	= 33003:97:0
vdvProduct3Parameter97	= 33003:98:0
vdvProduct3Parameter98	= 33003:99:0
vdvProduct3Parameter99	= 33003:100:0
vdvProduct3Parameter100	= 33003:101:0
vdvProduct3Parameter101	= 33003:102:0
vdvProduct3Parameter102	= 33003:103:0
vdvProduct3Parameter103	= 33003:104:0
vdvProduct3Parameter104	= 33003:105:0
vdvProduct3Parameter105	= 33003:106:0
vdvProduct3Parameter106	= 33003:107:0
vdvProduct3Parameter107	= 33003:108:0
vdvProduct3Parameter108	= 33003:109:0
vdvProduct3Parameter109	= 33003:110:0
vdvProduct3Parameter110	= 33003:111:0
vdvProduct3Parameter111	= 33003:112:0
vdvProduct3Parameter112	= 33003:113:0
vdvProduct3Parameter113	= 33003:114:0
vdvProduct3Parameter114	= 33003:115:0
vdvProduct3Parameter115	= 33003:116:0
vdvProduct3Parameter116	= 33003:117:0
vdvProduct3Parameter117	= 33003:118:0
vdvProduct3Parameter118	= 33003:119:0
vdvProduct3Parameter119	= 33003:120:0
vdvProduct3Parameter120	= 33003:121:0
vdvProduct3Parameter121	= 33003:122:0
vdvProduct3Parameter122	= 33003:123:0
vdvProduct3Parameter123	= 33003:124:0
vdvProduct3Parameter124	= 33003:125:0
vdvProduct3Parameter125	= 33003:126:0
vdvProduct3Parameter126	= 33003:127:0
vdvProduct3Parameter127	= 33003:128:0
vdvProduct3Parameter128	= 33003:129:0
vdvProduct3Parameter129	= 33003:130:0
vdvProduct3Parameter130	= 33003:131:0
vdvProduct3Parameter131	= 33003:132:0
vdvProduct3Parameter132	= 33003:133:0
vdvProduct3Parameter133	= 33003:134:0
vdvProduct3Parameter134	= 33003:135:0
vdvProduct3Parameter135	= 33003:136:0
vdvProduct3Parameter136	= 33003:137:0
vdvProduct3Parameter137	= 33003:138:0
vdvProduct3Parameter138	= 33003:139:0
vdvProduct3Parameter139	= 33003:140:0
vdvProduct3Parameter140	= 33003:141:0
vdvProduct3Parameter141	= 33003:142:0
vdvProduct3Parameter142	= 33003:143:0
vdvProduct3Parameter143	= 33003:144:0
vdvProduct3Parameter144	= 33003:145:0
vdvProduct3Parameter145	= 33003:146:0
vdvProduct3Parameter146	= 33003:147:0
vdvProduct3Parameter147	= 33003:148:0
vdvProduct3Parameter148	= 33003:149:0
vdvProduct3Parameter149	= 33003:150:0
vdvProduct3Parameter150	= 33003:151:0

vdvProduct4				= 33004:1:0
vdvProduct5				= 33005:1:0
vdvProduct6				= 33006:1:0
vdvProduct7				= 33007:1:0
vdvProduct8				= 33008:1:0
vdvProduct9				= 33009:1:0
vdvProduct10			= 33010:1:0
vdvProduct11			= 33011:1:0
vdvProduct12			= 33012:1:0
vdvProduct13			= 33013:1:0
vdvProduct14			= 33014:1:0
vdvProduct15			= 33015:1:0

vdvNull					= 34001:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

INTEGER nScreensaverStatic				= 1
INTEGER nScreensaverSlides				= 2
INTEGER nScreensaverVideo				= 3

INTEGER nProductDME24					= 1
INTEGER nProductDME64					= 2
INTEGER nProductDMESatellite			= 3
INTEGER nProduct01V96V2					= 4
INTEGER nProductLS9						= 5
INTEGER nProductM7CL					= 6
INTEGER nProductTXn						= 7
INTEGER nProductXP						= 8
INTEGER nProductDVDS2700				= 9

INTEGER nSetupPageLanguages				= 1
INTEGER nSetupPageProducts				= 2
INTEGER nSetupPageDevices				= 3
INTEGER nSetupPageOptions				= 4

LONG lTimelineScreensaver				= 1													// timeline ID for screensaver slides

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

// product comms

PERSISTENT DEV vdvProductLink[15]		= { dvSerial1, vdvNull, dvIP03, dvMIDI, dvMIDI, dvMIDI, vdvNull, dvSerial2, vdvNull, vdvNull, vdvNull, vdvNull, vdvNull, vdvNull, vdvNull }

// touch panel numbering

VOLATILE DEV dvPanelProduct[]					= { dvPanelProduct1, dvPanelProduct2, dvPanelProduct3, dvPanelProduct4, dvPanelProduct5,
													dvPanelProduct6, dvPanelProduct7, dvPanelProduct8, dvPanelProduct9, dvPanelProduct10,
													dvPanelProduct11, dvPanelProduct12, dvPanelProduct13, dvPanelProduct14, dvPanelProduct15 }

VOLATILE DEV vdvProduct[]						= { vdvProduct1, vdvProduct2, vdvProduct3, vdvProduct4, vdvProduct5,
													vdvProduct6, vdvProduct7, vdvProduct8, vdvProduct9, vdvProduct10,
													vdvProduct11, vdvProduct12, vdvProduct13, vdvProduct14, vdvProduct15 }

VOLATILE INTEGER nButtonTouchToStart			= 10
VOLATILE INTEGER nButtonLanguage				= 100
VOLATILE INTEGER nButtonLanguageSlot[]			= { 101, 102, 103, 104, 105, 106, 107, 108, 109, 110 }
VOLATILE INTEGER nButtonProduct					= 120
VOLATILE INTEGER nButtonProductSlot[]			= { 121, 122, 123, 124, 125, 126, 127, 128, 129, 130 }
VOLATILE INTEGER nButtonProductPage[]			= { 196, 197, 198, 199, 200 }
/*VOLATILE INTEGER nButtonProductControl[]		= { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
													11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
													21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
													31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
													41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
													51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
													61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
													71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
													81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
													91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
													101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
													111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
													121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
													131, 132, 133, 134, 135, 136, 137, 138, 139, 140,
													141, 142, 143, 144, 145, 146, 147, 148, 149, 150,
													151, 152, 153, 154, 155, 156, 157, 158, 159, 160,
													161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
													171, 172, 173, 174, 175, 176, 177, 178, 179, 180,
													181, 182, 183, 184, 185, 186, 187, 188, 189, 190,
													191, 192, 193, 194, 195, 196, 197, 198, 199, 200 }*/
VOLATILE INTEGER nButtonProductControl[]		= { 301, 302, 303, 304, 305, 306, 307, 308, 309, 310,
													311, 312, 313, 314, 315, 316, 317, 318, 319, 320,
													321, 322, 323, 324, 325, 326, 327, 328, 329, 330,
													331, 332, 333, 334, 335, 336, 337, 338, 339, 340,
													341, 342, 343, 344, 345, 346, 347, 348, 349, 350,
													351, 352, 353, 354, 355, 356, 357, 358, 359, 360,
													361, 362, 363, 364, 365, 366, 367, 368, 369, 370,
													371, 372, 373, 374, 375, 376, 377, 378, 379, 380,
													381, 382, 383, 384, 385, 386, 387, 388, 389, 390,
													391, 392, 393, 394, 395, 396, 397, 398, 399, 400,
													401, 402, 403, 404, 405, 406, 407, 408, 409, 410,
													411, 412, 413, 414, 415, 416, 417, 418, 419, 420,
													421, 422, 423, 424, 425, 426, 427, 428, 429, 430,
													431, 432, 433, 434, 435, 436, 437, 438, 439, 440,
													441, 442, 443, 444, 445, 446, 447, 448, 449, 450,
													451, 452, 453, 454, 455, 456, 457, 458, 459, 460,
													461, 462, 463, 464, 465, 466, 467, 468, 469, 470,
													471, 472, 473, 474, 475, 476, 477, 478, 479, 480,
													481, 482, 483, 484, 485, 486, 487, 488, 489, 490,
													491, 492, 493, 494, 495, 496, 497, 498, 499, 500 }
VOLATILE INTEGER nButtonScreensaverType[]		= { 501, 502, 503 }
VOLATILE INTEGER nButtonScreensaverTimeout[]	= { 511, 512, 513, 514, 515, 516, 517, 518, 519, 520 }
VOLATILE INTEGER nButtonSetupLanguageSlot[]		= { 521, 522, 523, 524, 525, 526, 527, 528, 529, 530 }
VOLATILE INTEGER nButtonSetupLanguage[]			= { 531, 532, 533, 534, 535, 536, 537, 538, 539, 540,
													541, 542, 543, 544, 545, 546, 547, 548, 549, 550,
													551, 552, 553, 554, 555, 556 }
VOLATILE INTEGER nButtonSetup					= 569
VOLATILE INTEGER nButtonPIN[]					= { 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581 }
VOLATILE INTEGER nButtonSetupDone				= 582
VOLATILE INTEGER nButtonSetupPage[]				= { 586, 587, 588, 589, 590 }
VOLATILE INTEGER nButtonSetupProductSlot[]		= { 601, 602, 603, 604, 605, 606, 607, 608, 609, 610 }
VOLATILE INTEGER nButtonSetupProduct[]			= { 621, 622, 623, 624, 625, 626, 627, 628, 629, 630,
													631, 632, 633, 634, 635, 636 }
VOLATILE INTEGER nButtonSetupFilePath			= 651
VOLATILE INTEGER nButtonKeyboard[]				= { 										699, 700,
													701, 702, 703, 704, 705, 706, 707, 708, 709, 710,
													711, 712, 713, 714, 715, 716, 717, 718, 719, 720,
													721, 722, 723, 724, 725, 726, 727, 728, 729, 730,
													731, 732, 733, 734, 735, 736, 737, 738, 739, 740,
													741, 742, 743, 744, 745, 746, 747, 748, 749, 750,
													751 }
VOLATILE INTEGER nButtonSerialPortProduct[][]	= {{801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815},
													{821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835}}

VOLATILE INTEGER nAddressScreensaverSlide		= 1
VOLATILE INTEGER nAddressLanguageCurrent		= 2
VOLATILE INTEGER nAddressKeyboard				= 5
VOLATILE INTEGER nAddressFilePath				= 6
VOLATILE INTEGER nAddressLanguageSlot[]			= { 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 }
VOLATILE INTEGER nAddressProductSlot[]			= { 31, 32, 33, 34, 35, 36, 37, 38, 39, 40 }
VOLATILE INTEGER nAddressLanguage[]				= { 51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
													61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
													71, 72, 73, 74, 75 }
VOLATILE INTEGER nAddressProduct[]				= { 91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
													101, 102, 103, 104, 105 }
VOLATILE INTEGER nAddressGenericText[]			= { 151, 152, 153, 154, 155, 156, 157, 158, 159, 160,
													161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
													171, 172, 173, 174, 175, 176, 177, 178, 179, 180,
													181, 182, 183, 184, 185, 186, 187, 188, 189, 190,
													191, 192, 193, 194, 195, 196, 197, 198, 199, 200 }
VOLATILE INTEGER nAddressProductText[]			= { 251, 252, 253, 254, 255, 256, 257, 258, 259, 260,
													261, 262, 263, 264, 265, 266, 267, 268, 269, 270,
													271, 272, 273, 274, 275, 276, 277, 278, 279, 280,
													281, 282, 283, 284, 285, 286, 287, 288, 289, 290,
													291, 292, 293, 294, 295, 296, 297, 298, 299, 300,
													301, 302, 303, 304, 305, 306, 307, 308, 309, 310,
													311, 312, 313, 314, 315, 316, 317, 318, 319, 320,
													321, 322, 323, 324, 325, 326, 327, 328, 329, 330 }

VOLATILE INTEGER nLevelProductControl[]			= { 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
													51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
													61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
													71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
													81, 82, 83, 84, 85, 86, 87, 88, 89, 90 }

// product control devices

VOLATILE DEV vdvProduct1Comms[]			= { vdvProduct1, vdvProduct1Parameter1, vdvProduct1Parameter2, vdvProduct1Parameter3, vdvProduct1Parameter4, vdvProduct1Parameter5, vdvProduct1Parameter6, vdvProduct1Parameter7, vdvProduct1Parameter8, vdvProduct1Parameter9, vdvProduct1Parameter10,
											vdvProduct1Parameter11, vdvProduct1Parameter12, vdvProduct1Parameter13, vdvProduct1Parameter14, vdvProduct1Parameter15, vdvProduct1Parameter16, vdvProduct1Parameter17, vdvProduct1Parameter18, vdvProduct1Parameter19, vdvProduct1Parameter20,
											vdvProduct1Parameter21, vdvProduct1Parameter22, vdvProduct1Parameter23, vdvProduct1Parameter24, vdvProduct1Parameter25, vdvProduct1Parameter26, vdvProduct1Parameter27, vdvProduct1Parameter28, vdvProduct1Parameter29, vdvProduct1Parameter30,
											vdvProduct1Parameter31, vdvProduct1Parameter32, vdvProduct1Parameter33, vdvProduct1Parameter34, vdvProduct1Parameter35, vdvProduct1Parameter36, vdvProduct1Parameter37, vdvProduct1Parameter38, vdvProduct1Parameter39, vdvProduct1Parameter40,
											vdvProduct1Parameter41, vdvProduct1Parameter42, vdvProduct1Parameter43, vdvProduct1Parameter44, vdvProduct1Parameter45, vdvProduct1Parameter46, vdvProduct1Parameter47, vdvProduct1Parameter48, vdvProduct1Parameter49, vdvProduct1Parameter50,
											vdvProduct1Parameter51, vdvProduct1Parameter52, vdvProduct1Parameter53, vdvProduct1Parameter54, vdvProduct1Parameter55, vdvProduct1Parameter56, vdvProduct1Parameter57, vdvProduct1Parameter58, vdvProduct1Parameter59, vdvProduct1Parameter60,
											vdvProduct1Parameter61, vdvProduct1Parameter62, vdvProduct1Parameter63, vdvProduct1Parameter64, vdvProduct1Parameter65, vdvProduct1Parameter66, vdvProduct1Parameter67, vdvProduct1Parameter68, vdvProduct1Parameter69, vdvProduct1Parameter70,
											vdvProduct1Parameter71, vdvProduct1Parameter72, vdvProduct1Parameter73, vdvProduct1Parameter74, vdvProduct1Parameter75, vdvProduct1Parameter76, vdvProduct1Parameter77, vdvProduct1Parameter78, vdvProduct1Parameter79, vdvProduct1Parameter80,
											vdvProduct1Parameter81, vdvProduct1Parameter82, vdvProduct1Parameter83, vdvProduct1Parameter84, vdvProduct1Parameter85, vdvProduct1Parameter86, vdvProduct1Parameter87, vdvProduct1Parameter88, vdvProduct1Parameter89, vdvProduct1Parameter90,
											vdvProduct1Parameter91, vdvProduct1Parameter92, vdvProduct1Parameter93, vdvProduct1Parameter94, vdvProduct1Parameter95, vdvProduct1Parameter96, vdvProduct1Parameter97, vdvProduct1Parameter98, vdvProduct1Parameter99, vdvProduct1Parameter100,
											vdvProduct1Parameter101, vdvProduct1Parameter102, vdvProduct1Parameter103, vdvProduct1Parameter104, vdvProduct1Parameter105, vdvProduct1Parameter106, vdvProduct1Parameter107, vdvProduct1Parameter108, vdvProduct1Parameter109, vdvProduct1Parameter110,
											vdvProduct1Parameter111, vdvProduct1Parameter112, vdvProduct1Parameter113, vdvProduct1Parameter114, vdvProduct1Parameter115, vdvProduct1Parameter116, vdvProduct1Parameter117, vdvProduct1Parameter118, vdvProduct1Parameter119, vdvProduct1Parameter120,
											vdvProduct1Parameter121, vdvProduct1Parameter122, vdvProduct1Parameter123, vdvProduct1Parameter124, vdvProduct1Parameter125, vdvProduct1Parameter126, vdvProduct1Parameter127, vdvProduct1Parameter128, vdvProduct1Parameter129, vdvProduct1Parameter130,
											vdvProduct1Parameter131, vdvProduct1Parameter132, vdvProduct1Parameter133, vdvProduct1Parameter134, vdvProduct1Parameter135, vdvProduct1Parameter136, vdvProduct1Parameter137, vdvProduct1Parameter138, vdvProduct1Parameter139, vdvProduct1Parameter140,
											vdvProduct1Parameter141, vdvProduct1Parameter142, vdvProduct1Parameter143, vdvProduct1Parameter144, vdvProduct1Parameter145, vdvProduct1Parameter146, vdvProduct1Parameter147, vdvProduct1Parameter148, vdvProduct1Parameter149, vdvProduct1Parameter150 }

VOLATILE DEV vdvProduct2Comms[]			= { vdvProduct2, vdvProduct2Parameter1, vdvProduct2Parameter2, vdvProduct2Parameter3, vdvProduct2Parameter4, vdvProduct2Parameter5, vdvProduct2Parameter6, vdvProduct2Parameter7, vdvProduct2Parameter8, vdvProduct2Parameter9, vdvProduct2Parameter10,
											vdvProduct2Parameter11, vdvProduct2Parameter12, vdvProduct2Parameter13, vdvProduct2Parameter14, vdvProduct2Parameter15, vdvProduct2Parameter16, vdvProduct2Parameter17, vdvProduct2Parameter18, vdvProduct2Parameter19, vdvProduct2Parameter20,
											vdvProduct2Parameter21, vdvProduct2Parameter22, vdvProduct2Parameter23, vdvProduct2Parameter24, vdvProduct2Parameter25, vdvProduct2Parameter26, vdvProduct2Parameter27, vdvProduct2Parameter28, vdvProduct2Parameter29, vdvProduct2Parameter30,
											vdvProduct2Parameter31, vdvProduct2Parameter32, vdvProduct2Parameter33, vdvProduct2Parameter34, vdvProduct2Parameter35, vdvProduct2Parameter36, vdvProduct2Parameter37, vdvProduct2Parameter38, vdvProduct2Parameter39, vdvProduct2Parameter40,
											vdvProduct2Parameter41, vdvProduct2Parameter42, vdvProduct2Parameter43, vdvProduct2Parameter44, vdvProduct2Parameter45, vdvProduct2Parameter46, vdvProduct2Parameter47, vdvProduct2Parameter48, vdvProduct2Parameter49, vdvProduct2Parameter50,
											vdvProduct2Parameter51, vdvProduct2Parameter52, vdvProduct2Parameter53, vdvProduct2Parameter54, vdvProduct2Parameter55, vdvProduct2Parameter56, vdvProduct2Parameter57, vdvProduct2Parameter58, vdvProduct2Parameter59, vdvProduct2Parameter60,
											vdvProduct2Parameter61, vdvProduct2Parameter62, vdvProduct2Parameter63, vdvProduct2Parameter64, vdvProduct2Parameter65, vdvProduct2Parameter66, vdvProduct2Parameter67, vdvProduct2Parameter68, vdvProduct2Parameter69, vdvProduct2Parameter70,
											vdvProduct2Parameter71, vdvProduct2Parameter72, vdvProduct2Parameter73, vdvProduct2Parameter74, vdvProduct2Parameter75, vdvProduct2Parameter76, vdvProduct2Parameter77, vdvProduct2Parameter78, vdvProduct2Parameter79, vdvProduct2Parameter80,
											vdvProduct2Parameter81, vdvProduct2Parameter82, vdvProduct2Parameter83, vdvProduct2Parameter84, vdvProduct2Parameter85, vdvProduct2Parameter86, vdvProduct2Parameter87, vdvProduct2Parameter88, vdvProduct2Parameter89, vdvProduct2Parameter90,
											vdvProduct2Parameter91, vdvProduct2Parameter92, vdvProduct2Parameter93, vdvProduct2Parameter94, vdvProduct2Parameter95, vdvProduct2Parameter96, vdvProduct2Parameter97, vdvProduct2Parameter98, vdvProduct2Parameter99, vdvProduct2Parameter100,
											vdvProduct2Parameter101, vdvProduct2Parameter102, vdvProduct2Parameter103, vdvProduct2Parameter104, vdvProduct2Parameter105, vdvProduct2Parameter106, vdvProduct2Parameter107, vdvProduct2Parameter108, vdvProduct2Parameter109, vdvProduct2Parameter110,
											vdvProduct2Parameter111, vdvProduct2Parameter112, vdvProduct2Parameter113, vdvProduct2Parameter114, vdvProduct2Parameter115, vdvProduct2Parameter116, vdvProduct2Parameter117, vdvProduct2Parameter118, vdvProduct2Parameter119, vdvProduct2Parameter120,
											vdvProduct2Parameter121, vdvProduct2Parameter122, vdvProduct2Parameter123, vdvProduct2Parameter124, vdvProduct2Parameter125, vdvProduct2Parameter126, vdvProduct2Parameter127, vdvProduct2Parameter128, vdvProduct2Parameter129, vdvProduct2Parameter130,
											vdvProduct2Parameter131, vdvProduct2Parameter132, vdvProduct2Parameter133, vdvProduct2Parameter134, vdvProduct2Parameter135, vdvProduct2Parameter136, vdvProduct2Parameter137, vdvProduct2Parameter138, vdvProduct2Parameter139, vdvProduct2Parameter140,
											vdvProduct2Parameter141, vdvProduct2Parameter142, vdvProduct2Parameter143, vdvProduct2Parameter144, vdvProduct2Parameter145, vdvProduct2Parameter146, vdvProduct2Parameter147, vdvProduct2Parameter148, vdvProduct2Parameter149, vdvProduct2Parameter150 }

VOLATILE DEV vdvProduct3Comms[]			= { vdvProduct3, vdvProduct3Parameter1, vdvProduct3Parameter2, vdvProduct3Parameter3, vdvProduct3Parameter4, vdvProduct3Parameter5, vdvProduct3Parameter6, vdvProduct3Parameter7, vdvProduct3Parameter8, vdvProduct3Parameter9, vdvProduct3Parameter10,
											vdvProduct3Parameter11, vdvProduct3Parameter12, vdvProduct3Parameter13, vdvProduct3Parameter14, vdvProduct3Parameter15, vdvProduct3Parameter16, vdvProduct3Parameter17, vdvProduct3Parameter18, vdvProduct3Parameter19, vdvProduct3Parameter20,
											vdvProduct3Parameter21, vdvProduct3Parameter22, vdvProduct3Parameter23, vdvProduct3Parameter24, vdvProduct3Parameter25, vdvProduct3Parameter26, vdvProduct3Parameter27, vdvProduct3Parameter28, vdvProduct3Parameter29, vdvProduct3Parameter30,
											vdvProduct3Parameter31, vdvProduct3Parameter32, vdvProduct3Parameter33, vdvProduct3Parameter34, vdvProduct3Parameter35, vdvProduct3Parameter36, vdvProduct3Parameter37, vdvProduct3Parameter38, vdvProduct3Parameter39, vdvProduct3Parameter40,
											vdvProduct3Parameter41, vdvProduct3Parameter42, vdvProduct3Parameter43, vdvProduct3Parameter44, vdvProduct3Parameter45, vdvProduct3Parameter46, vdvProduct3Parameter47, vdvProduct3Parameter48, vdvProduct3Parameter49, vdvProduct3Parameter50,
											vdvProduct3Parameter51, vdvProduct3Parameter52, vdvProduct3Parameter53, vdvProduct3Parameter54, vdvProduct3Parameter55, vdvProduct3Parameter56, vdvProduct3Parameter57, vdvProduct3Parameter58, vdvProduct3Parameter59, vdvProduct3Parameter60,
											vdvProduct3Parameter61, vdvProduct3Parameter62, vdvProduct3Parameter63, vdvProduct3Parameter64, vdvProduct3Parameter65, vdvProduct3Parameter66, vdvProduct3Parameter67, vdvProduct3Parameter68, vdvProduct3Parameter69, vdvProduct3Parameter70,
											vdvProduct3Parameter71, vdvProduct3Parameter72, vdvProduct3Parameter73, vdvProduct3Parameter74, vdvProduct3Parameter75, vdvProduct3Parameter76, vdvProduct3Parameter77, vdvProduct3Parameter78, vdvProduct3Parameter79, vdvProduct3Parameter80,
											vdvProduct3Parameter81, vdvProduct3Parameter82, vdvProduct3Parameter83, vdvProduct3Parameter84, vdvProduct3Parameter85, vdvProduct3Parameter86, vdvProduct3Parameter87, vdvProduct3Parameter88, vdvProduct3Parameter89, vdvProduct3Parameter90,
											vdvProduct3Parameter91, vdvProduct3Parameter92, vdvProduct3Parameter93, vdvProduct3Parameter94, vdvProduct3Parameter95, vdvProduct3Parameter96, vdvProduct3Parameter97, vdvProduct3Parameter98, vdvProduct3Parameter99, vdvProduct3Parameter100,
											vdvProduct3Parameter101, vdvProduct3Parameter102, vdvProduct3Parameter103, vdvProduct3Parameter104, vdvProduct3Parameter105, vdvProduct3Parameter106, vdvProduct3Parameter107, vdvProduct3Parameter108, vdvProduct3Parameter109, vdvProduct3Parameter110,
											vdvProduct3Parameter111, vdvProduct3Parameter112, vdvProduct3Parameter113, vdvProduct3Parameter114, vdvProduct3Parameter115, vdvProduct3Parameter116, vdvProduct3Parameter117, vdvProduct3Parameter118, vdvProduct3Parameter119, vdvProduct3Parameter120,
											vdvProduct3Parameter121, vdvProduct3Parameter122, vdvProduct3Parameter123, vdvProduct3Parameter124, vdvProduct3Parameter125, vdvProduct3Parameter126, vdvProduct3Parameter127, vdvProduct3Parameter128, vdvProduct3Parameter129, vdvProduct3Parameter130,
											vdvProduct3Parameter131, vdvProduct3Parameter132, vdvProduct3Parameter133, vdvProduct3Parameter134, vdvProduct3Parameter135, vdvProduct3Parameter136, vdvProduct3Parameter137, vdvProduct3Parameter138, vdvProduct3Parameter139, vdvProduct3Parameter140,
											vdvProduct3Parameter141, vdvProduct3Parameter142, vdvProduct3Parameter143, vdvProduct3Parameter144, vdvProduct3Parameter145, vdvProduct3Parameter146, vdvProduct3Parameter147, vdvProduct3Parameter148, vdvProduct3Parameter149, vdvProduct3Parameter150 }

// status variables

VOLATILE LONG lScreensaverTimes[5]		= { 0, 2500, 5000 }									// timeline times for screensaver slides
VOLATILE LONG lTimelineAbsolute			= 0													// timeline constant
VOLATILE LONG lTimelineRelative			= 1													// timeline constant
VOLATILE LONG lTimelineNoRepeat			= 0													// timeline constant
VOLATILE LONG lTimelineRepeat			= 1													// timeline constant

PERSISTENT INTEGER nScreensaverTimeoutCurrent	= 3													// currently selected nScreensaverTimeout
PERSISTENT INTEGER nLanguageSlot[10]			= { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }					// language allocated to each slot
PERSISTENT INTEGER nLanguageCurrent				= 1													// language currently in use
PERSISTENT INTEGER nProductSlot[10]				= { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }					// product allocated to each slot
PERSISTENT INTEGER nScreensaverType				= nScreensaverStatic								// the type of screensaver to be used
VOLATILE INTEGER nProductCurrent				= 1													// product currently in use
VOLATILE INTEGER nProductPageCurrent			= 1													// product page currently in use
PERSISTENT CHAR cMidiChannel[15]				= {0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0}		// MIDI channel used for each product's comms

VOLATILE CHAR cPanelActive						= false												// true while user is pressing buttons
VOLATILE CHAR cLanguageChoosing					= false												// true while user is deciding on a language
VOLATILE CHAR cProductChoosing					= false												// true while user is deciding on a product
VOLATILE CHAR cPINActive						= false												// true while user is entering the setup PIN
VOLATILE CHAR cSetupActive						= false												// true while user is using setup pages
VOLATILE CHAR cFilePathActive					= false												// true while user is entering file path
VOLATILE INTEGER nScreensaverTimeout[]			= { 0, 1, 2, 5, 10, 15, 20, 30, 45, 60 }			// timeouts in minutes available for screensaver timeout
VOLATILE INTEGER nSetupLanguageChoosing			= 0													// the number of the language slot for which a language is being chosen
VOLATILE INTEGER nSetupProductChoosing			= 0													// the number of the product slot for which a product is being chosen
VOLATILE INTEGER nPINEntered					= 0													// the accumulated setup PIN, as entered so far
VOLATILE INTEGER nPINCorrect					= 4520												// the correct setup PIN
VOLATILE INTEGER nSetupPageCurrent				= nSetupPageOptions									// page number of the current setup page
VOLATILE CHAR cGenericText[150][100]																// complete text for the generic areas, in the current language
VOLATILE CHAR cProductText[15][150][100]															// complete text for each product, in the current language
VOLATILE WIDECHAR cWGenericText[150][100]															// complete text for the generic areas, in the current language
VOLATILE WIDECHAR cWProductText[15][150][100]														// complete text for each product, in the current language
VOLATILE CHAR cShiftOn
VOLATILE CHAR cCapsLockOn
PERSISTENT CHAR cFilePath[100]					= 'ftp://192.168.0.201/'							// file path to find dynamic images
PERSISTENT CHAR cImageUsername[40]				= 'NetLinx'											// username for loading dynamic images
PERSISTENT CHAR cImagePassword[40]				= 'password'										// password for loading dynamic images
PERSISTENT CHAR cImageServer[100]
PERSISTENT CHAR cImagePath[100]
PERSISTENT CHAR cImageProtocol

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION ButtonImage(DEV dvDevice, INTEGER nButton, CHAR cImage[])
{
	SEND_COMMAND dvDevice, "'^BMP-',ITOA(nButton),',0,',cImage"
}

DEFINE_FUNCTION ButtonDynamicImage(DEV dvDevice, INTEGER nButton, CHAR cImage[])
{
	SEND_COMMAND dvDevice, "'^BBR-',ITOA(nButton),',0,',cImage"
}

DEFINE_FUNCTION ButtonText(DEV dvDevice, INTEGER nButton, CHAR cText[])
{
	SEND_COMMAND dvDevice, "'^TXT-',ITOA(nButton),',0,',cText"
}

DEFINE_FUNCTION ButtonWText(DEV dvDevice, INTEGER nButton, WIDECHAR cWText[])
{
	SEND_COMMAND dvDevice, "'^UNI-',ITOA(nButton),',0,',WC_TP_ENCODE(cWText)"
}

DEFINE_FUNCTION PanelPage(DEV dvDevice, CHAR cPage[])
{
	SEND_COMMAND dvDevice, "'PAGE-', cPage"
}

DEFINE_FUNCTION PanelRedraw()
{
	IF (cPanelActive)
	{
		IF (cSetupActive)
		{
			SELECT
			{
				ACTIVE(cFilePathActive):
				{
					PanelPage(dvPanel, 'Setup keyboard')
				}
				ACTIVE(nSetupLanguageChoosing > 0):
				{
					LanguageImagesRedraw()
					PanelPage(dvPanel, 'Setup languages choice')
				}
				ACTIVE(nSetupProductChoosing > 0):
				{
					ProductImagesRedraw()
					PanelPage(dvPanel, 'Setup products choice')
				}
				ACTIVE(nSetupPageCurrent == nSetupPageLanguages):
				{
					LanguageSlotImagesRedraw()
					PanelPage(dvPanel, 'Setup languages layout')
				}
				ACTIVE(nSetupPageCurrent == nSetupPageProducts):
				{
					ProductSlotImagesRedraw()
					PanelPage(dvPanel, 'Setup products layout')
				}
				ACTIVE(nSetupPageCurrent == nSetupPageDevices):
				{
					PanelPage(dvPanel, 'Setup devices')
				}
				ACTIVE(nSetupPageCurrent == nSetupPageOptions):
				{
					ButtonText(dvPanel, nAddressFilePath, cFilePath)
					PanelPage(dvPanel, 'Setup options')
				}
				ACTIVE(true):
				{
					nSetupPageCurrent = nSetupPageOptions
					PanelPage(dvPanel, 'Setup options')
				}
			}
		}
		ELSE
		{
			SELECT
			{
				ACTIVE(cLanguageChoosing):
				{
					LanguageSlotImagesRedraw()
					PanelPage(dvPanel, 'Languages')
					LanguageSlotImagesRedraw()
				}
				ACTIVE(cProductChoosing):
				{
					ProductSlotImagesRedraw()
					PanelPage(dvPanel, 'Products')
					ProductSlotImagesRedraw()
				}
				ACTIVE(cPINActive):
				{
					PanelPage(dvPanel, 'PIN')
				}
				ACTIVE(1):
				{
					PanelPage(dvPanel, "'Product ',ITOA(nProductCurrent),' page ',ITOA(nProductPageCurrent)")
				}
			}
		}
	}
	ELSE
	{
		SWITCH(nScreensaverType)
		{
			CASE nScreensaverStatic:
			{
				PanelPage(dvPanel, 'Screensaver static')
				BREAK
			}
			CASE nScreensaverSlides:
			{
				PanelPage(dvPanel, 'Screensaver slides')
				IF (TIMELINE_ACTIVE(lTimelineScreensaver))
				{
					TIMELINE_KILL(lTimelineScreensaver)
				}
				lScreensaverTimes[1] = 0
				lScreensaverTimes[2] = 2500
				lScreensaverTimes[3] = 5000
				SET_LENGTH_ARRAY(lScreensaverTimes, 3)
				TIMELINE_CREATE(lTimelineScreensaver, lScreensaverTimes, LENGTH_ARRAY(lScreensaverTimes), lTimelineAbsolute, lTimelineRepeat)
				BREAK
			}
			CASE nScreensaverVideo:
			{
				PanelPage(dvPanel, 'Screensaver video')
				BREAK
			}
			DEFAULT:
			{
				BREAK
			}
		}
	}
}

DEFINE_FUNCTION LanguageTextRedraw()
{
	STACK_VAR SLONG slHandle
	STACK_VAR SLONG slResult
	STACK_VAR CHAR cText[100]
	STACK_VAR WIDECHAR cWText[100]
	STACK_VAR CHAR cName[100]
	STACK_VAR INTEGER nSection
	STACK_VAR INTEGER nLine
	STACK_VAR INTEGER nCount
	STACK_VAR INTEGER nCount2
	STACK_VAR INTEGER nFormat
	cName = "'language', nLanguageCurrent + 64"
/*	SWITCH(nLanguageCurrent)
	{
		CASE  1:	{ cName = 'languageA'; BREAK }
		CASE  2:	{ cName = 'languageB'; BREAK }
		CASE  3:	{ cName = 'languageC'; BREAK }
		CASE  4:	{ cName = 'languageD'; BREAK }
		CASE  5:	{ cName = 'languageE'; BREAK }
		CASE  6:	{ cName = 'languageF'; BREAK }
		CASE  7:	{ cName = 'languageG'; BREAK }
		CASE  8:	{ cName = 'languageH'; BREAK }
		CASE  9:	{ cName = 'languageI'; BREAK }
		CASE 10:	{ cName = 'languageJ'; BREAK }
		CASE 11:	{ cName = 'languageK'; BREAK }
		CASE 12:	{ cName = 'languageL'; BREAK }
		CASE 13:	{ cName = 'languageM'; BREAK }
		CASE 14:	{ cName = 'languageN'; BREAK }
		CASE 15:	{ cName = 'languageO'; BREAK }
		CASE 16:	{ cName = 'languageP'; BREAK }
		CASE 17:	{ cName = 'languageQ'; BREAK }
		CASE 18:	{ cName = 'languageR'; BREAK }
		CASE 19:	{ cName = 'languageS'; BREAK }
		CASE 20:	{ cName = 'languageT'; BREAK }
		CASE 21:	{ cName = 'languageU'; BREAK }
		CASE 22:	{ cName = 'languageV'; BREAK }
		CASE 23:	{ cName = 'languageW'; BREAK }
		CASE 24:	{ cName = 'languageX'; BREAK }
		CASE 25:	{ cName = 'languageY'; BREAK }
		DEFAULT:	{ cName = 'languageA'; BREAK }
	}*/
	slHandle = WC_FILE_OPEN("cName, '.txt'", 1, nFormat)
	//SEND_STRING 0,"'file format = ', ITOA(nFormat)"
	IF (slHandle > 0)
	{
		slResult = 0
		nSection = 0
		nLine = 0
		SWITCH(nFormat)
		{
			CASE 0:	// ANSI, ASCII
			{
				WHILE (slResult >= 0)
				{
					slResult = FILE_READ_LINE(slHandle, cText, MAX_LENGTH_STRING(cText))
					IF (slResult >= 0)
					{
						//SEND_STRING 0,"'cText = [',cText,']'"
						SELECT
						{
							ACTIVE(cText == '#START#'):
							{
								nSection = 0
								nLine = 1
							}
							ACTIVE(cText == '#END#'):
							{
								IF (nSection == 0)
								{
									SET_LENGTH_ARRAY(cGenericText, nLine-1)
									SET_LENGTH_ARRAY(cWGenericText, nLine-1)
								}
								ELSE
								{
									SET_LENGTH_ARRAY(cProductText[nSection], nLine-1)
									SET_LENGTH_ARRAY(cWProductText[nSection], nLine-1)
								}
								nSection = 0
								nLine = 1
								BREAK
							}
							ACTIVE(cText == '#SECTION#'):
							{
								IF (nSection == 0)
								{
									SET_LENGTH_ARRAY(cGenericText, nLine-1)
									SET_LENGTH_ARRAY(cWGenericText, nLine-1)
								}
								ELSE
								{
									SET_LENGTH_ARRAY(cProductText[nSection], nLine-1)
									SET_LENGTH_ARRAY(cWProductText[nSection], nLine-1)
								}
								nSection++
								nLine = 1
							}
							ACTIVE(cText == ''):
							{
								// skip blank lines
							}
							ACTIVE(1):
							{
								IF (nSection > 0)
								{
									cProductText[nSection][nLine] = cText
									cWProductText[nSection][nLine] = CH_TO_WC(cText)
								}
								ELSE
								{
									cGenericText[nLine] = cText
									cWGenericText[nLine] = CH_TO_WC(cText)
								}
								nLine++
							}
						}
					}
				}
				FILE_CLOSE(slHandle)
				FOR (nCount = 1; nCount <= LENGTH_ARRAY(cGenericText); nCount++)
				{
					ButtonText(dvPanel, nAddressGenericText[nCount], cGenericText[nCount])
				}
				FOR (nCount2 = 1; nCount2 < 16; nCount2++)
				{
					FOR (nCount = 1; nCount <= LENGTH_ARRAY(cProductText[nCount2]); nCount++)
					{
						ButtonText(dvPanelProduct[nCount2], nAddressProductText[nCount], cProductText[nCount2][nCount])
					}
				}
				BREAK
			}
			CASE 1:	// Unicode
			{
				WHILE (slResult >= 0)
				{
					slResult = WC_FILE_READ_LINE(slHandle, cWText, MAX_LENGTH_STRING(cWText))
					IF (slResult >= 0)
					{
						//SEND_STRING 0,"'cWText = [',WC_TO_CH(cWText),']'"
						SELECT
						{
							ACTIVE(cWText == '#START#'):
							{
								nSection = 0
								nLine = 1
							}
							ACTIVE(cWText == '#END#'):
							{
								IF (nSection == 0)
								{
									SET_LENGTH_ARRAY(cGenericText, nLine-1)
									SET_LENGTH_ARRAY(cWGenericText, nLine-1)
								}
								ELSE
								{
									SET_LENGTH_ARRAY(cProductText[nSection], nLine-1)
									SET_LENGTH_ARRAY(cWProductText[nSection], nLine-1)
								}
								nSection = 0
								nLine = 1
								BREAK
							}
							ACTIVE(cWText == '#SECTION#'):
							{
								IF (nSection == 0)
								{
									SET_LENGTH_ARRAY(cGenericText, nLine-1)
									SET_LENGTH_ARRAY(cWGenericText, nLine-1)
								}
								ELSE
								{
									SET_LENGTH_ARRAY(cProductText[nSection], nLine-1)
									SET_LENGTH_ARRAY(cWProductText[nSection], nLine-1)
								}
								nSection++
								nLine = 1
							}
							ACTIVE(cWText == ''):
							{
								// skip blank lines
							}
							ACTIVE(1):
							{
								IF (nSection > 0)
								{
									cWProductText[nSection][nLine] = cWText
									cProductText[nSection][nLine] = WC_TO_CH(cWText)
								}
								ELSE
								{
									cWGenericText[nLine] = cWText
									cGenericText[nLine] = WC_TO_CH(cWText)
								}
								nLine++
							}
						}
					}
				}
				WC_FILE_CLOSE(slHandle)
				FOR (nCount = 1; nCount <= LENGTH_ARRAY(cWGenericText); nCount++)
				{
					ButtonWText(dvPanel, nAddressGenericText[nCount], cWGenericText[nCount])
				}
				FOR (nCount2 = 1; nCount2 < 16; nCount2++)
				{
					FOR (nCount = 1; nCount <= LENGTH_ARRAY(cWProductText[nCount2]); nCount++)
					{
						ButtonWText(dvPanelProduct[nCount2], nAddressProductText[nCount], cWProductText[nCount2][nCount])
					}
				}
				BREAK
			}
			CASE 2:	// Big-endian Unicode
			{
				WHILE (slResult >= 0)
				{
					slResult = WC_FILE_READ_LINE(slHandle, cWText, MAX_LENGTH_STRING(cWText))
					IF (slResult >= 0)
					{
						//SEND_STRING 0,"'cWText = [',WC_TO_CH(cWText),']'"
						SELECT
						{
							ACTIVE(cWText == '#START#'):
							{
								nSection = 0
								nLine = 1
							}
							ACTIVE(cWText == '#END#'):
							{
								IF (nSection == 0)
								{
									SET_LENGTH_ARRAY(cGenericText, nLine-1)
									SET_LENGTH_ARRAY(cWGenericText, nLine-1)
								}
								ELSE
								{
									SET_LENGTH_ARRAY(cProductText[nSection], nLine-1)
									SET_LENGTH_ARRAY(cWProductText[nSection], nLine-1)
								}
								nSection = 0
								nLine = 1
								BREAK
							}
							ACTIVE(cWText == '#SECTION#'):
							{
								IF (nSection == 0)
								{
									SET_LENGTH_ARRAY(cGenericText, nLine-1)
									SET_LENGTH_ARRAY(cWGenericText, nLine-1)
								}
								ELSE
								{
									SET_LENGTH_ARRAY(cProductText[nSection], nLine-1)
									SET_LENGTH_ARRAY(cWProductText[nSection], nLine-1)
								}
								nSection++
								nLine = 1
							}
							ACTIVE(cWText == ''):
							{
								// skip blank lines
							}
							ACTIVE(1):
							{
								IF (nSection > 0)
								{
									cWProductText[nSection][nLine] = cWText
									cProductText[nSection][nLine] = WC_TO_CH(cWText)
								}
								ELSE
								{
									cWGenericText[nLine] = cWText
									cGenericText[nLine] = WC_TO_CH(cWText)
								}
								nLine++
							}
						}
					}
				}
				WC_FILE_CLOSE(slHandle)
				FOR (nCount = 1; nCount <= LENGTH_ARRAY(cWGenericText); nCount++)
				{
					ButtonWText(dvPanel, nAddressGenericText[nCount], cWGenericText[nCount])
				}
				FOR (nCount2 = 1; nCount2 < 16; nCount2++)
				{
					FOR (nCount = 1; nCount <= LENGTH_ARRAY(cWProductText[nCount2]); nCount++)
					{
						ButtonWText(dvPanelProduct[nCount2], nAddressProductText[nCount], cWProductText[nCount2][nCount])
					}
				}
				BREAK
			}
			CASE 3:	// UTF-8
			{
				WHILE (slResult >= 0)
				{
					slResult = WC_FILE_READ_LINE(slHandle, cWText, MAX_LENGTH_STRING(cWText))
					IF (slResult >= 0)
					{
						//SEND_STRING 0,"'cWText = [',WC_TO_CH(cWText),']'"
						SELECT
						{
							ACTIVE(cWText == '#START#'):
							{
								nSection = 0
								nLine = 1
							}
							ACTIVE(cWText == '#END#'):
							{
								IF (nSection == 0)
								{
									SET_LENGTH_ARRAY(cGenericText, nLine-1)
									SET_LENGTH_ARRAY(cWGenericText, nLine-1)
								}
								ELSE
								{
									SET_LENGTH_ARRAY(cProductText[nSection], nLine-1)
									SET_LENGTH_ARRAY(cWProductText[nSection], nLine-1)
								}
								nSection = 0
								nLine = 1
								BREAK
							}
							ACTIVE(cWText == '#SECTION#'):
							{
								IF (nSection == 0)
								{
									SET_LENGTH_ARRAY(cGenericText, nLine-1)
									SET_LENGTH_ARRAY(cWGenericText, nLine-1)
								}
								ELSE
								{
									SET_LENGTH_ARRAY(cProductText[nSection], nLine-1)
									SET_LENGTH_ARRAY(cWProductText[nSection], nLine-1)
								}
								nSection++
								nLine = 1
							}
							ACTIVE(cWText == ''):
							{
								// skip blank lines
							}
							ACTIVE(1):
							{
								IF (nLine > 0)
								{
									IF (nSection > 0)
									{
										cWProductText[nSection][nLine] = cWText
										cProductText[nSection][nLine] = WC_TO_CH(cWText)
									}
									ELSE
									{
										cWGenericText[nLine] = cWText
										cGenericText[nLine] = WC_TO_CH(cWText)
									}
								}
								nLine++
							}
						}
					}
				}
				WC_FILE_CLOSE(slHandle)
				FOR (nCount = 1; nCount <= LENGTH_ARRAY(cWGenericText); nCount++)
				{
					ButtonWText(dvPanel, nAddressGenericText[nCount], cWGenericText[nCount])
				}
				FOR (nCount2 = 1; nCount2 < 16; nCount2++)
				{
					FOR (nCount = 1; nCount <= LENGTH_ARRAY(cWProductText[nCount2]); nCount++)
					{
						ButtonWText(dvPanelProduct[nCount2], nAddressProductText[nCount], cWProductText[nCount2][nCount])
					}
				}
				BREAK
			}
			DEFAULT:
			{
				//SEND_STRING 0,"'language file format [',ITOA(nFormat),'] not recognised'"
				BREAK
			}
		}
	}
	ButtonDynamicImage(dvPanel, nAddressLanguageCurrent, cName)
}

DEFINE_FUNCTION LanguageSlotImagesRedraw()
{
	WAIT 2 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[1],"'language', nLanguageSlot[1] + 64")
	WAIT 4 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[2],"'language', nLanguageSlot[2] + 64")
	WAIT 6 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[3],"'language', nLanguageSlot[3] + 64")
	WAIT 8 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[4],"'language', nLanguageSlot[4] + 64")
	WAIT 10 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[5],"'language', nLanguageSlot[5] + 64")
	WAIT 12 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[6],"'language', nLanguageSlot[6] + 64")
	WAIT 14 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[7],"'language', nLanguageSlot[7] + 64")
	WAIT 16 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[8],"'language', nLanguageSlot[8] + 64")
	WAIT 18 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[9],"'language', nLanguageSlot[9] + 64")
	WAIT 20 ButtonDynamicImage(dvPanel, nAddressLanguageSlot[10],"'language', nLanguageSlot[10] + 64")
}

DEFINE_FUNCTION ProductSlotImagesRedraw()
{
	WAIT 2 ButtonDynamicImage(dvPanel, nAddressProductSlot[1],"'product', nProductSlot[1] + 64")
	WAIT 4 ButtonDynamicImage(dvPanel, nAddressProductSlot[2],"'product', nProductSlot[2] + 64")
	WAIT 6 ButtonDynamicImage(dvPanel, nAddressProductSlot[3],"'product', nProductSlot[3] + 64")
	WAIT 8 ButtonDynamicImage(dvPanel, nAddressProductSlot[4],"'product', nProductSlot[4] + 64")
	WAIT 10 ButtonDynamicImage(dvPanel, nAddressProductSlot[5],"'product', nProductSlot[5] + 64")
	WAIT 12 ButtonDynamicImage(dvPanel, nAddressProductSlot[6],"'product', nProductSlot[6] + 64")
	WAIT 14 ButtonDynamicImage(dvPanel, nAddressProductSlot[7],"'product', nProductSlot[7] + 64")
	WAIT 16 ButtonDynamicImage(dvPanel, nAddressProductSlot[8],"'product', nProductSlot[8] + 64")
	WAIT 18 ButtonDynamicImage(dvPanel, nAddressProductSlot[9],"'product', nProductSlot[9] + 64")
	WAIT 20 ButtonDynamicImage(dvPanel, nAddressProductSlot[10],"'product', nProductSlot[10] + 64")
}

DEFINE_FUNCTION LanguageImagesRedraw()
{
	/*STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < 26; nCount++)
	{
		ButtonDynamicImage(dvPanel, nAddressLanguage[nCount],"'language', nCount + 64")
	}*/
	WAIT 2 ButtonDynamicImage(dvPanel, nAddressLanguage[1],"'languageA'")
	WAIT 4 ButtonDynamicImage(dvPanel, nAddressLanguage[2],"'languageB'")
	WAIT 6 ButtonDynamicImage(dvPanel, nAddressLanguage[3],"'languageC'")
	WAIT 8 ButtonDynamicImage(dvPanel, nAddressLanguage[4],"'languageD'")
	WAIT 10 ButtonDynamicImage(dvPanel, nAddressLanguage[5],"'languageE'")
	WAIT 12 ButtonDynamicImage(dvPanel, nAddressLanguage[6],"'languageF'")
	WAIT 14 ButtonDynamicImage(dvPanel, nAddressLanguage[7],"'languageG'")
	WAIT 16 ButtonDynamicImage(dvPanel, nAddressLanguage[8],"'languageH'")
	WAIT 18 ButtonDynamicImage(dvPanel, nAddressLanguage[9],"'languageI'")
	WAIT 20 ButtonDynamicImage(dvPanel, nAddressLanguage[10],"'languageJ'")
	WAIT 22 ButtonDynamicImage(dvPanel, nAddressLanguage[11],"'languageK'")
	WAIT 24 ButtonDynamicImage(dvPanel, nAddressLanguage[12],"'languageL'")
	WAIT 26 ButtonDynamicImage(dvPanel, nAddressLanguage[13],"'languageM'")
	WAIT 28 ButtonDynamicImage(dvPanel, nAddressLanguage[14],"'languageN'")
	WAIT 30 ButtonDynamicImage(dvPanel, nAddressLanguage[15],"'languageO'")
	WAIT 32 ButtonDynamicImage(dvPanel, nAddressLanguage[16],"'languageP'")
	WAIT 34 ButtonDynamicImage(dvPanel, nAddressLanguage[17],"'languageQ'")
	WAIT 36 ButtonDynamicImage(dvPanel, nAddressLanguage[18],"'languageR'")
	WAIT 38 ButtonDynamicImage(dvPanel, nAddressLanguage[19],"'languageS'")
	WAIT 40 ButtonDynamicImage(dvPanel, nAddressLanguage[20],"'languageT'")
	WAIT 42 ButtonDynamicImage(dvPanel, nAddressLanguage[21],"'languageU'")
	WAIT 44 ButtonDynamicImage(dvPanel, nAddressLanguage[22],"'languageV'")
	WAIT 46 ButtonDynamicImage(dvPanel, nAddressLanguage[23],"'languageW'")
	WAIT 48 ButtonDynamicImage(dvPanel, nAddressLanguage[24],"'languageX'")
	WAIT 50 ButtonDynamicImage(dvPanel, nAddressLanguage[25],"'languageY'")
}

DEFINE_FUNCTION ProductImagesRedraw()
{
	/*STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < 16; nCount++)
	{
		ButtonDynamicImage(dvPanel, nAddressProduct[nCount],"'product', nCount + 64")
	}*/
	WAIT 2 ButtonDynamicImage(dvPanel, nAddressProduct[1],"'productA'")
	WAIT 4 ButtonDynamicImage(dvPanel, nAddressProduct[2],"'productB'")
	WAIT 6 ButtonDynamicImage(dvPanel, nAddressProduct[3],"'productC'")
	WAIT 8 ButtonDynamicImage(dvPanel, nAddressProduct[4],"'productD'")
	WAIT 10 ButtonDynamicImage(dvPanel, nAddressProduct[5],"'productE'")
	WAIT 12 ButtonDynamicImage(dvPanel, nAddressProduct[6],"'productF'")
	WAIT 14 ButtonDynamicImage(dvPanel, nAddressProduct[7],"'productG'")
	WAIT 16 ButtonDynamicImage(dvPanel, nAddressProduct[8],"'productH'")
	WAIT 18 ButtonDynamicImage(dvPanel, nAddressProduct[9],"'productI'")
	WAIT 20 ButtonDynamicImage(dvPanel, nAddressProduct[10],"'productJ'")
	WAIT 22 ButtonDynamicImage(dvPanel, nAddressProduct[11],"'productK'")
	WAIT 24 ButtonDynamicImage(dvPanel, nAddressProduct[12],"'productL'")
	WAIT 26 ButtonDynamicImage(dvPanel, nAddressProduct[13],"'productM'")
	WAIT 28 ButtonDynamicImage(dvPanel, nAddressProduct[14],"'productN'")
	WAIT 30 ButtonDynamicImage(dvPanel, nAddressProduct[15],"'productO'")
}

DEFINE_FUNCTION ImagesReload()
{
	STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < 26; nCount++)
	{
		SEND_COMMAND dvPanel,"'^RMF-language',(nCount + 64),',%P',cImageProtocol"
		SEND_COMMAND dvPanel,"'^RMF-language',(nCount + 64),',%H',cImageServer"
		SEND_COMMAND dvPanel,"'^RMF-language',(nCount + 64),',%U',cImageUsername"
		SEND_COMMAND dvPanel,"'^RMF-language',(nCount + 64),',%S',cImagePassword"
		SEND_COMMAND dvPanel,"'^RMF-language',(nCount + 64),',%A',cImagePath"
		SEND_COMMAND dvPanel,"'^RMF-language',(nCount + 64),',%Flanguage',(nCount + 64),'.png'"
		SEND_COMMAND dvpanel,"'^RFR-language',(nCount + 64)"
	}
	FOR (nCount = 1; nCount < 16; nCount++)
	{
		SEND_COMMAND dvPanel,"'^RMF-product',(nCount + 64),',%P',cImageProtocol"
		SEND_COMMAND dvPanel,"'^RMF-product',(nCount + 64),',%H',cImageServer"
		SEND_COMMAND dvPanel,"'^RMF-product',(nCount + 64),',%U',cImageUsername"
		SEND_COMMAND dvPanel,"'^RMF-product',(nCount + 64),',%S',cImagePassword"
		SEND_COMMAND dvPanel,"'^RMF-product',(nCount + 64),',%A',cImagePath"
		SEND_COMMAND dvPanel,"'^RMF-product',(nCount + 64),',%Fproduct',(nCount + 64),'.png'"
		SEND_COMMAND dvpanel,"'^RFR-product',(nCount + 64)"
	}
	FOR (nCount = 1; nCount < 21; nCount++)
	{
		SEND_COMMAND dvPanel,"'^RMF-screen',(nCount + 64),',%P',cImageProtocol"
		SEND_COMMAND dvPanel,"'^RMF-screen',(nCount + 64),',%H',cImageServer"
		SEND_COMMAND dvPanel,"'^RMF-screen',(nCount + 64),',%U',cImageUsername"
		SEND_COMMAND dvPanel,"'^RMF-screen',(nCount + 64),',%S',cImagePassword"
		SEND_COMMAND dvPanel,"'^RMF-screen',(nCount + 64),',%A',cImagePath"
		SEND_COMMAND dvPanel,"'^RMF-screen',(nCount + 64),',%Fscreen',(nCount + 64),'.png'"
		SEND_COMMAND dvpanel,"'^RFR-screen',(nCount + 64)"
	}
}

DEFINE_FUNCTION ParseFilePath()
{
	STACK_VAR CHAR cInput[100]
	STACK_VAR INTEGER nCount
	cInput = cFilePath
	IF (LEFT_STRING(cFilePath, 7) == 'http://')
	{
		cImageProtocol = '0'
		cInput = RIGHT_STRING(cFilePath, LENGTH_STRING(cFilePath) - 7)

	}
	ELSE IF (LEFT_STRING(cFilePath, 6) == 'ftp://')
	{
		cImageProtocol = '1'
		cInput = RIGHT_STRING(cFilePath, LENGTH_STRING(cFilePath) - 6)
	}
	ELSE
	{
		RETURN
	}
	nCount = FIND_STRING(cInput, '/', 1)
	IF (nCount > 0)
	{
		cImageServer = LEFT_STRING(cInput, nCount - 1)
		cImagePath = RIGHT_STRING(cInput, LENGTH_STRING(cInput) - nCount + 1)
	}
}

DEFINE_FUNCTION PanelFeedback()
{
	STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < 11; nCount++)
	{
		[dvPanel, nButtonLanguageSlot[nCount]] = (nLanguageCurrent == nLanguageSlot[nCount])
		[dvPanel, nButtonProductSlot[nCount]] = (nProductCurrent == nProductSlot[nCount])
	}
	FOR (nCount = 1; nCount < 6; nCount++)
	{
		[dvPanel, nButtonProductPage[nCount]] = (nProductPageCurrent == nCount)
	}
	IF (cSetupActive && (nSetupPageCurrent == nSetupPageOptions))
	{
		FOR (nCount = 1; nCount < 4; nCount++)
		{
			[dvPanel, nButtonScreensaverType[nCount]] = (nScreensaverType == nCount)
		}
		FOR (nCount = 1; nCount < 11; nCount++)
		{
			[dvPanel, nButtonScreensaverTimeout[nCount]] = (nScreensaverTimeoutCurrent == nCount)
		}
	}
	IF (nSetupLanguageChoosing > 0)
	{
		FOR (nCount = 1; nCount < 26; nCount++)
		{
			[dvPanel, nButtonSetupLanguage[nCount]] = (nLanguageSlot[nSetupLanguageChoosing] == nCount)
		}
	}
	IF (nSetupProductChoosing > 0)
	{
		FOR (nCount = 1; nCount < 16; nCount++)
		{
			[dvPanel, nButtonSetupProduct[nCount]] = (nProductSlot[nSetupProductChoosing] == nCount)
		}
	}
	FOR (nCount = 1; nCount < 5; nCount++)
	{
		[dvPanel, nButtonSetupPage[nCount]] = (nSetupPageCurrent == nCount)
	}
	[dvPanel,nButtonKeyboard[1]] = cCapsLockOn
	[dvPanel,nButtonKeyboard[2]] = cShiftOn
	FOR (nCount = 1; nCount < 16; nCount++)
	{
		[dvPanel, nButtonSerialPortProduct[1][nCount]] = (vdvProductLink[nCount] == dvSerial1)
		[dvPanel, nButtonSerialPortProduct[2][nCount]] = (vdvProductLink[nCount] == dvSerial2)
	}
}

DEFINE_FUNCTION PanelActive(CHAR cState)
{
	STACK_VAR CHAR cOldState
	STACK_VAR CHAR cFlag
	STACK_VAR INTEGER nCount
	CANCEL_WAIT 'ScreensaverTimeout'
	cOldState = cPanelActive
	IF (cState != cOldState)
	{
		cFlag = true
	}
	ELSE
	{
		cFlag = false
	}
	IF (cState)
	{
		cPanelActive = true
		IF (TIMELINE_ACTIVE(lTimelineScreensaver))
		{
			TIMELINE_KILL(lTimelineScreensaver)
		}
		IF (cFlag)
		{
			cPanelActive = true
			cLanguageChoosing = false
			cProductChoosing = false
			cPINActive = false
			cSetupActive = false
			cFilePathActive = false
			nSetupLanguageChoosing = 0
			nSetupProductChoosing = 0
			nProductPageCurrent = 1
			IF (nProductCurrent == 0)
			{
				FOR (nCount = 1; nCount <= 11; nCount++)
				{
					IF (nProductSlot[nCount] != 0)
					{
						nProductCurrent = nCount
						BREAK
					}
				}
				IF (nProductCurrent == 0)
				{
					nProductCurrent = 1
				}
			}
			SEND_COMMAND vdvProduct[nProductCurrent], 'PAGE-1'
			SEND_COMMAND vdvProduct[nProductCurrent],'ENABLE'
			PanelRedraw()
		}
		IF (nScreensaverTimeout[nScreensaverTimeoutCurrent] > 0)
		{
			WAIT 600 * nScreensaverTimeout[nScreensaverTimeoutCurrent] 'ScreensaverTimeout'
			{
				cPanelActive = false
				cLanguageChoosing = false
				cProductChoosing = false
				cPINActive = false
				cSetupActive = false
				cFilePathActive = false
				nSetupLanguageChoosing = 0
				nSetupProductChoosing = 0
				IF (nProductCurrent > 0)
				{
					SEND_COMMAND vdvProduct[nProductCurrent],'DISABLE'
				}
				PanelRedraw()
			}
		}
	}
	ELSE
	{
		cPanelActive = false
	}
	IF (cFlag)
	{
		PanelRedraw()
	}
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ParseFilePath()

(***********************************************************)
(*                   MODULES GO BELOW                      *)
(***********************************************************)

DEFINE_MODULE 'Yamaha DME24 UI'						Module001(vdvProduct1Comms, dvPanelProduct1)
DEFINE_MODULE 'Yamaha DME64 UI'						Module002(vdvProduct2Comms, dvPanelProduct2)
DEFINE_MODULE 'Yamaha DME4 UI'						Module003(vdvProduct3Comms, dvPanelProduct3)
DEFINE_MODULE 'Yamaha LS9 UI'						Module004(vdvProduct4, dvPanelProduct4)
DEFINE_MODULE 'Yamaha M7CL UI'						Module005(vdvProduct5, dvPanelProduct5)
DEFINE_MODULE 'Yamaha 01V UI'						Module006(vdvProduct6, dvPanelProduct6)

DEFINE_MODULE 'Yamaha BD-S2900 UI'					Module007(vdvProductLink[7], dvPanelProduct7, cProductText[7])
DEFINE_MODULE 'Yamaha IMX644 UI'					Module008(vdvProductLink[8], dvPanelProduct8)

DEFINE_MODULE 'Yamaha DME Comms'					Module051(vdvProduct1, vdvProductLink[1])
DEFINE_MODULE 'Yamaha DME Comms'					Module052(vdvProduct2, vdvProductLink[2])
DEFINE_MODULE 'Yamaha DME Comms'					Module053(vdvProduct3, vdvProductLink[3])
DEFINE_MODULE 'Yamaha LS9 Comms'					Module054(vdvProduct4, vdvProductLink[4])
DEFINE_MODULE 'Yamaha M7CL Comms'					Module055(vdvProduct5, vdvProductLink[5])
DEFINE_MODULE 'Yamaha 01V Comms'					Module056(vdvProduct6, vdvProductLink[6])

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvPanel]
{
	ONLINE:
	{
		SET_VIRTUAL_PORT_COUNT(dvPanel, 20)
		ImagesReload()
		WAIT 10
		{
			PanelRedraw()
		}
		WAIT 20
		{
			LanguageTextRedraw()
		}
	}
}

BUTTON_EVENT[dvPanel, 0]
BUTTON_EVENT[dvPanelProduct, 0]
{
	PUSH:
	{
		PanelActive(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonTouchToStart]
{
	PUSH:
	{
		nProductPageCurrent = 1
		SEND_COMMAND vdvProduct[nProductCurrent], 'ENABLE'
		SEND_COMMAND vdvProduct[nProductCurrent], 'PAGE-1'
		PanelActive(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonLanguage]
{
	PUSH:
	{
		cLanguageChoosing = true
		PanelRedraw()
	}
}

BUTTON_EVENT[dvPanel, nButtonLanguageSlot]
{
	PUSH:
	{
		STACK_VAR INTEGER nLanguage
		nLanguage = GET_LAST(nButtonLanguageSlot)
		IF (nLanguageSlot[nLanguage] != 0)
		{
			nLanguageCurrent = nLanguageSlot[nLanguage]
			cLanguageChoosing = false
			PanelRedraw()
			LanguageTextRedraw()
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonProduct]
{
	PUSH:
	{
		cProductChoosing = true
		SEND_COMMAND vdvProduct[nProductCurrent], 'DISABLE'
		PanelRedraw()
	}
}

BUTTON_EVENT[dvPanel, nButtonProductSlot]
{
	PUSH:
	{
		STACK_VAR INTEGER nProduct
		nProduct = GET_LAST(nButtonProductSlot)
		IF (nProductSlot[nProduct] != 0)
		{
			nProductCurrent = nProductSlot[nProduct]
			cProductChoosing = false
			nProductPageCurrent = 1
			SEND_COMMAND vdvProduct[nProductCurrent], 'PAGE-1'
			SEND_COMMAND vdvProduct[nProductCurrent], 'ENABLE'
			PanelRedraw()
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonProductPage]
{
	PUSH:
	{
		nProductPageCurrent = GET_LAST(nButtonProductPage)
		SEND_COMMAND vdvProduct[nProductCurrent],"'PAGE-', ITOA(nProductPageCurrent)"
		PanelRedraw()
	}
}

BUTTON_EVENT[dvPanel, nButtonProductControl]
{
	PUSH:
	{
		// all done in the active product module
	}
}

BUTTON_EVENT[dvPanel, nButtonScreensaverType]
{
	PUSH:
	{
		nScreensaverType = GET_LAST(nButtonScreensaverType)
	}
}

BUTTON_EVENT[dvPanel, nButtonScreensaverTimeout]
{
	PUSH:
	{
		nScreensaverTimeoutCurrent = GET_LAST(nButtonScreensaverTimeout)
	}
}

BUTTON_EVENT[dvPanel, nButtonSetupLanguageSlot]
{
	PUSH:
	{
		nSetupLanguageChoosing = GET_LAST(nButtonSetupLanguageSlot)
		PanelRedraw()
	}
}

BUTTON_EVENT[dvPanel, nButtonSetupLanguage]
{
	PUSH:
	{
		IF (nSetupLanguageChoosing > 0)
		{
			nLanguageSlot[nSetupLanguageChoosing] = GET_LAST(nButtonSetupLanguage) - 1
			nSetupLanguageChoosing = 0
			PanelRedraw()
			WAIT 5
			{
				LanguageSlotImagesRedraw()
			}
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonSetupProductSlot]
{
	PUSH:
	{
		nSetupProductChoosing = GET_LAST(nButtonSetupProductSlot)
		PanelRedraw()
	}
}

BUTTON_EVENT[dvPanel, nButtonSetupProduct]
{
	PUSH:
	{
		IF (nSetupProductChoosing > 0)
		{
			nProductSlot[nSetupProductChoosing] = GET_LAST(nButtonSetupProduct) - 1
			nSetupProductChoosing = 0
			PanelRedraw()
			WAIT 5
			{
				ProductSlotImagesRedraw()
			}
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonSetup]
{
	PUSH:
	{
	}
	HOLD[20]:
	{
		nPINEntered = 0
		cPINActive = true
		PanelRedraw()
	}
	RELEASE:
	{
		IF (!cPINActive)
		{
			PanelActive(false)
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonPIN]
{
	PUSH:
	{
		STACK_VAR nButton
		TO[button.input]
		nButton = GET_LAST(nButtonPIN)
		SWITCH (nButton)
		{
			CASE 1:
			CASE 2:
			CASE 3:
			CASE 4:
			CASE 5:
			CASE 6:
			CASE 7:
			CASE 8:
			CASE 9:
			CASE 10:		// digits 0 to 9
			{
				nPINEntered = (10 * nPINEntered) + nButton - 1
				BREAK
			}
			CASE 11:		// cancel
			{
				cPINActive = false
				PanelRedraw()
				BREAK
			}
			CASE 12:		// enter
			{
				cPINActive = false
				cSetupActive = (nPINEntered == nPINCorrect)
				PanelRedraw()
				BREAK
			}
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonSetupDone]
{
	PUSH:
	{
		cPINActive = false
		cSetupActive = false
		PanelRedraw()
	}
}

BUTTON_EVENT[dvPanel, nButtonSetupPage]
{
	PUSH:
	{
		nSetupPageCurrent = GET_LAST(nButtonSetupPage)
		PanelRedraw()
	}
}

BUTTON_EVENT[dvPanel, nButtonSetupFilePath]
{
	PUSH:
	{
		cFilePathActive = true
		ButtonText(dvPanel, nAddressKeyboard, cFilePath)
		PanelRedraw()
	}
}

BUTTON_EVENT[dvPanel, nButtonKeyboard]
{
	PUSH:
	{
		LOCAL_VAR CHAR cText[100]
		STACK_VAR INTEGER nButton
		nButton = GET_LAST(nButtonKeyboard)
		SWITCH(nButton)
		{
			CASE 1:
			{
				cCapsLockOn = !cCapsLockOn
				cShiftOn = false
				BREAK
			}
			CASE 2:
			{
				IF (cCapsLockOn)
				{
					cCapsLockOn = false
				}
				ELSE
				{
					cShiftOn = !cShiftOn
				}
				BREAK
			}
			CASE 3:
			{
				cText = ''
				cFilePathActive = false
				PanelRedraw()
				BREAK
			}
			CASE 4:
			{
				TO[button.input]
				IF (LENGTH_STRING(cText))
				{
					cText = LEFT_STRING(cText, LENGTH_STRING(cText) - 1)
				}
				BREAK
			}
			CASE 5:
			{
				TO[button.input]
				IF (FIND_STRING(cText, '?', 1) || FIND_STRING(cText, '*', 1) || FIND_STRING(cText, '"', 1) || FIND_STRING(cText, '<', 1) || FIND_STRING(cText, '>', 1))
				{
					BREAK
				}
				cFilePath = cText
				cText = ''
				cFilePathActive = false
				ParseFilePath()
				ImagesReload()
				PanelRedraw()
				BREAK
			}
			CASE 6:
			{
				TO[button.input]
				cText = "cText, ' '"
				BREAK
			}
			CASE 7:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '"'"
				}
				ELSE
				{
					cText = "cText, ''''"
				}
				BREAK
			}
			CASE 8:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '<'"
				}
				ELSE
				{
					cText = "cText, ','"
				}
				BREAK
			}
			CASE 9:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '_'"
				}
				ELSE
				{
					cText = "cText, '-'"
				}
				BREAK
			}
			CASE 10:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '>'"
				}
				ELSE
				{
					cText = "cText, '.'"
				}
				BREAK
			}
			CASE 11:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '?'"
				}
				ELSE
				{
					cText = "cText, '/'"
				}
				BREAK
			}
			CASE 12:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, ':'"
				}
				ELSE
				{
					cText = "cText, ';'"
				}
				BREAK
			}
			CASE 13:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '+'"
				}
				ELSE
				{
					cText = "cText, '='"
				}
				BREAK
			}
			CASE 14:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '{'"
				}
				ELSE
				{
					cText = "cText, '['"
				}
				BREAK
			}
			CASE 15:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '|'"
				}
				ELSE
				{
					cText = "cText, '\'"
				}
				BREAK
			}
			CASE 16:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '}'"
				}
				ELSE
				{
					cText = "cText, ']'"
				}
				BREAK
			}
			CASE 17:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '~'"
				}
				ELSE
				{
					cText = "cText, '`'"
				}
				BREAK
			}
			CASE 18:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, ')'"
				}
				ELSE
				{
					cText = "cText, '0'"
				}
				BREAK
			}
			CASE 19:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '!'"
				}
				ELSE
				{
					cText = "cText, '1'"
				}
				BREAK
			}
			CASE 20:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '@'"
				}
				ELSE
				{
					cText = "cText, '2'"
				}
				BREAK
			}
			CASE 21:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '#'"
				}
				ELSE
				{
					cText = "cText, '3'"
				}
				BREAK
			}
			CASE 22:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '$'"
				}
				ELSE
				{
					cText = "cText, '4'"
				}
				BREAK
			}
			CASE 23:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '%'"
				}
				ELSE
				{
					cText = "cText, '5'"
				}
				BREAK
			}
			CASE 24:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '^'"
				}
				ELSE
				{
					cText = "cText, '6'"
				}
				BREAK
			}
			CASE 25:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '&'"
				}
				ELSE
				{
					cText = "cText, '7'"
				}
				BREAK
			}
			CASE 26:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '*'"
				}
				ELSE
				{
					cText = "cText, '8'"
				}
				BREAK
			}
			CASE 27:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, '('"
				}
				ELSE
				{
					cText = "cText, '9'"
				}
				BREAK
			}
			CASE 28:
			CASE 29:
			CASE 30:
			CASE 31:
			CASE 32:
			CASE 33:
			CASE 34:
			CASE 35:
			CASE 36:
			CASE 37:
			CASE 38:
			CASE 39:
			CASE 40:
			CASE 41:
			CASE 42:
			CASE 43:
			CASE 44:
			CASE 45:
			CASE 46:
			CASE 47:
			CASE 48:
			CASE 49:
			CASE 50:
			CASE 51:
			CASE 52:
			CASE 53:
			{
				TO[button.input]
				IF (cCapsLockOn || cShiftOn)
				{
					cText = "cText, nButton + 37"
				}
				ELSE
				{
					cText = "cText, nButton + 69"
				}
				BREAK
			}
			DEFAULT:
			{
			}
		}
		ButtonText(dvPanel, nAddressKeyboard, cText)
	}
}

BUTTON_EVENT[dvPanel,nButtonSerialPortProduct[1]]
{
	PUSH:
	{
		STACK_VAR INTEGER nProduct
		STACK_VAR INTEGER nCount
		nProduct = GET_LAST(nButtonSerialPortProduct[1])
		FOR (nCount = 1; nCount < 16; nCount++)
		{
			IF (vdvProductLink[nCount] == dvSerial1)
			{
				vdvProductLink[nCount] = vdvNull
			}
		}
		vdvProductLink[nProduct] = dvSerial1
	}
}

BUTTON_EVENT[dvPanel,nButtonSerialPortProduct[2]]
{
	PUSH:
	{
		STACK_VAR INTEGER nProduct
		STACK_VAR INTEGER nCount
		nProduct = GET_LAST(nButtonSerialPortProduct[2])
		FOR (nCount = 1; nCount < 16; nCount++)
		{
			IF (vdvProductLink[nCount] == dvSerial2)
			{
				vdvProductLink[nCount] = vdvNull
			}
		}
		vdvProductLink[nProduct] = dvSerial2
	}
}

DATA_EVENT[vdvProduct1]
{
	ONLINE:
	{
		SEND_COMMAND vdvProduct1, 'DISABLE'
		SEND_COMMAND vdvProduct1, 'PROPERTY-IP_Address,'
		SEND_COMMAND vdvProduct1, 'PROPERTY-Port,0'
		SEND_COMMAND vdvProduct1,"'REINIT'"
	}
}

DATA_EVENT[vdvProduct2]
{
	ONLINE:
	{
		SEND_COMMAND vdvProduct2, 'DISABLE'
		SEND_COMMAND vdvProduct2, 'PROPERTY-IP_Address,'
		SEND_COMMAND vdvProduct2, 'PROPERTY-Port,0'
		SEND_COMMAND vdvProduct2,"'REINIT'"
	}
}

DATA_EVENT[vdvProduct3]
{
	ONLINE:
	{
		SEND_COMMAND vdvProduct3, 'DISABLE'
		SEND_COMMAND vdvProduct3, 'PROPERTY-IP_Address,192.168.0.103'
		SEND_COMMAND vdvProduct3, 'PROPERTY-Port,49152'
		SEND_COMMAND vdvProduct3,"'REINIT'"
	}
}

DATA_EVENT[vdvProduct4]
{
	ONLINE:
	{
		SEND_COMMAND vdvProduct4, 'DISABLE'
		SEND_COMMAND vdvProduct4, "'SETMIDICHANNEL-',ITOA(cMidiChannel[4])"
		SEND_COMMAND vdvProduct4, 'INIT'
	}
}

DATA_EVENT[vdvProduct5]
{
	ONLINE:
	{
		SEND_COMMAND vdvProduct5, 'DISABLE'
		SEND_COMMAND vdvProduct5, "'SETMIDICHANNEL-',ITOA(cMidiChannel[5])"
		SEND_COMMAND vdvProduct5, 'INIT'
	}
}

DATA_EVENT[vdvProduct6]
{
	ONLINE:
	{
		SEND_COMMAND vdvProduct6, 'DISABLE'
		SEND_COMMAND vdvProduct6, "'SETMIDICHANNEL-',ITOA(cMidiChannel[6])"
		SEND_COMMAND vdvProduct6, 'INIT'
	}
}

DATA_EVENT[vdvProduct7]
{
	ONLINE:
	{
	}
}

DATA_EVENT[dvMIDI]
{
	ONLINE:
	{
		SEND_COMMAND dvMIDI,'INA-5'
		SEND_COMMAND dvMIDI,'INB-5'
	}
}

TIMELINE_EVENT[lTimelineScreensaver]
{
	LOCAL_VAR nImage
	SWITCH (timeline.sequence)
	{
		CASE 1:
		{
			nImage++
			IF (nImage > 20)
			{
				nImage = 1
			}
			ButtonDynamicImage(dvPanel, nAddressScreensaverSlide, "'screen', 64 + nImage")
		}
		DEFAULT:
		{
		}
	}
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

WAIT 1
{
	PanelFeedback()
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
