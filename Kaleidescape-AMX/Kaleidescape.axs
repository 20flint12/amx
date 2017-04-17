MODULE_NAME='Kaleidescape' (dev m_KPort, dev m_Interface[], integer m_VT[32], 
			    char m_UIPages[20][], char m_UIPopups[10][], 
			    char m_UIImages[3][], char m_UIIcons[3])
/*
 *  m_VT is an array of variable text fields on the touch
 *  panel that are populated as their information changes.
 *
 *  Leaving any of these values at 0 will disable variable
 *  text transmission.
 *
 *  m_UIPages are the page names on the touch panel for
 *  the different pages of control.  This module will
 *  instruct the touch panel to page flip at the
 *  time.  If any name is blank, it will not be sent.
 *
 *  m_UIPopups are popup page names on the touch panel.
 *  This module will instruct the touch panel to pop on
 *  or pop off the pages as needed.  If any name is blank,
 *  it will not be sent.
 *
 *  m_UIImages are image resource names on the touch panel.
 *  These are used to update the touch panel with various
 *  images (cover art) at run time.  If any name is blank,
 *  it will not be sent.
 *
 *  m_UIIcons are touch panel icon number used for SATP.
 *
 */			    

/*******************************************************************************************
 * Module Information
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
 * Compiler Directives
 *******************************************************************************************/
#DEFINE SATP		//compile with SATP routines (significantly increases memory usage)

DEFINE_VARIABLE
#IF_DEFINED SATP
  constant char ModuleDescription[] = 'Kaleidescape Player AMX Module 8.4.0        (SATP+OSD) Release Date: Feb 27, 2014   '
#ELSE
  constant char ModuleDescription[] = 'Kaleidescape Player AMX Module 8.4.0        (OSD only) Release date: Feb 27, 2014   '
#END_IF
 
/*******************************************************************************************
 * Constant Definitions
 *******************************************************************************************/
DEFINE_CONSTANT
MAX_NUMBER_OF_PLAYERS    = 32


//Useful characters that we'll use in the parsing code
CR 			= $0D // Carriage return
LF			= $0A // Linefeed
TAB 			= $09 // Tab
BACKSLASH 		= $5C // \

//definitions for internal use
BACKSPACE 		= 8
CLEAR 			= 0

UNKNOWN			= 254	//used for setting a value that's not TRUE (1) or FALSE (0)

/*
 * All feedback is offset by this amount.  Thus, the Play button is 1, the 
 * Play feedback is 1+FEEDBACK_OFFSET
 */
FEEDBACK_OFFSET		= 1000

//These are buttons on the virtual device interface.
BTN_PLAY 		= 1
BTN_STOP		= 2
BTN_PAUSE		= 3
BTN_SKIP_FORWARD	= 4
BTN_SKIP_REVERSE 	= 5
BTN_SCAN_FORWARD 	= 6
BTN_SCAN_REVERSE 	= 7

BTN_KEYPAD_KEY		= 10
// KEYPAD 0-9  		= 10-19

BTN_KEYPAD_ENTER	= 20

BTN_PAGE_UP		= 22
BTN_PAGE_DOWN		= 23

BTN_VOLUME_UP		= 24
BTN_VOLUME_DOWN		= 25
BTN_VOLUME_MUTE		= 26

BTN_POWER_ON		= 27
BTN_POWER_OFF		= 28

BTN_INTERMISSION	= 30
BTN_INSTANT_REPLAY	= 31
BTN_START_CHAPTER_ENTRY = 32
BTN_SET_FAVORITE_START	= 33
BTN_SET_FAVORITE_END	= 34

BTN_RANDOM_TOGGLE	= 35
BTN_REPEAT_TOGGLE	= 36

BTN_PLAY_OR_PAUSE	= 37

BTN_SPECIAL_BLURAY_STOP = 38
/*
 During Blu-ray playback, sends the "Blu-ray Stop" command to the disc that is playing.
 For all other content, it behaves as a Kaleidescape Stop command.
CAUTION: Using this command could trap the user.  
 Depending on how the disc was authored, this command may not return the user to a Kaleidescape movie
 place like the STOP OR CANCEL command; some discs may instead use it for accessing special features.  
 If used as the only Stop command, the remote must provide another mechanism to get to the 
 Kaleidescape menu or a Kaleidescape movie place to prevent the user getting "trapped" in Blu-ray 
 playback.
*/

BTN_COORDINATES		= 40

BTN_DVD_MENU		= 44
BTN_UP 			= 45
BTN_DOWN 		= 46
BTN_LEFT		= 47
BTN_RIGHT		= 48
BTN_OK			= 49

BTN_CANCEL		= 50
BTN_TOP_MENU		= 51
BTN_CHAPTER_ENTRY	= 52
BTN_CLEAR		= 53
BTN_RESUME		= 54

BTN_SUBTITLE		= 56

BTN_STATUS_AND_SETTINGS = 58
BTN_DETAILS		= 59

BTN_AUDIO		= 60

BTN_SHUFFLE_COVERS	= 61
BTN_SAFE_LEVEL		= 62
BTN_ALPHABETIZE_COVERS	= 63

BTN_FILTER_LIST		= 65
BTN_SPACE		= 66
BTN_BACKSPACE		= 67

BTN_KALEIDESCAPE_MENU	= 70
BTN_COVER_ART 		= 71
BTN_MOVIE_LIST 		= 72
BTN_COLLECTIONS 	= 73
BTN_PARENTAL_CONTROL	= 74
BTN_SYSTEM_STATUS	= 75
BTN_DEMO		= 76
BTN_DEMO_LOOP		= 77
BTN_SCREEN_SAVER	= 78
BTN_SCREEN_SAVER_STOP	= 79
BTN_DVD_OR_K_MENU	= 80

BTN_MUSIC_LIST		= 81
BTN_MUSIC_COVERS	= 82
BTN_MUSIC_COLLECTIONS	= 83
BTN_MUSIC_NOW_PLAYING	= 84

BTN_MOVIE_OSD_PLACE	= 85
BTN_MUSIC_OSD_PLACE	= 86

// 90-93 are reserved for lighting feedback

BTN_RED			= 95
BTN_GREEN		= 96
BTN_BLUE		= 97
BTN_YELLOW		= 98

/* 
 * The following buttons are defined for controlling in a stand alone state (SATP) using a text
 * list.  These commands do not directly send commands and are thus parsed differently.
 */

BTN_FIRST_LIST_COMMAND	= 50

BTN_LIST_KEYB_CANCEL	= 51
BTN_LIST_KEYB_ENTER	= 52
BTN_LIST_KEYB_SPACE	= 53
BTN_LIST_KEYB_BACKSP	= 54
BTN_LIST_KEYB_CLEAR	= 55

BTN_LIST_SEARCH		= 56
BTN_LIST_SEARCH_RESULT	= 57

BTN_LIST_TITLE		= 60
BTN_LIST_LINE1		= 61
// LIST_LINE 1-20	= 61-80

BTN_LIST_BACK		= 81
BTN_LIST_UP		= 82
BTN_LIST_DOWN		= 83
BTN_LIST_HOME		= 84

BTN_LIST_BROWSE_SELECT	= 85
BTN_LIST_NOW_PLAYING_SELECT = 86


LAST_BUTTON		= BTN_YELLOW //last button handled by the Commands array

//These are feedback only buttons
FB_LIST_LINE1_STATUS	= 101
//LIST_LINE 1-20 STATUS = 101-120

//These are feedback only channels
FB_LIGHTS_MOVIE		= FEEDBACK_OFFSET + 90
FB_LIGHTS_INTERMISSION	= FEEDBACK_OFFSET + 91
FB_LIGHTS_CREDITS	= FEEDBACK_OFFSET + 92
FB_LIGHTS_NON_MOVIE	= FEEDBACK_OFFSET + 93

FB_CINEMASCAPE_OFF		= 130
FB_CINEMASCAPE_ANAMORPHIC	= 131
FB_CINEMASCAPE_LETTERBOX	= 132
FB_CINEMASCAPE_NATIVE		= 133

//Keypad Functions
BTN_PRESET1		= 121
BTN_PRESET2		= 122
BTN_PRESET3		= 123
BTN_PRESET4		= 124
BTN_PRESET5		= 125
BTN_PRESET6		= 126
BTN_PRESET7		= 127
BTN_PRESET8		= 128
BTN_PRESET9		= 129
BTN_PRESET10		= 130

BTN_COLLECTION1_FIRST	= 131
BTN_COLLECTION1_NEXT	= 132
BTN_COLLECTION1_PREVIOUS= 133
BTN_COLLECTION2_FIRST	= 134
BTN_COLLECTION2_NEXT	= 135
BTN_COLLECTION2_PREVIOUS= 136
BTN_COLLECTION3_FIRST	= 137
BTN_COLLECTION3_NEXT	= 138
BTN_COLLECTION3_PREVIOUS= 139

BTN_PRESET_FIRST	= 140
BTN_PRESET_NEXT		= 141
BTN_PRESET_PREVIOUS	= 142

BTN_RETRY_CONNECTION_ATTEMPT = 151


//These channels are used internally as flags on the interface
CHN_PAGE_OFFSET		= 800 /*
			       * Set high to instruct the interface to go to the corresponding 
			       * page in the m_UIPages array. pulse[interface,801] will send 
			       * the touch panel to m_UIPages[1] if it is defined
			       */
CHN_POPUP_OFFSET	= 850 /*
			       * Set high to instruct the interface to open the corresponding 
			       * popup in the m_UIPopups array. on[interface,851] will open 
			       * m_UIPopups[1] and off[interface,851] will close m_UIPopups[1] 
			       * (if defined).
			       */


BTN_POWER_ON_FB		= BTN_POWER_ON + FEEDBACK_OFFSET
BTN_POWER_OFF_FB	= BTN_POWER_OFF + FEEDBACK_OFFSET

CHN_DEVICE_ONLINE	= 900 //set high when the device is online, low if not online
CHN_CONFIGURATION_VALID	= 901

CHN_LIST_ACTIVE		= 911 //set high when a get_list is requested, but blocked by the timeout
CHN_LIST_PENDING	= 912 //timeout indicating that we're receiving get_list results.

//when this goes low, runs get_list - used to compress multiple requests into 1
CHN_GET_LIST_DELAYED	= 913 

//When this is high, override following the now playing in the Now Playing place
CHN_OVERRIDE_NP_FOLLOW	= 914 

//When this goes low, the interface pulls the highlighted details, if available
CHN_RESET_HIGHLIGHTED_DETAILS = 915 

//Pulse this channel to refresh the interface
CHN_REFRESH		= 999

//Amount of time to wait before assuming that we're not getting any results back
LIST_ACTIVE_TIMEOUT	= 10

//Time to wait before requesting the list when FB indicates it's time for an update
LIST_REQUEST_TIMEOUT	= 2

//Time to wait before moving the now playing list to show the current track
TIMEOUT_NOW_PLAYING_MOVE = 1200
TIMEOUT_GET_DETAILS 	= 10 //Time to wait before getting the details of the highlighted item

//These are the defined levels
LVL_MOVIE_LOCATION_RELATIVE 	= 1
LVL_SCROLL_BAR_COMMAND		= 4
LVL_SCROLL_BAR_TOP		= 5
LVL_SCROLL_BAR_BOTTOM		= 6

LVL_CONNECTION_PROGRESS		= 8

LVL_MASK_DATA			= 11
LVL_MASK_TRIM_TOP		= 12
LVL_MASK_TRIM_BOTTOM		= 13
LVL_MASK_CONSERVATIVE		= 14
LVL_MASK_TOP_ABSOLUTE		= 15
LVL_MASK_BOTTOM_ABSOLUTE	= 16

LVL_VIDEO_MODE_COMPOSITE	= 20
LVL_VIDEO_MODE_COMPONENT	= 21
LVL_VIDEO_MODE_HDMI		= 22

LVL_CINEMASCAPE_MODE		= 31
LVL_CINEMASCAPE_SCALE_MODE	= 32
LVL_CINEMASCAPE_MASK		= 33

LVL_IDLE_MODE			= 35

LVL_COORDINATE_X		= 50
LVL_COORDINATE_Y		= 51

LVL_VOLUME			= 55


//These are the variable text array references
VT_MOVIE_TITLE			= 1
VT_CHAPTER_NUMBER		= 2
VT_TRACK_TOTAL_TIME		= 3
VT_TRACK_REMAIN_TIME		= 4
VT_TRACK_CURRENT_TIME		= 5
VT_INPUT_PROMPT			= 6
VT_INPUT_FIELD			= 7
VT_PLAYER_NAME			= 8
VT_DETAILS_TITLE		= 9
VT_DETAILS_INFO			= 10
VT_SONG_NAME			= 11
VT_ALBUM_NAME			= 12
VT_ARTIST_NAME			= 13
VT_SATP_SEARCH_BUTTON		= 14
VT_SATP_KEYBOARD_TEXT		= 15
VT_SATP_SEARCH_MATCH		= 16
VT_NOW_PLAYING_ITEM		= 17
VT_PRESET_LABEL_1		= 18
//VT_PRESET_LABEL_1-10 		= 18-27
VT_CONNECTION_STATUS		= 30
VT_CONNECT_RETRY_BTN		= 31
VT_CONNECTION_PROGRESS_BAR	= 32


//These are the m_UIPopups text array references
POP_KEYBOARD_PAGE	= 1
POP_KEYPAD_PAGE		= 2
POP_NOW_PLAYING		= 3
POP_DETAILS_PAGE	= 4
POP_SATP_NOW_PLAYING	= 5
POP_SATP_KEYBOARD_SEARCH= 6
POP_BLURAY_CONTROLS	= 7
POP_CONNECTION_STATUS	= 8

COMMAND_LENGTH		= 30

//These are the m_UIPages text array references
OSD_SCREEN_MOVIE_LIST 		= 1
OSD_SCREEN_COLLECTIONS 		= 2
OSD_SCREEN_COVER_ART 		= 3
OSD_SCREEN_PARENTAL_CONTROL 	= 4
//usused			= 5
//unused			= 6
OSD_SCREEN_MOVIE_PLAYING	= 7
OSD_SCREEN_SYSTEM_STATUS    	= 8
OSD_SCREEN_MUSIC_LIST 		= 9
OSD_SCREEN_MUSIC_COVERS 	= 10
OSD_SCREEN_MUSIC_COLLECTIONS 	= 11
OSD_SCREEN_MUSIC_NOW_PLAYING 	= 12

OSD_DIALOG_KALEIDESCAPE_MENU 	= 1
OSD_DIALOG_STATUS		= 2
OSD_DIALOG_SETTINGS		= 3

//These are the m_UIImages text array references
IMG_NOW_PLAYING			= 1
IMG_DETAILS			= 2
//reserved			= 3

//These are the play modes returned by the player
PLAY_MODE_NOT_PLAYING 		= 0
PLAY_MODE_PAUSED 		= 1
PLAY_MODE_PLAYING 		= 2
PLAY_MODE_SCAN_FORWARD 		= 4
PLAY_MODE_SCAN_REVERSE 		= 6
PLAY_MODE_UNKNOWN		= 254

//These are the different movie locations returned by the player
MOVIE_LOCATION_PLAYING      	= 3
MOVIE_LOCATION_INTERMISSION 	= 4
MOVIE_LOCATION_CREDITS      	= 5

//These are used to initialize various arrays within DEFINE_VARIABLE */
KALEIDESCAPE_BUFFER_SIZE 	= 10000
MAX_PLAYER_NAME_LENGTH	 	= 50
MAX_RESPONSE_ARGS	 	= 15
MAX_RESPONSE_ARG_LEN	 	= 200
MAX_LIST_WINDOW_LENGTH	 	= 20
MAX_HANDLE_LENGTH	 	= 100
MAX_BROWSE_NODES		= 100	//this defines the number of times back can be pressed
MAX_SEARCH_TEXT_LENGTH	 	= 100
MAX_PRESETS		 	= 10
MAX_NUMBER_OF_KEYPAD_COLLECTIONS = 3

//Various IP Port status values
IP_PORT_CLOSED			= 0
IP_PORT_OPEN			= 1
IP_PORT_ERROR			= 2
IP_PORT_RESET			= 3
IP_PORT_OPENING			= 4

//Use these to indicate how to handle the different commands
PRESS_DIRECT 			= 0
PRESS_REPEAT 			= 1
PRESS_PULSED 			= 2
PRESS_COORDS 			= 3
PRESS_PLAYPS 			= 4

//These values are used to describe what a list item can do
LIST_BEHAVIOR_BROWSE	= 1
LIST_BEHAVIOR_DETAILS	= 2
LIST_BEHAVIOR_ACTION	= 3

//The two different views that can be presented by the list
LIST_SHOW_BROWSE	= 1
LIST_SHOW_NOWPLAYING	= 2

//the various keyboard states
KEYB_OFF		= 0
KEYB_SEARCH		= 1

//connection related constants
CONNECTION_POP_SUCCEEDED	= 0
CONNECTION_POP_PROGRESS		= 1
CONNECTION_POP_RESET		= 2
CONNECTION_POP_FAILED		= 3
CONNECTION_POP_REPEAT_LAST	= 10

MAX_CONNECTION_ATTEMPTS = 4

//timeline IDs
TL_CONNECTION_TIMEOUT	= 2
TL_ANIMATE_PROGRESS_BAR	= 3

//timeline constants
END_TIMELINE		= 0
CREATE_TIMELINE		= 1
PAUSE_TIMELINE		= 2
RESTART_TIMELINE	= 3
CHANGE_TIMELINE		= 4
SET_TIMELINE		= 5


/*******************************************************************************************
 * Structure Definitions
 *******************************************************************************************/
DEFINE_TYPE

// Structure to hold details information
structure STRUCT_Details	
{
    char 	library[MAX_RESPONSE_ARG_LEN]
    char 	title[MAX_RESPONSE_ARG_LEN]
    char 	performer[MAX_RESPONSE_ARG_LEN]
    char 	composer[MAX_RESPONSE_ARG_LEN]
    char 	genre[MAX_RESPONSE_ARG_LEN]
    char 	rating[MAX_RESPONSE_ARG_LEN]
    char 	ratingReason[MAX_RESPONSE_ARG_LEN]
    char 	year[MAX_RESPONSE_ARG_LEN]
    char 	runningTime[MAX_RESPONSE_ARG_LEN]
    char 	coverURL[MAX_RESPONSE_ARG_LEN]
    char	synopsis[MAX_RESPONSE_ARG_LEN]
    char	location[MAX_RESPONSE_ARG_LEN]
}

structure STRUCT_ListItem
{
    char 	handle[MAX_HANDLE_LENGTH]
    char 	behavior
    char 	pop
}

structure STRUCT_BrowseNode
{
    char 	handle[MAX_HANDLE_LENGTH]
    char 	searchText[MAX_SEARCH_TEXT_LENGTH]
    char 	moved
    integer 	position
    integer 	selection
    
    //Pointers to implement the doubly-linked list.
    integer 	previousNode //accessed when back is pressed
    integer	nextNode //to ensure this node is the right one when moving back
}

//an array to define a node array user.  
structure STRUCT_BrowseNodeStack
{
    integer 	current //pointer to the top node in the stack
    integer 	size //number of nodes this stack has
    integer 	bottom //first node in the stack
}

structure STRUCT_ControlID
{
/* 
 * The Kaleidescape_Device_ID is a two-digit number assigned to all Kaleidescape
 * devices.  You can use device IDs to route messages through the
 * Kaleidescape system, controlling every device using only a single
 * connection.  Device ID 01 always refers to the device that you're
 * connected to.  You can set device IDs using the installer web utility.
 */
    char deviceId[13]
    
/* 
 * The stream ID defines what audio output port to control.  If set to 0,
 * then the OSD is controlled.  If set to any other number, the interface
 * will use the text mode (SATP).  If the intent is to use the text mode on
 * a Movie Player, set the stream ID to 1.  If using a Music Player, then
 * the stream ID indicates which audio output will be controlled
 */
    char zoneId
    
/* 
 * The sequence ID allows multiple virtual devices to control a single 
 * stream.  This is particularly useful for SATP control, where 2 different
 * touch panels have different numbers of lines shown on their display.
 * SequenceID defaults to 1, and can be set between 1 and 9
 * Sequnce 0 is reserved for discovering infomation about the connected port
 */
    char sequence
}

/*******************************************************************************************
 * Global Variables
 *******************************************************************************************/
DEFINE_VARIABLE

// Begin port status variables
volatile integer		IPConnection
volatile integer		binaryDelimiters
volatile integer		portOpened
volatile integer		portInitialized
volatile integer		portPassingCommands

volatile integer		connectionAttempt
volatile integer		PauseSendingToPort
volatile integer		lastConnectionMessage
long				tlConnectionTimes[5]
// End port status variables

volatile integer		usingCPDAddressing
volatile integer		usingSNAddressing

constant char 			ListBrowseStart[] = 'music'
constant char 			ListNowPlayingStart[] = 'now_playing'

//string sequence to create a new line on the touch panel - set at DEFINE_START, below
volatile char 			TouchPanelNewLine[2]

//Variables keeping track of UI state (the "UI_STATE" event).
volatile char			OSDScreen[MAX_NUMBER_OF_PLAYERS]
volatile char 			OSDPopup[MAX_NUMBER_OF_PLAYERS]
volatile char 			OSDDialog[MAX_NUMBER_OF_PLAYERS]
volatile char 			OSDSaver[MAX_NUMBER_OF_PLAYERS]

volatile char 			MovieLocation[MAX_NUMBER_OF_PLAYERS]

volatile integer 		Chapter[MAX_NUMBER_OF_PLAYERS]
volatile integer 		TitleLength[MAX_NUMBER_OF_PLAYERS]

volatile char 			HighlightedSelectionHandle[MAX_NUMBER_OF_PLAYERS][MAX_HANDLE_LENGTH]

//Variables keeping track of playback state (the "PLAY_STATUS" event).

//MODE memorized per player
volatile char			PlayMode[MAX_NUMBER_OF_PLAYERS]

volatile integer		Volume[MAX_NUMBER_OF_PLAYERS]

volatile integer		CinemaScape_Mode[MAX_NUMBER_OF_PLAYERS]
volatile integer		Scale_Mode[MAX_NUMBER_OF_PLAYERS]
volatile integer		CinemaScape_Mask[MAX_NUMBER_OF_PLAYERS]

volatile char			PlayerName[MAX_NUMBER_OF_PLAYERS][MAX_PLAYER_NAME_LENGTH]
volatile char			DeviceTypeName[MAX_NUMBER_OF_PLAYERS][MAX_PLAYER_NAME_LENGTH]

char				IPAddress[30]

char 				CoverHostOverride[128]

volatile integer		IPPortStatus

/*
 * This string holds the command used to set the baud rate for the m_KPort.
 * It is initialized if blank on startup with the default rate for the K
 * Player, and can be overridden by the user at any time.
*/
char				BaudRateCommand[50]

//Used to enable or disable displaying of debugging trace information
volatile integer		SentTraceInfo

//volatile Kaleidescape_Stream_ID[MAX_NUMBER_OF_PLAYERS]
volatile STRUCT_ControlID 	KaleidescapeID[MAX_NUMBER_OF_PLAYERS]

/* 
 * Keep track of the connected device to determine if we need to provide
 * additional redirection commands and if we need to find the actual device
 * ID when the interface is set to 01, but the device's ID is actually different.
 */
volatile char 			ConnectedDeviceID[2]
volatile char			ConnectedDeviceSN[13]

/* 
 * DeviceIndirect is used to indicate that the Kaleidescape being
 * controlled is not the one directly connected to, and that messages
 * will have to be routed.  When this is high, this module will set 
 * up the interface to route events through our connected port
 * Setting is memorized per possible player
 */
volatile char			DeviceIndirect[MAX_NUMBER_OF_PLAYERS]

//Array to hold all commands to be sent to the player
volatile char			Commands[LAST_BUTTON][COMMAND_LENGTH]

//Array to hold the coordinate values of the video window for each player
volatile integer 		Coordinate[MAX_NUMBER_OF_PLAYERS][3]

//Temporarily holds all content details for display
volatile STRUCT_Details 	ContentDetail

/*
 * the following definitions take a significant amount of memory
 * and will not be compiled if SATP is not desired
 */
#IF_DEFINED SATP
    /* 
     * This array of structures is used to remember the command and 
     * action to take for every line on a text list.  One set is needed
     * per player. 
     */
    volatile STRUCT_ListItem 	List[MAX_NUMBER_OF_PLAYERS][MAX_LIST_WINDOW_LENGTH]
    
    /* 
     * Keep track of the number of lines available to display on each
     * virtual device
     */
    volatile 			ListWindowLength[MAX_NUMBER_OF_PLAYERS]
    
    //length of the entire list (not just the returned items)
    volatile integer 		ListLength[MAX_NUMBER_OF_PLAYERS]
    
    //The offset of the list items - if line 1 is list line 5, offset is 4
    volatile integer 		ListOffset[MAX_NUMBER_OF_PLAYERS]
    
    /*
     * create a browse node array for use by each list
     * The BrowseNodeResource array is used to store the various nodes
     * used by the BrowseNodeStacks.  Each stack is a double linked list.
     */
    volatile STRUCT_BrowseNode BrowseNodeResource[MAX_BROWSE_NODES]
    
    //Variables to track information about the available browse node resources.
    volatile integer		AvailableResources;
    volatile integer		NextFreeNode;
    
    //Manages the actual stacks stored within the BrowseNodeResource array.
    volatile STRUCT_BrowseNodeStack BrowseNodeStack[MAX_NUMBER_OF_PLAYERS][2]
    
    /* 
     * keep track of whether we're looking at the BROWSE or NOWPLAYING list 
     * (the second ref in the BrowseNodeStack)
     */
    volatile char 		CurrentList[MAX_NUMBER_OF_PLAYERS]
    
    //keep track of what function the keyboard is currently serving
    volatile char 		KeyboardStatus[MAX_NUMBER_OF_PLAYERS]
    
    //an array of a single time (1 second), used for repeating the up/down command
    long 			Timeline1Second[1] =
    {
	1000
    }

#END_IF //SATP

//Preset Variables
volatile char 			PresetLock[MAX_NUMBER_OF_PLAYERS]
volatile char 			PresetID[MAX_NUMBER_OF_PLAYERS][MAX_HANDLE_LENGTH]
volatile char 			PresetFeedback[MAX_NUMBER_OF_PLAYERS][MAX_PRESETS]
volatile char			PresetHeld[MAX_NUMBER_OF_PLAYERS][MAX_PRESETS]
volatile char 			PresetHandleTable[MAX_NUMBER_OF_PLAYERS][MAX_PRESETS][MAX_RESPONSE_ARG_LEN]
volatile char 			KeypadCollection[MAX_NUMBER_OF_PLAYERS][MAX_NUMBER_OF_KEYPAD_COLLECTIONS][MAX_RESPONSE_ARG_LEN]
volatile integer 		LastSelectedPreset[MAX_NUMBER_OF_PLAYERS]
volatile integer		NumberOfPresets[MAX_NUMBER_OF_PLAYERS]
volatile integer		VolumeCapability[MAX_NUMBER_OF_PLAYERS]

/*******************************************************************************************
 * Functions
 *******************************************************************************************/

//Turn on diagnostics in NetLinx Studio to see these.
DEFINE_CALL 'TRACE' (integer interfaceRef, char line[256])
{
    if (SentTraceInfo)
    {
	if(interfaceRef)
	{
	    send_string 0, "'Kaleidescape ', itoa(interfaceRef), ':', line"
	}
	else
	{
	    send_string 0, "'Kaleidescape:', line"
	}
    }
}

//handle feedback going through virtual device 
DEFINE_CALL 'FB' (dev fbDevice, integer fbChan, integer state)
{
    stack_var integer ch
    
    if(fbChan > FEEDBACK_OFFSET)
    {
	ch = fbChan
    }
    else
    {
	ch = fbChan + FEEDBACK_OFFSET
    }
    
    if(state)
    {
	on[fbDevice, ch]
    }
    else
    {
	off[fbDevice, ch]
    }
	
    if(SentTraceInfo = 3) //detailed trace
    {
	send_string 0, "'Setting channel ', itoa(ch), ' to ', itoa(state)"
    }
}

//display hours, mins, seconds given only seconds
DEFINE_FUNCTION char[12] displayHMS(integer seconds)
{
    return "itoa(       seconds / (60 * 60) ),':', //hours
	format( '%02d', (seconds / 60) % 60 ),':', //minutes
	format( '%02d',  seconds % 60 )" //seconds
}

//display mins, seconds given only seconds
DEFINE_FUNCTION char[12] displayMS(integer seconds)
{
    return "itoa(       seconds / 60 ),':', //minutes
	format( '%02d',  seconds % 60 )" //seconds
}

DEFINE_FUNCTION char[40] formatHMS(hours, minutes, seconds)
{
    stack_var char timeString[40]
    //show nothing if time is 0
    //h hour(s)
    //h hour(s) m minute(s)
    //h hour(s) m minute(s) s second(s)
    //leave out if any of them are 0
    
    select
    {
	active (hours = 1):
	    timeString = '1 hour'
	active (hours > 1):
	    timeString = "itoa(hours), ' hours'"
    }
    if(hours and minutes) timeString = "timeString, ' '"
    
    select
    {
	active (minutes = 1):
	    timeString = "timeString, '1 minute'"
	active (minutes > 1):
	    timeString = "timeString, itoa(minutes), ' minutes'"
    }
    if( (hours or minutes) and seconds ) timeString = "timeString, ' '"
    
    select
    {
	active (seconds = 1):
	    timeString = "timeString, '1 second'"
	active (seconds > 1):
	    timeString = "timeString, itoa(seconds), ' seconds'"
    }
    
    return timeString
}

//determine if 2 given devices are equal
DEFINE_FUNCTION char devEQ(dev deviceA, dev deviceB)
{
    //if the number or port don't match, discard
    if(deviceA.number <> deviceB.number || deviceA.port <> deviceB.port) return false
    if(deviceA.system = deviceB.system) return true //if the systems match exactly, return true
    
    /* 
     * system number 0 is shorthand for "this system".  So, we need to 
     * check any 0 instead against get_system_number()
     */
    if(!deviceA.system) //if deviceA's system is 0
    {
	//check if b's system is the same as system_number
	if( deviceB.system = get_system_number() ) 
	    return true
	return false
    }
    if(!deviceB.system) //if deviceB's system is 0
    {
	//check if deviceA's system is the same as system_number
	if( deviceA.system <> get_system_number() )
	    return true
	return false
    }
    return false //if the systems don't match and neither is 0, return false
}

