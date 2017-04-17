PROGRAM_NAME='Kaleidescape Include'
/*******************************************************************************************
 * File Information
 *******************************************************************************************/

/*
 * (c) 2004-2014 Kaleidescape Inc.  Please see legal notice below.
 *
 * Version 8.4.0
 * Dated Feb 27, 2014
 *
 * This module has been created and is supported by directly by
 * Kaleidescape Inc.  Please direct all inquiries regarding this
 * module to Kaleidescape support at (650) 625-6160.  AMX does
 * not support this module itself.
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
 *  Device Definitions
 *******************************************************************************************/
DEFINE_DEVICE

/********************************************************
 *  Create a virtual device per KPlayer controlled.     *
 ********************************************************/
KPLAYER1	 = 33001:1:0
//KPLAYER2	 = 33002:1:0
//KPLAYER3	 = 33003:1:0

//KZone1	 	= 34001:1:0
//KZone2	 	= 34002:1:0
//KZone3		= 34003:1:0

/********************************************************
 *  Define structures to handle volume events           *
 ********************************************************/
DEFINE_TYPE

STRUCTURE STRUCT_Controller_ID		// Structure to hold properties of a Kaleidescape
{					// controller configured with a controller zone name
    char	controllerZoneName[50]
    integer	zoneToControl
    dev		lastKplayer

}

STRUCTURE STRUCT_Volume_Properties	// Structure to hold volume capabilities and attributes
{					// of a zone. Used with Kaleidescape controllers that
    char	capability[50]		// support volume control, and Kaleidescape IR volume commands.
    integer	muteStatus
    integer	volLevel
    integer	volUpChannel
    integer	volDownChannel
    integer	volMuteChannel
}

/*******************************************************************************************
 *  Global Variables
 *******************************************************************************************/
DEFINE_VARIABLE
integer startUpLoop

/********************************************************
 *  If using Kaleidescape IR volume commands or	a	*
 *  Kaleidescape controller configured without a 	*
 *  controller zone name, remove the comments from  	*
 *  the volumeByPlayer code block and make 		*
 *  numberOfPlayers equal to the number of virtual 	*
 *  devices in the KPlayer array.			*
 *							*
 *  If using a Kaleidescape controller with a 		*
 *  controller zone name remove the comments from the 	*
 *  volumeByZone code block and define the number of 	*
 *  Kaleidescape controllers configured with a  	*
 *  controller zone name, and  the number of zones the 	*
 *  players can be used in. numberOfZones should be 	*
 *  equal to the length of KZones.			*
 *							*
 *  See Programming AMX Controllers for a 		*
 *  Kaleidescape system for complete instructions.	*
 ********************************************************/

/*
#DEFINE volumeByPlayer
constant numberOfPlayers = 2
*/
/*
#DEFINE volumeByZone
constant numberOfControllers	 = 2
constant numberOfZones	 = 3
*/


/********************************************************
 *  Put all KPLAYER virtual devs into one array		*
 ********************************************************/
dev Kplayer[] = //Add any additional controlled players here
{
    KPLAYER1
//    KPLAYER2,
//    KPLAYER3
}

/********************************************************
 *  Define all the touch panels that will control a     *
 *  Kaleidescape Player and which player they will      *
 *  control.                                            *
 ********************************************************/
//An array of all the touch panels that will control the K Players
dev KTouchPanels[] =
{
    TP_ONE
//    TP_TWO,
//    TP_THREE
}

//This array determines what player each touch panel controls
integer controlledKplayer[] = //for each touch panel, add an entry to this array
{
    1		//First TP to control Player 1
//    2,	//Second TP to control Player 2
//    3		//Third TP to control Player 3
}


/*
 * An array of all the zones whose volume can be controlled by
 * the Kaleidescape App, will only be compiled if volumeByZone
 * is defined.
 */
#IF_DEFINED volumeByZone
dev KZones[] =
{
    KZone1,
    KZone2,
    KZone3
}
#END_IF


/********************************************************
 *  Create an array of the Kaleidescape TP page names.  *
 *  These pages are called when the player flips to the *
 *  indicated page.                                     *
 ********************************************************/
char KTouchpanelPages[20][20] //page names on the touch panel for automatic page flip

/********************************************************
 *  Create an array of the Kaleidescape TP popup names. *
 *  These popups are called at various points.          *
 ********************************************************/
char KTouchpanelPopups[10][30] //popup names on the touch panel

/***********************************************************
 *  Create an array of the Kaleidescape TP resource names. *
 *  These resources are updated with the URL of the        *
 *  appropriate images.                                    *
 ***********************************************************/
char KTouchpanelResources[3][20] //resource names on the touch panel

/**********************************************************
 *  Create an array of the Kaleidescape TP bitmap names.  *
 *  These are used in SATP to indicate the status of each *
 *  line shown on the touch panel text window.            *
 *********************************************************/
char KTouchpanelIcons[3] = //icons on the touch panel
{
    3, //play
    2, //pause
    1 //checkmark
}

/********************************************************
 *  Create an array of the Variable Text fields to      *
 *  populate on the touch panel.                        *
 ********************************************************/
integer KVariableTextFields[32] =
{
    1,			//Movie Title
    2,			//Chapter number
    3,			//Total track time
    4,			//Remaining track time
    5,            	//Current track time
    6,			//Keyboard & Keypad prompt
    7,			//Keyboard & Keypad entry field
    0,	//unused	//Player friendly name
    8,			//Details title
    9,			//Details info
    11,			//Song Name
    12,			//Album Name
    13,			//Artist Name
    14,			//SATP Search Button
    15,			//SATP Keyboard Text feedback
    16,			//SATP Search Mini Result
    17,			//Now Playing Item
    18,			//PRESET 1 Label
    19,			//PRESET 2 Label
    20,			//PRESET 3 Label
    21,			//PRESET 4 Label
    22,			//PRESET 5 Label
    23,			//PRESET 6 Label
    24,			//PRESET 7 Label
    25,			//PRESET 8 Label
    26,			//PRESET 9 Label
    27,			//PRESET 10 Label
    00,	//unused	//Future use
    00,	//unused	//Future use
    30,			//Connection status message
    31,			//Retry connection button
    32			//Connection progress bar
}

/********************************************************
 *  Define arrays to store information used by the 	*
 *  volume control routines when volume can be	 	*
 *  controlled by Kaleidescape controllers		*
 ********************************************************/

#IF_DEFINED volumeByPlayer
/*
 * This array holds the volume capabilities, volume level, and mute status
 * of a zone when volume commands will be received from IR or from a
 * Kaleidescape controller configured without a controller zone name.
 */
STRUCT_Volume_Properties playerVolumeProperties[numberOfPlayers]
#END_IF


#IF_DEFINED volumeByZone
/*
 * This array holds the volume capabilities, volume level, and mute status
 * of a zone when volume commands will be received from IR or from a
 * Kaleidescape controller configured without a controller zone name.
 */
STRUCT_Volume_Properties zoneVolumeProperties[numberOfZones]
/*
 * This array holds information about Kaleidescape controllers
 * configured with a controller zone name.
 */
STRUCT_Controller_ID controllerProperties[numberOfControllers]
#END_IF



