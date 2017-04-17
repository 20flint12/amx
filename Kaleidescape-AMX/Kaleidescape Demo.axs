PROGRAM_NAME='Kaleidescape Demo'
/*******************************************************************************************
 * Program Information
 *******************************************************************************************/

/*
 * (c) 2004-2014 Kaleidescape Inc.  Please see legal notice below.
 *
 * Version 8.4.0
 * Dated Feb 27, 2014
 *
 * This module has been created and supported by Kaleidescape Inc.
 * This module is supported directly by Kaleidescape Inc.  Please
 * direct all inquiries regarding this module to  Kaleidescape support
 * at (650) 625-6160.  AMX does not support this module itself.
 *
 * ----------------------------------------------------------------------
 *
 * LEGAL NOTICE
 *     (c) 2004-2014 Kaleidescape Inc. This Source Code is the intellectual
 * property of Kaleidescape, Inc. Kaleidescape grants the non-exclusive
 * right to modify and/or compile and/or compress the Source Code, and
 * upload such modified and/or compiled and/or compressed Source Code
 * to control systems that control at least one licensed Kaleidescape
 * System. No right is granted to otherwise copy, reproduce, modify,
 * upload, download, transmit, or distribute the Source Code, or
 * derivative works, in any way. The Source Code, and derivative works,
 * are protected by copyright, trade secret, and other intellectual
 * property laws and by international treaties, which provide rights
 * and obligations in addition to the rights and obligations set forth here.
 */

/*******************************************************************************************
 * Device Definitions
 *******************************************************************************************/
DEFINE_DEVICE

KALEIDESCAPE_PORT	= 0:4:0 //IP interface
//KALEIDESCAPE_PORT 	= 5001:1:0 //KPlayer 232 interface

TP_ONE			= 10001:1:0
//TP_TWO		= 10002:1:0
//TP_THREE		= 128:1:0

INCLUDE 'Kaleidescape Multiple Panel Include'

/*******************************************************************************************
 * Startup Code
 *******************************************************************************************/
DEFINE_START
send_command 33001, 'debug'	//enable Kaleidescape Module debugging
//End of File