//find the array reference given a dev.  (used to work around get_last bugs)
DEFINE_FUNCTION integer getDevRef(dev deviceArray[], dev deviceToFind)
{
    local_var integer loop
    
    for(loop = 1; loop <= length_array(deviceArray); loop++) //step through the array
    {
	if(devEQ(deviceArray[loop], deviceToFind)) //if it matches
	{
	    return loop //return the first reference found
	}
    }
    
    return 0 //if we're here, we didn't find anything
}

DEFINE_FUNCTION char[255] escapeInvalidChars(char in[])
{
    stack_var char 	result[255]
    stack_var integer 	loop

    for(loop = 1; loop <= length_array(in); loop++)
    {
	switch (in[loop])
	{
	    case ':' : 		result = "result, BACKSLASH, in[loop]"
	    case BACKSLASH: 	result = "result, BACKSLASH, BACKSLASH"
	    case '/' :		result = "result, BACKSLASH, in[loop]"
	    default:		result = "result, in[loop]" //no escape needed
	}
    }
    return result

}

// Function to determine if a given integer is an upper case letter
DEFINE_FUNCTION char isUpperLetter(char character)  
{
    return ((character >= 'A') && (character <= 'Z'))
}

// Function to determine if a given integer is an lower case letter
DEFINE_FUNCTION char isLowerLetter(char character)  
{
    return ((character >= 'a') && (character <= 'z'))
}

//Function to determine if a given integer is a valid letter
DEFINE_FUNCTION char isLetter(char character) 
{
    return (isUpperLetter(character) || isLowerLetter(character))
}

//Function to convert a string to title caps
DEFINE_FUNCTION char[255] toTitleCaps(char inputString[])	
{
    integer 	loop
    char 	character[1]
    char 	inWord
    char 	responseString[255]
    
    inWord = false
    responseString = ''
    
    for(loop = 1;loop <= length_string(inputString);loop++) //step through every character of s
    { 
	character = "inputString[loop]" //extract it
	if(isLetter(character[1])) //check if it's a letter
	{ 
	    if(inWord) //if we're already in a word
	    {
		//set the letter to lower case
		responseString = "responseString, lower_string(character)"
	    }
	    else //if we're not (beginning of the word)
	    {
		//set the letter to upper case (beginning of word)
		responseString = "responseString, upper_string(character)"
		inWord = true
	    }
	}
	else //if it's not a letter
	{
	    responseString = "responseString, character" //just copy verbatum
	    inWord = false //note that we're no longer in a word
	}
    }
    return(responseString)
}

#IF_DEFINED SATP
DEFINE_FUNCTION char isFuzzySearch(integer nodeRef)
{
    if(length_string(BrowseNodeResource[nodeRef].searchText) = 0)
    {
	return 0;
    }    
    return (BrowseNodeResource[nodeRef].searchText[1] = '[')
}
#END_IF

DEFINE_CALL 'SEND LONG TEXT'(integer interfaceRef, integer field, char textToSend[])
{
    stack_var char 	sendBuffer[50]
    stack_var integer position
    stack_var char	commandString[5]
    
    commandString = '^TXT-' //send the first line as a txt to replace the field
    position = 1
    while(position <= length_array(textToSend))
    {
	sendBuffer = mid_string(textToSend, position, 50)
	position = position + 50
	send_string m_Interface[interfaceRef], "commandString, itoa(field), ',0,', sendBuffer"
	commandString= '^BAT-' //append any subsequent text	
    }
}

//returns true if character is a digit
DEFINE_FUNCTION char isDigit(char character)
{
    return ((character >= '0' && character <='9'))
}

//returns true if character is a hex char - 0-9 or A-F
DEFINE_FUNCTION char isHex(char character)
{
    return((  isDigit(character) || ( character >= 'A' && character <= 'F' )  ))
}

//returns true if character is a valid sequence - 0-9, ! or ?
DEFINE_FUNCTION char isSequence(char character)
{
    return(( isDigit(character) || character = '!' || character = '?' ))
}

//determine if a message is valid
DEFINE_FUNCTION char isValidMessage(char message[], char deviceId[], integer deviceZoneId, 
				    integer sequenceSent, integer dataBegin)
{
    stack_var integer messageLength
    stack_var char segmentDelimiter;
    
    messageLength = length_array(message)
    if(message[messageLength] = 2)		//if this is a binary delimited message, the last character will be a chr(2)
    {
	segmentDelimiter = 1			//segments will then be delimited by chr(1)
    }
    else
    {
	segmentDelimiter = '/'			//otherwise, this is a printable delimiter message, using / between segments
    }
    
    select
    {
	/*
	 * The shortest response is "01x1x000y", so if we have something
	 * shorter than that, then we can just ignore it since we know it's
	 * corrupted. 
	 */
	active(messageLength < 9):
	{
	    call 'TRACE' (0, "'Response too short: ', message")
	    return(0)
	}
	/*
	* If using sn device ID messages, the message will be longer
	* #00000000FFFFx1x000y
	*/
	active(message[1] = '#' && messageLength < 20):
	{
	    call 'TRACE' (0, "'Response too short: ', message")
	    return(0)
	}
	/*
	 * feedback presented as device serial number with a stream
	 * #00000000FFFF.00/0/xxx.../00
	 * #00000000FFFF.00/!/xxx.../00
	 */
	active(message[1] = '#' && message[14] = '.'):	
	{
	    if (!isHex(message[2]) || 	//char isn't a hex digit
	        !isHex(message[3]) || 	//char isn't a hex digit
	        !isHex(message[4]) || 	//char isn't a hex digit
	        !isHex(message[5]) || 	//char isn't a hex digit
	        !isHex(message[6]) || 	//char isn't a hex digit
	        !isHex(message[7]) || 	//char isn't a hex digit
	        !isHex(message[8]) || 	//char isn't a hex digit
	        !isHex(message[9]) || 	//char isn't a hex digit
	        !isHex(message[10]) || 	//char isn't a hex digit
	        !isHex(message[11]) || 	//char isn't a hex digit
	        !isHex(message[12]) || 	//char isn't a hex digit
	        !isHex(message[13]) || 	//char isn't a hex digit
	 	!isDigit(message[15]) || //char isn't a digit
	 	!isDigit(message[16]) || //char isn't a digit
		message[17] != segmentDelimiter ||
		!isSequence(message[18]) || //char isn't a sequence 
		message[19] != segmentDelimiter)
	    {
		call 'TRACE' (0, "'Garbled header: ', message")
		return(0)
	    }
	    
	    set_length_array(deviceId, 13)
	    deviceId = left_string(message, 13)
	    deviceZoneId = atoi("message[15], message[16]") //retreive the stream
	    sequenceSent = message[18]
	    dataBegin = 20
	    
	    call 'TRACE' (0, "'Parsing message for ', deviceId, '.', deviceZoneId")
	    //return(0)
	}
	/*
	 * feedback presented as device serial number
	 * #00000000FFFF/0/xxx.../00
	 * #00000000FFFF/!/xxx.../00
	 */
	active(message[1] = '#'):
	{
	    if (!isHex(message[2]) || 	//char isn't a hex digit
	        !isHex(message[3]) || 	//char isn't a hex digit
	        !isHex(message[4]) || 	//char isn't a hex digit
	        !isHex(message[5]) || 	//char isn't a hex digit
	        !isHex(message[6]) || 	//char isn't a hex digit
	        !isHex(message[7]) || 	//char isn't a hex digit
	        !isHex(message[8]) || 	//char isn't a hex digit
	        !isHex(message[9]) || 	//char isn't a hex digit
	        !isHex(message[10]) || 	//char isn't a hex digit
	        !isHex(message[11]) || 	//char isn't a hex digit
	        !isHex(message[12]) || 	//char isn't a hex digit
	        !isHex(message[13]) || 	//char isn't a hex digit
		message[14] != segmentDelimiter ||
		!isSequence(message[15]) ||	//char isn't a sequence 
		message[16] != segmentDelimiter)
	    {
		call 'TRACE' (0, "'Garbled header: ', message")
		return(0)
	    }
	    
	    set_length_array(deviceId, 13)
	    deviceId = left_string(message, 13)
	    deviceZoneId = 0 //no stream
	    sequenceSent = message[15]
	    dataBegin = 17
	    
	    call 'TRACE' (0, "'Parsing message ', deviceId")
	    //return(0)
	    
	}
	/*
	 * feedback contains a zone ID
	 * 00.00/0/xxx.../00
	 * 00.00/!/xxx.../00
	 */
	active(message[3] = '.'):
	{
	    if (!isDigit(message[1]) ||	//char isn't a digit
		!isDigit(message[2]) ||	//char isn't a digit
		!isDigit(message[4]) ||	//char isn't a digit
		!isDigit(message[5]) ||	//char isn't a digit
		message[6] != segmentDelimiter ||
		!isSequence(message[7]) || //char isn't a sequence
		message[8] != segmentDelimiter)
	    {
		call 'TRACE' (0, "'Garbled header: ', message")
		return(0)
	    }
	    
	    set_length_array(deviceId, 2)
	    deviceId = left_string(message, 2)
	    deviceZoneId = atoi("message[4], message[5]") //retreive the stream 
	    sequenceSent = message[7]
	    dataBegin = 9
	}
	/*
	 * default feedback
	 * 00/0/xxx.../00
	 * 00/!/xxx.../00
	 */
	active(1):
	{    
	    /* 
	     * Check that the first two characters are digits, then a slash, then
	     * one digit, then a slash.  Also third-to-last character must be a slash. 
	     */
	    if (!isDigit(message[1]) ||	//char isn't a digit
		!isDigit(message[2]) ||	//char isn't a digit
		message[3] != segmentDelimiter ||
		!isSequence(message[4]) ||		//char isn't a digit or !
		message[5] != segmentDelimiter)
	    {
		call 'TRACE' (0, "'Garbled header: ', message")
		return(0)
	    }
		
	    set_length_array(deviceId, 2)
	    deviceId = left_string(message, 2)
	    deviceZoneId = 0 //no stream
	    sequenceSent = message[4]
	    dataBegin = 6
	}
    }
    return(1) //return success
}

DEFINE_FUNCTION char verifyChecksum (char message[])
{
    stack_var long 	calculatedChecksum
    stack_var long 	responseChecksum
    stack_var integer 	index
    
    //Calculate the checksum and verify it.
    calculatedChecksum = 0
    index = 1
    
    //skip last two characters, that's the checksum itself.
    for(index = 1; index <= length_array(message) - 2; index++)
    {
        calculatedChecksum = calculatedChecksum + message[index]
    }
    calculatedChecksum = calculatedChecksum % 100
    responseChecksum = atoi(right_string(message, 2))
    if (calculatedChecksum != responseChecksum)
    {
        call 'TRACE' (0, "'Bad checksum: ', itoa(calculatedChecksum), ' vs ', itoa(responseChecksum)")
        return(0)
    }
    
    return(1)
}

//pull out fields of the response
DEFINE_FUNCTION integer getArguments(char message[], char arguments[MAX_RESPONSE_ARGS][MAX_RESPONSE_ARG_LEN])
{
    if(message[length_array(message)] = 2)	//if the last character is a binary delimiter
    {
	return( getArgumentsBinary(message, arguments) )
    }
    else
    {
	return( getArgumentsPrintable(message, arguments) )
    }
}

DEFINE_FUNCTION integer getArgumentsBinary(char message[], char arguments[MAX_RESPONSE_ARGS][MAX_RESPONSE_ARG_LEN])
{
    stack_var integer numargs
    stack_var integer messagePosition
    stack_var integer messageLength
    stack_var integer delimiterPosition
    stack_var integer fieldLength
    
    messagePosition = 1
    messageLength = length_array(message)
    numargs = 0
    
    while( messagePosition < messageLength and
	    numargs < MAX_RESPONSE_ARGS )
    {
	delimiterPosition = find_string(message, "2", messagePosition)	//find the field delimiter
	if(!delimiterPosition)						//if we didn't find a delimiter
	    break							//we're done, exit the loop
	
	numargs++
	fieldLength = delimiterPosition - messagePosition		//calculate the length of the field
	arguments[numargs] = mid_string(message, messagePosition, fieldLength)	//pull it out of the message
	messagePosition = delimiterPosition + 1				//move our search position past the delimiter
    }
    return(numargs)
}

//pull out fields of the response
DEFINE_FUNCTION integer getArgumentsPrintable(char message[], char arguments[MAX_RESPONSE_ARGS][MAX_RESPONSE_ARG_LEN])
{
    stack_var char 	escaped
    stack_var char 	character
    stack_var integer messagePosition
    stack_var integer	messageLength
    stack_var integer argumentLength
    stack_var integer numArgs
    
    /* 
     * Parse the command and the arguments.  Make sure we translate all
     * escape sequences. Escape sequences start with a backslash.  See
     * the control programming documentation for the list. 
     */
     
    escaped = 0 //Keep track of whether we've just seen a backslash.
    messagePosition = 1
    argumentLength = 1
    numArgs = 1
    messageLength = length_array(message)
    
    // step through each character.
    while(messagePosition < messageLength AND 
	    argumentLength <= MAX_RESPONSE_ARG_LEN AND 
	    numArgs < MAX_RESPONSE_ARGS)
    {
        // Character being examined.
        character = message[messagePosition]
	messagePosition++
        
        if (escaped)
        {
            // The previous character was a backslash, treat this character specially.
            switch (character)
            {
                case 'd':
                {
                    // The following three digits make up the character.
		    character = (message[messagePosition] - '0') * 100
		    character = character + (message[messagePosition + 1] - '0') * 10
		    character = character + (message[messagePosition + 2] - '0')
		    messagePosition = messagePosition + 3
                    break
                }
                case 't':
                {
                    character = TAB
                    break
                }
                case 'n':
                {
                    character = LF
                    break
                }
                case 'r':
                {
                    character = CR
                    break
                }
                default:
                {
                    //All other characters are simply themselves, nothing to do here.
                    break
                }
            }

            //Append character to current argument.
            arguments[numArgs][argumentLength] = character
	    argumentLength ++

            /* 
	     * The escape only applies to the next character.  After that we're
	     * back to normal. 
	     */
            escaped = 0
        }
        else
        {
            switch (character)
            {
                case BACKSLASH:
                {
                    //Treat the next character specially.
                    escaped = 1
                    break
                }
                case ':':
                {
                    //Colons separate arguments, so we're done.                    
		    set_length_array(arguments[numArgs], argumentLength - 1)
		    
		    numArgs ++
		    argumentLength = 1
                    break
                }
                default:
                {
                    //Normal character, append it.
		    arguments[numArgs][argumentLength] = character
		    argumentLength ++
                    break
                }                    
            }
        }
        
    }
    return(numArgs - 1) //no terminating colon, not a field
}

DEFINE_FUNCTION managePort(integer portStatus, long error)
{
    call 'TRACE' (0, "'managePort; portStatus=', itoa(portStatus)")

    switch(portStatus)
    {
	case IP_PORT_CLOSED	/*0*/: // Initiate reconnection attempts
	{
	    managePort(IP_PORT_OPENING, 0)
	}
	
	case IP_PORT_OPEN /*1*/: // Stop all reconnection attempts, dismiss popup
	{
	    connectionAttempt = 0
    	    IPPortStatus = IP_PORT_OPEN
	    showConnectionPopup(CONNECTION_POP_SUCCEEDED)
	}
	
	case IP_PORT_ERROR /*2*/: // Error conditions handled below
	{
	    if(!PauseSendingToPort || error = 7 || error = 8)
	    {
		processPortError(error)
	    }
	}
	
	case IP_PORT_RESET /*3*/: // Close and reopen port
	{
	    connectionAttempt = 0
	    
	    if(IPPortStatus = IP_PORT_OPEN)
	    {
		IP_CLIENT_CLOSE(m_Kport.port)
		IPPortStatus = IP_PORT_CLOSED
	    }
	    else
	    {
		managePort(IP_PORT_OPENING, 0)
		showConnectionPopup(CONNECTION_POP_RESET)
	    }
	}
	
	case IP_PORT_OPENING /*4*/: // Wait for feedback indicating port is available again.
	{
	    cancel_wait 'Reconnect dead port'
	    connectionAttempt = connectionAttempt + 1
	    call 'TRACE'(0, "'Connection attempt changed to ', itoa(connectionAttempt)")
		
	    if(connectionAttempt <= MAX_CONNECTION_ATTEMPTS && !pauseSendingToPort)
	    {
    		call 'TRACE' (0, "'Opening IP port ', IPAddress, ':10000'")
		IP_CLIENT_OPEN(m_Kport.port, IPAddress, 10000, 1)
		IPPortStatus = IP_PORT_OPENING
		    
		    tlConnectionTimes[1] = 0
		    tlConnectionTimes[2] = 90000
		    manageTimeline(CREATE_TIMELINE, TL_CONNECTION_TIMEOUT, tlConnectionTimes, 2, 0, timeline_absolute, timeline_once)
	    }
	    else if (connectionAttempt > MAX_CONNECTION_ATTEMPTS)
	    {
		showConnectionPopup(CONNECTION_POP_FAILED)
		IPPortStatus = IP_PORT_CLOSED
		
		wait 3000 'Reconnect dead port'
		{
    		    call 'TRACE' (0, "'Resetting port from Reconnect dead port wait'")
		    managePort(IP_PORT_RESET, 0)
		}
	    }
	    else
	    {
		call 'TRACE' (0, "'Request to open port ignored while waiting for port to respond.'")
	    }
	}
    }
}

DEFINE_FUNCTION processPortError(long error)
{
    switch(error)
    {
	case 0:  // operation successful
	{
	    // nothing to do here
	}
	case 1:  // invalid server address
	case 2:  // invalid server port
	case 3:  // invalid value for Protocol
	case 4:  // unable to open communication port with server
	case 6:  // Connection refused
	case 10:  // Binding error
	case 11:  // Listening error
	case 16:  // Too many open sockets 
	{
	    managePort(IP_PORT_CLOSED, 0) //set the port back to closed
	}
	
	case 7:  // Connection timed out
	case 8:  // Unknown connection error
	{
	    manageTimeline(END_TIMELINE, TL_CONNECTION_TIMEOUT, tlConnectionTimes, 0, 0, 0, 0)
	    manageTimeline(END_TIMELINE, TL_ANIMATE_PROGRESS_BAR, tlConnectionTimes, 0, 0, 0, 0)
	    
    	    PauseSendingToPort = False
	    managePort(IP_PORT_CLOSED, 0) //set the port back to closed
	}
	    
	case 9:  // Already closed
	{
	    managePort(IP_PORT_OPENING, 0)
	}
	    
	    
	case 14:  // Local port already used
	case 15:  // UDP socket already listening
	{
	    PauseSendingToPort = True
	    managePort(IP_PORT_OPENING, 0)
	}
	
	case 17:  // writing to a closed port
	{
	    //if we thought the port was open, set to error condition
	    if(IPPortStatus = IP_PORT_OPEN)
	    {
		managePort(IP_PORT_RESET, 0)
	    }
	    else
	    {
		managePort(IP_PORT_CLOSED, 0)
	    }
	}
	
	default: //other unknown error
	{
	    managePort(IP_PORT_RESET, 0)
	}
    }
}

/*
 * Function to manage K Connect Status popup.  state determines whether the popup is shown or hidden, buttonState
 * determines whether buttonGroup is hidden or visible.  Connection is the message that will be displayed on the popup
 */

DEFINE_FUNCTION showConnectionPopup(integer state)
{
    switch(state)
    {
	case CONNECTION_POP_SUCCEEDED: //Dismiss popup, connection succeeded
		{
		    manageTimeline(END_TIMELINE, TL_CONNECTION_TIMEOUT, tlConnectionTimes, 0, 0, 0, 0)
		    sendConnectionMessageToTouchPanel(VT_CONNECTION_STATUS, "'Connection successful, hiding page'")
	    	    showConnectionButtons(False, m_VT[VT_CONNECT_RETRY_BTN])
		    showConnectionProgressBar(False, m_VT[VT_CONNECTION_PROGRESS_BAR])
		    manageTimeline(END_TIMELINE, TL_ANIMATE_PROGRESS_BAR, tlConnectionTimes, 0, 0, 0, 0)
		    OFF[m_Interface, CHN_POPUP_OFFSET + POP_CONNECTION_STATUS] //Hide K Connect Status popup
		}
	case CONNECTION_POP_PROGRESS: //Show popup, connection in progress
		{
		    sendConnectionMessageToTouchPanel(VT_CONNECTION_STATUS, connectionProgressMessage(connectionAttempt, MAX_CONNECTION_ATTEMPTS))
		    showConnectionButtons(False, m_VT[VT_CONNECT_RETRY_BTN])
		    showConnectionProgressBar(True, m_VT[VT_CONNECTION_PROGRESS_BAR])
		    ON[m_Interface, CHN_POPUP_OFFSET + POP_CONNECTION_STATUS] //Show K Connect Status popup
		    tlConnectionTimes[1] = 300
		    manageTimeline(CREATE_TIMELINE, TL_ANIMATE_PROGRESS_BAR, tlConnectionTimes, 1, 0, timeline_relative, timeline_repeat)
		}
	case CONNECTION_POP_RESET: //Show popup, connection is being reset
		{
		    sendConnectionMessageToTouchPanel(VT_CONNECTION_STATUS, connectionResetMessage())
    	    	    showConnectionButtons(False, m_VT[VT_CONNECT_RETRY_BTN])
		    ON[m_Interface, CHN_POPUP_OFFSET + POP_CONNECTION_STATUS] //Show K Connect Status popup
		}
	case CONNECTION_POP_FAILED: //Show popup, connection failed
		{
		    sendConnectionMessageToTouchPanel(VT_CONNECTION_STATUS, connectionFailedMessage(IPAddress))
		    showConnectionProgressBar(False, m_VT[VT_CONNECTION_PROGRESS_BAR])
	    	    manageTimeline(END_TIMELINE, TL_ANIMATE_PROGRESS_BAR, tlConnectionTimes, 0, 0, 0, 0)
	    	    showConnectionButtons(True, m_VT[VT_CONNECT_RETRY_BTN])
		}
    }
    
    lastConnectionMessage = state
}

/*
 * Simple function to send a message to a variable text field (VT).
 */

DEFINE_FUNCTION sendConnectionMessageToTouchPanel(integer vtAddress, char connectionMessage[])
{
    send_string m_Interface, "'!T', vtAddress, connectionMessage"
}

/*
 * Create the message shown on the touch panel that indicates connection atempts are being made.
 */
DEFINE_FUNCTION char[150] connectionProgressMessage(integer attempt, integer max_attempt)
{
    return "'Connection to Kaleidescape system lost, ', 'reconnect attempt ', ITOA(attempt)
			, ' of ', itoa(max_attempt), ' in progress.'"
}

DEFINE_FUNCTION char[150] connectionResetMessage()
{
    return "'Resetting port for new IP, waiting for port to timeout.'"
}

/*
 * Create the message shown on the touch panel that indicates the timeline has expired and display 
 * the IP address of the Kaleidescape component the AMX is trying to connect to.
 */
DEFINE_FUNCTION char[150] connectionFailedMessage(char targetIPAddress[])
{
    return "'Connection to Kaleidescape component at IP address ', targetIPAddress, ' has been lost.'"
}

/*
 * Simple function to show or hide a button/button group.
 */
DEFINE_FUNCTION showConnectionButtons(integer state, integer vtAddress)
{
    if(vtAddress)
    {
	send_string m_Interface, "'^SHO-', itoa(vtAddress), ',', itoa(state)"
    }
}

DEFINE_FUNCTION showConnectionProgressBar(integer state, integer vtAddress)
{
    if(vtAddress)
    {
	send_string m_Interface, "'^SHO-', itoa(vtAddress), ',', itoa(state)"
    }
}

DEFINE_FUNCTION manageTimeline(integer action, long TLid, long times[], long length, long step, long sentence, long repetition)
{
    set_length_array(times, length)
    
    if(timeline_active(TLid))
    {
	switch(action)
	{
	    case END_TIMELINE:		{timeline_kill(TLid)}
	    case PAUSE_TIMELINE:	{timeline_pause(TLid)}
	    case RESTART_TIMELINE:	{timeline_restart(TLid)}
	    case CHANGE_TIMELINE:	{timeline_reload(TLid, times, length)}
	    case SET_TIMELINE:		{timeline_set(TLid, step)}
	}
    }
    else
    {
	switch(action)
	{
	    case CREATE_TIMELINE: 
	    {
		timeline_create(TLid, times, length, sentence, repetition)
	    }
	}
    }
}


/*******************************************************************************************
 **                  Connection routines                                                  **
 *******************************************************************************************/ 
DEFINE_FUNCTION setPortOpened(state)
{
    if(state != portOpened)
    {
	portOpened = state
	switch(state)
	{
	    case true:
	    {
		call 'CHECK PORT'()
	    }
	    case false: // FALSE
	    {
		setPortInitialized(false)
	    }
	}
    }
}

DEFINE_FUNCTION setPortInitialized(state)
{
    if(state != portInitialized)
    {
	portInitialized = state
	switch(state)	// if the port is initialized
	{
	    case true:
	    {
		if(!portOpened)	//if the port isn't open
		{
		    setPortInitialized(false)	    //turn this channel back off and do nothing else
		}
		else
		{
		    call 'CHECK COMMAND PASSING'()
		}
	    }
	    case false:
	    {
		setPortPassingCommands(false)   	//Commands cannot be passed if we've lost comms 
		
		//if we've lost comms, but the port status is open (and we're using IP)
		if(IPConnection && IPPortStatus = IP_PORT_OPEN)
		{
		    //reset the port
		    managePort(IP_PORT_RESET, 0)
		}
	    }
	}
    }
}

DEFINE_FUNCTION setPortPassingCommands(state)
{
    if(state != portPassingCommands)
    {
	portPassingCommands = state
	switch(state)	// if the port has started passing commands
	{
	    case true:
	    {
		if(!portInitialized)	//if the port isn't initialized
		{
		    setPortPassingCommands(false)	//turn this channel back off, and do nothing else
		}
		else
		{
		    call 'TRACE'(0, 'Port passing commands')
		    //if it's an IP connection
		    if(IPConnection)
		    {
			//attempt to turn on binary delimiters
			call 'SEND TO TARGET'('01', 0, '0', 'SET_PROTOCOL_SETTINGS:BINARY_DELIMITERS:LATIN-1:')
			binaryDelimiters = true
		    }
			
		    //Determine what devices can be reached and what their state is
		    if(usingCPDAddressing) call 'SEND TO TARGET'('01', 0, '0', 'GET_AVAILABLE_DEVICES:')
		    if(usingSNAddressing) call 'SEND TO TARGET'('01', 0, '0', 'GET_AVAILABLE_DEVICES_BY_SERIAL_NUMBER:')
		    
		    reportModuleInfo()
		}
	    }
	    case false:		// if the port is no longer passing commands
	    {
		stack_var integer index
		
		call 'TRACE'(0, 'Port no longer passing commands')
		
		for(index = 1; index <= length_array(m_Interface); index++)
		{
		    //indicate that this device is not on
		    
		    if(DeviceIndirect[index])
		    {
			//if not directly connected, indicate that it's offline
			OFF[m_Interface[index], CHN_DEVICE_ONLINE]
		    }
		    else
		    {
			//if it's directly connected, indicate that it's off
			ON[m_Interface[index], BTN_POWER_OFF_FB]
		    }
		}	
		cancel_wait 'SEND DATA TO SYSLOG'
	    }
	}
    }
}