/********************************************************
 *  The following two arrays are only needed under      *
 *  special circumstances.  If the keyboard strings come*
 *  from a different device than the button and level   *
 *  events, enable these arrays and define the          *
 *  information just as above.                          *
 ********************************************************/
//An array of all the keyboard devices that will control the K Players
/*dev keyboardDev[] =
{
    TP_ONE_KEYB  //Note that this is different than the TP_ONE above.
    //TP_TWO_KEYB,
    //TP_THREE_KEYB,
}

//This array determines what player each touch panel keyboard controls
integer controlledKplayerKeyboard[] =
{
    1          //First TP Keyboard to control Player 1
    //2,       //Second TP Keyboard to control Player 2
    //1,       //Third TP Keyboard to control Player 1
}
*/

DEFINE_CONSTANT
LastInputChannel = 255

/********************************************************
 *  These values can be sent to Kaleidescape 		*
 *  controllers to show volume buttons and feedback	*
 ********************************************************/
No_volume_control_or_feedback			= '0'
Volume_control_but_no_mute_or_feedback		= '1'
Volume_and_mute_control_but_no_feedback		= '3'
Volume_control_and_feedback_but_no_Mute		= '5'
Volume_and_mute_control_with_volume_feedback	= '7'
Volume_and_mute_control_with_feedback		= '15'


/*********************************************************
 *  Define the module with the created variables/devices.*
 *********************************************************/
DEFINE_MODULE 'Kaleidescape' Kplayers (
	    KALEIDESCAPE_PORT, 		//port (232 or TCP/IP) used for communication with
					//the Kaleidescape System
	    Kplayer, 			//virtual device array for communicating with one
					//or more Kaleidescape Players
	    KVariableTextFields,	//Variable text fields to use on the touch panel
	    KTouchpanelPages, 		//Pages to flip to on the touch panel for
					//various OSD states
	    KTouchpanelPopups, 		//Popup pages to turn on/off on the touch panel
	    KTouchpanelResources, 	//Touch panel resources (cover art) to update
	    KTouchpanelIcons) 		//Bitmaps to use


/******************************************************************************************
 *  Startup code									  *
 ******************************************************************************************/
DEFINE_START

//Populate the TP page names array
KTouchpanelPages[1] = 'K MovieList'		//Movie List control page
KTouchpanelPages[2] = 'K Collections'		//Movie Collections control page
KTouchpanelPages[3] = 'K CoverArt'		//Movie Covers control page
KTouchpanelPages[4] = 'K ParentalControl'	//Parental controls page
KTouchpanelPages[5] = ''			//unused - reserved for future use
KTouchpanelPages[6] = ''			//Screen Saver enabled
KTouchpanelPages[7] = 'K Movie Playing'		//Playing a movie
KTouchpanelPages[8] = 'K StatusScreen'		//System status page
KTouchpanelPages[9] = 'K MusicList'		//Music List control page
KTouchpanelPages[10]= 'K MusicCovers'		//Music Covers control page
KTouchpanelPages[11]= 'K MusicCollections'	//Music Collections control page
KTouchpanelPages[12]= 'K MusicNowPlaying'	//Music Now Playing control page



KTouchpanelPopups[1] = 'K Keyboard'		//Keyboard popup page
KTouchpanelPopups[2] = 'K Keypad'		//Numeric keypad popup page
KTouchpanelPopups[3] = 'K Music Playing'	//Music Playing info popup
KTouchpanelPopups[4] = 'K Details'		//Details popup (only used for OSD w/o Video control)
KTouchpanelPopups[5] = ''			//SATP Now Playing popup
KTouchpanelPopups[6] = 'K SATP Keyboard Search'	//SATP Keyboard Search
KTouchpanelPopups[7] = 'K Bluray Keys'		//Bluray controls
KTouchpanelPopups[8] = 'K Connection Status'	//Connection Status

KTouchpanelResources[1] = 'K Now Playing Cover'	//Cover art for the currently playing item
KTouchpanelResources[2] = 'K Details Cover'	//Cover art for the currently showing details
KTouchpanelResources[3] = ''			//unused - reserved for future use

/*********************************************************
 *  Define volume properties by player.			 *
 *********************************************************/
/*
 * Define a player's volume capabilities for Kaleidescape
 * controllers that are not configured with a controller
 * zone name. In this configuration the volume events are
 * sent to and received from the virtual device for
 * the player that received them.
 *
 * If volUpChannel, volDownChannel, or volMuteChannel are not
 * defined, default values of 24, 25, and 26 will be used
 *
 * Position in this array is equal to position in the KPlayer
 * array.
 *
 * playerVolumeProperties[1] corresponds to KPlayer[1]
 *
 */
#IF_DEFINED volumeByPlayer
playerVolumeProperties[1].capability	= Volume_and_mute_control_with_feedback
playerVolumeProperties[2].capability	= Volume_and_mute_control_but_no_feedback

    // set undefined volume channels to standard AMX channels
    for(startUpLoop = 1; startUpLoop <= numberOfPlayers; startUpLoop++)
    {
	if(playerVolumeProperties[startUpLoop].volUpChannel	= 0)
	{
	    playerVolumeProperties[startUpLoop].volUpChannel = 24
	}
	if(playerVolumeProperties[startUpLoop].volDownChannel = 0)
	{
	    playerVolumeProperties[startUpLoop].volDownChannel = 25
	}
	if(playerVolumeProperties[startUpLoop].volMuteChannel = 0)
	{
	    playerVolumeProperties[startUpLoop].volMuteChannel = 26
	}
    }
#END_IF

/*********************************************************
 *  Define volume properties by zone			 *
 *********************************************************/
/*
 * List the controller zone name of each Kaleidescape controller
 * configured with a controller zone name and set a default zone
 * for them to control.
 */

#IF_DEFINED volumeByZone
controllerProperties[1].controllerZoneName	= 'iPad 1'
controllerProperties[1].zoneToControl		= 1

controllerProperties[2].controllerZoneName	= 'iPad 2'
controllerProperties[2].zoneToControl		= 2

/*
 * Define a zone's volume capabilities for Kaleidescape
 * controllers that are configured with a controller
 * zone name.
 *
 * If volUpChannel, volDownChannel, or volMuteChannel are not
 * defined, default values of 24, 25, and 26 will be used
 *
 * Position in this array is equal to position in the KZones
 * array.
 */

zoneVolumeProperties[1].capability	= No_volume_control_or_feedback
zoneVolumeProperties[2].capability	= Volume_and_mute_control_with_feedback
zoneVolumeProperties[3].capability	= Volume_control_and_feedback_but_no_Mute

    // set undefined volume channels to standard AMX channels
    for(startUpLoop = 1; startUpLoop <= numberOfZones; startUpLoop++)
    {
	if(zoneVolumeProperties[startUpLoop].volUpChannel	= 0)
	{
	    zoneVolumeProperties[startUpLoop].volUpChannel	= 24
	}
	if(zoneVolumeProperties[startUpLoop].volDownChannel = 0)
	{
	    zoneVolumeProperties[startUpLoop].volDownChannel = 25
	}
	if(zoneVolumeProperties[startUpLoop].volMuteChannel = 0)
	{
	    zoneVolumeProperties[startUpLoop].volMuteChannel = 26
	}
    }
#END_IF

/*********************************************************
 *  Set up interface information.                        *
 *********************************************************/

/*
 * tell the module the what this virtual device should control:
 *   send_command <virtual device>, '<ID>[.<Zone>][/<sequence>]'
 *
 * <ID> is set on the player as the
 * "Control Protocol Device ID" within the installer web
 * utility or is the serial number of the player.  If the
 * IP address defined below (in the 'IP' command)
 * is the IP address of the player, you can simply use an ID of '01'
 * and the module will figure out the correct setting. If the
 * serial number of the player is being used it should start
 * with a hash (#) character and be padded with zeroes to make
 * the length 12 characters.
 *
 * example:
 * send_command KPLAYER1, 'ID 05' will make the virtual device
 *                                KPLAYER1 control the player
 *                                whose Control Protocol Device ID
 *                                is set to 5.
 * send_command KPLAYER1, 'ID #000000292D9D' will make the
 *				  virtual device KPLAYER1 control
 *				  the player whose serial number
 *                                is 295D9D.
 *
 * if using SATP, you need to define which zone you want to
 * control.  Zone (output) 1 of the Kaleidescape Music Player
 * is defined as '.01' Zone 2 is '.02' etc.  If you want to set
 * the virtual device to use SATP with a Kaleidescape Movie
 * Player, set the Zone to '.01'
 *
 * examples:
 * send_command KPLAYER1, 'ID 05.03' will make the virtual device
 *                                   KPLAYER1 control output 3 on
 *                                   player 5 using SATP.
 *
 * send_command KPLAYER1, 'ID 05.01' will make the virtual device
 *                                   KPLAYER1 control output 1 on
 *                                   player 5 using SATP. (the only
 *                                   output for a movie player)
 *
 * if you need to control the same player's Zone with multiple, different
 * sized touch panels or you want to allow each touch panel to browse
 * independently, you need to define separate virtual devices
 * that use the same ID and Zone, but use different sequence numbers.
 * The sequence number is a single digit between 1 and 9.
 *
 *  example:
 *   send_command KPLAYER1, 'ID 05.03/1'
 *   send_command KPLAYER2, 'ID 05.03/2'
 * 				    both KPLAYER1 and KPLAYER2 will
 * 				    control output 3 on player 5,
 * 				    but will have independant browse
 * 				    trees, and can show a different
 * 				    number of lines on the touch panel.
 */

/*
 * sometimes there are problems with the startup sequence.
 * this wait will clear up those problems by ensuring these
 * commands are only sent after the event handler starts.
 */
wait 50
{
    send_command KPLAYER1, 'ID 02'		//OSD control
    //send_command KPLAYER2, 'ID 03'		//SATP control

    //send_command KPLAYER2, 'ID 04'
    //send_command KPLAYER3, 'ID 05'

/*
 * If Kaleidescape_Port is a network port, tell the module
 * the ip address to connect to.  This only needs to be set
 * once for the entire module and can be sent through
 * any one of the defined virtual devices.
 */

/*
 * Kaleidescape recommends using the server as the single
 * point of connection.  That way if any player is turned off,
 * the rest of the system will still function.
 */

    send_command KPLAYER1, 'IP 10.100.12.82'

//Tell the module how many SATP lines of text to populate on this interface

    //send_command KPLAYER1, 'LINES 8'		//AXT-CV6 and CP4
    //send_command KPLAYER2, 'LINES 16'		//CV10, MVP-8400 and NXT-1700
    //send_command KPLAYER3, 'LINES 16'

/*
 * This section sets up the keypad control of the module.
 * Keypads can be used to start music playing without requring the user
 * to use either a video display or a text-based touch panel.
 */

/*
 * There are two methods for keypad control.  The first is a set of buttons
 * to cycle through any collection.  Each virtual device can be instructed
 * to control up to three collections.  There are 3 channels per collection -
 * first, next and previous.
 */

    //define the first set of channels to cycle through albums
    send_command KPLAYER1, 'COLLECTION 1 Albums'
    //first = 131, next = 132, previous = 133

    //define the second set of channels to cycle through genres
    send_command KPLAYER1, 'COLLECTION 2 Genres'
    //first = 134, next = 135, previous = 136

    //define the third set of channels to cycle through mix albums
    send_command KPLAYER1, 'COLLECTION 3 Mix Albums'
    //first = 137, next = 138, previous = 139

/*
 * For keypad control, all virtual devices are set up independantly.  If KPLAYER2 is defined,
 * and a keypad is to be used to control it, copy the above commands and define which collections
 * it will cycle through.
 */

/*
 * The second method for keypad control is using presets.
 * The 10 channels for presets are 121-130
 * Every virtual device needs a Preset ID to identify which set of presets to use.
 * This ID is used to identify a set of presets to the player, and may one day
 * be visible to the user.
 *
 * The Preset ID is used to create the tag that is ultimately used per preset.
 * If a Preset ID of 'test' is used, the first preset (channel 121) will use the tag
 * 'test1', the second preset (channel 122) will use the tag 'test2', etc.
 */

    //send_command KPLAYER1, 'PRESET ID test'

/*
 * if two different players are to share a set of presets, give them the same Preset ID.
 * To save a preset, press and hold the channel (use a "to" statement) and the preset will save
 * See below for sample code.
 */

} //end of wait


/**************************
 * End of interface setup *
 **************************/

/*
 * Use this call to match user defined events.  User defined events can be used
 * inside scripts to make the control system do something.  Examples may be to
 * change the lighting level, open or close curtains, or whatever else the end-user
 * may want to happen automatically from a script that they write.
 *
 * A good suggestion is to give the user a mechanism to disable the screen masking
 * changes.  This way, when they've got a script that plays a series of favorite
 * scenes, they can leave the masking set to a specific position.  You may also
 * want to provide a command to re-enable the auto masking within a script
 * so that if the user wanted to create a script that played a series of favorite
 * scenes, then a movie - they could freeze the mask when desired (scenes) then
 * allow the mask to automatically move at the appropriate time (during the movie).
 */
DEFINE_CALL 'Kaleidescape User Commands' (integer kplayerReference, char userCommand[])
{
    userCommand = upper_string(userCommand) //make all text case insensitive

    switch (userCommand)
    {
	case 'OPEN CURTAINS':	{}
	case 'DISABLE MASK':	{}
	case 'ENABLE MASK':	{}
	case 'START POPCORN':	{}
    }
}

/*
 * This call is used when the player receives volume commands from IR or
 * from a Kaleidescape controller that do not include a controller zone
 * name. The volume events will pulse channels on the virtual device of the
 * player they were received from.
 */