//Send the module data to the syslog and schedule the action again the next day
DEFINE_FUNCTION reportModuleInfo()
{
    if(portPassingCommands)
    {
	//tell the syslog about this module
	call 'SEND TO TARGET'('01', 0, '0', "'SEND_TO_SYSLOG:INFORMATION:',
		escapeInvalidChars(ModuleDescription), ':'")
		
	wait 864000 'SEND DATA TO SYSLOG' //in exactly one day
	{
	    reportModuleInfo()	//send it again
	}
    }
}

/*******************************************************************************************
 **                  End Connection routines                                              **
 *******************************************************************************************/ 
 
DEFINE_FUNCTION formatId(char deviceID[])
{
    local_var integer loop
    if(deviceID[1] = '#')
    {
	for(loop = length_array(deviceID); length_string(deviceID) < 13; loop++)
	{
	    deviceID = "deviceID[1], '0', mid_string(deviceID, 2, 12)"
	}
    }
    else
    {
	for(loop = length_array(deviceID); length_string(deviceID) < 2; loop++)
	{
	    deviceID = "'0', deviceID"
	}
    }
}

DEFINE_CALL 'RECEIVE BUFFER' (char data[])
{
    local_var char receiveBuffer[KALEIDESCAPE_BUFFER_SIZE]
    local_var char parseFails
    stack_var char message[KALEIDESCAPE_BUFFER_SIZE]
    stack_var char terminater[1]
    
    /* 
     * The Kaleidescape sends its commands terminated with CR/LF or chr(4).  So
     * we shouldn't process anything until there's a terminater in
     * the buffer, otherwise we might try to process a partial command.
     * Also, after processing the command, remove it from the buffer
     * and keep going until there are no more terminaters. 
     */		
        
    if(length_array(receiveBuffer) + length_array(data) > KALEIDESCAPE_BUFFER_SIZE)
    {
	send_string 0, "13, 'ERROR!  Kaleidescape buffer overflow!',13"
    }
    else
    {
	receiveBuffer = "receiveBuffer, data"
    }
    
    if(binaryDelimiters)
    {
	terminater = "4"
    }
    else
    {
	terminater = "LF"
    }
    
    //while theres data in the buffer, try and process it
    while( length_array(receiveBuffer) )
    {
	//remove everything up to and including the first terminater
	message = remove_string(receiveBuffer, terminater, 1)
	if(message = '') break;	//if the message is null (term not found), break out of the loop
	
	cancel_wait 'SWITCH DELIMITERS'	//don't switch delimiters
	parseFails = 0				//clear out the failure count	
	call 'PROCESS_KALEIDESCAPE_RESPONSE' (message)
    }
    
    if(receiveBuffer != '')		//if there is still data in the receive buffer
    {
	wait 20 'SWITCH DELIMITERS'
	{
	    if(receiveBuffer != '')
	    {
		call 'TRACE' (0, 'Terminater not found in receive buffer, switching delimiters and trying again.')
		binaryDelimiters = !binaryDelimiters	//toggle the delimiters
		parseFails++				//increment the failures
		call 'RECEIVE BUFFER'('')		//call this routine again with no additional data
	    }
	}
	
	wait_until (parseFails > 3) 'CLEAR BUFFER'
	{
	    clear_buffer receiveBuffer 	//clear the buffer
	    parseFails = 0		 	//reset the count
	    cancel_wait 'SWITCH DELIMITERS'	//don't bother retrying - buffer in empty
	    send_string 0, "13,'Warning!  Kaleidescape buffer contains bad data.  Clearing.'"	    
	}
    }

}



// Process a single response or event from the Kaleidescape.
DEFINE_CALL 'PROCESS_KALEIDESCAPE_RESPONSE' (message[256])
{
    stack_var integer 	messageLength 	//Keep track of the length of the response.
    stack_var char 	deviceId[13] 	//The device ID we parse from the response.
    stack_var integer 	deviceZoneId 	//The zone ID we parse from the response.
    stack_var char 	sequence 	//The sequence ID we parse from the response
    stack_var integer	dataStart	//where the meat of the message begins
    stack_var integer 	index 		//General-purpose index to loop through strings.
    stack_var integer 	numArgs 	//Number of colon-terminated arguments in this response.
    stack_var char 	arguments[MAX_RESPONSE_ARGS][MAX_RESPONSE_ARG_LEN] //The arguments themselves
    stack_var integer 	matches 	//General purpose flag

    /* 
     * Kaleidescape responses and events have this format:
     *
     *     01/1/000:COMMAND:ARG1:ARG2:ARG3:/28 
     *       
     *   where:
     *   
     *       01 is the device ID 
     *       1 is the sequence number (the same one we sent it in the command)
     *       000 is the status (000 means "success", anything else is an error)
     *       COMMAND identifies the kind of data being sent to us
     *       ARGn are the arguments of the command
     *       28 is the checksum of the message (always two digits)   
     *       
     *   So we will parse the response from the beginning to the end.
     *   Since we may be dealing with a serial connection, we must assume
     *   that this buffer may have been corrupted in transit.  We must be
     *   very careful to check that the syntax of the response is valid.
     *   (This is not really necessary when using TCP/IP since the TCP 
     *   layer ensures this for us.)
     */

    call 'TRACE' (0, "13, 10, '-- Processing response:  ', message")

    messageLength = length_string(message)

    //Remove trailing carriage return, linefeed and/or binary terminater
    while (messageLength > 0 && (message[messageLength] = CR || message[messageLength] = LF || message[messageLength] = 4))
    {
        message = left_string(message, messageLength - 1)
        messageLength = messageLength - 1
    }
    
    //check for valid message, passing the deviceZoneId by reference
    if(NOT isValidMessage(message, deviceId, deviceZoneId, sequence, dataStart)) return    
    
    if(message[messageLength] != 2)			//if this is not a binary delimited message
    {
	if(NOT verifyChecksum(message)) return	//verify the checksum
    }
	
    message = right_string(message, messageLength - dataStart + 1)	//remove the header
    
    numArgs = getArguments(message, arguments)

    if (SentTraceInfo = 2) //detailed trace info
    {
	//Trace our arguments to debug and help the handling of new commands.
	call 'TRACE' (0, "'Arguments: ', itoa(numArgs)")
	for(index = 1; index <= numArgs; index++)
	{
	    call 'TRACE' (0, "'Argument ', itoa(index), ': ', arguments[index]")
	}     
    }
    
    //Be sure there's something in the message.
    if (numArgs = 0)
    {
        call 'TRACE' (0, "'No message: ', message")
        return
    }

    //Be sure that the status is success (000), but pass 017 (invalid handle) and 020 (device in standby) to the parser.  Send any other errors for decoding
    if (arguments[1] != '000' and
	arguments[1] != '004' and
        arguments[1] != '017' and
	arguments[1] != '020' and 
	length_array(arguments[1]) = 3)
    {
        call 'ERROR DECODER' (atoi(arguments[1]), arguments[2])
        return
    }
    
    //if we've reached this point, the message is valid and the port is communicating normally
    setPortInitialized(true)

    //If there's only one argument, and it's OK, then we're done.
    if (arguments[1] = '000' && numArgs = 1)
    {
	return
    }
    
    matches = 0;
    //First handle system messages from the local port.
    if( (deviceId = ConnectedDeviceID || deviceId = ConnectedDeviceSN || deviceId = '01') && deviceZoneId = 0)
    {
	//matches++;
	call 'PARSE SYSTEM MESSAGE' (arguments, numArgs, sequence)
    }

    for(index = 1; index <= length_array(m_Interface); index++)
    {
	if ( ( "deviceId = KaleidescapeID[index].deviceId"    //if this is our ID...
	       || (deviceId = '01' && DeviceIndirect[index] = 0) ) //if directly connected, ID is 1
	     && deviceZoneId = KaleidescapeID[index].zoneId   //and if the stream matches
	     && (   sequence = '!'         //and the sequence is ! (unsolicited FB)
		  || sequence = '0'        //or the sequence is 0 (message for all)
		  || sequence = KaleidescapeID[index].sequence )   //or the sequence matches
	    ) //End of the conditional.
	{
	    matches++ //set the flag to indicate success
	    call 'PARSE MESSAGE' (index, deviceId, sequence, matches, arguments, numArgs)
	}
    }
    if(matches = 0) //if the above code failed to find any valid references
    {	
	if(deviceZoneId)
	{
	    call 'TRACE'(0, "'Ignoring Player ID: ', deviceId,
			    format('.%02d', deviceZoneId), '/', sequence")
	}
	else
	{
	    call 'TRACE' (0, "'Ignoring Player ID: ', deviceId, '/', sequence")
	}
    }
}

DEFINE_CALL 'PARSE SYSTEM MESSAGE' (char arguments[][], integer numArgs, char sequence)
{
    call 'TRACE' (0, 'Parsing system message')
    
    select
    {
	active (arguments[2] = 'DEVICE_INFO' and sequence = '0' ):
	{
	    setPortPassingCommands(true)
	    
	    //remember the control ID of the connected device
	    ConnectedDeviceID = arguments[5] //determine the ID of the connected device
	    	    
	    //if the ID is 0 (not routable), set to 1
	    if(ConnectedDeviceID = '00') ConnectedDeviceID = '01'
	    
	    //remember the serial number of the connected device
	    ConnectedDeviceSN = "'#', right_string(arguments[4], 12)"
	}
	
	//we'll receive this combo when the connected device is in standby
	active (arguments[1] = '020' and sequence = '!'):
	{
	    //when we get a general zone-in-standby error, the routed connection is down.
	    call 'TRACE'(0, 'Port received the !/020 error')
	    setPortPassingCommands(false)
	}

    	active (arguments[1] = 'PLAYER_RESTART'):
	{
	    //indicate (possibly belatedly) that the port wasn't passing commands
	    setportPassingCommands(false)
	    
	    //then, try to turn that back on to re-init everything
	    call 'CHECK COMMAND PASSING'()
	    
	}
	
	active (arguments[2] = 'AVAILABLE_DEVICES' ):
	{
	    stack_var integer	interfaceRef
	    stack_var char 	playerId[2]
	    stack_var integer	index
	    stack_var char 	playerOnline[MAX_NUMBER_OF_PLAYERS]
		    
	    call 'TRACE' (0, 'Handling available devices message.')
	    
	    setPortPassingCommands(true)
	    
	    //Initialize the playerOnline list.
	    for(interfaceRef = 1; interfaceRef <= MAX_NUMBER_OF_PLAYERS; interfaceRef++)
	    {
		playerOnline[interfaceRef] = 0;
	    }
	    
	    //Evaluate all of the online players.
	    for(index = 3; index <= numArgs; index++)
	    {	
		//Convert the id string to an integer.
		playerId = arguments[index]
		call 'TRACE'(0, "'Examining ID ',itoa(playerID)")
		
		//Search through the player list to see if that player exists.
		for(interfaceRef = 1; interfaceRef <= length_array(m_Interface); interfaceRef++)
		{
		    //If the player is found.
		    if(KaleidescapeID[interfaceRef].deviceId = playerId)
		    {		
			//Record that we found the player online.
			playerOnline[interfaceRef] = 1;
			
			call 'TRACE'(interfaceRef, "'Player is online (ID=', KaleidescapeID[interfaceRef].deviceId,')'")
			
			//indicate that this device is online
			ON[m_Interface[interfaceRef],CHN_DEVICE_ONLINE]
		    }
		}
	    }
	    	    
	    //Set devices to reinitialize if they went offline.
	    for(interfaceRef = 1; interfaceRef <= length_array(m_Interface); interfaceRef++)
	    {
		//If the device was previously initialized, but is now offline
		if(NOT playerOnline[interfaceRef] && KaleidescapeID[interfaceRef].deviceId[1] != '#')
		{
		    call 'TRACE'(interfaceRef, "'Player is offline (ID=',KaleidescapeID[interfaceRef].deviceId,')'")
			
		    OFF[m_Interface[interfaceRef],CHN_DEVICE_ONLINE]
		}
	    }
	}
	
	active (arguments[2] = 'AVAILABLE_DEVICES_BY_SERIAL_NUMBER' ):
	{
	    stack_var integer	interfaceRef
	    stack_var char 	playerId[13]
	    stack_var integer	index
	    stack_var char 	playerOnline[MAX_NUMBER_OF_PLAYERS]
		    
	    call 'TRACE' (0, 'Handling available devices by serial number message.')
	    
	    setPortPassingCommands(true)
	    
	    //Initialize the playerOnline list.
	    for(interfaceRef = 1; interfaceRef <= MAX_NUMBER_OF_PLAYERS; interfaceRef++)
	    {
		playerOnline[interfaceRef] = 0;
	    }
	    
	    //Evaluate all of the online players.
	    for(index = 3; index <= numArgs; index++)
	    {	
		//Convert the id string to an integer.
		playerId = arguments[index]
		call 'TRACE'(0, "'Examining ID ', playerID")
		
		//Search through the player list to see if that player exists.
		for(interfaceRef = 1; interfaceRef <= length_array(m_Interface); interfaceRef++)
		{
		    //If the player is found.
		    if(KaleidescapeID[interfaceRef].deviceId = "'#', playerId")
		    {		
			//Record that we found the player online.
			playerOnline[interfaceRef] = 1;
			
			call 'TRACE'(interfaceRef, "'Player is online (ID=',KaleidescapeID[interfaceRef].deviceId,')'")
			
			//indicate that this device is online
			ON[m_Interface[interfaceRef],CHN_DEVICE_ONLINE]
		    }
		}
	    }
	    
	    //Set devices to reinitialize if they went offline.
	    for(interfaceRef = 1; interfaceRef <= length_array(m_Interface); interfaceRef++)
	    {
		//If the device was previously initialized, but is now offline
		if(NOT playerOnline[interfaceRef] && KaleidescapeID[interfaceRef].deviceId[1] = '#')
		{
		    call 'TRACE'(interfaceRef, "'Player is offline (ID=',KaleidescapeID[interfaceRef].deviceId,')'")
			
		    OFF[m_Interface[interfaceRef],CHN_DEVICE_ONLINE]
		}
	    }
	}
	
	active(arguments[2] = 'MUSIC_PRESET_INFORMATION'):
	{	    
	    stack_var char 	presetIDTest[MAX_RESPONSE_ARG_LEN]
	    stack_var char	presetTag[MAX_RESPONSE_ARG_LEN]
	    stack_var integer 	presetNumber
	    stack_var integer	interfaceRef
	    
	    for(interfaceRef = 1; interfaceRef <= length_array(m_Interface); interfaceRef++)
	    {
		//Pull the Preset ID out of the Preset Tag.
		presetTag = arguments[3]
		presetIDTest = remove_string(presetTag, PresetID[interfaceRef], 1)
		    
		//Check to see if this ID is the one we're interested in.
		if(presetIDTest = PresetID[interfaceRef])
		{
		    call 'TRACE' (interfaceRef, "'Setting preset data for preset ', arguments[3], 
					' with handle: ', arguments[4], ' and label: ', arguments[5]")
		    
		    //The rest of presetTag is the numeric ID of the preset.
		    presetNumber = atoi(presetTag)
		    
		    //Drop the handle into the table for later identification.
		    PresetHandleTable[interfaceRef][presetNumber] = arguments[4]
		    //if the preset label VT has been defined
		    if(m_VT[VT_PRESET_LABEL_1 + presetNumber - 1] <> 0) 
		    {
			//send the preset label text to the VT
			send_string m_Interface[interfaceRef], "'!T', 
			    m_VT[VT_PRESET_LABEL_1 + presetNumber - 1], arguments[5]"
		    }
		    call 'FEEDBACK PRESET' (interfaceRef, arguments[4])
		}
	    }
	}
    }
}

DEFINE_CALL 'PARSE MESSAGE' (integer interfaceRef, char deviceId[], integer sequence, 
			     integer matches, char arguments[][], integer numArgs)
{
    local_var integer numberOfDetails

    call 'TRACE'(interfaceRef, 'Parsing message')

    //if we've got any good message, then this device is online
    if(arguments[1] = '000') ON[m_Interface[interfaceRef], CHN_DEVICE_ONLINE]

    //See what the content of the response is.
    select
    {
        active (arguments[2] = 'PLAY_STATUS' && numArgs = 10) :
        {
	    stack_var integer titlePosition
	    stack_var integer titleRemaining
	    stack_var integer titleProgress
	    local_var integer lastChapter[MAX_NUMBER_OF_PLAYERS]
	    local_var integer lastTitleLength[MAX_NUMBER_OF_PLAYERS]
	    /*
	     * keep track of the last values to prevent re-sending the same info over and over
	     * this will help the bus speed and prevent flickering on older panels
	     */
	    
            PlayMode[interfaceRef] = atoi(arguments[3])
	    TitleLength[interfaceRef] = atoi(arguments[6])
	    titlePosition = atoi(arguments[7])
	    titleRemaining = TitleLength[interfaceRef] - titlePosition
	    
	    if (TitleLength[interfaceRef] = 0) //avoid div by 0 error
	    {
		titleProgress 	= 0
	    }
	    else
	    {
		titleProgress	= titlePosition * 255 / TitleLength[interfaceRef]
	    }
		
    	    Chapter[interfaceRef] = atoi(arguments[8])
	    
	    call 'TRACE' (interfaceRef, "'TitleLength=', itoa(TitleLength[interfaceRef])")
	    call 'TRACE' (interfaceRef, "'TitlePosition=', itoa(titlePosition)")
	    call 'TRACE' (interfaceRef, "'TitleRemaining=', itoa(titleRemaining)")
	    call 'TRACE' (interfaceRef, "'TitleProgress=', itoa(titleProgress)")
	    
	    call 'FB' (m_Interface[interfaceRef], BTN_PLAY + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], BTN_PLAY_OR_PAUSE + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], BTN_STOP + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_NOT_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], BTN_SPECIAL_BLURAY_STOP + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_NOT_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], BTN_PAUSE + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_PAUSED))
	    call 'FB' (m_Interface[interfaceRef], BTN_SCAN_FORWARD + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_SCAN_FORWARD))
	    call 'FB' (m_Interface[interfaceRef], BTN_SCAN_REVERSE + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_SCAN_REVERSE))
	    
	    
	    if( (m_VT[VT_CHAPTER_NUMBER] <> 0) && 
		( Chapter[interfaceRef] <> lastChapter[interfaceRef] ) )
	    {
		//send chapter info to TP if defined
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_CHAPTER_NUMBER],
				itoa(Chapter[interfaceRef])"
	    }
		
	    lastChapter[interfaceRef] = Chapter[interfaceRef]
	    
	    if( (m_VT[VT_TRACK_TOTAL_TIME] <> 0) && 
		( TitleLength[interfaceRef] <> lastTitleLength[interfaceRef] ) )
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_TRACK_TOTAL_TIME],
				displayHMS(TitleLength[interfaceRef])"
	    }
		
	    lastTitleLength[interfaceRef] = TitleLength[interfaceRef]
		
	    if( m_VT[VT_TRACK_CURRENT_TIME] <> 0 )
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_TRACK_CURRENT_TIME],
				displayHMS(titlePosition)"
	    }
		
	    if( m_VT[VT_TRACK_REMAIN_TIME] <> 0 )
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_TRACK_REMAIN_TIME],
				displayHMS(titleRemaining)"
	    }
		
	    send_level m_Interface[interfaceRef], LVL_MOVIE_LOCATION_RELATIVE, titleProgress
	    	    
            call 'TRACE' (interfaceRef, 'Setting play status')
        }
        
	active (arguments[2] = 'MUSIC_PLAY_STATUS') :
	{
	    stack_var integer songPosition
	    stack_var integer songRemaining
	    stack_var integer songProgress
	    local_var integer lastTitleLength[MAX_NUMBER_OF_PLAYERS]
	    local_var integer lastPlayMode[MAX_NUMBER_OF_PLAYERS]
	    stack_var integer loop
	    stack_var integer npPop
	    
	    PlayMode[interfaceRef] = atoi(arguments[3])
	    TitleLength[interfaceRef] = atoi(arguments[5])
	    songPosition = atoi(arguments[6])
	    songRemaining = TitleLength[interfaceRef] - songPosition
	    
	    if (TitleLength[interfaceRef] = 0)
	    {
		songProgress = 0
	    }
	    else
	    {
		songProgress = songPosition * 255 / TitleLength[interfaceRef]
	    }
		
	    call 'FB' (m_Interface[interfaceRef], BTN_PLAY + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], BTN_PLAY_OR_PAUSE + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], BTN_STOP + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_NOT_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], BTN_SPECIAL_BLURAY_STOP + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_NOT_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], BTN_PAUSE + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_PAUSED))
	    call 'FB' (m_Interface[interfaceRef], BTN_SCAN_FORWARD + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_SCAN_FORWARD))
	    call 'FB' (m_Interface[interfaceRef], BTN_SCAN_REVERSE + FEEDBACK_OFFSET, 
			(PlayMode[interfaceRef] = PLAY_MODE_SCAN_REVERSE))
	    
	    
	    if( (m_VT[VT_TRACK_TOTAL_TIME] <> 0) && 
		( TitleLength[interfaceRef] <> lastTitleLength[interfaceRef] ) )
	    {
		send_string m_Interface[interfaceRef], "'!T',m_VT[VT_TRACK_TOTAL_TIME],
				displayMS(TitleLength[interfaceRef])"
	    }
		
	    lastTitleLength[interfaceRef] = TitleLength[interfaceRef]
		
	    if( m_VT[VT_TRACK_CURRENT_TIME] <> 0 )
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_TRACK_CURRENT_TIME],
				displayMS(songPosition)"
	    }
		
	    if( m_VT[VT_TRACK_REMAIN_TIME] <> 0 )
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_TRACK_REMAIN_TIME],
				displayMS(songRemaining)"
	    }
		
	    send_level m_Interface[interfaceRef], LVL_MOVIE_LOCATION_RELATIVE, songProgress
	      
	    npPop = POP_NOW_PLAYING + CHN_POPUP_OFFSET
	    
	    #IF_DEFINED SATP
		//if this is an SATP, and the SATP now playing is non-zero len
		if(KaleidescapeID[interfaceRef].zoneId && (length_string(m_UIPopups[POP_SATP_NOW_PLAYING]) > 0) )
		{
		    npPop = POP_SATP_NOW_PLAYING + CHN_POPUP_OFFSET
		}
	    #END_IF
	    
	    //Pop or hide the now playing popup
	    [m_Interface[interfaceRef], npPop] = (PlayMode[interfaceRef] <> PLAY_MODE_NOT_PLAYING)
	    
	    
            call 'TRACE' (interfaceRef, 'Setting music play status')
	    
   	    #IF_DEFINED SATP
		//if the play status has changed
		if(lastPlayMode[interfaceRef] != PlayMode[interfaceRef])
		{
		    if(KaleidescapeID[interfaceRef].zoneId) 
		    {
			//update the list in a moment, if shown
			do_push_timed(m_Interface[interfaceRef], CHN_GET_LIST_DELAYED,
					LIST_REQUEST_TIMEOUT)
		    }
		}
	    #END_IF
	    
	    lastPlayMode[interfaceRef] = PlayMode[interfaceRef]
	}
	
	active (arguments[2] = 'SCREEN_MASK2') :
	{
	    //DO NOTHING YET
	}
	
        active (arguments[2] = 'SCREEN_MASK') :
        {
            /* 
	     * arguments[3] is the "closest mask".  Use arguments[6] if you want the "safe mask",
             *  i.e., the mask that doesn't ever overlap into the picture. 
	     */
	    send_level m_Interface[interfaceRef], LVL_MASK_DATA, atoi(arguments[3])
	    send_level m_Interface[interfaceRef], LVL_MASK_TRIM_TOP, atoi(arguments[4])
	    send_level m_Interface[interfaceRef], LVL_MASK_TRIM_BOTTOM, atoi(arguments[5])
	    send_level m_Interface[interfaceRef], LVL_MASK_CONSERVATIVE, atoi(arguments[6])
	    send_level m_Interface[interfaceRef], LVL_MASK_TOP_ABSOLUTE, atoi(arguments[7])
	    send_level m_Interface[interfaceRef], LVL_MASK_BOTTOM_ABSOLUTE, atoi(arguments[8])
        }
        
        active (arguments[2] = 'TITLE_NAME' && numArgs = 3) :
        {
            //Set the movie title.
	    if(m_VT[VT_MOVIE_TITLE] <> 0)
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_MOVIE_TITLE], 
				arguments[3]"
	    }
            call 'TRACE' (interfaceRef, "'Movie title is ', arguments[3]")
        }
	
	active (arguments[2] = 'MUSIC_TITLE') :
	{
	    
	    if(m_VT[VT_SONG_NAME]) 
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_SONG_NAME], 
				arguments[3]"
	    }
	    if(m_VT[VT_ARTIST_NAME])
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_ARTIST_NAME], 
				arguments[4]"
	    }
	    if(m_VT[VT_ALBUM_NAME])
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_ALBUM_NAME], 
				arguments[5]"
	    }

	    //if the cover is defined and a handle is provided
	    if(length_array(m_UIImages[IMG_NOW_PLAYING]) && length_array(arguments[7]))
	    {
		if(MATCHES = 1) //if this is the first match (ie, only get once)
		{
		    //send a request to sequence 0 for the details
		    call 'SEND TO TARGET'(deviceId, KaleidescapeID[interfaceRef].zoneId,
			    '0', "'GET_CONTENT_DETAILS:', arguments[7],'::'")
		}
	    }
	    
	    #IF_DEFINED SATP
		if(KaleidescapeID[interfaceRef].zoneId) 
		{
		    //update the list in a moment, if shown
		    do_push_timed(m_Interface[interfaceRef], CHN_GET_LIST_DELAYED, 
				    LIST_REQUEST_TIMEOUT)
		}
	    #END_IF	    
	}

	active (arguments[2] = 'SYSTEM_READINESS_STATE' && numArgs = 3):
	{
	    // When a sytsem is unused for a period of time the system may spin down the disks and enter idle mode. The system
	    // can be removed from idle mode using LEAVE_IDLE_MODE or any user interaction. It takes at least 15 seconds to 
	    // exit idle mode. Possible values are:
	    //	0 - system is ready
	    //	1 - system is exiting idle mode
	    //	2 - system is idle
	    
    	    send_level m_Interface[interfaceRef], LVL_IDLE_MODE, atoi(arguments[3])
	}

        active (arguments[2] = 'UI_STATE' && numArgs = 6) :
        {
	    stack_var integer MoviePlace
	    stack_var integer MusicPlace
	    
	    call 'TRACE'(interfaceRef, 'Found UI_STATE')
	    
            //Set the OSD state.
            OSDScreen[interfaceRef] = atoi(arguments[3])
            OSDPopup[interfaceRef] = atoi(arguments[4])
            OSDDialog[interfaceRef] = atoi(arguments[5])
            OSDSaver[interfaceRef] = atoi(arguments[6])
	    
	    //if this comes back as zero, make it movie list
	    if(OSDScreen[interfaceRef] = 0) OSDScreen[interfaceRef] = 1	    

	    //if a page has been defined for this screen
	    if(length_array(m_UIPages[OSDScreen[interfaceRef]]) > 0)
	    {
		send_string m_Interface[interfaceRef], "'PAGE-', 
		    m_UIPages[OSDScreen[interfaceRef]]"
	    }
	    
	    call 'FB' (m_Interface[interfaceRef], BTN_KALEIDESCAPE_MENU + FEEDBACK_OFFSET,
			(OSDDialog[interfaceRef] = OSD_DIALOG_KALEIDESCAPE_MENU))
            call 'FB' (m_Interface[interfaceRef], BTN_STATUS_AND_SETTINGS + FEEDBACK_OFFSET,
			( (OSDPopup[interfaceRef] = OSD_DIALOG_STATUS) ||
			(OSDPopup[interfaceRef] = OSD_DIALOG_SETTINGS) ) )
	    
            call 'FB' (m_Interface[interfaceRef], BTN_COVER_ART + FEEDBACK_OFFSET,
			(OSDScreen[interfaceRef] = OSD_SCREEN_COVER_ART))
            call 'FB' (m_Interface[interfaceRef], BTN_MOVIE_LIST + FEEDBACK_OFFSET,
			(OSDScreen[interfaceRef] = OSD_SCREEN_MOVIE_LIST))
            call 'FB' (m_Interface[interfaceRef], BTN_COLLECTIONS + FEEDBACK_OFFSET,
			(OSDScreen[interfaceRef] = OSD_SCREEN_COLLECTIONS))
            call 'FB' (m_Interface[interfaceRef], BTN_PARENTAL_CONTROL + FEEDBACK_OFFSET,
			(OSDScreen[interfaceRef] = OSD_SCREEN_PARENTAL_CONTROL))
            call 'FB' (m_Interface[interfaceRef], BTN_SYSTEM_STATUS + FEEDBACK_OFFSET, 
			(OSDScreen[interfaceRef] = OSD_SCREEN_SYSTEM_STATUS))
	    
            call 'FB' (m_Interface[interfaceRef], BTN_MUSIC_COLLECTIONS + FEEDBACK_OFFSET,
			(OSDScreen[interfaceRef] = OSD_SCREEN_MUSIC_COLLECTIONS))
            call 'FB' (m_Interface[interfaceRef], BTN_MUSIC_COVERS + FEEDBACK_OFFSET,
			(OSDScreen[interfaceRef] = OSD_SCREEN_MUSIC_COVERS))
            call 'FB' (m_Interface[interfaceRef], BTN_MUSIC_LIST + FEEDBACK_OFFSET,
			(OSDScreen[interfaceRef] = OSD_SCREEN_MUSIC_LIST))
            call 'FB' (m_Interface[interfaceRef], BTN_MUSIC_NOW_PLAYING + FEEDBACK_OFFSET,
			(OSDScreen[interfaceRef] = OSD_SCREEN_MUSIC_NOW_PLAYING))

            call 'FB' (m_Interface[interfaceRef], BTN_SCREEN_SAVER + FEEDBACK_OFFSET,
			(OSDSaver[interfaceRef] = 1))	    
	    
	    MoviePlace = false
	    MusicPlace = false
	    switch (OSDScreen[interfaceRef]) //determine what type of page is showing
	    {
		case OSD_SCREEN_COVER_ART: MoviePlace = true
		case OSD_SCREEN_MOVIE_LIST: MoviePlace = true
		case OSD_SCREEN_COLLECTIONS: MoviePlace = true
		case OSD_SCREEN_MOVIE_PLAYING: MoviePlace = true
		
		case OSD_SCREEN_MUSIC_COVERS: MusicPlace = true
		case OSD_SCREEN_MUSIC_COLLECTIONS: MusicPlace = true
		case OSD_SCREEN_MUSIC_LIST: MusicPlace = true
		case OSD_SCREEN_MUSIC_NOW_PLAYING: MusicPlace = true		
	    }
	    
	    call 'FB' (m_Interface[interfaceRef], BTN_MOVIE_OSD_PLACE + FEEDBACK_OFFSET, 
			MoviePlace)
	    call 'FB' (m_Interface[interfaceRef], BTN_MUSIC_OSD_PLACE + FEEDBACK_OFFSET, 
			MusicPlace)
	    
            call 'TRACE' (interfaceRef, 'Setting OSD place')
        }
        
	active (arguments[2] = 'MOVIE_LOCATION') :
	{
	    MovieLocation[interfaceRef] = atoi(arguments[3])
	    
	    call 'FB' (m_Interface[interfaceRef], FB_LIGHTS_MOVIE,
			(MovieLocation[interfaceRef] = MOVIE_LOCATION_PLAYING))
	    call 'FB' (m_Interface[interfaceRef], FB_LIGHTS_INTERMISSION,
			(MovieLocation[interfaceRef] = MOVIE_LOCATION_INTERMISSION))
	    call 'FB' (m_Interface[interfaceRef], BTN_INTERMISSION + FEEDBACK_OFFSET,
			(MovieLocation[interfaceRef] = MOVIE_LOCATION_INTERMISSION))
	    call 'FB' (m_Interface[interfaceRef], FB_LIGHTS_NON_MOVIE,
			(MovieLocation[interfaceRef] = 0))
	    call 'FB' (m_Interface[interfaceRef], FB_LIGHTS_CREDITS,
			(MovieLocation[interfaceRef] = MOVIE_LOCATION_CREDITS))
	}
	
	active (arguments[2] = 'MOVIE_MEDIA_TYPE') :
	{
	    //arguments[3] = Media Type
		//00 = nothing playing
		//01 = DVD
		//02 = Video Stream
		//03 = Blu-ray
		
	    [m_Interface[interfaceRef],POP_BLURAY_CONTROLS + CHN_POPUP_OFFSET] = (arguments[3] = '03')	    
	}
	
	active (arguments[2] = 'MUSIC_NOW_PLAYING_STATUS') :
	{
	    call 'FB' (m_Interface[interfaceRef], BTN_REPEAT_TOGGLE + FEEDBACK_OFFSET,
			(arguments[5]='1'))
	    call 'FB' (m_Interface[interfaceRef], BTN_RANDOM_TOGGLE + FEEDBACK_OFFSET,
			(arguments[6]='1'))
	    
	    #IF_DEFINED SATP
		if(KaleidescapeID[interfaceRef].zoneId) //if this is an SATP device
		{
		    //update the list in a moment, if shown
		    do_push_timed(m_Interface[interfaceRef], CHN_GET_LIST_DELAYED, 
				    LIST_REQUEST_TIMEOUT)
		    
		    if(CenterNowPlayingList(interfaceRef)) //if the center has changed
		    {
			//and if we're looking at the now playing window
			if(CurrentList[interfaceRef] = LIST_SHOW_NOWPLAYING)
			{
			    call 'GET LIST' (interfaceRef) //reload the list
			}
		    }
		}
	    #END_IF
	}
	active(arguments[2] = 'MUSIC_PRESET_INFORMATION') :
	{
	    stack_var char 	presetIDTest[MAX_RESPONSE_ARG_LEN]
	    stack_var char	presetTag[MAX_RESPONSE_ARG_LEN]
	    stack_var integer 	presetNumber
	    
	    //Pull the Preset ID out of the Preset Tag.
	    presetTag = arguments[3]	    
	    presetIDTest = remove_string(presetTag, PresetID[interfaceRef], 1)
	    
	    //Check to see if this ID is the one we're interested in.
	    if(presetIDTest = PresetID[interfaceRef])
	    {
		call 'TRACE' (interfaceRef, "'Setting preset data for preset ', arguments[3], 
				    ' with handle: ', arguments[4], ' and label: ', arguments[5]")
	    
		//The rest of presetTag is the numeric ID of the preset.
		presetNumber = atoi(presetTag)
		
		//Drop the handle into the table for later identification.
		PresetHandleTable[interfaceRef][presetNumber] = arguments[4]
		//if the prest label VT has been defined
		if(m_VT[VT_PRESET_LABEL_1 + presetNumber - 1] <> 0) 
		{
		    //send the preset label text to the VT
		    send_string m_Interface[interfaceRef], "'!T', 
			m_VT[VT_PRESET_LABEL_1 + presetNumber - 1], arguments[5]"
		}
		call 'FEEDBACK PRESET' (interfaceRef, arguments[4])
	    }
	}
	active(arguments[2] = 'PLAYING_MUSIC_INFORMATION') :
	{	    	    
	    call 'FEEDBACK PRESET' (interfaceRef, arguments[3])
	    if(m_VT[VT_NOW_PLAYING_ITEM] <> 0)
	    {
		//Output the Now Playing Item Label
		send_string m_Interface[interfaceRef], "'!T',
		    m_VT[VT_NOW_PLAYING_ITEM], arguments[4]"
	    }
	}
	
	active (arguments[2] = 'DEVICE_INFO') :
	{
	    //pass the sn and device ID to refactor the interface
	    call 'REFACTOR DEVICE ID' (interfaceRef, arguments[4], arguments[5])	    
	    call 'GET ADDITIONAL DEVICE DATA'(interfaceRef)
	}
	
	active (arguments[2] = 'DEVICE_TYPE_NAME'):
	{
	    DeviceTypeName[interfaceRef] = arguments[3]
	}
	
	active (arguments[2] = 'NUM_ZONES') :
	{
	    stack_var integer vid_zones
	    stack_var integer aud_zones
	    
	    vid_zones = atoi(arguments[3])
	    aud_zones = atoi(arguments[4])
	    
	    call 'CHECK CONFIGURATION'(interfaceRef, vid_zones, aud_zones)
	}
	
	//handle zone-in-standby error
	active (arguments[1] = '020') :
	{
	    //when we get a zone-in-standby error, indicate that our zone is off
	    call 'TRACE'(interfaceRef, 'Device receive the 020 error')
	    ON[m_Interface[interfaceRef], BTN_POWER_OFF_FB]
	}
	
	//invalid device error
	active (arguments[1] = '004') :
	{
	    OFF[m_Interface[interfaceRef], CHN_DEVICE_ONLINE]
	}
	
	active (arguments[2] = 'DEVICE_POWER_STATE') :
	{
	    stack_var integer offset
	    //When we get the power state feedback, check if our zone is on or off
	    
	    offset = KaleidescapeID[interfaceRef].zoneId + 3
	    
	    call 'TRACE'(interfaceRef, "'Received power change notice.  My state=',arguments[offset]")
	    
	    [m_Interface[interfaceRef],BTN_POWER_ON_FB]  = not (arguments[offset] = '0')
	    [m_Interface[interfaceRef],BTN_POWER_OFF_FB] =     (arguments[offset] = '0')
	    
	}
	
	active (arguments[2] = 'VIDEO_MODE') :
	{
	    send_level m_Interface[interfaceRef], LVL_VIDEO_MODE_COMPOSITE, atoi(arguments[3])
	    send_level m_Interface[interfaceRef], LVL_VIDEO_MODE_COMPONENT, atoi(arguments[4])
	    send_level m_Interface[interfaceRef], LVL_VIDEO_MODE_HDMI, atoi(arguments[5])
	    
	    if (SentTraceInfo)
	    {
		call 'VIDEO MODE TRACE' ('Composite/Svideo', atoi(arguments[3]),interfaceRef)
		call 'VIDEO MODE TRACE' ('Component       ', atoi(arguments[4]),interfaceRef)
		call 'VIDEO MODE TRACE' ('HDMI            ', atoi(arguments[5]),interfaceRef)
	    }
	}
	
	active (arguments[2] = 'CINEMASCAPE_MODE') :	//Added for CinemaScape support, 10/26/11
	{
	    CinemaScape_Mode[interfaceRef] = atoi(arguments[3])
	    
		send_level m_Interface[interfaceref], LVL_CINEMASCAPE_MODE, CinemaScape_Mode[interfaceRef]
		   
		call 'FB' (m_Interface[interfaceRef], FB_CINEMASCAPE_OFF, 
			    (CinemaScape_Mode[interfaceRef] = FB_CINEMASCAPE_OFF - 130))
		call 'FB' (m_Interface[interfaceRef], FB_CINEMASCAPE_ANAMORPHIC, 
			    (CinemaScape_Mode[interfaceRef] = FB_CINEMASCAPE_ANAMORPHIC - 130))
		call 'FB' (m_Interface[interfaceRef], FB_CINEMASCAPE_LETTERBOX, 
			    (CinemaScape_Mode[interfaceRef] = FB_CINEMASCAPE_LETTERBOX - 130))
		call 'FB' (m_Interface[interfaceRef], FB_CINEMASCAPE_NATIVE, 
			    (CinemaScape_Mode[interfaceRef] = FB_CINEMASCAPE_NATIVE - 130))
	    
	    if(CinemaScape_Mode[interfaceRef])
	    {
		call 'SEND_REQUEST' (interfaceRef, 'GET_SCALE_MODE:')
		call 'SEND_REQUEST' (interfaceRef, 'GET_CINEMASCAPE_MASK:')
	    }
	}
	
	active (arguments[2] = 'SCALE_MODE') :	//Added for CinemaScape support, 02/13/12
	{
	    Scale_Mode[interfaceRef] = atoi(arguments[3])
	    
	    send_level m_Interface[interfaceRef], LVL_CINEMASCAPE_SCALE_MODE, Scale_Mode[interfaceRef]
	}
	
	active (arguments[2] = 'CINEMASCAPE_MASK') :	//Added for CinemaScape support, 10/26/11
	{
	    CinemaScape_Mask[interfaceRef] = atoi(arguments[3])
	
	    send_level m_Interface[interfaceRef], LVL_CINEMASCAPE_MASK, CinemaScape_Mask[interfaceRef]
	}
	
	active (arguments[2] = 'USER_INPUT') :
	{
	    stack_var integer keyboardPageState
	    stack_var integer keypadPageState
	    
	    keyboardPageState = 0 //assume we're going to close the pages
	    keypadPageState = 0
	    
	    switch (atoi(arguments[3]))	// determines the type of input needed
	    {		
		case 1: // keyboard input 
		{
		    keyboardPageState = 1
		}
		case 2: // keypad input 
		{
		    //don't pop the keypad over the parental control screen
		    if(OSDScreen[interfaceRef] != OSD_SCREEN_PARENTAL_CONTROL)
			keypadPageState = 1
		}
	    }
	       
	    [m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_KEYBOARD_PAGE] = keyboardPageState
	    [m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_KEYPAD_PAGE] = keypadPageState
	
	    if(m_VT[VT_INPUT_PROMPT] <> 0) //if the input prompt VT has been defined
	    {
		//send the prompt text to the VT
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_INPUT_PROMPT], 
				arguments[4]"
	    }

	    if(m_VT[VT_INPUT_FIELD] <> 0) //if the input field VT has been defined
	    {
		//send the input field text to the VT
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_INPUT_FIELD], 
				arguments[5]"
	    }
	}
	
	active (arguments[2] = 'USER_DEFINED_EVENT') :	// To create similar processes for handling volume commands with or without a 
	{						// Controller Zone Name the response to volume events has been moved to
							// the Kaleidescape Multiple Panel Include file. 
	    if(find_string(arguments[3], 'VOLUME_', 1) || find_string(arguments[3], 'TOGGLE_', 1))
	    {
	    	send_string m_Interface[interfaceRef], "'*V', arguments[3]"
	    }
	    else
	    {
		send_string m_Interface[interfaceRef], "'~U', arguments[3]"
	    }
	}
	
	active (arguments[2] = 'FRIENDLY_NAME') :
	{
	    PlayerName[interfaceRef] = arguments[3]
	    if(m_VT[VT_PLAYER_NAME] <> 0)
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_PLAYER_NAME], 
				arguments[3]"
	    }
	}
	
	active (arguments[2] = 'HIGHLIGHTED_SELECTION') :
	{
	    //if either the details info, title, or images values are defined...
	    if( (m_VT[VT_DETAILS_INFO]) 
	     || (m_VT[VT_DETAILS_TITLE])
	     || (length_string(m_UIImages[IMG_DETAILS]) > 0) )
	    {		    
		//ask for the details for this handle
		HighlightedSelectionHandle[interfaceRef] = arguments[3]
		do_push_timed(m_Interface[interfaceRef], CHN_RESET_HIGHLIGHTED_DETAILS, 
				TIMEOUT_GET_DETAILS)
	    }
	}
	
	active (sequence = '0') : //trap the now playing update information
	{
	    if(arguments[2] = 'CONTENT_DETAILS' && arguments[4] = 'Cover_URL')
	    {
		//if a now playing image is defined
		if( length_array(m_UIImages[IMG_NOW_PLAYING]) )	
		{
		    call 'SET IMAGE'(interfaceRef, m_UIImages[IMG_NOW_PLAYING], arguments[5])
		}
	    }	
	}
	
	active (arguments[2] = 'CONTENT_DETAILS_OVERVIEW') :
	{	    
	    NumberOfDetails = atoi(arguments[3])
	    ContentDetail.library = arguments[5]
	    
	    //Clear all remaining fields
	    ContentDetail.title = ''
	    ContentDetail.performer = ''
	    ContentDetail.composer = ''
	    ContentDetail.genre = ''
	    ContentDetail.rating = ''
	    ContentDetail.ratingReason 	= ''
	    ContentDetail.year = ''
	    ContentDetail.runningTime = ''
	    ContentDetail.synopsis = ''
	    ContentDetail.location = ''
	}   
	
	//if this is a detail, and there is detail data
	active(arguments[2] = 'CONTENT_DETAILS' ) :
	{  
	    select
	    {		
		active(arguments[4] = 'Artist') : ContentDetail.performer = arguments[5]
		active(arguments[4] = 'Artists') : ContentDetail.performer = arguments[5]
		active(arguments[4] = 'Performer') : ContentDetail.performer = arguments[5] 
		active(arguments[4] = 'Performers') : ContentDetail.performer = arguments[5] 
		active(arguments[4] = 'Composer') : ContentDetail.composer = arguments[5] 
		active(arguments[4] = 'Composers') : ContentDetail.composer = arguments[5] 
		active(arguments[4] = 'Genre') : ContentDetail.genre = arguments[5] 
		active(arguments[4] = 'Genres') : ContentDetail.genre = arguments[5] 
		active(arguments[4] = 'Album_title') : ContentDetail.title = arguments[5] 
		active(arguments[4] = 'Title') : ContentDetail.title = arguments[5] 
		active(arguments[4] = 'Album_year') : ContentDetail.year = arguments[5] 
		active(arguments[4] = 'Rating') : ContentDetail.Rating = arguments[5]
		active(arguments[4] = 'Rating_reason') : 
		    ContentDetail.ratingReason = arguments[5]
		active(arguments[4] = 'Synopsis') : ContentDetail.synopsis = arguments[5]
		active(arguments[4] = 'Year') : ContentDetail.year = arguments[5]
		active(arguments[4] = 'Actors') : ContentDetail.performer = arguments[5]
		active(arguments[4] = 'Directors') : ContentDetail.composer = arguments[5]
		active(arguments[4] = 'Running_time') : 
		    ContentDetail.runningTime = arguments[5]    	
		active(arguments[4] = 'Cover_URL') : ContentDetail.coverURL = arguments[5]
		active(arguments[4] = 'Disc_location') : ContentDetail.location = arguments[5]
		active(1) : call 'TRACE' (interfaceRef, 'Ignoring this detail')
	    }
	    
	    //if we've seen the last detail, render the details
	    if(atoi(arguments[3]) = numberOfDetails) call 'RENDER DETAILS' (interfaceRef)
	
    	return;
	}
	
	#IF_DEFINED SATP
	
	//combine these two notices to have unified local variables
	active( arguments[2] = 'BROWSE_RESULTS_OVERVIEW' || 
		arguments[2] = 'BROWSE_RESULT') :
	{
	    local_var integer lastItem
	    stack_var integer lineNumber
	    
	    //reset the timeout
	    do_push_timed(m_Interface[interfaceRef], CHN_LIST_ACTIVE, LIST_ACTIVE_TIMEOUT)
	    
	    if(length_string(arguments[2]) = 23) //this is the overview
	    {
		stack_var integer nodeRef
		nodeRef = BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current
		
		//the handle is arguments[3]
		select
		{
		    //no search is active
		    active (length_array(BrowseNodeResource[nodeRef].searchText) = 0):
		    {
			//send the list title
			send_string m_Interface[interfaceRef], "'!T', BTN_LIST_TITLE, 
					arguments[4]"
		    }
		    //fuzzy search is active (telephone keypad style)
		    active (isFuzzySearch(nodeRef)): 
		    {
			send_string m_Interface[interfaceRef], "'!T', BTN_LIST_TITLE, 
					arguments[4], ' - Matching '"
		    }
		    active (1):
		    {
			send_string m_Interface[interfaceRef], "'!T', BTN_LIST_TITLE, arguments[4], 
			    ' - Matching "', toTitleCaps(BrowseNodeResource[nodeRef].searchText), 
			    '"'"
		    }
		}
		    
		lastItem = atoi(arguments[5])
		ListLength[interfaceRef] = atoi(arguments[6])
		ListOffset[interfaceRef] = 0 //clear the offset
		if(CurrentList[interfaceRef] = LIST_SHOW_NOWPLAYING)
		{
		    BrowseNodeResource[nodeRef].selection = 0		//we can't track the now playing item, so remove the highlight
		}
		
		//if the keyboard search is active
		if(KeyboardStatus[interfaceRef] = KEYB_SEARCH) 
		{
		    if( m_VT[VT_INPUT_PROMPT])
		    {
			send_string m_Interface[interfaceRef], "'!T', m_VT[VT_INPUT_PROMPT], 
					'Search ', arguments[4]"
		    }
			
		    if(m_VT[VT_SATP_SEARCH_MATCH]) //if the VT is setup
		    {
			if(ListLength[interfaceRef] = 0) //if the list length is zero
			{
			    //indicate no matches
			    send_string m_Interface[interfaceRef], "'!T', 
					    m_VT[VT_SATP_SEARCH_MATCH], 
					    'No matching entries'"
			}
			//if more than 1 entry
			if( (ListLength[interfaceRef] > 1) and (!isFuzzySearch(nodeRef)) )
			{
			    //indicate the number
			    send_string m_Interface[interfaceRef], "'!T', 
					    m_VT[VT_SATP_SEARCH_MATCH],
					    'Matches ', itoa(ListLength[interfaceRef]), 
					    ' entries'"
			}
		    }
		}
		else //keyboard search is off
		{
		    //Check to ensure list is in bounds
		    
		    //if the list fits in the window
		    if(ListLength[interfaceRef] <= ListWindowLength[interfaceRef] )
		    {
			//if the last item on the list isn't the last item displayed and has been intentionally moved
			if(lastItem <> ListLength[interfaceRef] and 
		           BrowseNodeResource[nodeRef].moved )
			{
			    BrowseNodeResource[nodeRef].position = 1 //reset to the top of the list
			    
			    call 'TRACE'(interfaceRef, 'Reposistioning list to fill the top of the window.')
			    
			    //go get the new list (will double draw the window)
			    call 'GET LIST'(interfaceRef)
			}
		    }
		    else   //if the list doesn't fit in the window and hasn't moved
		    {
			/*
			 * if the entire list doesn't fill the window (last item short 
			 * of the window length)
			 * and the list has been intentionally moved
			 */
			if(lastItem < ListWindowLength[interfaceRef] and 
		           BrowseNodeResource[nodeRef].moved )
			{
			    /*
			     * reset to the bottom of the list (last item occupies 
			     * the last spot in the window)
			     */
			    BrowseNodeResource[nodeRef].position = ListLength[interfaceRef] - 
				    ListWindowLength[interfaceRef] + 1
				    
			    call 'TRACE'(interfaceRef, 'Reposistioning list to fill the bottom of the window.')
				    
			    //go get the new list (will double draw the window)
			    call 'GET LIST'(interfaceRef) 
			}
		    }
		    		    
		    call 'LIST RENDER SEARCH BUTTON' (interfaceRef)
		    
		    if(!ListLength[interfaceRef]) //if the length is non zero
		    {
			//blank the lines
			for(lineNumber++; lineNumber <= ListWindowLength[interfaceRef]; 
				lineNumber++)
			{
			    List[interfaceRef][lineNumber].behavior = 0
			    call 'LIST RENDER WINDOW'(interfaceRef, lineNumber, '', 0, 0)
			}
		    }
		    else
		    {
			call 'LIST RENDER SCROLLBAR' (interfaceRef)
		    }

		    //if there's a previous node in the stack, render the back button
		    call 'FB' (m_Interface[interfaceRef], BTN_LIST_BACK + FEEDBACK_OFFSET, 
				BrowseNodeResource[nodeRef].previousNode)
		}
	    }
	    else //this is a result
	    {
		lineNumber = atoi(arguments[3])
		
		//store the functions for each line
		List[interfaceRef][lineNumber].behavior = atoi(arguments[8])
		List[interfaceRef][lineNumber].handle = arguments[9]
		List[interfaceRef][lineNumber].pop = atoi(arguments[10])
		
		//if the keyboard search is active
		if(KeyboardStatus[interfaceRef] = KEYB_SEARCH)
		{
		    if(m_VT[VT_SATP_SEARCH_MATCH]) //if the VT is setup
		    {
			if(ListLength[interfaceRef] = 1) //if there is exactly one match
			{
			    //send that named match
			    send_string m_Interface[interfaceRef], "'!T', 
					    m_VT[VT_SATP_SEARCH_MATCH], 'Matches "', 
					    arguments[5], '"'"
			}
			else if(isFuzzySearch(BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current))
			{
			    //send that named match
			    send_string m_Interface[interfaceRef], "'!T', 
					    m_VT[VT_SATP_SEARCH_MATCH], 'Matches "',
					    arguments[5], '"', TouchPanelNewLine, 'and ',
					    itoa(ListLength[interfaceRef] - 1), ' more'"
			}
		    }
			
		    //indicate that we're done with the list
		    do_release(m_Interface[interfaceRef], CHN_LIST_ACTIVE)
		    
		    call 'LIST RENDER SCROLLBAR' (interfaceRef)
		}
		
		else //not in keyboard search
		{
		    if(lineNumber = 1) //if this is the first line
		    {
		    	stack_var integer nodeRef
			
			nodeRef = BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current
			
			//store the actual position of this node
			BrowseNodeResource[nodeRef].position = atoi(arguments[4])
			//set the relative position of the entire list
			ListOffset[interfaceRef] = BrowseNodeResource[nodeRef].position - lineNumber
			call 'LIST RENDER SCROLLBAR' (interfaceRef)
		    }
				    
		    call 'LIST RENDER WINDOW'(interfaceRef, lineNumber, arguments[5], 
			    atoi(arguments[6]), List[interfaceRef][lineNumber].behavior)
		    
		    //if we've reached the last line
		    if(lineNumber = lastItem)
		    {
			//Check if the list was smaller than the window.
			if(lineNumber < ListWindowLength[interfaceRef])
			{
			    //blank the last lines
			    for(lineNumber++; lineNumber <= ListWindowLength[interfaceRef]; 
				    lineNumber++)
			    {
				List[interfaceRef][lineNumber].behavior = 0
				call 'LIST RENDER WINDOW'(interfaceRef, lineNumber, '', 0, 0)
			    }
			}
			
			//indicate that we're done with the list
			do_release(m_Interface[interfaceRef], CHN_LIST_ACTIVE)
		    }
		}
	    }
	}	
	active(arguments[1] = '017' ) :		//we'll get this error if we've an invalid browse handle
	{
	    stack_var integer nodeRef
	    nodeRef = BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current
	    
	    if( KeyboardStatus[interfaceRef] = KEYB_OFF and		//if no keyboard search is active
		BrowseNodeResource[nodeRef].previousNode )		//and there's a previous node
	    {
		call 'POP NODE' (interfaceRef, CurrentList[interfaceRef])	//pop the node
		call 'GET LIST' (interfaceRef)					//and get the new list
		
	    }
	        
	    
	}
	
	
	#END_IF    
        //Parse other events here
    }
}