#IF_DEFINED volumeByPlayer
DEFINE_CALL 'Handle Volume Message by Player' (integer kplayerRef, char volEvent[])
{
    switch(volEvent)
    {
	case 'VOLUME_QUERY':
	    if(length_string(playerVolumeProperties[kplayerRef].capability)>0)
	    {
		send_command Kplayer[kplayerRef], "'SEND_EVENT:VOLUME_CAPABILITIES=', playerVolumeProperties[kplayerRef].capability, ':'"

		send_command Kplayer[kplayerRef], "'SEND_EVENT:VOLUME_LEVEL=', itoa(playerVolumeProperties[kplayerRef].volLevel), ':'"

		if (playerVolumeProperties[kplayerRef].muteStatus)
		{
		    send_command Kplayer[kplayerRef], "'SEND_EVENT:MUTE_ON_FB:'"
		}
		else
		{
		    send_command Kplayer[kplayerRef], "'SEND_EVENT:MUTE_OFF_FB:'"
		}
	    }
	    else
	    {
		send_string 0, "'Cannot send volume capabilities or feedback because the volume capabilities of this player are not defined in the Kaleidescape Multiple Panel Include file.'"
	    }
	case 'VOLUME_UP': do_push_timed (Kplayer[kplayerRef], playerVolumeProperties[kplayerRef].volUpChannel, 1)
	case 'VOLUME_UP_PRESS': do_push_timed (Kplayer[kplayerRef], playerVolumeProperties[kplayerRef].volUpChannel, 100)
	case 'VOLUME_UP_RELEASE': do_release (Kplayer[kplayerRef], playerVolumeProperties[kplayerRef].volUpChannel)
	case 'VOLUME_DOWN': do_push_timed (Kplayer[kplayerRef], playerVolumeProperties[kplayerRef].volDownChannel, 1)
	case 'VOLUME_DOWN_PRESS': do_push_timed (Kplayer[kplayerRef], playerVolumeProperties[kplayerRef].volDownChannel, 100)
	case 'VOLUME_DOWN_RELEASE': do_release (Kplayer[kplayerRef], playerVolumeProperties[kplayerRef].volDownChannel)
	case 'TOGGLE_MUTE' : do_push_timed (Kplayer[kplayerRef], playerVolumeProperties[kplayerRef].volMuteChannel, 1)
    }
}
#END_IF

/*
 * This call is used when the player receives volume commands from a Kaleidescape
 * controller that includes a controller zone name. The volume events will pulse
 * channels on devices in the KZone array.
 */
#IF_DEFINED volumeByZone
DEFINE_CALL 'Handle Volume Message by Zone' (integer kplayerRef, char volEvent[], char volumeZone[])
{
    stack_var integer controllerRef

    controllerRef = getControllerReference(volumeZone)

    if(controllerRef)
    {
	controllerProperties[controllerRef].lastKplayer = Kplayer[kplayerRef]

	switch(volEvent)
	{
	    case 'VOLUME_QUERY':
		if(length_string(zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].capability)>0)
		{
	    	    call 'Send Volume Capabilities to Kaleidescape Controller' (controllerProperties[controllerRef].controllerZoneName)
		    call 'Send Volume Level to Kaleidescape Controller' (controllerProperties[controllerRef].controllerZoneName, zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volLevel)
		    call 'Send Mute Feedback to Kaleidescape Controller' (controllerProperties[controllerRef].controllerZoneName, zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].muteStatus)
		}
		else
		{
		    send_string 0, "'Cannot send volume capabilities or feedback because the volume capabilities of this zone are not defined in the Kaleidescape Multiple Panel Include file.'"
		}
	    case 'VOLUME_UP': do_push_timed (KZones[controllerProperties[controllerRef].zoneToControl], zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volUpChannel, 1)
	    case 'VOLUME_UP_PRESS': do_push_timed (KZones[controllerProperties[controllerRef].zoneToControl], zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volUpChannel, 100)
	    case 'VOLUME_UP_RELEASE': do_release (KZones[controllerProperties[controllerRef].zoneToControl], zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volUpChannel)
	    case 'VOLUME_DOWN': do_push_timed (KZones[controllerProperties[controllerRef].zoneToControl], zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volDownChannel, 1)
	    case 'VOLUME_DOWN_PRESS': do_push_timed (KZones[controllerProperties[controllerRef].zoneToControl], zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volDownChannel, 100)
	    case 'VOLUME_DOWN_RELEASE': do_release (KZones[controllerProperties[controllerRef].zoneToControl], zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volDownChannel)
	    case 'TOGGLE_MUTE' : do_push_timed (KZones[controllerProperties[controllerRef].zoneToControl], zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volMuteChannel, 1)
	}
    }
}

/*
 * Use button events 600-608 or this call to change the zone the volume buttons on a
 * Kaleidescape controller should affect. After changing the zone, the new zone's
 * volume capabilities, volume level, and mute status will be sent to the controller.
 */
DEFINE_CALL 'Select Zone for Kaleidescape Controller' (char controllerID[], integer newZone, integer volume, integer mute)
{
	stack_var integer controllerRef

    controllerRef = getControllerReference(controllerID)

    if(controllerRef)
    {
	controllerProperties[controllerRef].zoneToControl = newZone

	    call 'Send Volume Capabilities to Kaleidescape Controller' (controllerID)
	    call 'Send Volume Level to Kaleidescape Controller' (controllerID, zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volLevel)
	    call 'Send Mute Feedback to Kaleidescape Controller' (controllerID, zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].muteStatus)
    }
}

/*
 * This call is used to send volume capabilites to a Kaleidescape controller.
 */
DEFINE_CALL 'Send Volume Capabilities to Kaleidescape Controller' (char controllerID[])
{
	stack_var integer controllerRef

    controllerRef = getControllerReference(controllerID)

    send_command controllerProperties[controllerRef].lastKplayer, "'SEND_EVENT:VOLUME_CAPABILITIES=', zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].capability, ';', controllerProperties[controllerRef].controllerZoneName, ':'"
}

/*
 * This call is used to send the volume level to a Kaleidescape controller.
 */
DEFINE_CALL 'Send Volume Level to Kaleidescape Controller' (char controllerID[], integer volume)
{
	stack_var integer controllerRef

    controllerRef = getControllerReference(controllerID)

    zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volLevel = volume
    send_command controllerProperties[controllerRef].lastKplayer, "'SEND_EVENT:VOLUME_LEVEL=', itoa(zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].volLevel), ';', controllerProperties[controllerRef].controllerZoneName, ':'"
}

/*
 * This call is used to send mute feedback to a Kaleidescape controller.
 */
DEFINE_CALL 'Send Mute Feedback to Kaleidescape Controller' (char controllerID[], integer muteState)
{
	stack_var integer controllerRef

    controllerRef = getControllerReference(controllerID)

    zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].muteStatus = muteState

    if (zoneVolumeProperties[controllerProperties[controllerRef].zoneToControl].muteStatus)
    {
	send_command controllerProperties[controllerRef].lastKplayer, "'SEND_EVENT:MUTE_ON_FB;', controllerProperties[controllerRef].controllerZoneName, ':'"
    }
    else
    {
	send_command controllerProperties[controllerRef].lastKplayer, "'SEND_EVENT:MUTE_OFF_FB;', controllerProperties[controllerRef].controllerZoneName, ':'"
    }
}

/*
 * Check the controllerProperties array for the Controller Zone Name in the
 * string received from a Kaleidescape controller
 */
DEFINE_FUNCTION integer getControllerReference (char controllerToFind[])
{
    	stack_var integer loop
	stack_var integer controllerRef

    controllerToFind = lower_string(controllerToFind)

    for(loop = 1; loop <= max_length_array(controllerProperties); loop++)
    {
	if(lower_string(controllerProperties[loop].controllerZoneName) = controllerToFind)
	{
	    controllerRef = loop

	    return controllerRef
	}
    }
    send_string 0, "'Target ', controllerToFind, ' was not found in the Kaleidescape Controller array.'"
    return 0 //if we are here we didn't find anything
}
#END_IF

/*******************************************************************************************
 * Event Handlers
 *******************************************************************************************/
DEFINE_EVENT

/************************************************************
 *  Pass the connection progress indicator to all the touch *
 *  panels.						    *
 ************************************************************/
LEVEL_EVENT[Kplayer, 8]
{
    stack_var integer touchpanelRef

    //step through each TP
    for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
    {
	//if the touch panel is controlling any kplayer
	if(controlledKplayer[touchpanelRef] !=0)
	{
	    //send the level to the touch panel
	    send_level KTouchPanels[touchpanelRef], 60, level.value
	}
    }
}

/*
 * if the TP is controlling multiple players or other devices with the same
 * channel, level or VT numbers, put a conditional on the events below
 * and only send controls or feedback when the Player is selected on the TP.
 *
 * In such a case, the UI may be out of sync.  Issue the following command:
 * send_command KPLAYER1, 'refresh'
 * and the TP page flips, VT data and levels will be resent.
 */

DATA_EVENT[KTouchPanels]
{
    online:
    {
	stack_var integer touchpanelRef
	stack_var integer kplayerRef

	//determine which touch panel triggered the event
	touchpanelRef = get_last(KTouchPanels)

	//determine which player this panel is controlling
	kplayerRef = controlledKplayer[touchpanelRef]

	//tell the controlled player to refresh the signals
	if(kplayerRef > 0) send_command Kplayer[kplayerRef], 'refresh'
    }

    /*
     * keyboard input can be accomplished by placing text within the buttons on the
     * touch panel. Set key "a" to "KAL-A", "b" to "KAL-B", etc.  Any single character
     * command sent to the interface will be processed as if it were a keyboard key.
     * the "space" and "backspace" buttons are handled with the button event below.
     * Space is channel 66 and backspace is 67
     */

    string:
    {
	stack_var char 		kCharacter[10]
	stack_var integer 	touchpanelRef
	stack_var integer 	kplayerRef

	//determine which touch panel triggered the event
	touchpanelRef = get_last(KTouchPanels)

	//determine which player this panel is controlling
	kplayerRef = controlledKplayer[touchpanelRef]

	//only proceed if the ref is valid
	if(kplayerRef > 0)
	{
	    if(find_string(data.text,'KAL-', 1)) // when our custom header is found
	    {
		remove_string(data.text, 'KAL-', 1) // remove the header
		kCharacter = "get_buffer_char(data.text)" // remove the keyboard character

		if(kCharacter[1] = '[') // if this is a fuzzy set (for instance [abc2] )
		{
		    //pull out the remaining characters
		    kCharacter = "'[', remove_string(data.text,']',1)"
		}
		// send that character (or set) to the player
		send_command Kplayer[kplayerRef], "kCharacter"
	    }

	    if(find_string(data.text,'WAKE',1)) // when the TP wakes up
	    {
		// clear the screen saver from the kplayer (if active)
		pulse [Kplayer[kplayerRef],79]
	    }
	}
    }
}

/*
 * Let's wake up the panel when the K screen saver kicks in, then wake up the panel when
 * it clears. The above DATA_EVENT will clear the K screen saver when the touch panel
 * wakes up (opposite of this CHANNEL_EVENT)
 *
 * Use caution when changing which player the TP is controlling.  If you change the
 * controlledKplayer array and send 'refresh' the panel will immediately sleep if the
 * K screen saver is up.  The best implementation is to clear the screen saver
 * with channel 79 immediately before sending the refresh to prevent this.
 */
CHANNEL_EVENT[Kplayer, 1078] //screen saver feedback
{
    on:
    {
	stack_var integer touchpanelRef
	stack_var integer kplayerRef

	kplayerRef = get_last(Kplayer) //determine which player triggered the event

	//step through each TP
	for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
	{
	    //if this TP is controlling this player
	    if(controlledKplayer[touchpanelRef] = kplayerRef)
	    {
		//put the panel to sleep too
		send_command KTouchPanels[touchpanelRef], 'SLEEP'
	    }
	}
    }
    off:
    {
	stack_var integer touchpanelRef
	stack_var integer kplayerRef

	kplayerRef = get_last(Kplayer) //determine which player triggered the event

	//step through each TP
	for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
	{
	    //if this TP is controlling this player
	    if(controlledKplayer[touchpanelRef] = kplayerRef)
	    {
		send_command KTouchPanels[touchpanelRef], 'WAKE' //wake up the panel
	    }
	}
    }
}

/********************************************************
 *  Pass VT and level information to the touch panel.   *
 ********************************************************/
DATA_EVENT[Kplayer]
{
    string:
    {
	stack_var integer touchpanelRef
	stack_var integer kplayerRef

	kplayerRef = get_last(Kplayer) //determine which player triggered the event

	switch(left_string(data.text, 2))
	{
	    case '*V': //The following string is a volume event
	    {
		stack_var char volumeCommand[20]
		stack_var char volumeZone[50]

		if(find_string(data.text, ';', 1))
		{
		    /*
		     * If there is a semi colon in the string assume that it was inserted by a Kaleidescape controller
		     * and seperates the the controller zone name from the volume command.
		     */
		    #IF_DEFINED volumeByZone
			    volumeCommand = mid_string(data.text, find_string(data.text, '*V', 1) + 2, find_string(data.text, ';', 1) - 3)
			    volumeZone = right_string(data.text, length_string(data.text) - find_string(data.text, ';', 1))
			call'Handle Volume Message by Zone' (kplayerRef, volumeCommand, volumeZone)
		    #ELSE
			send_string 0, "'Volume by zone is not defined'"
		    #END_IF
		}
		else
		{
		    /*
		     * If there is no semi colon in the string then these events came from IR or from a Kaleidescape
		     * controller that does not have a controller zone name configured.
		     */
		    #IF_DEFINED volumeByPlayer
			    volumeCommand = right_string(data.text, length_string(data.text) - 2)

			call 'Handle Volume Message by Player' (kplayerRef, volumeCommand)
		    #ELSE
			send_string 0, "'Volume by player is not defined'"
		    #END_IF
		}
	    }
	    default :
	    {
		//step through each TP
		for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
		{
		    //if this TP is controlling this player
		    if(controlledKplayer[touchpanelRef] = kplayerRef)
		    {
			switch (data.text[1]) //evaluate the first character
			{
			    case '~': //string passing flag
			    {
				switch (data.text[2]) //evaluate the second character
				{
				    case 'U': //user defined command
				    {
					stack_var char userCommand[256]
					userCommand = right_string(data.text, length_string(data.text) - 2)
					call 'Kaleidescape User Commands' (kplayerRef, userCommand)
				    }
				}
			    }
			    default: //pass all other commands directly to the touch panel
			    {
				send_command KTouchPanels[touchpanelRef], data.text
			    }
			} //end of 'switch'
		    } //end of 'if'
		} //end of 'for'
	    } // end of 'default' case
	} // end of 'switch'
    } //end of 'string'
} //end of event

/*********************************************************
 *  Pass progress level information to the touch panel.  *
 *********************************************************/