DEFINE_CALL 'ERROR DECODER' (integer errorCode, char details[])
{
    stack_var char description[80]
    
    switch (errorCode)
    {
	case 1:  
	{
		description =  "'Message too long.'"
	}
	case 2:  
	{
		description =  "'Message contains invalid character.'"
	}
	case 3:  
	{
		description =  "'Checksum error.'"
	}
	case 4:  
	{
		description =  "'Invalid device.'"
	}
	case 5:  
	{
		description =  "'Device unavailable.'"
	}
	case 10:  
	{
		description =  "'Invalid request.'"
	}
	case 11:  
	{
		description =  "'Invalid number of parameters.'"
	}
	case 12:
	{
		description =  "'Invalid parameter.'"
	}
	case 13:  
	{
		description =  "'Device identifier conflict.'"
	}
	case 14:  
	{
		description =  "'Invalid sequence number.'"
	}
	case 15:  
	{
		description =  "'Disallowed due to parental control.'"
	}
	case 16:  
	{
		description =  "'Invalid passcode.'"
	}
	case 17:  
	{
		description =  "'Invalid content handle.'"
	}
	case 28:  
	{
		description =  "'Incompatible video configuration.'"
	}
	case 29:  
	{
		description =  "'Incompatible video configuration.'"
	}
	case 999:  
	{
		description =  "'Undetermined error.'"
	}
	default:  
	{
		description =  "'Unknown error.'"
	}
    }
    
    call 'TRACE' (0, "'Error ', itoa(errorCode), ': ', description, ' ', details")
}

DEFINE_CALL 'VIDEO MODE TRACE' (char output[], integer videoMode, integer interfaceRef)
{
    stack_var char description[20]
    
    switch (videoMode)
    {
	case 0:
	{
	    description = "'no output'"
	}
	case 1:
	{
	    description = "'480i60 4x3'"
	}
	case 2:
	{
	    description = "'480i60 16x9'"
	}
	case 3:
	{
	    description = "'480p60 4x3'"
	}
	case 4:
	{
	    description = "'480p60 16x9'"
	}
	case 5:
	{
	    description = "'576i50 4x3'"
	}
	case 6:
	{
	    description = "'576i50 16x9'"
	}
	case 7:
	{
	    description = "'576p50 4x3'"
	}
	case 8:
	{
	    description = "'576p50 16x9'"
	}
	case 9:
	{
	    description = "'720p60'"
	}
	case 10:
	{
	    description = "'720p50'"
	}
	case 11:
	{
	    description = "'1080i60 16x9'"
	}
	case 12:
	{
	    description = "'1080i50 16x9'"
	}
	CASE 13:
	{
	    description = "'1080p60 16x9'"
	}
	CASE 14:
	{
	    description = "'1080p50 16x9'"
	}
	CASE 17:
	{
	    description = "'1080p24 16x9'"
	}
	CASE 19:
	{
	    description = "'480i60 64x27'"
	}
	CASE 20:
	{
	    description = "'576i50 64x27'"
	}
	CASE 21:
	{
	    description = "'1080i60 64x27'"
	}
	CASE 22:
	{
	    description = "'1080i50 64x27'"
	}
	CASE 23:
	{
	    description = "'1080p60 64x27'"
	}
	CASE 24:
	{
	    description = "'1080p50 64x27'"
	}
	CASE 25:
	{
	    description = "'1080p24 64x27'"
	}
    }
    
    call 'TRACE' (interfaceRef, "output,' video mode: ',description")
}

DEFINE_CALL 'SEND_KPORT' (messageToSend[256])
{
    if(length_string(messageToSend) = 0) return //do not process blank sends 
    
    if(portOpened)
    {
	send_string m_Kport, "messageToSend, $0D"
	
	call 'TRACE' (0, "'Sending command "', messageToSend, '"'")
	
	
	wait 50 'Send Timeout' //if no response in 5 seconds
	{
	    setPortInitialized(false)
	}
    }
    else
    {
	call 'TRACE' (0, 'Not sending string, port closed.')
	
	if(IPPortStatus = IP_PORT_CLOSED)
	{
	    managePort(IP_PORT_RESET, 0)
	}
    }
}

DEFINE_CALL 'SEND TO TARGET'(char deviceId[], integer deviceZoneId, integer sequence, char commandData[])
{
    stack_var char 	dataOut[256]
    stack_var char 	checksum
    stack_var integer 	index
    
    //Build the whole command.
    dataOut = deviceId //set the device ID

    //if there's a stream ID, set the stream ID
    if(deviceZoneId != 0) dataOut = "dataOut, format('.%02d', deviceZoneId)"	 
    
    //add in the sequence and command
    dataOut = "dataOut, '/', sequence, '/', commandData, '/'"
    
    //Calculate the checksum.
    checksum = 0

    for( index = 1; index <= length_array(dataOut); index++ )
    {
        checksum = (checksum + dataOut[index]) % 100
    }
    
    //Add checksum to request, always two digits, zero-padded.
    dataOut = "dataOut, format('%02d', checksum)"
    
    call 'SEND_KPORT' (dataOut)
}

DEFINE_CALL 'SEND_REQUEST' (integer interfaceRef, char commandData[256])
{
    stack_var char deviceId[13]
    
    /* 
     * Kaleidescape requests are of the format:
     *
     *    01/1/COMMAND:ARG1:ARG2:/99
     * 		or
     * 	  01.01/1/COMMAND:ARG1:ARG2:/99
     *
     *    where:
     *  
     *      01 is the device you're controlling (01 is the device you're connected to,
     *          but you can assign each device a unique ID using the installer web utility.)
     *      1 is the sequence number.  
     *      COMMAND: is the command, such as "SELECT:" to press the Select button.
     *      ARG1: are the arguments to the command.  Usually there are no arguments.
     *      99 is the checksum, which we calculate.
     */
    
    if(atoi(KaleidescapeID[interfaceRef].deviceId) = 0)
    {
	deviceId = '01'
    }
    else
    {
	deviceId = KaleidescapeID[interfaceRef].deviceId
    }
	
    call 'SEND TO TARGET' (deviceId, KaleidescapeID[interfaceRef].zoneId, 
	    KaleidescapeID[interfaceRef].sequence, commandData)
}

//refresh all strings and levels on given device
DEFINE_CALL 'REFRESH TP' (interfaceRef)
{
    stack_var loop
    call 'TRACE' (interfaceRef,"'Refreshing TP Feedback'")
    
    if(m_VT[VT_CHAPTER_NUMBER] <> 0)
    {
	//send chapter info to TP if defined
	send_string m_Interface[interfaceRef], "'!T', m_VT[VT_CHAPTER_NUMBER],
			itoa(Chapter[interfaceRef])" 
    }
	
    if(m_VT[VT_TRACK_TOTAL_TIME] <> 0)
    {
	send_string m_Interface[interfaceRef], "'!T', m_VT[VT_TRACK_TOTAL_TIME],
			displayHMS(TitleLength[interfaceRef])"
    }
	
    if(m_VT[VT_PLAYER_NAME] <> 0)
    {
	send_string m_Interface[interfaceRef], "'!T', m_VT[VT_PLAYER_NAME],
			PlayerName[interfaceRef]"
    }
	
    // send page flips
    
    //if a page reference exists for this screen and it's been set
    if (  (max_length_array(m_UIPages) >= OSDScreen[interfaceRef]) &&
       (OSDScreen[interfaceRef] <> 0) )
    {
	//if a page has been defined for this screen
	if(length_array(m_UIPages[OSDScreen[interfaceRef]]) > 0)
	{
	    send_string m_Interface[interfaceRef], "'PAGE-', 
			    m_UIPages[OSDScreen[interfaceRef]]"
	}
    }
    
    for(loop = max_length_array(m_UIPopups); loop > 0; loop--)
    {
	call 'SET POPUP STATE'(interfaceRef, loop)
    }

    if(IPPortStatus != IP_PORT_OPEN)
    {
	showConnectionPopup(lastConnectionMessage)
    }
}

DEFINE_CALL 'ENABLE EVENTS' (integer interfaceRef)
{
    if(KaleidescapeID[interfaceRef].zoneId = 0) //if we're not controlling a stream
    {
	if(DeviceIndirect[interfaceRef]) //and if we're not directly connected
	{
	    //enable feedback
	    call 'SEND TO TARGET' ('01', 0, '0', "'ENABLE_EVENTS:', KaleidescapeID[interfaceRef].deviceId, ':'")
	}
    }
    else //if we are controlling a stream
    {
	//enable events for the stream ID
	call 'SEND TO TARGET' ('01', 0, '0', "'ENABLE_EVENTS:', KaleidescapeID[interfaceRef].deviceId, '.', itoa(KaleidescapeID[interfaceRef].zoneId), ':'")	
    }
}