LEVEL_EVENT[Kplayer, 1]
{
    stack_var integer touchpanelRef
    stack_var integer kplayerRef

    kplayerRef = get_last(Kplayer) //determine which virtual device triggered the event

    //step through each TP
    for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
    {
	//if this TP is controlling this player
	if(controlledKplayer[touchpanelRef] = kplayerRef)
	{
	    //send the level to the touch panel
	    send_level KTouchPanels[touchpanelRef], 1, level.value
	}
    }
}

/*********************************************************
 *  Pass scroll bar top information to the virtual dev.  *
 *********************************************************/
LEVEL_EVENT[KTouchPanels, 4]
{
    stack_var integer touchpanelRef
    stack_var integer kplayerRef

    //determine which touch panel triggered the event
    touchpanelRef = get_last(KTouchPanels)

    //determine which player this panel is controlling
    kplayerRef = controlledKplayer[touchpanelRef]

    if(kplayerRef)
    {
	send_level Kplayer[kplayerRef], 4, level.value
    }
}

/*********************************************************
 *  Pass scroll bar top information to the touch panel.  *
 *********************************************************/
LEVEL_EVENT[Kplayer, 5]
{
    stack_var integer touchpanelRef
    stack_var integer kplayerRef

    kplayerRef = get_last(Kplayer) //determine which virtual device triggered the event

    //step through each TP
    for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
    {
	//if this TP is controlling this player
	if(controlledKplayer[touchpanelRef] = kplayerRef)
	{
	    //send the level to the touch panel
	    send_level KTouchPanels[touchpanelRef], 5, level.value
	}
    }
}

/************************************************************
 *  Pass scroll bar bottom information to the touch panel.  *
 ************************************************************/
LEVEL_EVENT[Kplayer, 6]
{
    stack_var integer touchpanelRef
    stack_var integer kplayerRef

    kplayerRef = get_last(Kplayer) //determine which virtual device triggered the event

    //step through each TP
    for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
    {
	//if this TP is controlling this player
	if(controlledKplayer[touchpanelRef] = kplayerRef)
	{
	    //send the level to the touch panel
	    send_level KTouchPanels[touchpanelRef], 6, level.value
	}
    }
}


/************************************************************
 *  System Readiness Mode				    *
 *  This event can be used to show and hide status messages *
 *  when a system enters or exits idle mode.
 ************************************************************/
LEVEL_EVENT[Kplayer, 35]
{
    stack_var integer touchpanelRef
    stack_var integer kplayerRef
    stack_var integer system_readiness_state

    kplayerRef = get_last(Kplayer) //determine which virtual device triggered the event
    system_readiness_state = level.value

    //step through each TP
    for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
    {
	//if this TP is controlling this player
	if(controlledKplayer[touchpanelRef] = kplayerRef)
	{
	    switch(system_readiness_state)
	    {
		case 0:{} // System ready
		case 1:{} // System becoming ready
		case 2:{} // System not ready
	    }
	}
    }
}

/***********************************************************
 *  Pass all TP presses to module through virtual dev      *
 *  note that virtual dev follows standard IR button order *
 ***********************************************************/
BUTTON_EVENT[KTouchPanels, 0]
{
    push:
    {
	stack_var integer touchpanelRef
	stack_var integer kplayerRef

	if(button.input.channel <= LastInputChannel)
	{

	    //determine which touch panel triggered the event
	    touchpanelRef = get_last(KTouchPanels)

	    //determine which player this panel is controlling
	    kplayerRef = controlledKplayer[touchpanelRef]
	    if(kplayerRef > 0)
	    {
		to[Kplayer[kplayerRef], push_channel]
	    }
	}
    }
}

/****************************************************
 *  An example of how to invoke a script.           *
 ****************************************************/
BUTTON_EVENT[KTouchPanels, 201]
{
    push:
    {
	stack_var integer touchpanelRef
	stack_var integer kplayerRef

	//determine which touch panel triggered the event
	touchpanelRef = get_last(KTouchPanels)

	//determine which player this panel is controlling
	kplayerRef = controlledKplayer[touchpanelRef]
	if(kplayerRef > 0)
	{
	    send_command Kplayer[kplayerRef], "'PLAY_SCRIPT:Theater Startup:'"
	}
    }
}

/****************************************************
 *  Pass TP XY levels to module through virtual dev *
 ****************************************************/
LEVEL_EVENT[KTouchPanels, 7]
{
    stack_var integer touchpanelRef
    stack_var integer kplayerRef

    //determine which touch panel triggered the event
    touchpanelRef = get_last(KTouchPanels)

    //determine which player this panel is controlling
    kplayerRef = controlledKplayer[touchpanelRef]
    if(kplayerRef > 0)
    {
	send_level Kplayer[kplayerRef], 50, level.value
    }
}

LEVEL_EVENT[KTouchPanels, 8]
{
    stack_var integer touchpanelRef
    stack_var integer kplayerRef

    //determine which touch panel triggered the event
    touchpanelRef = get_last(KTouchPanels)

    //determine which player this panel is controlling
    kplayerRef = controlledKplayer[touchpanelRef]
    if(kplayerRef > 0) send_level Kplayer[kplayerRef], 51, level.value
}

/********************************************************
 *  The following events should be copied/pasted for    *
 *  use by the different players, if needed.            *
 ********************************************************/

/********************************************************
 *  Receive events from KPlayer for lighting cues       *
 ********************************************************/

CHANNEL_EVENT[KPLAYER1, 1090] //lights movie
{
    on:
    {
//	pulse[IR_LIGHTS,5] //instruct the lights to turn off
    }
}

CHANNEL_EVENT[KPLAYER1, 1091] //lights intermission
CHANNEL_EVENT[KPLAYER1, 1092] //lights credits
CHANNEL_EVENT[KPLAYER1, 1093] //lights non-movie
{
    on:
    {
//	pulse[IR_LIGHTS,1] //instruct the lights to turn on
    }
}


/********************************************************
 *  Receive events from KPlayer for masking information *
 ********************************************************/
LEVEL_EVENT[KPLAYER1, 11] //Screen masking data
{
    switch (level.value)
    {
	case 0: {} //unknown masking - open wide
	case 1: {} //image is 1.33 (4x3)
	case 2: {} //image is 1.66
	case 3: {} //image is 1.78 (16x9)
	case 4: {} //image is 1.85
	case 5: {} //image is 2.35
    }
}

/***********************************************************
 *  Receive events from KPlayer for video mode information *
 ***********************************************************/

/*
 * Information about the video mode is returned via the levels
 * 20 (Composite & S-video), 21 (Component) and 22 (HDMI).
 * These values may be used to set a scaler or change inputs
 * on a projector that wants different video modes on different
 * inputs.
 */