DEFINE_CALL 'REFACTOR DEVICE ID' (integer interfaceRef, char serialNumber[], char deviceId[])
{
    stack_var char realDeviceId[13]
    stack_var char oldDeviceId[13]

    realDeviceId = deviceId

    //if it's non routable (0), it's actaully 1 (local)
    if(realDeviceId = '00') realDeviceId = '01'
    
    oldDeviceId = KaleidescapeID[interfaceRef].deviceId
    
    if(KaleidescapeID[interfaceRef].deviceId = '01') //if the stated device ID is a control ID (not a serial number) and is 1
    {
	//use the connected device ID
	set_length_array(KaleidescapeID[interfaceRef].deviceId, 2)
	KaleidescapeID[interfaceRef].deviceId = ConnectedDeviceID
    }
    
    //if the serial number is the same as the connected device's SN
    if(serialNumber = ConnectedDeviceSN) 
    {
	DeviceIndirect[interfaceRef] = false //then we're directly connected
    }
    else
    {
	DeviceIndirect[interfaceRef] = true //if not, we're indirectly connected
    }

    call 'ENABLE EVENTS'(interfaceRef)
    
    call 'TRACE'(interfaceRef, "'Refactored - old ID=', oldDeviceId, 
		', new ID=', KaleidescapeID[interfaceRef].deviceId,
		', Stream=' ,itoa(KaleidescapeID[interfaceRef].zoneId), 
		', Indirect=', itoa(DeviceIndirect[interfaceRef]), 
		', SN=', serialNumber")
}

//when the device starts up...
DEFINE_CALL 'INITIALIZE DEVICE' (integer interfaceRef)
{    
    if(portPassingCommands)
    {
	//retrieve what type of device we're talking to
	call 'SEND_REQUEST' (interfaceRef, 'GET_DEVICE_INFO:')
    }
}


DEFINE_CALL 'GET ADDITIONAL DEVICE DATA' (integer interfaceRef)
{
    call 'SEND_REQUEST' (interfaceRef, 'GET_DEVICE_TYPE_NAME:') //get the name of the device we're connected to.
    call 'SEND_REQUEST' (interfaceRef, 'GET_NUM_ZONES:')   //find out how many zones are available on the device
    call 'SEND_REQUEST' (interfaceRef, 'GET_CINEMASCAPE_MODE:')
    call 'SEND_REQUEST' (interfaceRef, 'GET_SYSTEM_READINESS_STATE:')
    
    
    call 'SEND_REQUEST' (interfaceRef, "'SEND_EVENT:VOLUME_CAPABILITIES=', itoa(VolumeCapability[interfaceRef]), ':'")	//Send Volume capabilities to the player when the IP port is opened
}


DEFINE_CALL 'AUDIO ZONE COUNT ERROR' (InterfaceRef, aud_zones)
{
    if(aud_zones = 0)
    {
	send_string 0, "'Kaleidescape Config ERROR! K Virtual dev #',itoa(interfaceRef),
		  ' is set to control ID ', KaleidescapeID[interfaceRef].deviceId,
		  ', zone ',itoa(KaleidescapeID[interfaceRef].zoneId),
		  '; a ',DeviceTypeName[interfaceRef],' with no audio zones.',10,13"
    }
    else
    {
	send_string 0, "'Kaleidescape Config ERROR! K Virtual dev #',itoa(interfaceRef),
		  ' is set to control ID ', KaleidescapeID[interfaceRef].deviceId,
		  ', zone ',itoa(KaleidescapeID[interfaceRef].zoneId),
		  '; a ',DeviceTypeName[interfaceRef],' with only ',itoa(aud_zones),' audio zone(s).',10,13"
    }
}


DEFINE_CALL 'VIDEO ZONE COUNT ERROR' (InterfaceRef)
{
    send_string 0, "'Kaleidescape Config ERROR! K Virtual dev #',itoa(interfaceRef),
		  ' is set to control video on ID ', KaleidescapeID[interfaceRef].deviceId,
		  ', a ',DeviceTypeName[interfaceRef],' which has no video zones.',10,13"
}


DEFINE_CALL 'CHECK CONFIGURATION'(interfaceRef, vid_zones, aud_zones)
{
    if(DeviceTypeName[interfaceRef] = '')
    {
	DeviceTypeName[interfaceRef] = 'device'
    }
    
    if( KaleidescapeID[interfaceRef].zoneID = 0 )	//OSD control
    {
	if( vid_zones >= 1 )				//if there's at least 1 video zones
	{
	    ON[m_Interface[interfaceRef], CHN_CONFIGURATION_VALID]	    
	}
	else
	{
	    call 'VIDEO ZONE COUNT ERROR' (interfaceRef)
	}
    }
    else
    {
	if( aud_zones >= KaleidescapeID[interfaceRef].zoneId )
	{
	    ON[m_Interface[interfaceRef], CHN_CONFIGURATION_VALID]
	}
	else
	{
	    CALL 'AUDIO ZONE COUNT ERROR' (InterfaceRef, aud_zones)
	}
    }
}




//verify that the port is passing traffic
DEFINE_CALL 'CHECK PORT' ()
{
    //the DEVICE_POWER_STATE message should return even if the device is in standby
    call 'SEND TO TARGET'('01', 0, '0', 'GET_DEVICE_POWER_STATE:')    
}

//verify that the port is routing traffic
DEFINE_CALL 'CHECK COMMAND PASSING' ()
{
    //If DEVICE_INFO is valid, then command passing should be available
    call 'SEND TO TARGET'('01', 0, '0', 'GET_DEVICE_INFO:')
}


DEFINE_CALL 'SET POPUP STATE'(interfaceRef, popupRef)
{
    stack_var loop
    
    //ensure this page is defined
    if(m_UIPopups[popupRef] = '')
	return
	
    if([m_Interface[interfaceRef], CHN_POPUP_OFFSET + popupRef])
    {
	send_string m_Interface[interfaceRef], "'@PPN-',
	    m_UIPopups[popupRef]"
	    
	//for these popups, set on all pages
	if(popupRef =  POP_NOW_PLAYING or
	   popupRef =  POP_DETAILS_PAGE or
	   popupRef =  POP_CONNECTION_STATUS)
	{
	    for(loop = max_length_array(m_UIPages); loop > 0; loop--) //step through all K pages
	    {
		if(not (m_UIPages[loop] = '')) //if this page is used
		{
		    //enable the popup on this page
		    send_string m_Interface[interfaceRef], "'@PPN-', 
				    m_UIPopups[popupRef], ';', m_UIPages[loop]"
		}
	    }
	}
    }
    else
    {
	send_string m_Interface[interfaceRef], "'@PPK-',
	    m_UIPopups[popupRef]"
    }
}


DEFINE_CALL 'CLEAR FEEDBACK'(integer interfaceRef)
{
    stack_var integer chn, linenumber
    
    //clear any button feedback
    for(chn = 1; chn <= LAST_BUTTON; chn++)
    {
	if(chn <> BTN_POWER_OFF)		//don't clear the power off FB
	    call 'FB'(m_Interface[interfaceRef], chn, 0)
    }
    
    //clear the popups
    for(chn = CHN_POPUP_OFFSET + max_length_array(m_UIPopUps); chn > CHN_POPUP_OFFSET; chn--)
    {
	if(chn != POP_CONNECTION_STATUS + CHN_POPUP_OFFSET)		//don't clear the connection pop up
	    OFF[m_interface[interfaceRef], chn]
    }
    
    #IF_DEFINED SATP

    if(KaleidescapeID[interfaceRef].zoneId)	//if this is an SATP device
    {
	//clear the title
	send_string m_Interface[interfaceRef], "'!T', BTN_LIST_TITLE, ''"
	//?BrowseNodeResource[nodeRef].selection = 0		//we can't track the now playing item, so remove the highlight
	ListLength[interfaceRef] = 0
	ListOffset[interfaceRef] = 0
	
	//blank the lines
	for(lineNumber++; lineNumber <= ListWindowLength[interfaceRef]; 
		lineNumber++)
	{
	    List[interfaceRef][lineNumber].behavior = 0
	    call 'LIST RENDER WINDOW'(interfaceRef, lineNumber, '', 0, 0)
	}
    }
    #END_IF
}


// handle XY coordinate presses
DEFINE_CALL 'HANDLE COORDINATE PRESS' (integer interfaceRef)
{
    //the Coordinate array consists of [1]=X Coordinate, [2]=Y Coordinate, [3]=Press active

    //if the press isn't already active (this should always be true
    if(Coordinate[interfaceRef][3] = 0) 
    {
	Coordinate[interfaceRef][3] = 1 //indicate that we're going

	//wait for the X and Y Coordinates to settle or wait until the Press active expires
	wait_until ( ( (Coordinate[interfaceRef][1] <> 0) 
		    && (Coordinate[interfaceRef][2] <> 0) ) 
		    ||  (Coordinate[interfaceRef][3]  = 0) )
	{
	    if(Coordinate[interfaceRef][3] = 1) //if the Press active hasn't expired
	    {
		//send the command
		call 'SEND_REQUEST' (interfaceRef, "'POSITION_SELECT:', 
			itoa(Coordinate[interfaceRef][1]), ':',
			itoa(Coordinate[interfaceRef][2]), ':'")
	    }
	    else
	    {
		call 'TRACE' (interfaceRef, "'Push expired.'")
	    }
	}
    }
}

DEFINE_CALL 'HANDLE COORDINATE RELEASE' (integer interfaceRef)
{
    call 'TRACE' (interfaceRef, "'Coordinate release.  Coordinate= ', 
	    itoa(Coordinate[interfaceRef][1]), ',',
	    itoa(Coordinate[interfaceRef][2]), ',',
	    itoa(Coordinate[interfaceRef][3])")
    Coordinate[interfaceRef][1] = 0
    Coordinate[interfaceRef][2] = 0

    //reset flag to expire any pending wait_until, and clear coordinates
    Coordinate[interfaceRef][3] = 0 
}


DEFINE_CALL 'HANDLE PLAY PAUSE PRESS' (integer interfaceRef)
{
    if(PlayMode[interfaceRef] = PLAY_MODE_PLAYING) //if we are playing
    {
	call 'SEND_REQUEST'(interfaceRef, 'PAUSE_ON:') //send the pause command
    }
    else
    {
	call 'SEND_REQUEST'(interfaceRef, 'PLAY:') //otherwise, send the play command
    }
    
}

//function to substitute any char for any other
DEFINE_CALL 'STRING SUBSTITUTE' (char sourceString[], char stringToReplace, 
				 char replacementString[], char resultString[])
{
    stack_var integer loop
    
    //step through every character of source
    for(loop = 1; loop <= length_string(sourceString); loop++)
    {
	if(sourceString[loop] = stringToReplace) //examine it
	{
	    resultString = "resultString, replacementString" //replace it
	}
	else
	{
	    resultString = "resultString, sourceString[loop]" //append the character
	}
    }
}

DEFINE_CALL 'RENDER DETAILS' (integer interfaceRef)
{
    integer 	totalSeconds
    integer 	hours
    integer 	minutes
    char 	timeString[255]
    char 	details[2048]
    integer 	loop
    
    totalSeconds = atoi(ContentDetail.runningTime)
    
    call 'SET IMAGE' (interfaceRef, m_UIImages[IMG_DETAILS], ContentDetail.coverURL)
    
    if(ContentDetail.library = 'albums')
    {
	call 'TRACE' (interfaceRef, 'Rendering Album Details')
	if(m_VT[VT_DETAILS_TITLE]) //if the details title is defined
	{
	    send_string m_Interface[interfaceRef], "'!T', m_VT[VT_DETAILS_TITLE], 
			    ContentDetail.performer, ' - ', ContentDetail.title"
	}

	if(m_VT[VT_DETAILS_INFO])
	{
	    hours = totalSeconds / 3600
	    minutes = (totalSeconds mod 3600) / 60
	    timeString = formatHMS(hours, minutes, 0)
	    
	    details = "'Released ', ContentDetail.year, ', ', timeString, TouchPanelNewLine,
			TouchPanelNewLine"
	    
	    if(length_string(ContentDetail.genre) > 0)	
	    {
		//if there's more than one genre
		if(find_string(ContentDetail.genre, "13", 1) > 0)
		{
		    //add the plural description
		    details = "details, 'GENRES', TouchPanelNewLine"
		    
		    //substitute commas for line feeds
		    call 'STRING SUBSTITUTE' (ContentDetail.genre, 13, ', ', details)
		    details = "details, TouchPanelNewLine, TouchPanelNewLine"
		}
		else
		{
		    //add the singular description
		    details = "details, 'GENRE', TouchPanelNewLine, ContentDetail.genre,
				TouchPanelNewLine, TouchPanelNewLine"
		}
	    }
		    
	    if(length_string(ContentDetail.performer) > 0)
	    {
		details = "details, 'PERFORMER', TouchPanelNewLine, ContentDetail.performer, 
			    TouchPanelNewLine, TouchPanelNewLine"
	    }
	    
	    if(length_string(ContentDetail.location) > 0)	
	    {
		details = "details, 'LOCATION', TouchPanelNewLine, ContentDetail.location"
	    }
	}
    }
    
    else if(ContentDetail.library = 'movies')	
    {
	call 'TRACE' (interfaceRef, 'Rendering Movie Details')
	
	    
	if(m_VT[VT_DETAILS_TITLE]) //if the details title is defined
	{
	    send_string m_Interface[interfaceRef], "'!T', m_VT[VT_DETAILS_TITLE], 
			    ContentDetail.title"
	}
	
	if(m_VT[VT_DETAILS_INFO]) //if the details info is defined
	{
	    //For movies, running time incorrectly returns minutes instead of seconds.
	    hours = totalSeconds / 60
	    minutes = totalSeconds mod 60
	    
	    timeString = formatHMS(hours, minutes, 0)
	    
	    //if there's both a time and year
	    if( (length_string(timeString) > 0) && (length_string(ContentDetail.year) > 0) )
	    {
		timeString = "timeString, ', '"
	    }
	    
	    details = "'Rated ', ContentDetail.rating"
	    
	    if(length_string(ContentDetail.ratingReason) > 0)
	    {
		details = "details, ' for ', ContentDetail.ratingReason"
	    }
	
	    details = "details, '; ', timeString, ContentDetail.year, TouchPanelNewLine, 
		TouchPanelNewLine"
	    
	    if(length_string(ContentDetail.synopsis) > 0)
	    {
		details = "details, 'SYNOPSIS', TouchPanelNewLine, ContentDetail.synopsis, TouchPanelNewLine, TouchPanelNewLine"
	    }
	    
	    if(length_string(ContentDetail.genre) > 0)	
	    {
		//if there's more than one genre
		if(find_string(ContentDetail.genre, "13", 1) > 0)
		{
		    //add the plural description
		    details = "details, 'GENRES', TouchPanelNewLine"
		    
		    //substitute commas for line feeds
		    call 'STRING SUBSTITUTE' (ContentDetail.genre, 13, ', ', details)
		    details = "details, TouchPanelNewLine, TouchPanelNewLine"
		}
		else
		{
		    //add the singular description
		    details = "details, 'GENRE', TouchPanelNewLine, ContentDetail.genre, 
			TouchPanelNewLine, TouchPanelNewLine"
		}
	    }
		    
	    if(length_string(ContentDetail.performer) > 0)
	    {
		details = "details, 'CAST', TouchPanelNewLine"
		call 'STRING SUBSTITUTE' (ContentDetail.performer, 13, ', ', details)
		details = "details, TouchPanelNewLine, TouchPanelNewLine"
	    }
		    
	    if(length_string(ContentDetail.composer) > 0)	
	    {
		//if there's more than one director
		if(find_string(ContentDetail.composer, "13", 1) > 0)
		{
		    //add the plural description
		    details = "details, 'DIRECTORS', TouchPanelNewLine"	
		    
		    //substitute commas for line feeds
		    call 'STRING SUBSTITUTE' (ContentDetail.composer, 13, ', ', details)
		}
		else
		{
		    //add the singular description
		    details = "details, 'DIRECTOR', TouchPanelNewLine, 
			ContentDetail.composer"
		}
		details = "details, TouchPanelNewLine, TouchPanelNewLine"
	    }
	    if(length_string(ContentDetail.location) > 0)	
	    {
		details = "details, 'LOCATION', TouchPanelNewLine, ContentDetail.location"
	    }
	}
    }
    
    if(m_VT[VT_DETAILS_INFO]) //if there is a details info VT field
    {
	call 'SEND LONG TEXT'(interfaceRef, m_VT[VT_DETAILS_INFO], details)
    }
    
    ON[m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_DETAILS_PAGE]

}

//set the image on a touch panel when given a full URL 
DEFINE_CALL 'SET IMAGE' (integer interfaceRef, char resource[], char givenURL[])
{
    char junk[10]
    char host[50]
    char URI[500]
    
    URI = givenURL
    
    junk = remove_string(URI, "'//'", 1) //remove the http://
    host = remove_string(URI, "'/'", 1) //pull out the host name
    
    host = left_string(host, length_string(host) - 1) //remove the first character
    
    if(length_string(CoverHostOverride)) //if we've been given a different URL
    {
	host = CoverHostOverride //use it instead
    }
    
    if(length_string(resource)) //if this is a non-zero length
    {
	send_string m_Interface[interfaceRef], "'^RMF-', resource, ',%H', 
			host, '%F', URI"
	call 'TRACE'(interfaceRef, "'Updating cover - Resource: ', resource, ', Host: ',
		host, ','")
	call 'TRACE'(interfaceRef, "'Path: ', URI")
    }
    
}

#IF_DEFINED SATP
/*******************************************************************************************
 **                  SATP-Only routines                                                   **
 *******************************************************************************************/ 

DEFINE_FUNCTION integer boundsCheckListPosition(interfaceRef, integer listPosition)
{
    if(listPosition < 2) return(1) //if the position is 0 or 1, just return 1
    
    //if there's more list than window
    if(ListLength[interfaceRef] > ListWindowLength[interfaceRef])
    {
	//if listPosition doesn't fit in the page bottom
	if(listPosition > (ListLength[interfaceRef] - ListWindowLength[interfaceRef] + 1) )
	{
	    //return the lowest possible value
	    return(ListLength[interfaceRef] - ListWindowLength[interfaceRef] + 1)
	}
	return(listPosition) //otherwise, just return listPosition
    }
    
    return(1) //if not (more list than window), then just set the position to 1
    
}

DEFINE_CALL 'LIST RENDER SEARCH BUTTON' (integer interfaceRef)
{
    stack_var integer nodeRef
    
    if(!m_VT[VT_SATP_SEARCH_BUTTON]) return; //if the button isn't defined, do nothing    
    
    //Get the active browse node for this interface.
    nodeRef = BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current
    
    //if the list doesn't fit the window, or the search is already active
    if( (ListLength[interfaceRef] > ListWindowLength[interfaceRef]) ||
	(KeyboardStatus[interfaceRef] = KEYB_SEARCH)
	 || length_string(BrowseNodeResource[nodeRef].searchText)  ) //or if a search is currently part of the result set
	if(BrowseNodeResource[nodeRef].previousNode ) 	    //and only if we're not on the top node
	{
	    if(m_VT[VT_SATP_SEARCH_BUTTON]) 
	    {
		//show the search button
		send_string m_Interface[interfaceRef], "'@SHO', 
				m_VT[VT_SATP_SEARCH_BUTTON], 1"
	    }

	    //if there is an active search or the keyboard is up
	    if(length_string(BrowseNodeResource[nodeRef].searchText) || 
		[m_Interface, CHN_POPUP_OFFSET + POP_SATP_KEYBOARD_SEARCH])
	    {
		//turn on the feedback
		call 'FB'(m_Interface[interfaceRef], BTN_LIST_SEARCH + FEEDBACK_OFFSET, 1)
	    }
	    else //otherwise
	    {
		//turn off the feedback
		call 'FB'(m_Interface[interfaceRef], BTN_LIST_SEARCH + FEEDBACK_OFFSET, 0)
	    }
	    return
	}
    //otherwise
    if(m_VT[VT_SATP_SEARCH_BUTTON]) 
    {
	//remove the search button
	send_string m_Interface[interfaceRef], "'@SHO', m_VT[VT_SATP_SEARCH_BUTTON], 0"
    }
}


DEFINE_CALL 'LIST RENDER SCROLLBAR' (integer interfaceRef)
{
    stack_var integer sliderTop
    stack_var integer sliderBottom
    stack_var integer nodeRef
    
    nodeRef = BrowseNodeStack[interfaceRef][ CurrentList[interfaceRef] ].current 
    
    if(ListLength[interfaceRef]) //prevent any divide-by-zero errors
    {
	sliderTop = 255 - ( (255 * (BrowseNodeResource[nodeRef].position-1) ) / ListLength[interfaceRef] )
	
	//if the list doesn't fit in the window
	if(ListLength[interfaceRef] > ListWindowLength[interfaceRef])
	{
	    sliderBottom = 255 - ( (255 * (BrowseNodeResource[nodeRef].position - 1 + 
		ListWindowLength[interfaceRef])) / ListLength[interfaceRef] )	    
	}
	else
	{
	    sliderBottom = 0 //if the list fits the window, show at max size
	}
    }
    else				//if the length is zero
    {
	sliderTop = 255
	sliderBottom = 0
    }
    send_level m_Interface[interfaceRef], LVL_SCROLL_BAR_TOP, sliderTop
    send_level m_Interface[interfaceRef], LVL_SCROLL_BAR_BOTTOM, sliderBottom		
}


DEFINE_CALL 'LIST RENDER WINDOW' (integer interfaceRef, integer lineNumber, 
				    char displayText[], integer displayIcon, 
				    integer behavior)
{
    stack_var char childIndicator[3]
    stack_var integer icon
    stack_var char textPrefix[5]
    stack_var integer nodeRef
    
    if(behavior = LIST_BEHAVIOR_BROWSE) //if this line had children
    {
	childIndicator = '  >' //add an indicator
    }
    else
    {
	childIndicator = ''
    }
    if( displayIcon = 0 || displayIcon > 3 ) //if no icon defined or out of bounds
    {
	icon = 0 //set to no icon
    }
    else
    {
	icon = m_UIIcons[displayIcon] //otherwise use the icon provided
    }
    
    textPrefix = ''
    
    //set the text
    send_string m_Interface[interfaceRef], "'!T', (BTN_LIST_LINE1 - 1 + lineNumber), 
		    textPrefix, displayText, childIndicator"
    
    //set the status icon
    send_string m_Interface[interfaceRef], "'@ICO', (FB_LIST_LINE1_STATUS - 1 + lineNumber), 
		    icon"
    
    //FB if this line is selected
    nodeRef = BrowseNodeStack[interfaceRef][ CurrentList[interfaceRef] ].current
    
    //if we show the play icon on the now playing page
    if(displayIcon = 1 && CurrentList[interfaceRef] = LIST_SHOW_NOWPLAYING)
    {
	//set this line to the selection
	BrowseNodeResource[nodeRef].selection = lineNumber + ListOffset[interfaceRef]
    }
    
    //only show the highlight if there's something we can do on this line
    if(behavior)
    {
	call 'FB' (m_Interface[interfaceRef], (BTN_LIST_LINE1 - 1 + lineNumber + FEEDBACK_OFFSET),
		    (BrowseNodeResource[nodeRef].selection = lineNumber + ListOffset[interfaceRef]))    
    }
    else
    {
	call 'FB' (m_Interface[interfaceRef], (BTN_LIST_LINE1 - 1 + lineNumber + FEEDBACK_OFFSET), 0)
    }
}

//Go through all of the list lines and update the selection feedback on each.
DEFINE_CALL 'LIST UPDATE SELECTION' (integer interfaceRef)
{
    stack_var integer lineNumber
    stack_var integer nodeRef
    
    call 'TRACE' (interfaceRef, 'Updating list selection highlight.')
    
    nodeRef = BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current
    
    if(BrowseNodeResource[nodeRef].selection > ListLength[interfaceRef]) 
    {
	BrowseNodeResource[nodeRef].selection = 0
    }
    
    for(lineNumber = 1; lineNumber <= ListWindowLength[interfaceRef]; lineNumber++)
    {
	if(lineNumber <= ListLength[interfaceRef])
	{
	    call 'FB' (m_interface[interfaceRef], (BTN_LIST_LINE1 - 1 + lineNumber + FEEDBACK_OFFSET),
		BrowseNodeResource[nodeRef].selection = (lineNumber + ListOffset[interfaceRef]) )
	}
	else
	{
	    call 'FB' (m_interface[interfaceRef], 
		BTN_LIST_LINE1 - 1 + lineNumber + FEEDBACK_OFFSET, FALSE)
	}
    }
}

//Return a reference pointer to a fresh new node.
DEFINE_FUNCTION integer allocateNode()
{
    stack_var integer interfaceRef
    stack_var integer browseType
    
    stack_var integer largestStackInterface
    stack_var integer largestStackType
    stack_var integer largestStackSize
    
    stack_var integer nodeRef
    
    stack_var integer node1
    stack_var integer node2
    stack_var integer node3
    
    if(AvailableResources > 0) //if there's memory available for more nodes
    {
	AvailableResources-- //decrement the number free
	nodeRef = NextFreeNode //get the next free node 
	NextFreeNode = BrowseNodeResource[nodeRef].previousNode //move the free node back one
	
	if(AvailableResources > 0) //if we haven't used up available memory
	{
	    BrowseNodeResource[NextFreeNode].nextNode = 0 //indicate that we're at the head
	}	
	
	call 'TRACE' (0, "'Allocating node ', itoa(nodeRef)")	    
    }
    else //There is insufficient memory to allocate a browse node.
    {    
	//first, discover the largest stack.
	largestStackSize = 0
	
	//step through all the stacks
	for(interfaceRef = 1; interfaceRef <= MAX_NUMBER_OF_PLAYERS; interfaceRef++)
	{
	    //for both lists per player
	    for(browseType = 1; browseType <= 2; browseType++) 
	    {
		//if this list has the longest count
		if(BrowseNodeStack[interfaceRef][browseType].size > largestStackSize) 
		{
		    //remember the count, and the list
		    largestStackSize = BrowseNodeStack[interfaceRef][browseType].size 
		    largestStackInterface = interfaceRef
		    largestStackType = browseType
		}
	    }
	    
	}
	
	//remove the bottom item in the stack and allocate it fresh.
	
	//Shrink the stack size by one.
	BrowseNodeStack[largestStackInterface][largestStackType].size--
	
	//Grab references to the first three nodes in the stack.
	node1 = BrowseNodeStack[largestStackInterface][largestStackType].bottom
	node2 = BrowseNodeResource[node1].nextNode
	node3 = BrowseNodeResource[node2].nextNode
	
	//Remove the second node from the list.
	BrowseNodeResource[node1].nextNode = node3
	BrowseNodeResource[node3].previousNode = node1
	
	//Take the second node as our new node.
	nodeRef = node2
	
	call 'TRACE' (0, "'Allocating node ', itoa(nodeRef),
		'.  Taken from list ', itoa(largestStackInterface), ',', itoa(largestStackType)")
    }
    
    //clean the pointers before returning
    BrowseNodeResource[nodeRef].nextNode = 0 
    BrowseNodeResource[nodeRef].previousNode = 0
    
    return(nodeRef) //return the new node
}

//Deallocate memory for the specified node.
DEFINE_CALL 'FREE NODE' (integer nodeRef) 
{
    if(!nodeRef) //if trying to free a null node
    {
	call 'TRACE' (0, "'Attempting to free a null node'")
	return
    }

    call 'TRACE' (0, "'Freeing node ', itoa(nodeRef)")

    //Increase the amount of available resources.
    AvailableResources = AvailableResources + 1
    
    if(AvailableResources != 1) //if this is not the first node.
    {
	//store the link to this new node.
	BrowseNodeResource[NextFreeNode].nextNode = nodeRef
    }
    
    BrowseNodeResource[nodeRef].previousNode = NextFreeNode //store the link to the old node.
    
    NextFreeNode = nodeRef //mark this new node as the new free node.
    BrowseNodeResource[nodeRef].nextNode = 0 //The next node is always blank.
}

//Initialize the indicated stack.
DEFINE_CALL 'RESET STACK' (integer interfaceRef, integer listShow)
{
    stack_var integer nodeRef
    stack_var integer nodeToFree
    
    //start with the current node.
    nodeRef = BrowseNodeStack[interfaceRef][listShow].current
    
    call 'TRACE' (interfaceRef, "'Making First Node.  Current is ', itoa(nodeRef) ")
    
    if(nodeRef = 0)
    {
	call 'TRACE' (interfaceRef, "'Error!  Current node pointer is null'")
	return
    }
    
    //Free the memory associated with the stack.
    while(BrowseNodeStack[interfaceRef][listShow].size > 1 && 
	    BrowseNodeResource[nodeRef].previousNode != 0)
    {
	//Quick-pop the stack.
	BrowseNodeStack[interfaceRef][listShow].size-- //decrement the stack size.
	nodeToFree = nodeRef //retain the reference to free in a moment.		
	nodeRef = BrowseNodeResource[nodeToFree].previousNode  //Move backwards in the stack.
	
	//Free the memory associated with the popped node.
	call 'FREE NODE' (nodeToFree)
    }
    
    //At this point, the stack size should be 1.
    if(BrowseNodeStack[interfaceRef][listShow].size != 1) 
    {
	if(BrowseNodeStack[interfaceRef][listShow].size > 1)
	{
	    call 'TRACE' (interfaceRef, "'ERROR!  Stack ', 
			    itoa(interfaceRef), '-', itoa(listShow), 
			    ' leaked ', itoa(BrowseNodeStack[interfaceRef][listShow].size - 1), 
			    ' nodes.'")
	}
	else
	{
	    call 'TRACE' (interfaceRef, 
			    "'ERROR!  stack had 0 nodes, expected 1'")
	}
	    
	//Force the stack size to be 1.
	BrowseNodeStack[interfaceRef][listShow].size = 1
    }
    
    //at this point, the previous node should be null. We should be at the stack head.
    if(BrowseNodeResource[nodeRef].previousNode != 0) 
    {
	call 'TRACE' (interfaceRef, "'ERROR!  Stack ', 
		itoa(interfaceRef), '-', itoa(listShow), 
		' references a previous node (', itoa(BrowseNodeResource[nodeRef].previousNode),
		'), but the stack size is 1.  Resetting previous node to 0.'")
	BrowseNodeResource[nodeRef].previousNode = 0
    }

    //set the top node
    BrowseNodeStack[interfaceRef][listShow].current = nodeRef
    
    //at this point, we should be at the bottom of the stack
    if(BrowseNodeStack[interfaceRef][listShow].bottom <> nodeRef)
    {
	call 'TRACE' (interfaceRef, 
		"'ERROR!  BrowseNodeStack.bottom doesn''t point to the bottom of the list.'")
    }

    //Clear the node data
    BrowseNodeResource[nodeRef].position = 0 
    clear_buffer BrowseNodeResource[nodeRef].searchText
    BrowseNodeResource[nodeRef].selection = 0
    BrowseNodeResource[nodeRef].moved = false
    
    //Break the links on the node.    	
    BrowseNodeResource[nodeRef].previousNode = 0
    BrowseNodeResource[nodeRef].nextNode = 0
    
    switch (listShow) //set the handle based on the list 
    {
	case LIST_SHOW_BROWSE: BrowseNodeResource[nodeRef].handle = ListBrowseStart
	case LIST_SHOW_NOWPLAYING: BrowseNodeResource[nodeRef].handle = ListNowPlayingStart
    }
}

//Create a new node and push it onto the indicated stack.
DEFINE_CALL 'PUSH NODE' (integer interfaceRef, integer listShow, char handle[])
{
    stack_var integer newTopNode
    stack_var integer oldTopNode
    
    call 'TRACE' (interfaceRef, "'Pushing Node'")
    
    //Create a new node.
    newTopNode = allocateNode()
    
    //Put the new node onto the stack.
    BrowseNodeStack[interfaceRef][listShow].size++ //increment the stack size
    oldTopNode = BrowseNodeStack[interfaceRef][listShow].current //get the previous top node
    BrowseNodeStack[interfaceRef][listShow].current = newTopNode //Drop the new new node in.
    
    if(oldTopNode != 0) //If the previous top node was a real node...
    {
	//Link the old top node to the new top node.
	BrowseNodeResource[oldTopNode].nextNode = newTopNode 
    }
    else //The previous top node was not real.
    {
	//Without a previous node, this is both the bottom and top of the stack now.
	BrowseNodeStack[interfaceRef][listShow].bottom = newTopNode
    }
        
    //Configure the new top node.
    BrowseNodeResource[newTopNode].previousNode = oldTopNode //Link the new node to the old node.
    BrowseNodeResource[newTopNode].handle = handle //store the new handle
    clear_buffer BrowseNodeResource[newTopNode].searchText //clear any search text
    BrowseNodeResource[newTopNode].position = 0
    BrowseNodeResource[newTopNode].moved = false
    BrowseNodeResource[newTopNode].selection = 0
}

//Remove the top node from the stack.  This does not return that node.
DEFINE_CALL 'POP NODE' (integer interfaceRef, integer listShow)
{
    stack_var integer oldTopNode
    stack_var integer newTopNode
    
    call 'TRACE' (interfaceRef, "'Popping Node'")
    
    //Grab the top two nodes on the stack.
    oldTopNode = BrowseNodeStack[interfaceRef][listShow].current    
    newTopNode = BrowseNodeResource[oldTopNode].previousNode
    
    //If the search is active, then clear the search and be done.
    if(length_array(BrowseNodeResource[oldTopNode].searchText))
    {
	clear_buffer BrowseNodeResource[oldTopNode].searchText
    }    
    else if(newTopNode = 0) //if the second node isn't a real node...s
    {
	//set the current top node as the bottom node.
	call 'RESET STACK' (interfaceRef, listShow)
    }
    else //We can perform the actual pop operation.
    {    
	BrowseNodeStack[interfaceRef][listShow].current = newTopNode 
	BrowseNodeResource[newTopNode].nextNode = 0 //zero out the next node, this is the new top node.
	BrowseNodeStack[interfaceRef][listShow].size-- //decrease the size of the stack.
    
	//Deallocate the old top node.
	call 'FREE NODE'(oldTopNode)
    }
}

//Request the browse list from the Kaleidescape system.
DEFINE_CALL 'GET LIST' (integer interfaceRef)
{
    stack_var char handle[MAX_HANDLE_LENGTH]
    
    //needs to be larger than MAX_SEARCH_TEXT_LENGTH to handle the FILTER= and escaped form
    stack_var char flag[255] 
    stack_var integer listShow
    stack_var integer nodeRef
    stack_var integer lastItem
    stack_var integer position
    
    /*
     * if the list window contains no lines, do nothing 
     * (hasn't yet been configured or using blind keypad)
     */
    if(ListWindowLength[interfaceRef] = 0) return 
    
    //if a list update is already in progress
    if([m_Interface[interfaceRef], CHN_LIST_ACTIVE])
    {
	call 'LIST RENDER SCROLLBAR'(interfaceRef) //update the scroll bar
	on[m_Interface[interfaceRef], CHN_LIST_PENDING] //set flag to run this later
	return //and do nothing else
    }
    do_push_timed(m_Interface[interfaceRef], CHN_LIST_ACTIVE, LIST_ACTIVE_TIMEOUT)
    on[m_Interface[interfaceRef], CHN_LIST_ACTIVE]
    
    call 'TRACE' (interfaceRef, "'Getting List'")
    
    if(CurrentList[interfaceRef] = 0)
    {
	//if the current list isn't set, set it to browse
	CurrentList[interfaceRef] = LIST_SHOW_BROWSE
    }
    
    //Get the current browse node.
    listShow = CurrentList[interfaceRef]
    nodeRef = BrowseNodeStack[interfaceRef][listShow].current
    
    if(nodeRef = 0) //if it isn't defined.
    {	
	//Push the Browse list starting point onto the stack.
	call 'PUSH NODE' (interfaceRef, listShow, ListBrowseStart)
	nodeRef = BrowseNodeStack[interfaceRef][listShow].current
    }
    
    //Get the current handle.
    handle = BrowseNodeResource[nodeRef].handle 
    if(BrowseNodeResource[nodeRef].position = 0)
    {
	BrowseNodeResource[nodeRef].position = 1
	BrowseNodeResource[nodeRef].moved = false
    }
    
    flag = BrowseNodeResource[nodeRef].searchText //get the current search text.
    
    //if it is non-null or the search is active
    if(length_array(flag) || (KeyboardStatus[interfaceRef] = KEYB_SEARCH))
    {
	/*
	 * prepend the search keyword and handle invalid chars
	 * when the search is active, but there is no text, this will send a blank 
	 * filter, which will remove non-data options from the result
	 */
	flag = "'FILTER=', escapeInvalidChars(flag)"		
    }
    else if(not BrowseNodeResource[nodeRef].moved)	//if the list hasn't been moved
    {
	flag = 'SUGGEST'				//turn on suggest
    }
    
    if(KeyboardStatus[interfaceRef] = KEYB_SEARCH) //if the search keyboard is active
    {
	position = 1 //only get the first line
	lastItem = 1
	
	if(m_VT[VT_SATP_KEYBOARD_TEXT]) //if defined
	{
	    if(isFuzzySearch(nodeRef)) //if it's fuzzy
	    {
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_SATP_KEYBOARD_TEXT], 
				'***'"
	    }
	    else
	    {
		//send the search text to the keyboard entry window
		send_string m_Interface[interfaceRef], "'!T', m_VT[VT_SATP_KEYBOARD_TEXT],
				BrowseNodeResource[nodeRef].searchText"	
	    }
	}
    }
    else
    {
	position = BrowseNodeResource[nodeRef].position //retrieve the starting position
	lastItem = position + ListWindowLength[interfaceRef] - 1 //determine the last item
    }

    call 'FB'(m_Interface[interfaceRef], BTN_LIST_BROWSE_SELECT + FEEDBACK_OFFSET, 
	    (listShow = LIST_SHOW_BROWSE) )
    call 'FB'(m_Interface[interfaceRef], BTN_LIST_NOW_PLAYING_SELECT + FEEDBACK_OFFSET, 
	    (listShow = LIST_SHOW_NOWPLAYING) )
    
    call 'LIST RENDER SCROLLBAR'(interfaceRef) //update the scroll bar
    
    call 'SEND_REQUEST'(interfaceRef, "'BROWSE:', handle, '::', itoa(position), '-', 
	    itoa(lastItem), ':', flag,':'")
}


DEFINE_CALL 'LIST LINE COMMAND'(integer interfaceRef, integer lineNumber)
{
    stack_var integer loop
    
    /* if the list window contains no lines, do nothing 
     * (hasn't yet been configured or using keypad)
     */
    if(ListWindowLength[interfaceRef] = 0) return 

    switch (List[interfaceRef][lineNumber].behavior)
    {
	case LIST_BEHAVIOR_BROWSE:
	{
	    call 'PUSH NODE'(interfaceRef, CurrentList[interfaceRef], 
		    List[interfaceRef][lineNumber].handle)
	    call 'GET LIST' (interfaceRef)
	    
	    return
	}
	case LIST_BEHAVIOR_ACTION:
	{
	    call 'SEND_REQUEST'(interfaceRef, "'PERFORM_ACTION:', 
		    List[interfaceRef][lineNumber].handle, ':::'")
	    
	    //if there's no pop defined, finish
	    if(NOT List[interfaceRef][lineNumber].pop) return
		
	    //pop the number of pops defined
	    for(loop = 1; loop <= List[interfaceRef][lineNumber].pop; loop++)
	    {
		call 'POP NODE' (interfaceRef, CurrentList[interfaceRef])
	    }
	    
	    call 'GET LIST' (interfaceRef) //re-request the list	    
	}
	case LIST_BEHAVIOR_DETAILS:
	{
	    //not yet supported
	}
    }
}

DEFINE_FUNCTION char centerNowPlayingList(integer interfaceRef)
{
    stack_var integer nodeRef
    stack_var integer newPosition
    
    //if the flag to not follow the NP is on, do nothing
    if( [m_Interface[interfaceRef],CHN_OVERRIDE_NP_FOLLOW] ) return 0
	
    nodeRef = BrowseNodeStack[interfaceRef][LIST_SHOW_NOWPLAYING].current
	
    if(!nodeRef) return 0 //if there is no current node, do nothing
    	
    BrowseNodeResource[nodeRef].moved = false //indicate we've not moved
    
    return 1 //indicate that we've changed the position    
}

DEFINE_CALL 'MOVE LIST' (integer interfaceRef, sinteger direction)
{
    stack_var integer nodeRef
    stack_var integer newPosition
    
    //retreive the current browse node
    nodeRef = BrowseNodeStack[interfaceRef][ CurrentList[interfaceRef] ].current
    if(!nodeRef) return //if there is no browse node, stop
    
    if(direction < 0) //if direction is negative
    {
	//if it's a bigger absolute move than the position
	if(abs_value(direction) >= BrowseNodeResource[nodeRef].position)
	{
	    newPosition = 1 //set to the beginning
	}
	else
	{
	    //subtract the direction (it's negative)
	    newPosition = BrowseNodeResource[nodeRef].Position - abs_value(direction)
	}
    }
    else //if direction is positive or 0
    {
	newPosition = BrowseNodeResource[nodeRef].Position + abs_value(direction)	//add the direction
    }
    
    newPosition = boundsCheckListPosition(interfaceRef, newPosition)
    
    if(CurrentList[interfaceRef] = LIST_SHOW_NOWPLAYING) //if we're showing now playing
    {
	//tell the interface not to follow the current playing item for a bit
	do_push_timed(m_Interface[interfaceRef], CHN_OVERRIDE_NP_FOLLOW, TIMEOUT_NOW_PLAYING_MOVE)
    }
    
    if(newPosition != BrowseNodeResource[nodeRef].position)
    {
	BrowseNodeResource[nodeRef].position = newPosition //set the new position
	BrowseNodeResource[nodeRef].moved = true		//note that the list was intentionally moved
	call 'TRACE'(interfaceRef, "'Moving list to ', itoa(newPosition)")
	call 'GET LIST' (interfaceRef) //refresh the list
    }    
}


//Change the currently selected item/highlighted item.
DEFINE_CALL 'SET HIGHLIGHT' (integer interfaceRef, integer newSelection)
{
    stack_var integer nodeRef
    
    call 'TRACE' (interfaceRef, "'Moving selection highlight to ', itoa(newSelection)")
    
    nodeRef = BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current
    if(nodeRef = 0) return //if there is no browse node, stop
    
    if(newSelection < BrowseNodeResource[nodeRef].selection)
    {
	//Bounds check the highlight.
	if(newSelection < 1)
	{
	    BrowseNodeResource[nodeRef].selection = 1;
	}
	else
	{
	    BrowseNodeResource[nodeRef].selection = newSelection;
	}

	//Now handle the situation where the list selection went off screen.
	if(BrowseNodeResource[nodeRef].selection <= ListOffset[interfaceRef]) 
	{
	    call 'MOVE LIST' (interfaceRef, type_cast(BrowseNodeResource[nodeRef].selection - 
		    ListOffset[interfaceRef] - 1))
	}
		
	//If we're not already in the process of grabbing a list, then update the selection.
	if(! [m_Interface[interfaceRef], CHN_LIST_ACTIVE]) 
	{
	    call 'LIST UPDATE SELECTION' (interfaceRef);
	}
    }
    else if(newSelection > BrowseNodeResource[nodeRef].selection)
    {
	//Bounds check the highlight
	if(newSelection > ListLength[interfaceRef]) 
	{
	    BrowseNodeResource[nodeRef].selection = ListLength[interfaceRef];
	}
	else
	{
	    BrowseNodeResource[nodeRef].selection = newSelection;
	}

	//Now handle the situation where the list selection went off screen.
	if(BrowseNodeResource[nodeRef].selection > ListOffset[interfaceRef] + 
		ListWindowLength[interfaceRef])
	{
	    call 'MOVE LIST' (interfaceRef, type_cast(BrowseNodeResource[nodeRef].selection - 
		(ListOffset[interfaceRef] + ListWindowLength[interfaceRef])));
	}
		
	//If we're not already in the process of grabbing a list, then update the selection.
	if(! [m_Interface[interfaceRef], CHN_LIST_ACTIVE])
	{
	    call 'LIST UPDATE SELECTION' (interfaceRef);
	}
    }
    else
    {
	//do nothing
    }
}

DEFINE_CALL 'LIST COMMAND HANDLER' (integer interfaceRef, integer channel, integer state)
{
    stack_var integer nodeRef
    
    nodeRef = BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current

    if(!state)
    {
	if (channel = BTN_LIST_UP || channel = BTN_LIST_DOWN)
	{
	    do_release(m_Interface[interfaceRef], channel)	    
	}
	return
    }
    
    //if the chan is one of the selected lines
    if(channel >= BTN_LIST_LINE1 && channel < BTN_LIST_LINE1 + MAX_LIST_WINDOW_LENGTH)
    {
	stack_var integer line
	line = channel - BTN_LIST_LINE1 + 1
	
	if(List[interfaceRef][line].behavior) //if there's a behavior for this line	
	{
	    //remember the line
	    BrowseNodeResource[nodeRef].selection = line + ListOffset[interfaceRef] 
	    
	    //turn on the feedback
	    call 'LIST UPDATE SELECTION' (interfaceRef)
	}
	    
	call 'LIST LINE COMMAND' (interfaceRef, line)
    }
    //if the chan is one of the keypad keys
    else  if(channel >= BTN_KEYPAD_KEY && channel <= BTN_KEYPAD_KEY + 9) 
    {
	//send to the keyboard handler
	call 'KEYBOARD BUTTON' (interfaceRef, "channel - BTN_KEYPAD_KEY + '0'")
    }
    else  switch (channel) //if not a selected line, check which command
    {
	case BTN_LIST_BROWSE_SELECT :
	{
	    /*
	     * if the list window contains no lines, do nothing 
	     * (hasn't yet been configured or using keypad)
	     */
	    if(ListWindowLength[interfaceRef] > 0)
	    {
		
		//if we're already looking at this list
		if(CurrentList[interfaceRef] = LIST_SHOW_BROWSE) 
		{
		    //set to home
		    call 'RESET STACK' (interfaceRef, LIST_SHOW_BROWSE)
		    KeyboardStatus[interfaceRef] = KEYB_OFF //clear the keyboard if it's up
		}
		CurrentList[interfaceRef] = LIST_SHOW_BROWSE
		
		//pop or clear the page
		[m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_SATP_KEYBOARD_SEARCH] = 
		    (KeyboardStatus[interfaceRef] = KEYB_SEARCH)
		call 'GET LIST' (interfaceRef) //get the list
	    }
	}
	
	case BTN_LIST_NOW_PLAYING_SELECT :
	{
	    /*
	     * if the list window contains no lines, do nothing \
	     * (hasn't yet been configured or using keypad)
	     */
	    if(ListWindowLength[interfaceRef] > 0)
	    {
		//if we're already looking at this list
		if(CurrentList[interfaceRef] = LIST_SHOW_NOWPLAYING)
		{
		    //set to home
		    call 'RESET STACK' (interfaceRef, LIST_SHOW_NOWPLAYING)
		}
		CurrentList[interfaceRef] = LIST_SHOW_NOWPLAYING
		KeyboardStatus[interfaceRef] = KEYB_OFF
		
		//update the new nodeRef
		nodeRef = BrowseNodeStack[interfaceRef][CurrentList[interfaceRef]].current	
		//indicate we've not moved the list
		BrowseNodeResource[nodeRef].moved = false
		
		//hide the search page if it's showing
		off[m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_SATP_KEYBOARD_SEARCH]
		call 'GET LIST' (interfaceRef) //get the list
	    }
	}
	
	case BTN_LIST_HOME :
	{
	    /* 
	     * if the list window contains no lines, do nothing 
	     * (hasn't yet been configured or using keypad)
	     */
	    if(ListWindowLength[interfaceRef] > 0)
	    {
		call 'RESET STACK' (interfaceRef, CurrentList[interfaceRef])
		
		//hide the search page if it's showing
		off[m_Interface[interfaceRef],CHN_POPUP_OFFSET + POP_SATP_KEYBOARD_SEARCH]	
		call 'GET LIST' (interfaceRef)
	    }
	}
	
	case BTN_LIST_BACK :
	{
	    /*
	     * if the list window contains no lines, do nothing 
	     * (hasn't yet been configured or using blind keypad)
	     */
	    if(ListWindowLength[interfaceRef] > 0)
	    {
		call 'POP NODE' (interfaceRef, CurrentList[interfaceRef])
	    
		//hide the search page if it's showing
		off[m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_SATP_KEYBOARD_SEARCH] 
		call 'GET LIST' (interfaceRef)
	    }
	}
	
	case BTN_LIST_UP :
	{
	    /*
	     * if the list window contains no lines, do nothing 
	     * (hasn't yet been configured or using keypad)
	     */
	    if(ListWindowLength[interfaceRef] > 0)
	    {
		do_push_timed(m_Interface[interfaceRef], channel, do_push_timed_infinite)
	    }
	}
	
	case BTN_LIST_DOWN :
	{
	    /*
	     * if the list window contains no lines, do nothing 
	     *(hasn't yet been configured or using keypad)
	     */
	    if(ListWindowLength[interfaceRef] > 0)
	    {
		do_push_timed(m_Interface[interfaceRef], channel, do_push_timed_infinite)
	    }
	}
		
	case BTN_LIST_KEYB_SPACE :
	{
	    call 'KEYBOARD BUTTON' (interfaceRef, "' '")
	}
	
	case BTN_LIST_KEYB_BACKSP :
	{
	    call 'KEYBOARD BUTTON' (interfaceRef, "BACKSPACE")
	}
	
	case BTN_LIST_KEYB_CLEAR :
	{
	    call 'KEYBOARD BUTTON' (interfaceRef, "CLEAR")
	}
	
	case BTN_LIST_KEYB_CANCEL :
	{
	    if(KeyboardStatus[interfaceRef] = KEYB_SEARCH) //if the search is active
	    {
		//hide the search page
		off[m_Interface[interfaceRef],CHN_POPUP_OFFSET+POP_SATP_KEYBOARD_SEARCH]
	    }
		    
	    KeyboardStatus[interfaceRef] = KEYB_OFF
	    clear_buffer BrowseNodeResource[nodeRef].searchText	 //clear the search
	    
	    call 'GET LIST'(interfaceRef)
	}
	
	case BTN_LIST_SEARCH :
	{
	    /*
	     * if the list window contains no lines, do nothing 
	     * (hasn't yet been configured or using keypad)
	     */
	    if(ListWindowLength[interfaceRef] = 0) return; 
	    
	    if(KeyboardStatus[interfaceRef] <> KEYB_SEARCH) //if the search isn't active
	    {
		KeyboardStatus[interfaceRef] = KEYB_SEARCH
		call 'FB'(m_Interface[interfaceRef], BTN_LIST_SEARCH + FEEDBACK_OFFSET, 1)	//turn on the feedback
	    }
	    else
	    {
		KeyboardStatus[interfaceRef] = KEYB_OFF
	    }
	    
	    //pop or clear the page
	    [m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_SATP_KEYBOARD_SEARCH] = 
		(KeyboardStatus[interfaceRef] = KEYB_SEARCH)	
	    
	    call 'GET LIST'(interfaceRef)
	}
	
	case BTN_LIST_SEARCH_RESULT :
	case BTN_LIST_KEYB_ENTER :
	{
	    /*
	     * if the list window contains no lines, do nothing 
	     * (hasn't yet been configured or using keypad)
	     */
	    if(ListWindowLength[interfaceRef] = 0) return;
	    
	    if(KeyboardStatus[interfaceRef] = KEYB_SEARCH) //if the search is active
	    {
		//hide the search page
		off[m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_SATP_KEYBOARD_SEARCH]
	    }
		    
	    KeyboardStatus[interfaceRef] = KEYB_OFF
	    
	    //if there's only a single item in the search result
	    if(ListLength[interfaceRef] = 1) 
	    {
		clear_buffer BrowseNodeResource[nodeRef].searchText //clear the search
		call 'LIST LINE COMMAND'(interfaceRef, 1) //perform the action on the single item
	    }
	    
	    call 'GET LIST'(interfaceRef)
	}
    }
}

//handle SATP keyboard/keypad input
DEFINE_CALL 'KEYBOARD BUTTON' (integer interfaceRef, char character[])
{
    switch(KeyboardStatus[interfaceRef]) //determine the keyboard's current state
    {
	case KEYB_OFF: //if it's off, do nothing
	{
	}
	case KEYB_SEARCH://we're searching the current list
	{
	    stack_var integer listShow
	    stack_var integer nodeRef
	    stack_var integer loop
	    listShow = CurrentList[interfaceRef] //determine the currently shown list
	    
	    //Grab the current browse node.
	    nodeRef = BrowseNodeStack[interfaceRef][listShow].current
	    
	    switch(character[1])
	    {
		case BACKSPACE: //backspace
		{
		    /*
		     * if it's the closing bracket in a fuzzy search, pull out the 
		     * entire set within the brackets [abc]
		     */
		    if(right_string(BrowseNodeResource[nodeRef].searchText, 1) = ']')	
		    {
			loop = length_string(BrowseNodeResource[nodeRef].searchText)
			
			//step through the string until we find the open bracket
			while((BrowseNodeResource[nodeRef].searchText[loop]) <> '[' && loop > 1)
			{
			    loop = loop - 1
			}
			//trim down the string by this much
			BrowseNodeResource[nodeRef].searchText = 
			    left_string(BrowseNodeResource[nodeRef].searchText, loop - 1)
		    }
		    else
		    {
			BrowseNodeResource[nodeRef].searchText = left_string(BrowseNodeResource[nodeRef].searchText,
			    length_array(BrowseNodeResource[nodeRef].searchText) - 1)
		    }
		}    
		case CLEAR: //clear the string
		{
		    clear_buffer BrowseNodeResource[nodeRef].searchText
		}
		case '[': //multi-letter entry (for keypad alphabet - ABC2, DEF3, etc)
		{
		    BrowseNodeResource[nodeRef].searchText = "BrowseNodeResource[nodeRef].searchText, character"
		    
		    //if it didn't start fuzzy and there's already text there
		    if((length_string(BrowseNodeResource[nodeRef].searchText)>0) && 
			    !isFuzzySearch(nodeRef))
		    {
			//make it fuzzy by surrounding the first char in brackets
			BrowseNodeResource[nodeRef].searchText = "'[', BrowseNodeResource[nodeRef].searchText[1], ']',
			    right_string(BrowseNodeResource[nodeRef].searchText, 
			    length_string(BrowseNodeResource[nodeRef].searchText) - 1)"
		    }
		}
		    
		default:
		{
		    //append the keyboard character
		    BrowseNodeResource[nodeRef].searchText = toTitleCaps("BrowseNodeResource[nodeRef].searchText, character")
		}
	    }
	    call 'GET LIST' (interfaceRef) //get the list
	}
    }
}

/******************************************************************************************
 **                  End of SATP-Only Routines                                           **
 ******************************************************************************************/
#END_IF

/******************************************************************************************
 **                   Keypad Routines                                                    **
 ******************************************************************************************/

DEFINE_CALL 'FEEDBACK PRESET' (integer interfaceRef, char presetHandle[])
{    
    stack_var integer presetNumber
	
    for( presetNumber = 1; presetNumber <= MAX_PRESETS; presetNumber++ )
    {
	//Check to see if the handle matches.
	if(PresetHandleTable[interfaceRef][presetNumber] = presetHandle && presetHandle != '')
	{
	    call 'TRACE' (interfaceRef, "'Setting feedback high for preset ', itoa(presetNumber)")
	    //Turn the preset feedback on.
	    ON[m_Interface[interfaceRef], BTN_PRESET1 - 1 + presetNumber + FEEDBACK_OFFSET]
	    PresetFeedback[interfaceRef][presetNumber] = true;
	}
	else //The preset isn't active.		
	{
	    //Turn the preset feedback off.
	    OFF[m_Interface[interfaceRef], BTN_PRESET1 - 1 + presetNumber + FEEDBACK_OFFSET]
	    PresetFeedback[interfaceRef][presetNumber] = false;
	}
    }
}

DEFINE_CALL 'ACTIVATE PRESET' (integer interfaceRef, integer presetNumber)
{
    call 'TRACE' (interfaceRef, "'Activating preset ', itoa(presetNumber)")
    call 'SEND_REQUEST'(interfaceRef, "'PLAY_MUSIC_PRESET:', 
	    getPresetTag(interfaceRef, presetNumber),':'")
    
    //Record the number of the last preset selected.
    LastSelectedPreset[interfaceRef] = presetNumber
}

// Function to return the tag for a preset given the ref and preset number
DEFINE_FUNCTION char[100] getPresetTag(integer interfaceRef, integer presetNumber)
{
    stack_var char tag[100]
    
    if(length_array(PresetID[interfaceRef]) = 0)
    {
	tag = "'AMX Preset', itoa(presetNumber)"
    }
    else
    {
	tag = "escapeInvalidChars(PresetID[interfaceRef]), itoa(presetNumber)"
    }
	
    return tag
}

/******************************************************************************************
 **                   End of Keypad Routines                                             **
 ******************************************************************************************/

/******************************************************************************************
 *                Startup code                                                            *
 ******************************************************************************************/
DEFINE_START

TouchPanelNewLine = "CR, LF" //define the characters to create a newline on a touch panel

IPPortStatus = IP_PORT_CLOSED

usingCPDAddressing = 0
usingSNAddressing = 0

//initialize the device ID and stream ID arrays
{
    stack_var loop
    
    #IF_DEFINED SATP
	//initialize the browse node resources
	for(loop = 1; loop <= MAX_BROWSE_NODES; loop++)
	{
	    BrowseNodeResource[loop].handle = ''
	    BrowseNodeResource[loop].position = 0
	    BrowseNodeResource[loop].selection = 0
	    
	    //Link all of the nodes together.
	    BrowseNodeResource[loop].nextNode = loop + 1
	    BrowseNodeResource[loop].previousNode = loop - 1
	}
	BrowseNodeResource[MAX_BROWSE_NODES].nextNode = 0
	
	AvailableResources = MAX_BROWSE_NODES //We start with all resources available.
	NextFreeNode = MAX_BROWSE_NODES //Grab a link to the top free node.
    #END_IF
        
    for(loop = 1; loop <= MAX_NUMBER_OF_PLAYERS; loop++)
    {
	KaleidescapeID[loop].deviceId = '01'
	KaleidescapeID[loop].zoneId = 0
	KaleidescapeID[loop].sequence = 0
	
	#IF_DEFINED SATP
	    //initialize the browse node stacks.
	    ListWindowLength[loop] = MAX_LIST_WINDOW_LENGTH
	    
	    CurrentList[loop] = LIST_SHOW_BROWSE
	    
	    BrowseNodeStack[loop][LIST_SHOW_BROWSE].current = 0
	    BrowseNodeStack[loop][LIST_SHOW_BROWSE].bottom = 0
	    BrowseNodeStack[loop][LIST_SHOW_BROWSE].size = 0
	    
	    BrowseNodeStack[loop][LIST_SHOW_NOWPLAYING].current = 0
	    BrowseNodeStack[loop][LIST_SHOW_NOWPLAYING].bottom = 0
	    BrowseNodeStack[loop][LIST_SHOW_NOWPLAYING].size = 0	
	#END_IF
    }
    
    for(loop = 1; loop <= length_array(m_Interface); loop++)
    {
    	set_virtual_channel_count(m_Interface[loop], 255 + FEEDBACK_OFFSET)
    }
}

//set up all simple commands to the Kaleidescape player

/*
 * The first byte indicates how to handle the command:
 * PRESS_DIRECT simply sends the indicated command.
 * PRESS_REPEAT sends a command on the push and release with _PRESS and _RELEASE appended
 * PRESS_PULSED simply sends the command, and pulses the feedback high for 1/2 second
 * PRESS_COORDS is a special handler for the video touch interface
 * PRESS_PLAYPS is a special handler for the play-pause button
 */

Commands[BTN_PLAY	] = "PRESS_DIRECT, 'PLAY'" 
Commands[BTN_STOP	] = "PRESS_DIRECT, 'STOP'"
Commands[BTN_PAUSE	] = "PRESS_DIRECT, 'PAUSE'"
Commands[BTN_SKIP_FORWARD	] = "PRESS_DIRECT, 'NEXT'"
Commands[BTN_SKIP_REVERSE	] = "PRESS_DIRECT, 'PREVIOUS'"
Commands[BTN_SCAN_FORWARD	] = "PRESS_DIRECT, 'SCAN_FORWARD'"
Commands[BTN_SCAN_REVERSE	] = "PRESS_DIRECT, 'SCAN_REVERSE'"

Commands[BTN_KEYPAD_KEY + 0 ] = "PRESS_PULSED, 'DIGIT:0'"
Commands[BTN_KEYPAD_KEY + 1 ] = "PRESS_PULSED, 'DIGIT:1'"
Commands[BTN_KEYPAD_KEY + 2 ] = "PRESS_PULSED, 'DIGIT:2'"
Commands[BTN_KEYPAD_KEY + 3 ] = "PRESS_PULSED, 'DIGIT:3'"
Commands[BTN_KEYPAD_KEY + 4 ] = "PRESS_PULSED, 'DIGIT:4'"
Commands[BTN_KEYPAD_KEY + 5 ] = "PRESS_PULSED, 'DIGIT:5'"
Commands[BTN_KEYPAD_KEY + 6 ] = "PRESS_PULSED, 'DIGIT:6'"
Commands[BTN_KEYPAD_KEY + 7 ] = "PRESS_PULSED, 'DIGIT:7'"
Commands[BTN_KEYPAD_KEY + 8 ] = "PRESS_PULSED, 'DIGIT:8'"
Commands[BTN_KEYPAD_KEY + 9 ] = "PRESS_PULSED, 'DIGIT:9'"

Commands[BTN_KEYPAD_ENTER   ] = "PRESS_PULSED, 'SELECT'" 

Commands[BTN_PAGE_UP	    ] = "PRESS_REPEAT, 'PAGE_UP'" 
Commands[BTN_PAGE_DOWN	    ] = "PRESS_REPEAT, 'PAGE_DOWN'" 

Commands[BTN_POWER_ON	    ] = "PRESS_DIRECT, 'LEAVE_STANDBY'"
Commands[BTN_POWER_OFF	    ] = "PRESS_DIRECT, 'ENTER_STANDBY'"

Commands[BTN_INTERMISSION   ] = "PRESS_DIRECT, 'INTERMISSION_TOGGLE'" 
Commands[BTN_INSTANT_REPLAY ] = "PRESS_PULSED, 'REPLAY'" 
Commands[BTN_START_CHAPTER_ENTRY] = "PRESS_DIRECT, 'START_CHAPTER_ENTRY'"
Commands[BTN_SET_FAVORITE_START ] = "PRESS_PULSED, 'SET_FAVORITE_SCENE_START'"
Commands[BTN_SET_FAVORITE_END	] = "PRESS_PULSED, 'SET_FAVORITE_SCENE_END'"

Commands[BTN_RANDOM_TOGGLE  ] = "PRESS_DIRECT, 'MUSIC_RANDOM_TOGGLE'"
Commands[BTN_REPEAT_TOGGLE  ] = "PRESS_DIRECT, 'MUSIC_REPEAT_TOGGLE'"

Commands[BTN_DVD_MENU	    ] = "PRESS_PULSED, 'DVD_MENU'"
Commands[BTN_UP		] = "PRESS_REPEAT, 'UP'"
Commands[BTN_DOWN	] = "PRESS_REPEAT, 'DOWN'"
Commands[BTN_LEFT	] = "PRESS_REPEAT, 'LEFT'"
Commands[BTN_RIGHT	] = "PRESS_REPEAT, 'RIGHT'"
Commands[BTN_OK		] = "PRESS_PULSED, 'SELECT'"

Commands[BTN_CANCEL	] = "PRESS_PULSED, 'CANCEL'"
Commands[BTN_TOP_MENU		] = "PRESS_PULSED, 'DVD_TOP_MENU'"
Commands[BTN_CHAPTER_ENTRY	] = "PRESS_DIRECT, 'START_CHAPTER_ENTRY'"
Commands[BTN_CLEAR	] = "PRESS_PULSED, 'CLEAR'"
Commands[BTN_RESUME	] = "PRESS_PULSED, 'DVD_RESUME'"

Commands[BTN_SUBTITLE	] = "PRESS_PULSED, 'SUBTITLES_NEXT'"

Commands[BTN_STATUS_AND_SETTINGS] = "PRESS_DIRECT, 'STATUS_AND_SETTINGS'"
Commands[BTN_DETAILS	] = "PRESS_DIRECT, 'DETAILS'"

Commands[BTN_AUDIO	] = "PRESS_PULSED, 'AUDIO_NEXT'"

Commands[BTN_SHUFFLE_COVERS	] = "PRESS_PULSED, 'SHUFFLE_COVER_ART'"
Commands[BTN_SAFE_LEVEL	] = "PRESS_PULSED, 'SAFE_LEVEL'"
Commands[BTN_ALPHABETIZE_COVERS ] = "PRESS_PULSED, 'ALPHABETIZE_COVER_ART'"

Commands[BTN_FILTER_LIST	] = "PRESS_DIRECT, 'FILTER_LIST'"
Commands[BTN_SPACE		] = "PRESS_DIRECT, 'KEYBOARD_CHARACTER: '"
Commands[BTN_BACKSPACE		] = "PRESS_DIRECT, 'BACKSPACE'"

Commands[BTN_KALEIDESCAPE_MENU	] = "PRESS_DIRECT, 'KALEIDESCAPE_MENU_TOGGLE'"
Commands[BTN_COVER_ART 		] = "PRESS_DIRECT, 'GO_COVER_ART'"
Commands[BTN_MOVIE_LIST 	] = "PRESS_DIRECT, 'GO_MOVIE_LIST'"
Commands[BTN_COLLECTIONS 	] = "PRESS_DIRECT, 'GO_COLLECTIONS'"
Commands[BTN_PARENTAL_CONTROL	] = "PRESS_DIRECT, 'GO_PARENTAL_CONTROL'"
Commands[BTN_SYSTEM_STATUS	] = "PRESS_DIRECT, 'GO_SYSTEM_STATUS'"
Commands[BTN_DEMO		] = "PRESS_DIRECT, 'GO_DEMO'"
Commands[BTN_DEMO_LOOP		] = "PRESS_DIRECT, 'GO_DEMO_LOOP'"
Commands[BTN_SCREEN_SAVER	] = "PRESS_DIRECT, 'GO_SCREEN_SAVER'"
Commands[BTN_SCREEN_SAVER_STOP	] = "PRESS_DIRECT, 'STOP_SCREEN_SAVER'"
Commands[BTN_DVD_OR_K_MENU	] = "PRESS_DIRECT, 'DVD_OR_KALEIDESCAPE_MENU'"

Commands[BTN_MUSIC_LIST		] = "PRESS_DIRECT, 'GO_MUSIC_LIST'"
Commands[BTN_MUSIC_COVERS	] = "PRESS_DIRECT, 'GO_MUSIC_COVERS'"
Commands[BTN_MUSIC_COLLECTIONS	] = "PRESS_DIRECT, 'GO_MUSIC_COLLECTIONS'"
Commands[BTN_MUSIC_NOW_PLAYING	] = "PRESS_DIRECT, 'GO_NOW_PLAYING'"

Commands[BTN_MOVIE_OSD_PLACE	] = "PRESS_DIRECT, 'GO_MOVIES'"
Commands[BTN_MUSIC_OSD_PLACE	] = "PRESS_DIRECT, 'GO_MUSIC'"

Commands[BTN_RED		] = "PRESS_REPEAT, 'RED'"
Commands[BTN_BLUE		] = "PRESS_REPEAT, 'BLUE'"
Commands[BTN_GREEN		] = "PRESS_REPEAT, 'GREEN'"
Commands[BTN_YELLOW		] = "PRESS_REPEAT, 'YELLOW'"
        
Commands[BTN_COORDINATES	] = "PRESS_COORDS"
Commands[BTN_PLAY_OR_PAUSE	] = "PRESS_PLAYPS"
Commands[BTN_SPECIAL_BLURAY_STOP] = "PRESS_DIRECT, 'BLURAY_SPECIAL_STOP'"


{
    //initialize the Coordinate array
    stack_var integer interfaceRef
    
    //step through each element of this array
    for(interfaceRef = 1; interfaceRef <= MAX_NUMBER_OF_PLAYERS; interfaceRef++)	
    {
	Coordinate[interfaceRef][1] = 0
	Coordinate[interfaceRef][2] = 0
	Coordinate[interfaceRef][3] = 0 //clear all the values
    }
    
    //set up the levels on all virtual devices
    for(interfaceRef = 1; interfaceRef <= length_array(m_Interface); interfaceRef++)
    {
	set_virtual_level_count(m_Interface[interfaceRef],100)
    }
}

{
    //initialize the presets stuff.
    stack_var integer interfaceRef
    stack_var integer presetNumber
    
    for(interfaceRef = 1; interfaceRef <= MAX_NUMBER_OF_PLAYERS; interfaceRef++)
    {   
	NumberOfPresets[interfaceRef] = MAX_PRESETS
	LastSelectedPreset[interfaceRef] = 1
	for(presetNumber = 1; presetNumber <= MAX_PRESETS; presetNumber++)
	{
	    PresetFeedback[interfaceRef][presetNumber] = false
	    PresetHeld[interfaceRef][presetNumber] = false
	    PresetHandleTable[interfaceRef][presetNumber] = ''
	}	
    }
}

/*
 * Indicate if this port is to be used for an IP connection
 * IP devices are attached to the device 0, real devices will have a 
 * different dev number
 */
if(m_Kport.number = 0)
{
    IPConnection = true
}

if(!IPConnection)	//if this is a 232 connection
{
    setPortOpened(true)		//indicate that the port is opened
}

/*******************************************************************************************
 * Event Handlers
 *******************************************************************************************/
DEFINE_EVENT

DATA_EVENT [m_KPort]
{
    ONLINE:
    {
	//stack_var integer interfaceRef
	
	call 'TRACE'(0, "'Port online'")
	
	if(!IPConnection) //test whether this is an IP device or AMX device.
	{
	    //if the baud rate command hasn't yet been defined
	    if(length_string(BaudRateCommand) = 0)
	    {
		//set it to the K Player default
		BaudRateCommand = 'SET BAUD 19200,N,8,1,485 DISABLED'	
	    }
		
	    SEND_COMMAND m_KPort, BaudRateCommand
	}
	else
	{
	    //indicate that the port is open
	    managePort(IP_PORT_OPEN, 0)
	}
	
	binaryDelimiters = false			//a fresh port will not use binary delimiters
	setPortOpened(true)			//indicate that the port is opened
    }
    
    ONERROR:
    {
	call 'TRACE'(0, "'Port error ', itoa(data.number)")
	managePort(IP_PORT_ERROR, data.number)
    }
    
    OFFLINE:
    {
	call 'TRACE'(0, 'Port offline')
	if(IPConnection) //test whether this is an IP device
	{
	    wait 5
	    {
		managePort(IP_PORT_CLOSED, 0) //indicate that the port closed
	    }
	}
	
	//setPortInitialized(false)
	setPortOpened(false)
    }
    
    STRING:
    {
	cancel_wait 'Send Timeout' 		//clear pending connection reset due to non-response
	call 'RECEIVE BUFFER' (DATA.TEXT)	//pass new data to the receive buffer
    }
}

// The following three events handle the connection status
//  DCPortOpened -> DCPortInitialized -> DCPortPassingCommands
//
//  DCPortOpened when the IP connection succeeds or always on for a 232 connection
//  DCPortInitialized when we get back valid K responses
//  DCPortPassingCommands when the device is controlling everything OK,
//  may be off when connected to a Movie Player in standby

//for debugging:
CHANNEL_EVENT[m_KPort,0]
{
    ON:
    {
	call 'TRACE'(0, "'KPort channel change - ON  [', itoa(channel.channel),']'")
    }
    OFF:
    {
	call 'TRACE'(0, "'KPort channel change - OFF [', itoa(channel.channel),']'")
    }
}

//This channel is set high when the device is online
CHANNEL_EVENT[m_Interface, CHN_DEVICE_ONLINE]
{
    ON:
    {
	stack_var integer interfaceRef //used to reference which player is being addressed
	
	interfaceRef = get_last(m_Interface)
	
	call 'TRACE'(interfaceRef, 'Device online')
	
	call 'INITIALIZE DEVICE' (interfaceRef) //start the initialization
    }
    
    OFF:
    {
	stack_var integer interfaceRef //used to reference which player is being addressed
	
	interfaceRef = get_last(m_Interface)
	
	call 'TRACE'(interfaceRef, 'Device offline')
	
	//when the device is offline, we don't know if the config is valid
	OFF[m_Interface[interfaceRef], CHN_CONFIGURATION_VALID]
	
	//unsure of the power state, make both low
	OFF[m_Interface[interfaceRef], BTN_POWER_OFF_FB]
	OFF[m_Interface[interfaceRef], BTN_POWER_ON_FB]
    }
}


CHANNEL_EVENT[m_Interface, CHN_CONFIGURATION_VALID]
{
    ON:
    {
	stack_var integer interfaceRef //used to reference which player is being addressed
	interfaceRef = get_last(m_Interface)
	
	call 'TRACE'(interfaceRef, 'Device config valid.')
	
	call 'SEND_REQUEST' (interfaceRef, 'GET_DEVICE_POWER_STATE:')
    }
}

CHANNEL_EVENT[m_Interface, BTN_POWER_ON_FB]	//also perform this action when leaving standby
{
    ON:
    {
	stack_var integer interfaceRef //used to reference which player is being addressed
	interfaceRef = get_last(m_Interface)
	call 'TRACE'(interfaceRef, 'Device powered on')
	
	OFF[m_Interface[interfaceRef], BTN_POWER_OFF_FB]	//set the enter standby feedback to match
	pulse[m_Interface[interfaceRef], CHN_REFRESH]		//refresh the data
    }
    
    OFF:
    {
	stack_var integer interfaceRef //used to reference which player is being addressed
	interfaceRef = get_last(m_Interface)	
	CALL 'CLEAR FEEDBACK'(interfaceRef)
    }
}

CHANNEL_EVENT[m_Interface, BTN_POWER_OFF_FB]	//also perform this action when leaving standby
{
    ON:
    {
	stack_var integer interfaceRef //used to reference which player is being addressed
	interfaceRef = get_last(m_Interface)
	
	call 'TRACE'(interfaceRef, 'Device powered off')
	
	OFF[m_Interface[interfaceRef], BTN_POWER_ON_FB]	//set the leave standby feedback to match
    }
}

//This channel is pulsed to refresh the interface.
CHANNEL_EVENT[m_Interface, CHN_REFRESH]
{
    ON:
    {
	stack_var integer interfaceRef //used to reference which player is being addressed
	stack_var integer presetNumber
	interfaceRef = get_last(m_Interface)
	
	//if the device is off or offline or has invalid configuration
	if(not [m_Interface[interfaceRef],BTN_POWER_ON_FB] or
	   not [m_Interface[interfaceRef],CHN_DEVICE_ONLINE] or
	   not [m_Interface[interfaceRef],CHN_CONFIGURATION_VALID])
	{
	    CALL 'TRACE'(interfaceRef, 'Device not ready, clearing feedback')
	    CALL 'CLEAR FEEDBACK'(interfaceRef)
	}
	else	//if the device is on and configuration is valid
	{
	    //ensure events are enabled for this device
	    call 'ENABLE EVENTS'(interfaceRef)

	    //if a content handle is provided and the details page is defined
	    if( (length_string(HighlightedSelectionHandle[interfaceRef]) > 0) &&
		(length_string(m_UIPopups[POP_DETAILS_PAGE]) > 0) )
	    {
		//ask for the details for this handle
		call 'SEND_REQUEST' (interfaceRef, "'GET_CONTENT_DETAILS:', 
			HighlightedSelectionHandle[interfaceRef], '::'")
	    }
	    
	    //call 'REQUEST SYSTEM STATE' (interfaceRef)
	    
	    call 'SEND_REQUEST' (interfaceRef, 'GET_FRIENDLY_NAME:')	
	    
	    //if this isn't an SATP dev, request the OSD state information
	    if(!KaleidescapeID[interfaceRef].zoneId)
	    {
		call 'SEND_REQUEST' (interfaceRef, 'GET_MOVIE_LOCATION:')
		call 'SEND_REQUEST' (interfaceRef, 'GET_PLAY_STATUS:')
		call 'SEND_REQUEST' (interfaceRef, 'GET_PLAYING_TITLE_NAME:')
		call 'SEND_REQUEST' (interfaceRef, 'GET_UI_STATE:')
		call 'SEND_REQUEST' (interfaceRef, 'GET_MOVIE_MEDIA_TYPE:')
		call 'SEND_REQUEST' (interfaceRef, 'GET_VIDEO_MODE:')
		call 'SEND_REQUEST' (interfaceRef, 'GET_HIGHLIGHTED_SELECTION:')
		call 'SEND_REQUEST' (interfaceRef, 'GET_USER_INPUT:')
	    }
	    
	    call 'SEND_REQUEST' (interfaceRef, 'GET_MUSIC_PLAY_STATUS:')
	    call 'SEND_REQUEST' (interfaceRef, 'GET_MUSIC_TITLE:')    
	    
	    //Request preset information.
	    
	    if(PresetID[interfaceRef] != '')
	    {
		for(presetNumber = 1; presetNumber <= MAX_PRESETS; presetNumber++)
		{
		    if(m_VT[VT_PRESET_LABEL_1 + presetNumber - 1] <> 0) 
		    {
			//send the preset label text to the VT
			send_string m_Interface[interfaceRef], "'!T', 
			    m_VT[VT_PRESET_LABEL_1 + presetNumber - 1], ''"
		    }
		    call 'SEND_REQUEST' (interfaceRef, "'GET_MUSIC_PRESET_INFORMATION:', PresetID[interfaceRef], itoa(presetNumber), ':'")
		}
	    }
	    
	    call 'SEND_REQUEST' (interfaceRef, "'GET_PLAYING_MUSIC_INFORMATION:'")
	    
	    //if any of the fast update fb is desired,
	    if(  ( m_VT[VT_TRACK_CURRENT_TIME] <> 0 )
	      || ( m_VT[VT_TRACK_REMAIN_TIME] <> 0 )  )
	    {
		// enable feedback once a second during playback
		call 'SEND_REQUEST' (interfaceRef, 'SET_STATUS_CUE_PERIOD:1:')
	    }
	    else
	    {
		// disable feedback updates during playback
		call 'SEND_REQUEST' (interfaceRef, 'SET_STATUS_CUE_PERIOD:0:') 
	    }   
	    	    
	    //set this to not playing to force a now playing refresh
	    //this will refresh the now playing popup and re-request the list (if SATP)
	    PlayMode[interfaceRef] = PLAY_MODE_UNKNOWN 
	    	
	}
	CALL 'REFRESH TP' (interfaceRef)
    }
}




DATA_EVENT[m_Interface]
{
    command:
    {
	stack_var char textCommand[255] //used for command manipulation
	stack_var integer interfaceRef //used to reference which player is being addressed
	
	interfaceRef = get_last(m_Interface)
	
	//convert to upper case and put in temp variable
	textCommand = upper_string(data.text) 
	
	select
	{
	    active(left_string(textCommand,3) = 'IP '): //command to set the IP address
	    {
		remove_string(textCommand, 'IP ', 1) //remove the header
		
		if(IPAddress <> '') 
		{
		    call 'TRACE'(0, "'Was using IP Address: ',IPAddress")
		}
		
		IPAddress = textCommand //set the IP
		
		call 'TRACE'(0, "'Now using IP Address: ', IPAddress")
		
		if(IPConnection && IPAddress <> '')		//if this is a IP connection
		{
		    if(length_string(KaleidescapeID[interfaceRef].deviceID))
		    {
			managePort(IP_PORT_RESET, 0)
		    }
		}
	    }
	    
	    active(left_string(textCommand, 3) = 'ID '): //command to set the Id
	    {
		stack_var integer deviceID
		stack_var integer streamPos
		stack_var integer seqPos
		
		remove_string(textCommand, 'ID ', 1) //remove the header
		
		streamPos = find_string(textCommand, '.', 2)
		seqPos = find_string(textCommand, '/', 2)
		
		if(textCommand[1] = '#')
		{
		    //note that a device is routing commands using serial number device ids
		    usingSNAddressing = 1
		}
		else if(atoi(textCommand) >= 0 && atoi(textCommand) <= 99)
		{
		    //note that a device is routing commands using control protocol device ids
		    usingCPDaddressing = 1
		}
		
		if(streamPos)
		{
		    set_length_array(KaleidescapeID[interfaceRef].deviceId, streamPos-1)
		    KaleidescapeID[interfaceRef].deviceId = left_string(textCommand, streamPos-1)
		}
		else if(seqPos)
		{
		    set_length_array(KaleidescapeID[interfaceRef].deviceId, seqPos-1)
		    KaleidescapeID[interfaceRef].deviceId = left_string(textCommand, seqPos-1)
		}
		else
		{
		    set_length_array(KaleidescapeID[interfaceRef].deviceId, length_string(textCommand))
		    KaleidescapeID[interfaceRef].deviceId = textCommand
		}
		
		formatId(KaleidescapeID[interfaceRef].deviceId)
		
		if(KaleidescapeID[interfaceRef].deviceId != '01')
		{
		    DeviceIndirect[interfaceRef] = 1 //if the ID isn't 1, assume indirect
		}
		
		//if there is a stream within the command
		if(find_string(textCommand, '.', 1)) 
		{
		    remove_string(textCommand, '.', 1) //remove everything up to the stream
		    
		    //set the stream
		    KaleidescapeID[interfaceRef].zoneId = atoi(textCommand) 
		    #IF_DEFINED SATP
			//set the starting node
			call 'PUSH NODE' (interfaceRef, LIST_SHOW_BROWSE, 
				ListBrowseStart)
				
			//set the starting node
			call 'PUSH NODE' (interfaceRef, LIST_SHOW_NOWPLAYING, 
				ListNowPlayingStart)
		    #ELSE
			send_string 0, "13, 
			    'ERROR!  Kaleidescape SATP commands requested, but SATP not',
			    'compiled into the module.'"
		    #END_IF
		    
		}
		else
		{
		    KaleidescapeID[interfaceRef].zoneId = 0	//clear the stream
		}
		
		//if there is a sequence ID within the command
		if(find_string(textCommand, '/', 1)) 
		{
		    remove_string(textCommand, '/', 1)	//remove everything up to the sequence number
		    
		    //set the sequence
		    KaleidescapeID[interfaceRef].sequence = atoi(textCommand) //copy the sequence number from the string
		}
		else
		{
		    //set the default sequence
		    KaleidescapeID[interfaceRef].sequence = 1
		}
		
		//turn back into ASCII
		KaleidescapeID[interfaceRef].sequence = 
		    KaleidescapeID[interfaceRef].sequence + '0'
		
		
		if(KaleidescapeID[interfaceRef].zoneId)//format('%02d', deviceId)
		    call 'TRACE'(interfaceRef, "'Now using ID: ', KaleidescapeID[interfaceRef].deviceId, format('.%02d', KaleidescapeID[interfaceRef].zoneId), '/',KaleidescapeID[interfaceRef].sequence ")
		else
		    call 'TRACE'(interfaceRef, "'Now using ID: ', KaleidescapeID[interfaceRef].deviceId, '/',KaleidescapeID[interfaceRef].sequence")
		
		//indicate that this device is offline (we don't actually know)
		OFF[m_Interface[interfaceRef], CHN_DEVICE_ONLINE]
		
		//try to start communications
		call 'INITIALIZE DEVICE' (interfaceRef)
	    }
	    
	    #IF_DEFINED SATP
	    //indicate the number of lines available on the touch panel
	    active(left_string(textCommand,6) = 'LINES '): 
	    {
		remove_string(textCommand, 'LINES ', 1)
		ListWindowLength[interfaceRef] = atoi(textCommand)
	    }
	    #END_IF
	    
	    //deprecated, the module now figures this out by itself
	    active(textCommand = 'INDIRECT'): 
	    {
		DeviceIndirect[interfaceRef] = 1
	    }
	    
	    //deprecated, the module now figures this out by itself
	    active(textCommand = 'DIRECT'):
	    {
		DeviceIndirect[interfaceRef] = 0
	    }
	    
	    //command to request a refresh of all TP send strings/levels
	    active(textCommand = 'REFRESH'):
	    {
		pulse[m_Interface[interfaceRef], CHN_REFRESH]
	    }
	    
	    active(textCommand = 'DEBUG'): //start debug mode
	    {
		SentTraceInfo = 1
		call 'TRACE' (0, 
			'Enabling debugging trace information for Kaleidescape module')
	    }
	    
	    active(textCommand = 'VERSION'):
	    {
		send_string 0, ModuleDescription
	    }
	    
	    active(left_string(textCommand,6) = 'DEBUG '): //start detailed debug mode
	    {
		remove_string(textCommand, 'DEBUG ', 1)
		SentTraceInfo = atoi(textCommand)
		
		call 'TRACE' (0,"'Enabling detail ', itoa(SentTraceInfo),
			' debugging trace information for Kaleidescape module'")
	    }
	    
	    active( (textCommand = 'DEBUG STOP') || //leave debug mode 
	             (textCommand = 'DEBUG OFF')  ||
	             (textCommand = 'NO DEBUG')   ||
	             (textCommand = '!DEBUG')     ||
	             (textCommand = 'STOP DEBUG') ):
	    {
		call 'TRACE' (0, 
			'Disabling debugging trace information for Kaleidescape module')
		SentTraceInfo = 0
	    }
	    
	    //if the user it trying to set the baud rate
	    active(left_string(textCommand,8) = 'SET BAUD'):
	    {
		send_command m_KPort, textCommand //pass it on to the actual port 
		BaudRateCommand = textCommand //remember it for restarts
	    }
	    
	    /*
	     * treat any single character as a keyboard command 
	     * also, any sequence starting with [ is a alpha keypad set 
	     * ( [ABC2], [DEF3], etc)
	     */
	    active( (length_array(textCommand) = 1) || (textCommand[1] = '[') ): 	    
	    {
		if(KaleidescapeID[interfaceRef].zoneId) //if using the SATP interface
		{
		    #IF_DEFINED SATP
			//pass the character to the keyboard routine
			call 'KEYBOARD BUTTON' (interfaceRef, textCommand)	
		    #ELSE
			send_string 0, "13, 'ERROR!  Kaleidescape SATP commands requested, ',
			    'but SATP not compiled into the module.'"
		    #END_IF
		}
		
		else //using the OSD interface
		{
		    call 'SEND_REQUEST' (interfaceRef, "'KEYBOARD_CHARACTER:', 
			    escapeInvalidChars(textCommand), ':'")
		}
	    }
	    
	    active(left_string(textCommand, 5) = 'TEST '):
	    {
		textCommand = data.text //kill the upper case thing
		call 'TRACE' (0, "'letter:', itoa(isLetter(textCommand[6])), ' lower:',
			itoa(isLowerLetter(textCommand[6])), ' upper:',
			itoa(isUpperLetter(textCommand[6])) ")
	    }
	    
	    active(left_string(textCommand, 6) = 'TEST2 '):
	    {
		textCommand = data.text //kill the upper case thing
		call 'TRACE' (0, "'toTitleCaps:', toTitleCaps(textCommand)")
	    }
	    
	    
	    active( left_string(textCommand, 19) = 'COVER HOST OVERRIDE ' ):
	    {
		remove_string(textCommand, 'COVER HOST OVERRIDE ', 1)
		CoverHostOverride = textCommand
		
		call 'TRACE' (0, "'Setting Cover URL Override to "',
			CoverHostOverride, '"'")
	    }
	    
	    active( left_string(textCommand, 26) = 'CALIBRATE MASKING OVERSCAN'):
	    {
		call 'SEND_REQUEST' (interfaceRef, 'GO_CALIBRATE_MASKING_OVERSCAN:')
	    }
	    
	    active( left_string(textCommand, 17) = 'CALIBRATE MASKING'):
	    {
		call 'SEND_REQUEST' (interfaceRef, 'GO_CALIBRATE_MASKING:')
	    }
	    
	    active( left_string(textCommand, 11) = 'PRESET TAG ' ): //'PRESET TAG Kitchen' - alias for the PRESET ID command below.
	    {
		//get the proper case
		textCommand = right_string(data.text,length_string(data.text) - 11)
		PresetID[interfaceRef] = textCommand
		call 'TRACE' (interfaceRef, "'Setting the preset tag (ID) to "', 
			textCommand, '"'")
	    }
	    
	    active( left_string(textCommand, 10) = 'PRESET ID ' ): //'PRESET ID Kitchen'
	    {
		//get the proper case
		textCommand = right_string(data.text,length_string(data.text) - 10)
		PresetID[interfaceRef] = textCommand
		call 'TRACE' (interfaceRef, "'Setting the preset ID to "', 
			textCommand, '"'")
	    }
	    
	    active( textCommand = 'PRESET LOCK' ): //Lock the presets for this device
	    {
		PresetLock[interfaceRef] = true
		call 'TRACE' (interfaceRef, "'Setting the preset lock'")
	    }
	    
	    active( textCommand = 'PRESET UNLOCK' ): //Unlock the presets for this device
	    {
		PresetLock[interfaceRef] = false
		call 'TRACE' (interfaceRef, "'Clearing the preset lock'")
	    }
	    
	    active( left_string(textCommand, 11) = 'MAX PRESET ' ): //Set the number of presets
	    {
		textCommand = right_string(data.text, length_string(data.text) - 11)
		NumberOfPresets[interfaceRef] = atoi(textCommand)
		call 'TRACE' (interfaceRef, "'Setting number of presets to ', textCommand")
	    }
	    
	    active( left_string(textCommand, 11) = 'COLLECTION ' ): //'COLLECTION 1 Artists'
	    {
	    	stack_var integer collectionNumber
		
		remove_string(textCommand, 'COLLECTION ', 1)
		
		//pull out the collection number
		collectionNumber = atoi(remove_string(textCommand, ' ',1))

		if(collectionNumber > MAX_NUMBER_OF_KEYPAD_COLLECTIONS)
		{
		    call 'TRACE' (interfaceRef, "'ERROR! There is no collection #',
			    itoa(collectionNumber), '.  Only 1 to ', 
			    itoa(MAX_NUMBER_OF_KEYPAD_COLLECTIONS), ' are valid.'") 
		}
		else
		{
		    KeypadCollection[interfaceRef][collectionNumber] = textCommand
		    call 'TRACE' (interfaceRef, "'Setting keypad collection ', 
			    itoa(collectionNumber), ' to "', textCommand,'"'")
		}
	    }
	    
	    #IF_DEFINED SATP
	    active( left_string(textCommand, 13) = 'VERIFY CRUMBS' ||
		     left_string(textCommand, 13) = 'VERIFY STACKS'):
	    {
		stack_var char 	interfaceRefLoop
		stack_var char 	listType
		stack_var integer 	node1
		stack_var integer 	node2
		stack_var integer 	numNodes
		stack_var integer 	verbose
		
		if(length_string(textCommand) > 13)
		{
		    verbose = 1
		}
		else
		{
		    verbose = 0
		}
		
		//Check the size of all the stacks.
		numNodes = AvailableResources			    
		send_string 0, "'**Sizes**'"
		send_string 0, "' Free: ', itoa(AvailableResources)"
		
		for(interfaceRefLoop = 1; interfaceRefLoop <= MAX_NUMBER_OF_PLAYERS; interfaceRefLoop++)
		{
		    for(listType = 1; listType <= 2; listType++)
		    {
			if(BrowseNodeStack[interfaceRefLoop][listType].size > 0)
			{
			    send_string 0, "' ', itoa(interfaceRefLoop), ',', itoa(listType), ': ', 
				itoa(BrowseNodeStack[interfaceRefLoop][listType].size)"
			    numNodes = numNodes + BrowseNodeStack[interfaceRefLoop][listType].size
			}
		    }
		}
		
		send_string 0, "' total: ', itoa(numNodes),13,13"
		
		send_string 0, "'**Trace**', 13"
		
		//Check the list of unallocated nodes.
		send_string 0,  "13, 13, ' Free List: '"
				
		node1 = NextFreeNode
		node2 = 0		
		numNodes = 0
		
		while(node1 > 0)
		{
		    if(BrowseNodeResource[node1].nextNode <> node2)
		    {
			send_string 0, "'Error in Node ', itoa(node1), ' - next was ',
			    itoa(BrowseNodeResource[node1].nextNode)"
		    }
			
		    node2 = node1
		    node1 = BrowseNodeResource[node2].previousNode
		    
		    if(verbose) send_string 0, "itoa(node2), ' > ', itoa(node1), 13"
		    
		    numNodes++
		}
		
		if(numNodes != AvailableResources)
		{
		    send_string 0, "'Error in AvailableResources.  Found ', itoa(numNodes), 
				    ' nodes.'"
		}
		else 
		{
		    send_string 0, "'Count matches found nodes: ', itoa(numNodes)"
		}
		
		//Check the contents of each stack.
		for(interfaceRefLoop = 1; interfaceRefLoop <= MAX_NUMBER_OF_PLAYERS; interfaceRefLoop++)
		{
		    for(listType = 1; listType <= 2; listType++)
		    {
			if(BrowseNodeStack[interfaceRefLoop][listType].bottom > 0)
			{
			    send_string 0,  "13, 13, ' List: ', itoa(interfaceRefLoop), ',', 
				itoa(listType), ': '"
			    
			    numNodes = 0
			    node1 = BrowseNodeStack[interfaceRefLoop][listType].bottom
			    node2 = 0
			    
			    while(node1 > 0)
			    {
				if(BrowseNodeResource[node1].previousNode <> node2)
				{
				    send_string 0, "13,'Error in Node ',
					itoa(node1), ' - last was ',
					itoa(BrowseNodeResource[node1].previousNode)"
				}
				    
				node2 = node1
				node1 = BrowseNodeResource[node1].nextNode
				
				if(verbose) 
				{
				    send_string 0, "itoa(node2), ' > ', itoa(node1), 13"
				}
				
				numNodes++
				
			    }
			    
			    if(numNodes != BrowseNodeStack[interfaceRefLoop][listType].size)
			    {
				send_string 0, "'Error in .size.  Found ', 
				    itoa(numNodes), ' nodes.'"
			    }
			    else
			    {
				send_string 0, "'.size matches found nodes: ', 
				    itoa(numNodes)"
			    }
			    
			    if(node1 != BrowseNodeStack[interfaceRefLoop][listType].current)
			    {
				send_string 0, "'Error.  .Current (', 
				    itoa(BrowseNodeStack[interfaceRefLoop][listType].current),
				    ') does not match the last node (', itoa(node1), ')'"
			    }
			    else
			    {
				send_string 0, "'.Current (', 
				    itoa(BrowseNodeStack[interfaceRefLoop][listType].Current),
				    ') properly matches the last node.'"
			    }
			}
		    }
		}
		    
	    }
	    #END_IF
	    
	    active (left_string (textCommand,17) = 'VOLUME CAPABILITY'): //command to set the volume capabilities of a player
	    {
		VolumeCapability[interfaceRef] = atoi(textCommand)
	    }
	    
	    active(1): //default action
	    {
		//send all other unknown commands to the player
		call 'SEND_REQUEST' (interfaceRef, data.text)
	    }
	}
    }
}

channel_event[m_Interface, 0] //trap all events
{
    on:  
    {
	stack_var integer 	interfaceRef
	stack_var integer 	handling
	stack_var char 	commandString[COMMAND_LENGTH]
	
	//retreive the device that generated the event
	interfaceRef = get_last(m_Interface)	
	
	call 'TRACE' (interfaceRef, "'Received push ', itoa(channel.channel)")
	select
	{
	    //ensure that we only process events that are in range
	    active( channel.channel <= LAST_BUTTON ): 
	    {
		if( KaleidescapeID[interfaceRef].zoneId && //Check for defined stream
		    ( channel.channel >= BTN_FIRST_LIST_COMMAND  || //List command?
		     (channel.channel >= BTN_KEYPAD_KEY && //Keypad command
		      channel.channel <= BTN_KEYPAD_ENTER + 9) ) 
		  )
		{
		    #IF_DEFINED SATP
			call 'LIST COMMAND HANDLER' (interfaceRef, channel.channel, 1)
		    #ELSE
			call 'TRACE' (interfaceRef, 
			    'ERROR!!  SATP command requested, but SATP commands not compiled.  Recompile module with #DEFINE SATP.')
		    #END_IF
		}
		//verify that this command is defined
		else if( length_string(Commands[channel.channel]) )
		{
		    // retreive the command from the array
		    commandString = Commands[channel.channel]	
		    
		    // strip off the handling indicator
		    handling = get_buffer_char(commandString)
		    
		    call 'TRACE' (interfaceRef,"'Processing push ', commandString")
		    
		    switch (handling)
		    {
			case PRESS_DIRECT: //non-repeating, no feedback command
			{
			    //send the command
			    call 'SEND_REQUEST' (interfaceRef, "commandString, ':'")	
			}
			    
			case PRESS_REPEAT: //repeating, no feedback command 
			{
			    //send the command with a press
			    call 'SEND_REQUEST' (interfaceRef, "commandString, '_PRESS:'")
			    
			    //turn on the feedback 
			    on [m_Interface[interfaceRef], 
				channel.channel + FEEDBACK_OFFSET]	
			}
			    
			case PRESS_PULSED:
			{
			    //send the command
			    call 'SEND_REQUEST' (interfaceRef, "commandString, ':'")
			    
			    //pulse the feedback 
			    pulse [m_Interface[interfaceRef], 
				channel.channel + FEEDBACK_OFFSET]
			}
			
			case PRESS_COORDS:
			{
			    call 'HANDLE COORDINATE PRESS' (interfaceRef)
			}
			
			case PRESS_PLAYPS:
			{
			    call 'HANDLE PLAY PAUSE PRESS' (interfaceRef)
			}
		    }
		}
	    }
	    //do nothing if the channel is under the page offsets
	    active (channel.channel <= CHN_PAGE_OFFSET):
	    { 
	    }
	    //if this is one of the pages, trigger the UI to change to that page
	    active (channel.channel < CHN_PAGE_OFFSET + max_length_array(m_UIPages) ): 
	    {
		//ensure this page is defined
		if(length_string( m_UIPages[channel.channel - CHN_PAGE_OFFSET] ) > 0)
		{
		    send_string m_Interface[interfaceRef], "'PAGE-', 
			m_UIPages[channel.channel - CHN_PAGE_OFFSET]"
		}
	    }
	    
	    //do nothing if the channel is under the popup offset
	    active (channel.channel <= CHN_POPUP_OFFSET):
	    {
	    }
	    
	    //if this is one of the popups, trigger the popup
	    active (channel.channel < CHN_POPUP_OFFSET + max_length_array(m_UIPopUps) ):
	    {
		call 'SET POPUP STATE' (interfaceRef, channel.channel - CHN_POPUP_OFFSET)
	    }
	}
    }
    off:  
    {
	stack_var integer 	interfaceRef
	stack_var integer 	handling
	stack_var char 		commandString[COMMAND_LENGTH]
	
	//retreive the device that generated the event
	interfaceRef = get_last(m_Interface)	
	
	call 'TRACE' (interfaceRef, "'Received release ', itoa(channel.channel)")
	
	select
	{
	    //ensure that we only process events that are in range
	    active( channel.channel <= LAST_BUTTON ):
	    {
		//if there's a defined stream, and this is a list command
		if( KaleidescapeID[interfaceRef].zoneId &&
		    channel.channel >= BTN_FIRST_LIST_COMMAND )
		{
		    #IF_DEFINED SATP
			call 'LIST COMMAND HANDLER' (interfaceRef,channel.channel,0)
		    #END_IF
		}
		//verify that this command is defined
		else if( length_string(Commands[channel.channel]) )
		{
		    // retreive the command from the array
		    commandString = Commands[channel.channel]	
		    
		    // strip off the repeat indicator
		    handling = get_buffer_char(commandString)
		    
		    call 'TRACE' (interfaceRef, "'Processing release ', commandString")
		    
		    switch (handling)
		    {   case PRESS_REPEAT: //if this is a repeating command 
			{
			    //send the command with a press
			    call 'SEND_REQUEST' (interfaceRef, "commandString, 
				    '_RELEASE:'")
				    
			    //turn off the feedback 
			    off [m_Interface[interfaceRef], 
				    channel.channel + FEEDBACK_OFFSET]
			}
			
			case PRESS_COORDS:
			{
			    call 'HANDLE COORDINATE RELEASE' (interfaceRef)
			}
		    }
		}
	    }
	    //do nothing if the channel is under the popup offset
	    active (channel.channel <= CHN_POPUP_OFFSET):
	    {
	    }
	    //if this is one of the popups, trigger the popup	    
	    active (channel.channel < CHN_POPUP_OFFSET + max_length_array(m_UIPopUps) ):
	    {
		call 'SET POPUP STATE' (interfaceRef, channel.channel - CHN_POPUP_OFFSET)
	    }
	}
    }
}

level_event [m_Interface,LVL_COORDINATE_X]
level_event [m_Interface,LVL_COORDINATE_Y]
{
    stack_var integer interfaceRef
    stack_var integer levelReference
    
    /*
     * This code is intended to retreive the device that triggered this event.
     * Howver, get_last seems to have a bug when run in a level event against 
     * a virtual device.  Thus we must retreive the device that triggered this 
     * event the hard way
     */
    interfaceRef = getDevRef(m_Interface, level.sourcedev)	

    //calculate which level we're looking at 
    levelReference = level.input.level - LVL_COORDINATE_X + 1	
    
    //save the coordinate into the coordinate array
    Coordinate[interfaceRef][levelReference] = level.value	
    
    call 'TRACE' (interfaceRef, "'Level ref ', itoa(levelReference), ' changed to ',
	    itoa(Coordinate[interfaceRef][levelReference])")
}

level_event [m_Interface, LVL_VOLUME]
{
    stack_var integer interfaceRef
    
    /*
     * This code is intended to retreive the device that triggered this event.
     * Howver, get_last seems to have a bug when run in a level event against 
     * a virtual device.  Thus we must retreive the device that triggered this 
     * event the hard way
     */
    interfaceRef = getDevRef(m_Interface, level.sourcedev)	
    Volume[interfaceRef] = level.value
    
    //send the level to the player using SEND_EVENT:VOLUME_LEVEL=XX:
    call 'SEND_REQUEST' (interfaceRef, "'SEND_EVENT:VOLUME_LEVEL=', itoa(Volume[interfaceRef]), ':'")	
    
    call 'TRACE' (interfaceRef, "'Volume level ', itoa(LVL_VOLUME), 'changed to ',
	    itoa(Volume[interfaceRef])")
}

channel_event [m_Interface, BTN_VOLUME_MUTE]
{
    ON: 
    {
	stack_var integer interfaceRef
	    interfaceRef = get_last(m_Interface)
	    
	call 'SEND_REQUEST' (interfaceRef, "'SEND_EVENT:MUTE_ON_FB:'")
    }
    OFF: 
    {
	stack_var integer interfaceRef
	    interfaceRef = get_last(m_Interface)
	    
	call 'SEND_REQUEST' (interfaceRef, "'SEND_EVENT:MUTE_OFF_FB:'")
    }
}

#IF_DEFINED SATP

    level_event [m_Interface, LVL_SCROLL_BAR_COMMAND]
    {
	stack_var integer interfaceRef
	stack_var integer newPosition
	stack_var integer nodeRef
	
	/*
	 * This code is intended to retreive the device that sent this level.
	 * Howver, get_last seems to have a bug when run in a level event against 
	 * a virtual device.  Thus we must retreive the device that triggered this 
	 * event the hard way
	 */	
	interfaceRef = getDevRef(m_Interface, level.sourcedev)
	
	//if the list doesn't fit the window...
	if(ListLength[interfaceRef] > ListWindowLength[interfaceRef])
	{
	    newPosition = ( (level.value) * (ListLength[interfaceRef] + 1) / 255 ) + 1
	    
	    /*
	     * make range within half of the bug size (relative window length) 
	     * of each end of the bar
	     */
	     
	     //if the list position is at less than half the window length
	    if(newPosition <= ListWindowLength[interfaceRef]/2)
	    {
		newPosition = 1 //set it to the lowest point
	    }
	    else
	    {
		//otherwise, knock off the top half of the window
		newPosition = newPosition - ListWindowLength[interfaceRef] / 2
	    }
		
	    //bounds check to make out of bound values legit
	    newPosition = boundsCheckListPosition(interfaceRef, newPosition)
	    
	    if(CurrentList[interfaceRef] = LIST_SHOW_NOWPLAYING) //if we're showing now playing
	    {
		//tell the interface not to follow the current playing item for a bit
		do_push_timed(m_Interface[interfaceRef], CHN_OVERRIDE_NP_FOLLOW, 
		    TIMEOUT_NOW_PLAYING_MOVE)
	    }
		
	    nodeRef = BrowseNodeStack[interfaceRef][ CurrentList[interfaceRef] ].current
	    	    
	    if(nodeRef !=  0) //if there is an active browse node...
	    {
		//and if the position is actually different
		if(newPosition != BrowseNodeResource[nodeRef].Position) 
		{
		    BrowseNodeResource[nodeRef].position = newPosition //set the position
		    BrowseNodeResource[nodeRef].moved = true		//note that it's been intentionally moved
		    call 'GET LIST'(interfaceRef) //and refresh the list
		}
		else
		{
		    call 'TRACE'(interfaceRef, 'Scroll bar new position matches old position.')
		}
	    }
	    else
	    {
		call 'TRACE'(interfaceRef, 'Scroll bar moved, but nodeRef is invalid.')
	    }
	}
	else
	{
	    call 'TRACE'(interfaceRef, 
		"'Scroll bar moved, but list already fits in window.  List:', 
		itoa(ListLength[interfaceRef]), ' window:', itoa(ListWindowLength[interfaceRef])")
	    
	    call 'TRACE'(interfaceRef, "itoa(level.sourcedev.number), ' and ', 
		itoa(m_Interface[interfaceRef].number)")
	}
    }
    
    //triggered from the DO_PUSH within the list command handler to allow the hold
    button_event [m_Interface, BTN_LIST_UP] 
    {
	push:
	{
	    stack_var integer interfaceRef
	    
	    interfaceRef = get_last(m_Interface)
	    call 'MOVE LIST'(interfaceRef, (-1 * (ListWindowLength[interfaceRef] - 1)) )
	}
	hold[15, REPEAT]:
	{
	    stack_var integer interfaceRef
	    stack_var sinteger step
	    
	    interfaceRef = get_last(m_Interface)
	    step = type_cast(button.holdtime / 1000) //get how long this button has been held
	    
	    step = step * (ListWindowLength[interfaceRef] -1) * -1
	    
	    call 'MOVE LIST'(interfaceRef, step)
	}
    }

    //triggered from the DO_PUSH within the list command handler to allow the hold
    button_event [m_Interface, BTN_LIST_DOWN] 
    {
	push:
	{
	    stack_var integer interfaceRef
	    
	    interfaceRef = get_last(m_Interface)	    
	    
	    call 'MOVE LIST'(interfaceRef, (ListWindowLength[interfaceRef] - 1))
	}
	hold[15, REPEAT]:
	{
	    stack_var integer 	interfaceRef
	    stack_var sinteger 	step
	    
	    interfaceRef = get_last(m_Interface)
	    
	    //get how long this button has been held
	    step = type_cast(button.holdtime / 1000)
	    
	    step = step * (ListWindowLength[interfaceRef] - 1)
	    
	    call 'MOVE LIST'(interfaceRef, step)
	}
    }
    

    //handle resending a get list in an intelligent manner
    button_event [m_Interface, CHN_LIST_ACTIVE]
    {
	push:
	{
	    on[button.sourcedev, CHN_LIST_ACTIVE] //turn on the feedback channel
	}
	hold[100]: //this should never stay high, this is a safety
	{
	    do_release(button.sourcedev, CHN_LIST_ACTIVE)
	}
	release:
	{
	    stack_var integer interfaceRef
	    
	    interfaceRef = get_last(m_Interface)
	    
	    off[m_Interface[interfaceRef], CHN_LIST_ACTIVE] //turn off the feedback channel
	    
	    if([m_Interface[interfaceRef], CHN_LIST_PENDING]) //if there's a list pending
	    {
		off[m_Interface[interfaceRef], CHN_LIST_PENDING] //clear the flag
		call 'GET LIST'(interfaceRef) //get the list
	    }
	}
    }
    
    //handler to get the list after a slight delay
    button_event [m_Interface, CHN_GET_LIST_DELAYED]
    {
	push:
	{
	    /*
	     * do nothing.  This is defined to prevent the processor from running 
	     * mainline to find a handler
	     */
	}	
	hold[100]: //this should never stay high, this is a safety
	{
	    do_release(button.sourcedev, CHN_GET_LIST_DELAYED)
	}
	release:
	{
	    stack_var integer interfaceRef
	    
	    interfaceRef = get_last(m_Interface)
	    
	    call 'GET LIST' (interfaceRef)
	}
    }
    
    //when this goes low, recenter the now playing list
    button_event [m_Interface, CHN_OVERRIDE_NP_FOLLOW]
    {
	push:
	{
	    stack_var integer interfaceRef
	    
	    interfaceRef = get_last(m_Interface)
	    on[m_Interface[interfaceRef], CHN_OVERRIDE_NP_FOLLOW]
	}
	release:
	{
	    stack_var integer interfaceRef
    	    
	    interfaceRef = get_last(m_Interface)
	    
	    off[m_Interface[interfaceRef], CHN_OVERRIDE_NP_FOLLOW]
	    
	    if(centerNowPlayingList(interfaceRef)) //if the center has changed
	    {
		//and if we're looking at the now playing window
		if(CurrentList[interfaceRef] = LIST_SHOW_NOWPLAYING) 
		{
		    call 'GET LIST' (interfaceRef) //reload the list
		}
	    }
	}
    }
#END_IF

button_event [m_Interface, CHN_RESET_HIGHLIGHTED_DETAILS]
{
    push:
    {
	stack_var integer interfaceRef
	
	interfaceRef = get_last(m_Interface)
	
	OFF[m_Interface[interfaceRef], CHN_POPUP_OFFSET + POP_DETAILS_PAGE]
    }    
    release:
    {
	stack_var integer interfaceRef
	
	interfaceRef = get_last(m_Interface)
	
	//if a content handle is provided and if the details page is defined
	if( (length_string(HighlightedSelectionHandle[interfaceRef]) > 0) &&
	    (length_string(m_UIPopups[POP_DETAILS_PAGE]) > 0)       )
	{
	    //ask for the details for this handle
	    call 'SEND_REQUEST' (interfaceRef, "'GET_CONTENT_DETAILS:', 
		    HighlightedSelectionHandle[interfaceRef], '::'")
	}    
    }
}

channel_event [m_Interface, BTN_RETRY_CONNECTION_ATTEMPT]
{
    on:
    {
	call 'TRACE' (0, "'Retry button pressed'")
	if(IPPortStatus != IP_PORT_OPEN)
	{
	    managePort(IP_PORT_RESET, 0)
	}
    }
}


/******************************************************************************************
 **                   Keypad Events                                                      **
 ******************************************************************************************/

//Presets

//trigger the button event when receiving a channel event
channel_event [m_Interface, BTN_PRESET1]
channel_event [m_Interface, BTN_PRESET2]
channel_event [m_Interface, BTN_PRESET3]
channel_event [m_Interface, BTN_PRESET4]
channel_event [m_Interface, BTN_PRESET5]
channel_event [m_Interface, BTN_PRESET6]
channel_event [m_Interface, BTN_PRESET7]
channel_event [m_Interface, BTN_PRESET8]
channel_event [m_Interface, BTN_PRESET9]
channel_event [m_Interface, BTN_PRESET10]
{
    on:
    {
	do_push_timed(channel.device, channel.channel, do_push_timed_infinite)
    }
    off:
    {
	do_release(channel.device, channel.channel)
    }
}

button_event [m_Interface, BTN_PRESET1]
button_event [m_Interface, BTN_PRESET2]
button_event [m_Interface, BTN_PRESET3]
button_event [m_Interface, BTN_PRESET4]
button_event [m_Interface, BTN_PRESET5]
button_event [m_Interface, BTN_PRESET6]
button_event [m_Interface, BTN_PRESET7]
button_event [m_Interface, BTN_PRESET8]
button_event [m_Interface, BTN_PRESET9]
button_event [m_Interface, BTN_PRESET10]
{
    push:
    {
	stack_var integer presetNumber
	stack_var integer interfaceRef
	
	//determine which preset we're setting	    
	presetNumber = button.input.channel - BTN_PRESET1 + 1
	interfaceRef = getDevRef(m_Interface, button.input.device)
	
	//clear the feedback to allow a re-trigger or to save the preset
	PresetHeld[interfaceRef][presetNumber] = false
	
	if(PresetLock[interfaceRef])
	{
	    call 'ACTIVATE PRESET' (interfaceRef, presetNumber)
	}
    }
    
    hold[20]:
    {
	stack_var integer presetNumber
	stack_var integer interfaceRef
	
	//determine which preset we're setting
	presetNumber = button.input.channel - BTN_PRESET1 + 1	
	interfaceRef = getDevRef(m_Interface, button.input.device)
	
	if(NOT PresetLock[interfaceRef])
	{
	    call 'SEND_REQUEST'(interfaceRef, "'ASSIGN_PLAYING_MUSIC_TO_PRESET:',
		    getPresetTag(interfaceRef, presetNumber),':'")
		    
	    //set the feedback to prevent the release routine from resetting the preset
	    PresetHeld[interfaceRef][presetNumber] = true
	}
    }
    
    release:
    {
	stack_var integer presetNumber
	stack_var integer interfaceRef
	
	//determine which preset we're setting
	presetNumber = button.input.channel - BTN_PRESET1 + 1
	interfaceRef = getDevRef(m_Interface, button.input.device)
	
	if( (NOT PresetLock[interfaceRef]) && (NOT PresetHeld[interfaceRef][presetNumber]) )
	{
	    call 'ACTIVATE PRESET' (interfaceRef, presetNumber)
	}
	
	//Clear the preset held flag.
	PresetHeld[interfaceRef][presetNumber] = false;
    }
}

//trigger the feedback channel event when the button event fires
button_event [m_Interface, BTN_PRESET1 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET2 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET3 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET4 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET5 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET6 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET7 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET8 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET9 + FEEDBACK_OFFSET]
button_event [m_Interface, BTN_PRESET10 + FEEDBACK_OFFSET]
{
    push:
    {
	on[button.input.device, button.input.channel]
    }
    release:
    {
	off[button.input.device, button.input.channel]
    }
}

//Collections
channel_event [m_Interface, BTN_COLLECTION1_FIRST]
channel_event [m_Interface, BTN_COLLECTION2_FIRST]
channel_event [m_Interface, BTN_COLLECTION3_FIRST]
{
    on:
    {
	stack_var integer collection
	stack_var integer interfaceRef
	
	//determine which collection we're working with
	collection = (channel.channel - BTN_COLLECTION1_FIRST) / 3 + 1	
	interfaceRef = get_last(m_Interface)
	
	if(length_string(KeypadCollection[interfaceRef][collection]) = 0)
	{
	    call 'TRACE'(interfaceRef, "'Request to play first in collection #',
		    itoa(collection), ', but the collection name isn''t defined.'")
	}
	else
	{
	    call 'SEND_REQUEST'(interfaceRef, "'PLAY_FIRST_IN_MUSIC_COLLECTION:',
		    escapeInvalidChars(KeypadCollection[interfaceRef][collection]), ':'")
	}
    }
}

channel_event [m_Interface, BTN_COLLECTION1_NEXT]
channel_event [m_Interface, BTN_COLLECTION2_NEXT]
channel_event [m_Interface, BTN_COLLECTION3_NEXT]
{                                   
    on:
    {
	stack_var integer collection
	stack_var integer interfaceRef
	
	//determine which collection we're working with
	collection = (channel.channel - BTN_COLLECTION1_FIRST) / 3 + 1
	interfaceRef = get_last(m_Interface)
	
	if(length_string(KeypadCollection[interfaceRef][collection]) = 0)
	{
	    call 'TRACE'(interfaceRef, "'Request to play next in collection #',
		    itoa(collection), ', but the collection name isn''t defined.'")
	}
	else
	{
	    call 'SEND_REQUEST'(interfaceRef, "'PLAY_NEXT_IN_MUSIC_COLLECTION:',
		    escapeInvalidChars(KeypadCollection[interfaceRef][collection]), ':'")
	}
    }
}

channel_event [m_Interface, BTN_COLLECTION1_PREVIOUS]
channel_event [m_Interface, BTN_COLLECTION2_PREVIOUS]
channel_event [m_Interface, BTN_COLLECTION3_PREVIOUS]
{                                       
    on:
    {
	stack_var integer collection
	stack_var integer interfaceRef
	
	//determine which collection we're working with
	collection = (channel.channel - BTN_COLLECTION1_FIRST) / 3 + 1	
	interfaceRef = get_last(m_Interface)
	
	if(length_string(KeypadCollection[interfaceRef][collection]) = 0)
	{
	    call 'TRACE'(interfaceRef, "'Request to play previous in collection #',
		    itoa(collection), ', but the collection name isn''t defined.'")
	}
	else
	{
	    call 'SEND_REQUEST'(interfaceRef, "'PLAY_PREVIOUS_IN_MUSIC_COLLECTION:',
		    escapeInvalidChars(KeypadCollection[interfaceRef][collection]), ':'")
	}
    }
}

channel_event [m_Interface, BTN_PRESET_FIRST]
{
    on:
    {
    	stack_var integer interfaceRef
	stack_var integer presetNumber
	
	interfaceRef = get_last(m_Interface)
	
	//Activate the first defined preset.
	for(presetNumber = 1; presetNumber <= NumberOfPresets[interfaceRef]; presetNumber++)
	{	
	    if(PresetHandleTable[interfaceRef][presetNumber] != '')
	    {
		call 'ACTIVATE PRESET' (interfaceRef, 1)
	    }
	}
    }
}

channel_event [m_Interface, BTN_PRESET_NEXT]
{
    on:
    {	
    	stack_var integer 	interfaceRef
	stack_var integer 	presetNumber
	stack_var integer 	currentPreset
	stack_var char		presetActivated
	
	//Identify the interface through which this event came.
	interfaceRef = get_last(m_Interface)
	
	//Identify what will be used as the "current" preset.
	currentPreset = LastSelectedPreset[interfaceRef]
	while(! PresetFeedback[interfaceRef][currentPreset])
	{
	    //Check the next preset.
	    currentPreset = currentPreset + 1
		
	    //check the bounds for currentPreset
	    if(currentPreset > NumberOfPresets[interfaceRef]) 
	    {
		currentPreset = 1
	    }
		
	    //See if we've looped all the way back around.
	    if (currentPreset = LastSelectedPreset[interfaceRef]) break
	}
	
	//Now set that preset.
	presetActivated = false
	for(presetNumber = currentPreset + 1; presetNumber <= NumberOfPresets[interfaceRef]; presetNumber++)
	{
	    //if it's defined
	    if(PresetHandleTable[interfaceRef][presetNumber] != '')
	    {
		call 'ACTIVATE PRESET' (interfaceRef, presetNumber)
		presetActivated = true
		break
	    }
	} 
	
	//if process falls here, we didn't find a defined preset after the current preset.
	if(!presetActivated)
	{
	    //begin looking at the beginning
	    for(presetNumber = 1; presetNumber <= currentPreset - 1; presetNumber++) 
	    {
		if(PresetHandleTable[interfaceRef][presetNumber] != '')
		{
		    call 'ACTIVATE PRESET' (interfaceRef, presetNumber)
		    break
		}
	    }	
	}
    }
}

channel_event [m_Interface, BTN_PRESET_PREVIOUS]
{
    on:
    {
    	stack_var integer 	interfaceRef
	stack_var integer 	presetNumber
	stack_var integer 	currentPreset
	stack_var char		presetActivated
	
	//Identify the interface through which this event came.
	interfaceRef = get_last(m_Interface)
	
	//Identify what will be used as the "current" preset.
	currentPreset = LastSelectedPreset[interfaceRef]
	while(! PresetFeedback[interfaceRef][currentPreset])
	{
	    //Check the next preset.
	    currentPreset = currentPreset - 1
		
	    //check the bounds for currentPreset
	    if(currentPreset < 1) 
	    {
		currentPreset = NumberOfPresets[interfaceRef]
	    }
		
	    //See if we've looped all the way back around.
	    if (currentPreset = LastSelectedPreset[interfaceRef]) break
	}
	
	//begin walking back to the beginning
	presetActivated = false
	for(presetNumber = currentPreset - 1; presetNumber >= 1; presetNumber--)
	{
	    //if it's defined
	    if(PresetHandleTable[interfaceRef][presetNumber] != '')
	    {
		call 'ACTIVATE PRESET' (interfaceRef, presetNumber)
		presetActivated = true
		break
	    }
	} 
	
	//if process falls here, we didn't find a defined preset after the current preset.
	if(!presetActivated)
	{
	    //start from the end, and walk back to the active preset
	    for(presetNumber = NumberOfPresets[interfaceRef]; presetNumber >= currentPreset + 1; presetNumber--) 
	    {
		if(PresetHandleTable[interfaceRef][presetNumber] != '')
		{
		    call 'ACTIVATE PRESET' (interfaceRef, presetNumber)
		    break
		}
	    }
	}	
    }
}

/******************************************************************************************
 **                  End of  Keypad Events                                               **
 ******************************************************************************************/

timeline_event [TL_CONNECTION_TIMEOUT]
{
    switch(timeline.sequence)
    {
	case 1:
	{
	    showConnectionPopup(CONNECTION_POP_PROGRESS)
	    send_level m_Interface, LVL_CONNECTION_PROGRESS, 0
	}
	case 2:
	{
	    tlConnectionTimes[1] = 10
	    manageTimeline(CHANGE_TIMELINE, TL_ANIMATE_PROGRESS_BAR, tlConnectionTimes, 1, 0, 0, 0)
	    
	    wait_until(!timeline_active(TL_ANIMATE_PROGRESS_BAR))
	    {
		if(IPPortStatus != IP_PORT_OPEN)
		{
		    pauseSendingToPort = False
		    managePort(IP_PORT_CLOSED, 0)
		    showConnectionProgressBar(False, m_VT[VT_CONNECTION_PROGRESS_BAR])
		}
	    }
	}
    }
}

timeline_event [TL_ANIMATE_PROGRESS_BAR]
{
    if(timeline.repetition <= 255)
    {
	if(IPPortStatus = IP_PORT_OPEN)
	{
	    send_level m_Interface, LVL_CONNECTION_PROGRESS, 255
	}
	else
	{
	    send_level m_Interface, LVL_CONNECTION_PROGRESS, timeline.repetition
	}
    }
    else if(timeline.repetition = 256)
    {
	manageTimeline(END_TIMELINE, TL_ANIMATE_PROGRESS_BAR, tlConnectionTimes, 0, 0, 0, 0)
	
	if(IPPortStatus != IP_PORT_OPEN)
	{
	    pauseSendingToPort = False
	    managePort(IP_PORT_RESET, 0)
	}
    }
}

/*******************************************************************************************
 * Main Program
 *******************************************************************************************/
DEFINE_PROGRAM

if(!IPConnection)	//if this is a 232 connection
{
    wait 200		//periodically recheck the port status
    {
	select
	{
	    active (!portInitialized):
	    {
		call 'CHECK PORT'()
	    }
	    active (!portPassingCommands):
	    {
		call 'CHECK COMMAND PASSING'()
	    }
	}
    }
}

/***********************************************************
 *                     END OF PROGRAM                      *
 *        DO NOT PUT ANY CODE BELOW THIS COMMENT           *
 ***********************************************************/