//LEVEL_EVENT[KPLAYER1, 20]	//Composite & Svideo mode
//LEVEL_EVENT[KPLAYER1, 21] 	//Component video mode
LEVEL_EVENT[KPLAYER1, 22]	//HDMI vide mode
{
    switch (level.value)
    {
	case 00: {}          //  no output
	case 01: {}          //  480i60 4x3   NTSC
	case 02: {}          //  480i60 16x9
	case 03: {}          //  480p60 4x3
	case 04: {}          //  480p60 16x9
	case 05: {}          //  576i50 4x3   PAL
	case 06: {}          //  576i50 16x9
	case 07: {}          //  576p50 4x3
	case 08: {}          //  576p50 16x9
	case 09: {}          //  720p60       NTSC
	case 10: {}          //  720p50       PAL
	case 11: {}          //  1080i60      NTSC
	case 12: {}          //  1080i50      PAL
	case 13: {}          //  1080p60      NTSC
	case 14: {}          //  1080p50      PAL
	case 15: {}          //  Reserved
	case 16: {}          //  Reserved
	case 17: {}          //  1080p24
	case 18: {}          //  Reserved
	case 19: {}          //  480i60  64x27
	case 20: {}          //  576i50  64x27
	case 21: {}          //  1080i60  64x27
	case 22: {}          //  1080i50  64x27
	case 23: {}          //  1080p60  64x27
	case 24: {}          //  1080p50  64x27
	case 25: {}          //  1080p24  64x27

	default: {send_string 0, "'Video Mode value not handled by switch case.'"}
    }
}

/***********************************************************
 *  Receive events from KPlayer for CinemaScape		   *
 ***********************************************************/

/*
 * Information about the CinemaScape mode is returned via the levels
 * 31 (CinemaScape mode), 32 (CinemaScape Scale Mode) and 33 (CinemaScape Mask).
 * These values may be used to set the anamorphic lens position,
 * projector mode and masking position.
 */

LEVEL_EVENT[KPLAYER1, 31] //CinemaScape Mode
{
    switch (level.value)
    {
	case 0: {} //16:9 (default)
	case 1: {} //CinemaScape 2.35:1 Anamorphic
	case 2: {} //CinemaScape 2.35:1 Letterbox
	case 3: {} //CinemaScape Native 2.35:1 Display

	default: send_string 0, "'CinemaScape Mode value not handled by switch case.'"
    }
}

LEVEL_EVENT[KPLAYER1, 32] //CinemaScape Scale Mode
{
    switch (level.value)
    {
	case 0: {} //No scaling needed
	case 1: {} //CinemaScape Scale Mode Anamorphic
	case 2: {} //Reserved
	case 3: {} //CinemaScape Scale Mode Zoom

	default: send_string 0, "'CinemaScape Scale Mode value not handled by switch case.'"
    }
}

LEVEL_EVENT[KPLAYER1, 33] //CinemaScape Mask
{
    switch (level.value)
    {
	case 133: {} //image is 1.33 (4x3)
	case 137: {} //image is 1.37
	case 166: {} //image is 1.66
	case 178: {} //image is 1.78 (16x9)
	case 237: {} //image is 2.37
	case 240: {} //image is 2.40

	default: send_string 0, "'CinemaScape Mask value not handled by switch case.'"
    }
}

/********************************************************
 *  End of events to be copied/pasted per player        *
 ********************************************************/


/********************************************************
 ********************************************************
 ***                                                  ***
 ***                   SAMPLE CODE                    ***
 ***                                                  ***
 ********************************************************
 ********************************************************/


/********************************************************
 *  Change which TP controls which vdev at runtime.     *
 ********************************************************/

/*
 * This code snippet assumes that you've got 5 different virtual
 * devices to control, and the buttons to pick which player to
 * control are channels 501 - 505.
 *
 * As configured above, these virtual devices may represent
 * individual Movie Players, Zones of a Music Player, or
 * even the same player controlled in different ways.  Make sure
 * that the touch panel does an appropriate page flip to the
 * proper UI pages needed to control the selected KPLAYER.
 * (SATP if a zone is defined, OSD otherwise)
 */

/*
BUTTON_EVENT[KTouchPanels,500] //select none
BUTTON_EVENT[KTouchPanels,501] //select KPLAYER1
BUTTON_EVENT[KTouchPanels,502] //select KPLAYER2
BUTTON_EVENT[KTouchPanels,503] //select KPLAYER3
BUTTON_EVENT[KTouchPanels,504] //select KPLAYER4
BUTTON_EVENT[KTouchPanels,505] //select KPLAYER5
{
    push:
    {
	stack_var integer touchpanelRef
	stack_var integer interfaceRef

	touchpanelRef = get_last(KTouchPanels)		//determine the TP that generated this event
	interfaceRef = button.input.channel - 500	//determine the Player Ref that is requested

	controlledKplayer[touchpanelRef] = interfaceRef	//set the new player reference
	if(interfaceRef > 0)
	{
	    pulse[Kplayer[interfaceRef], 79] //Clear the screen saver.
	    send_command Kplayer[interfaceRef], 'REFRESH' //resend any strings to the touch panel
	}


    }
}
*/

/********************************************************
 *  Events for volume control				*
 ********************************************************/

/*
 * The button events below can be used to trigger volume events from IR or a Kaleidescape
 * controller, such as the Kaleidescape App for iPad, that is not configured with a
 * controller zone name. Volume and mute feedback can be displayed in the App by sending
 * it to the player's virtual device.
 */
#IF_DEFINED volumeByPlayer
BUTTON_EVENT [KPLAYER1, 24] //Volume up button event from Kaleidescape player 1
{
    push:
    {
	do_push_timed (KZone1, 24, 1)
    }
    hold [5, repeat]:
    {
	do_push (KZone1, 24)
    }
    release:
    {
	do_release (KZone1, 24)
    }
}

BUTTON_EVENT [KPLAYER1, 25] //Volume down button event from Kaleidescape player 1
{
    push:
    {
	do_push_timed (KZone1, 25, 1)
    }
    hold [5, repeat]:
    {
	do_push (KZone1, 25)
    }
    release:
    {
	do_release (KZone1, 25)
    }
}


BUTTON_EVENT [KPLAYER1, 26] //Mute button event from Kaleidescape player 1
{
    push:
    {
	do_push_timed (KZone1, 26, 1)
    }
}


CHANNEL_EVENT [KZone1, 26] //Mute feedback from a zone
{
    on:
    {
	on [KPLAYER1, 26]
	playerVolumeProperties[1].muteStatus = 1
    }
    off:
    {
	off [KPLAYER1, 26]
	playerVolumeProperties[1].muteStatus = 0
    }
}

LEVEL_EVENT [KZone1, 1] //Volume level feedback from the device controlling volume
{
    stack_var integer scaledVolume

    /*
    * The Kaleidescape controller will display a % after the volume
    * so the level needs to be scaled.  Since the scaling may leave a value
    * less than 1, type_cast is used to make a whole number.  The math
    * below scales feedback for a device whose normal range is 0 - 255.
    */
    scaledVolume = type_cast(level.value/2.55)
    send_level KPLAYER1, 55, scaledVolume

    playerVolumeProperties[1].volLevel	= scaledVolume
}
#END_IF // end volume events for volumeByPlayer


#IF_DEFINED volumeByZone
// Button events to select zones for a Kaleidescape controller with a controller zone name
BUTTON_EVENT[KTouchPanels, 600] //deselect touch panel
BUTTON_EVENT[KTouchPanels, 601] //select ZKones[1]
BUTTON_EVENT[KTouchPanels, 602] //select ZKones[2]
BUTTON_EVENT[KTouchPanels, 603] //select ZKones[3]
BUTTON_EVENT[KTouchPanels, 604] //select ZKones[4]
BUTTON_EVENT[KTouchPanels, 605] //select ZKones[5]
BUTTON_EVENT[KTouchPanels, 606] //select ZKones[6]
BUTTON_EVENT[KTouchPanels, 607] //select ZKones[7]
BUTTON_EVENT[KTouchPanels, 608] //select ZKones[8]
{
    push:
    {
	stack_var integer touchPanelRef
	stack_var integer zone

	touchPanelRef = get_last(KTouchPanels)
	zone = button.input.channel - 600

	send_string 0, "'Zone select button event, button ', itoa(zone), ' pressed on panel ', itoa(touchPanelRef), '.'"

	call 'Select Zone for Kaleidescape Controller'
			    (
				controllerProperties[touchPanelRef].controllerZoneName,
				zone,
				zoneVolumeProperties[zone].volLevel,
				zoneVolumeProperties[zone].muteStatus
			    )
    }
}
// Level event to send volume level feedback to a Kaleidescape controller with a controller zone name
LEVEL_EVENT [KZones, 1]
{
    stack_var integer zoneRef
    stack_var integer volume_level
    stack_var integer loop

    zoneRef = get_last(KZones)

    volume_level = level.value

    for(loop=1; loop <= numberOfZones; loop++)
    {
	if(zoneRef = controllerProperties[loop].zoneToControl)
	{
	    call 'Send Volume Level to Kaleidescape Controller' (controllerProperties[loop].controllerZoneName, volume_level)
	}
    }
}
// Channel events to send mute feedback to a Kaleidescape controller with a controller zone name
CHANNEL_EVENT [KZones, 26]
{
    on:
    {
	stack_var integer zoneRef
	stack_var integer loop

	zoneRef = get_last(KZones)

	for(loop=1; loop <= numberOfZones; loop++)
	{
	    if(zoneRef = controllerProperties[loop].zoneToControl)
	    {
		call 'Send Mute Feedback to Kaleidescape Controller' (controllerProperties[loop].controllerZoneName, 1)
	    }
	}
    }
    off:
    {
	stack_var integer zoneRef
	stack_var integer loop

	zoneRef = get_last(KZones)

	for(loop=1; loop <= numberOfZones; loop++)
	{
	    if(zoneRef = controllerProperties[loop].zoneToControl)
	    {
		call 'Send Mute Feedback to Kaleidescape Controller' (controllerProperties[loop].controllerZoneName, 0)
	    }
	}
    }
}
#END_IF

/********************************************************
 *  Sample keypad code                                  *
 ********************************************************/

/*
DEFINE_VARIABLE
//define an array to specify the functions the keypad will perform
devchan KeypadActions[] =
{
    {KPLAYER1, 37},	//play-pause
    {KPLAYER1, 2},	//stop
    {KPLAYER1, 121},	//K preset 1
    {KPLAYER1, 122},	//K preset 2
    {KPLAYER1, 135},	//K next genre
    {KPLAYER1, 136},	//K previous genre
    {KPLAYER1, 4},	//K next track
    {KPLAYER1, 5}	//K previous track
//  {MyTuner, VolUp}
//  {MyTuner, VolDown}
//  {MyTuner, Mute}
//  {MyTuner, Power_Toggle}
};

//define an array to specify what will drive the keypad's feedback
devchan KeypadFeedback[] =
{
    {KPLAYER1, 1037},	//play-pause fb
    {KPLAYER1, 1002},	//stop fb
    {KPLAYER1, 1121},	//K preset 1 fb
    {KPLAYER1, 1122},	//K preset 2 fb
    {KPLAYER1, 135},	//K next genre - momentary
    {KPLAYER1, 136},	//K previous genre - momentary
    {KPLAYER1, 4},	//K next track - momentary
    {KPLAYER1, 5}	//K previous track - momentary
//  {MyTuner, VolUp}
//  {MyTuner, VolDown}
//  {MyTuner, Mute_FB}
//  {MyTuner, Power_FB}
};

DEFINE_EVENT

BUTTON_EVENT[Sample_Keypad, 0] //trap all keypad button events
{
    push:
    {
	stack_var integer channel
	channel = button.input.channel //determine which channel triggered this event
	if(channel <= length_array(KeypadActions)) //if the channel is in the array bounds
	{
	    to[KeypadActions[chn]] //trigger that action
	}
    }
}

CHANNEL_EVENT[KeypadFeedback] //trap all feedback for the keypad
{
    on:
    {
	stack_var integer channel
	channel = get_last(KeypadFeedback) //determine which position in the array triggered this event
	on[SAMPLE_KEYPAD, channel] //turn on that feedback
    }
    off:
    {
	stack_var integer channel
	channel = get_last(KeypadFeedback) //determine which position in the array triggered this event
	off[SAMPLE_KEYPAD,channel] //turn off that feedback
    }
}

*/

/********************************************************
 ********************************************************
 ***                                                  ***
 ***                     end of                       ***
 ***                   SAMPLE CODE                    ***
 ***                                                  ***
 ********************************************************
 ********************************************************/


/*
 * The following event is only necessary under very special circumstances.
 * Sometimes, button events and level events are communicated from a separate device_id
 * than the string events.  For those situations, uncomment this code and the related code above.
 */
/*
DATA_EVENT[keyboardDev]
{
    string:
    {
	stack_var char 		kCharacter[10]
	stack_var integer 	keyboardRef
	stack_var integer 	kplayerRef

	//determine which touch panel triggered the event
	keyboardRef = get_last(keyboardDev)

	//determine which player this panel is controlling
	kplayerRef = controlledKplayerKeyboard[keyboardRef]

	//only proceed if the ref is valid
	if(kplayerRef > 0)
	{
	    if(find_string(data.text,'KAL-', 1)) // when our custom header is found
	    {
		remove_string(data.text, 'KAL-', 1) // remove the header
		kCharacter = "get_buffer_char(data.text)" // remove the keyboard character

		if(kCharacter[1] = '[') // if this is a fuzzy set (for instance [abc2] )
		{
		    //pull out the remaining characters
		    kCharacter = "'[', remove_string(data.text,']',1)"
		}
		// send that character (or set) to the player
		send_command Kplayer[kplayerRef], "kCharacter"
	    }

	    if(find_string(data.text,'WAKE',1)) // when the TP wakes up
	    {
		// clear the screen saver from the kplayer (if active)
		pulse [Kplayer[kplayerRef],79]
	    }
	}
    }
}*/

/********************************************************
 *  Handle feedback to the TP.                          *
 *  note that the feedback for any given button is      *
 *  offset by 1000.                                      *
 ********************************************************/
DEFINE_PROGRAM

{
    local_var integer channel
    stack_var integer touchpanelRef
    stack_var integer kplayerRef

    channel++ //on each run through mainline, handle the next feedback channel
    if(channel > LastInputChannel) channel = 1

    for(touchpanelRef = 1; touchpanelRef <= length_array(KTouchPanels); touchpanelRef++)
    {
	//determine which player this panel is controlling
	kplayerRef = controlledKplayer[touchpanelRef]
	if(kplayerRef > 0)
	{
	    [KTouchPanels[touchpanelRef], channel] = [Kplayer[kplayerRef], channel + 1000]
	}
    }
}