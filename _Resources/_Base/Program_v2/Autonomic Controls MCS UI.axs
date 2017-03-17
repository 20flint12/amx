(***********************************************************
    Copyright (c) 2006 Autonomic Controls, Inc.
    
    Mirage Media Control Server
    AMX Sample Application
    User Interface Module

    FILE CREATED ON: August 12, 2006                       

(*  FILE_LAST_MODIFIED_ON: 02/05/2009  			   *)
(***********************************************************)
    REV HISTORY:
	
    02/05/2008  Mirage 2.0
    08/19/2007  Added TP Video and Picture Browsing 
    04/04/2007  Various Bug fixes
    03/04/2007  EHX Orlando
    08/12/2006	Initial
    08/21/2006  Beta 1
    10/20/2006  Refactor Include Files, Generic Media Logic
************************************************************)

MODULE_NAME='Autonomic Controls MCS UI' 
(
    dev vdvMCS,
    dev dvTP,
    char cMCS_SERVER_IP[],
    integer iMCS_ART_PORT
)

(***********************************************************)
(*Database Functions 		   			   *)
(***********************************************************)

#INCLUDE 'UnicodeLib.axi'
#INCLUDE 'Text.axi'


DEFINE_CONSTANT

(***********************************************************)
(*IMPORTANT - Set giMaxListITems constant to the correct   *)
(*number of list items in your touch panel file.           *)
(***********************************************************)
constant giMaxListItems=8	//Set to the number of list items on the UI

//Flags
constant OS_VISTA=1
constant OS_XP=2

constant ALBUMLIST=1
constant ARTISTLIST=2
constant GENRELIST=3
constant TITLELIST=4
constant PLAYLISTS=5
constant NOWPLAYING=6

constant MOVIETITLES=7
constant MOVIEGENRES=8
constant MOVIEPEOPLE=9
constant MOVIEYEARS=10
constant MOVIERATINGS=11
constant MOVIECHAPTERS=12

constant BUTTON_STATE_OFF=0
constant BUTTON_STATE_BROWSE=1
constant BUTTON_STATE_QUEUE=2
constant MEDIA_AUDIO=1
constant MEDIA_MOVIES=2
constant MEDIA_RECORDEDTV=3
constant MEDIA_VIDEOS=4
constant MEDIA_PICTURES=5
constant MEDIA_TV=6
constant MEDIA_RADIO=7
constant MEDIA_OTHER=10

//Debug
constant Debug=2

//transport channels
constant btStop=1
constant btPlayPause=2
constant btFwd=3
constant btRew=4
constant btSkip=5
constant btPrev=6
constant btMute=7
constant btVolUp=8
constant btVolDn=9
constant btVolumeBar=10
constant btRepeat=11
constant btShuffle=12

//pages
constant pgOffline=13
constant pgNowPlaying=14
constant pgBrowse=15
constant pgBrowse_Album=16
constant pgBrowse_Album_List=17
constant pgVolPopup=18
constant btVolPopup=19

//Feedback channels
constant btStatus=20
constant btMetaData1=42
constant btMetaData2=21
constant btMetaData3=23
constant btMetaData4=22
constant btRecord=24
constant btEject=25
constant btConnection=26
constant btRepeatLg=27
constant btShuffleLg=28
constant btPopup=29
constant btTrackNumber=30
constant btTrackLen=31
constant btTrackTime=32
constant btTrackProgressBar=33
constant btBrowseCaption=34
constant btMediaDescription=35
constant btMediaInfo1=36
constant btMediaInfo2=37
constant btMediaInfo3=38
constant btMediaInfo4=39

//Dynamic Art channels
constant btNowPlayingArt=40
constant btBrowseArt=41

//Meda-Labels 
constant btMetaLabel1=43
constant btMetaLabel2=44
constant btMetaLabel3=45
constant btMetaLabel4=46

//Media Info (continued)
constant btMediaInfo5=47
constant btMediaInfo6=48
constant btMediaInfo7=49

//list navigation channels
constant btBack=50
constant btPrevPage=51
constant btNextPage=52
constant btScrollbar=53
constant btListPosition=54
constant btSearch=55
constant btSynopsis=56
constant btChapters=57

//GUI Navigation
constant btShowQueue=64
constant btClearQueue=65
constant btSaveQueue=66
constant btActions=67
constant btZones=68

//Media Library button arrays
constant btAddListToQueue=70
constant btPlayListNow=71
constant btItems=80		//start of list range-1, 1 for each listCount.
constant btAddItemToQueue=90    //start of list range-1, 1 for each listCount.
constant btTitleListTime=100	//start of list range-1, 1 for each listCount.
constant btBrowseAlbumArt=110   //start of list range-1, 1 for each listCount.

//Navigate
constant btStartMCE=200
constant btRecordedTV=201
constant btMusic=202
constant btMyMovies=203
constant btMyVideos=204
constant btMyPictures=205
constant btFavorites=213

//Pandora
constant btMSG1=206
constant btMSG2=207
constant btMSG3=208
constant btMsgCaption=209
constant btMsgText=210
constant btThumbsDown=211
constant btThumbsUp=212


//constant btSearchCategory=210 //211 212 213 214 215


constant btOrb=255

//Feedback Icons.
constant fbLED=2
constant fbStop=1
constant fbPlayPause=5
constant fbPlay=7
constant fbPause=9
constant fbSkip=11
constant fbPrev=15
constant fbFwd=19
constant fbRwd=23
constant fbMute=27
constant fbRepeat=48
constant fbRepeatOff=61
constant fbShuffle=52
constant fbShuffleOff=63
constant fbRepeatLg=31
constant fbShuffleLg=35
constant fbNoIcon=499
constant fbAddItem=40
constant fbDelItem=42
constant fbEditItem=57
constant fbPlayItem=59
constant fbThumbsUp=61
constant fbThumbsDown=63
constant fbRecordOff=44
constant fbRecordOn=46

//Keyboard Inputs
constant kbSearch=1
constant kbUI=2
constant kbSaveQueue=20
constant kbIPAddress=21

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE strHistory
{
    char cmd[256];
    char filters[1024];
    char description[256];
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

volatile integer giOnline=0	     	//MCE Server Online.
volatile integer giMCE=0		//Media Server Started.
volatile integer giEnablePages=0 	//Enables Page Flips.  Turn CH2 on when MCE in use.
volatile integer giVol=0
volatile integer giBusy=0
volatile integer giPlayState=0
volatile integer giMuteState=0
volatile integer giShuffleState=0
volatile integer giRepeatState=0
volatile integer giNowPlayingType=0
volatile integer giLastPush=0
volatile integer giHeld=0
volatile integer giKB=0
volatile integer giBrowsingMedia=0
volatile integer giScroll=0

volatile integer gbFetchingList;
volatile integer gbJump=0;
volatile integer gbVolPopup=0;
volatile integer gbSearch=0;

volatile integer giListCount;
volatile integer giListIndex;
volatile integer giListStartPos;
volatile integer giMoreItems;

volatile integer giPreviousItems;
volatile integer giButtonState;
volatile integer giTrackLen;
volatile integer giTrackTime;
volatile integer giTick;
volatile integer giTotalTracks;
volatile integer giOldTrackCount;

volatile Integer supportsMusic;
volatile Integer supportsVideo;
volatile Integer supportsLiveTv;
volatile Integer supportsRecordedTv;
volatile Integer supportsEpg;
volatile Integer supportsMovies;
volatile Integer supportsPictures;
volatile Integer supportsRadio;
volatile Integer supportsVolume;
volatile Integer supportsMusicOnly;

volatile integer giShuffleEnabled;
volatile integer giRepeatEnabled;

volatile char gsListType[25];
volatile char gsType[25][25];
volatile char gsFilterContext[7][10]={'Music','Movie','Dvr','Video','Picture','Epg','Radio'}
volatile char gsGUID[giMaxListItems+1][64];
volatile char gsItem[giMaxListItems+1][128];
volatile char gsActions[giMaxListItems+1][128];
volatile char gsNowPlayingGUID[64];
volatile char gsBrowse[64];
volatile char gsFilters[1024];
volatile char gsFiltersDesc[1024];
volatile char gsMediaName[128];

volatile char gsMediaRating[6];
volatile char gsMediaDuration[8];
volatile char gsMediaLocation[24];
volatile char gsMediaYear[4];
volatile char gsMediaGenre[64];
volatile char gsMediaDirectors[256];
volatile char gsMediaCast[1024];
volatile char gsMediaSynopsis[5000];

volatile char gsServer[giMaxListItems+1][128];
volatile char gsInstance[giMaxListItems+1][128];
volatile integer giCtlPort[giMaxListItems+1];

volatile char gsMsgActions[3][128];
volatile char gsMsgCaptions[3][64];

strHistory history[6];

volatile char mceinput[16000]
volatile char gsCurrentIPAddress[128];

(***********************************************************)
(*Utility Functions 		   			   *)
(***********************************************************)
define_function doCommand(char cmd[])
{
    giTick=0;  //reset inactivity timer.
    send_command vdvMCS, "cmd"
}

define_function enableButton(integer iChan, integer iEnabled)
{
    off [dvTP,iChan];
    send_command dvTP,"'^SHO-',itoa(iChan),',',itoa(iEnabled)"
}

define_function integer find_last(char sSearch[], char sSeq[])
{
	integer cursor;
	integer pos;
	
	cursor = length_string(sSearch);
	if (cursor > length_string(sSeq)) {
		while (cursor > 0) {
			pos = find_string(sSearch,sSeq,cursor);
			if (pos == 0) {
				cursor = cursor - 1;
			} else {
				cursor = 0;
			}
		}
	}
	
	return pos;
}

define_function killPopup (char popup[])
{
    send_command dvTP,"'@PPK-',popup";
}

define_function msgBox (char msg[])
{
    setText(btPopup,msg);
    send_command dvTP,"'@PPN-MCS_Message'";
}

define_function pageFlip (char newpage[])
{
  if (giEnablePages==1) send_command dvTP, "'@PPN-',newpage";
}



define_function refreshArt(char sResource[])
{
    send_command dvTP,"'^RFR-',sResource"
}

define_function setIcon(integer iButton, integer iIcon)
{
    send_command dvTP,"'^ICO-',itoa(iButton),',1,',itoa(iIcon)"
    send_command dvTP,"'^ICO-',itoa(iButton),',2,',itoa(iIcon+1)"
}

define_function setLevel(integer iChan, integer iLevel)
{
    send_level dvTP, iChan, iLevel;
}

define_function setText(integer iChan, char strMSG[])
{
    //send_command dvTP, "'TEXT',itoa(iChan),'-',strMSG"
    //SEND_COMMAND dvTP,"'^UNI-',itoa(iChan),',0,',UTF8_AmxUnicode (strMSG)"
    SendTextToPanel (dvTP, iChan, strMSG)
}

define_function setLongText(integer iChan, char strMSG[])
{

	char chunk[128];
	
	send_command dvTP,"'TEXT',itoa(iChan),'-',''"
	
	while (length_string(strMSG)>128)
	{
		chunk=left_string(strMsg,128)
		strMSG=mid_string(strMsg,129,length_string(strMSG)-128)
		send_command dvTP,"'^BAT-',itoa(iChan),',0,',chunk"
	}
	
	send_command dvTP,"'^BAT-',itoa(iChan),',0,',strMSG"
}

define_function showPopup (char popup[])
{
    send_command dvTP,"'@PPN-',popup";
}

define_function showMessageBox (char parms[])
{
    char guid[128];
    char caption[128];
    char message[256];
    char timeout[8];
    char action[128];
    char buttonCaption[64];
    char defaultButton[1];
    integer i;
    
    getField(parms,guid);
    getField(parms,caption);
    getField(parms,message);
    getField(parms,timeout);
    
    if (debug>1)
    {
	send_string 0,"'guid: ',guid";
	send_string 0,"'caption: ',caption";
	send_string 0,"'message: ',message";
	send_string 0,"'timeout: ',timeout";
    }
    
    setText(btMsgCaption,caption);
    setText(btMsgText,message);
    
    for (i=1 ; i<=3; i++)
    {
	if (length_string(parms)>0)
	{
	    getField(parms,buttonCaption);
	    getField(parms,action);
	    getField(parms,defaultButton);
	    gsMsgActions[i]=action
	    setText(btMSG1+(i-1),buttonCaption);
	    enableButton(btMSG1+(i-1),1);
	    if (debug>1) send_string 0,"'button',itoa(i),' caption:',buttonCaption";
	    if (debug>1) send_string 0,"'button',itoa(i),' action:',action";
	}
	else
	{
	    if (debug>1) send_string 0,"'disabling button',itoa(btMSG1+i-1)";
	    enableButton(btMSG1+(i-1),0);
	}
    }
    
    showPopup('MCS_Dialog');
}

define_function integer stob(char sBool[])
{
    //string to boolean
    return ((sBool=='True') | (sBool='T'))
}

(***********************************************************)
(*Database Functions 		   			   *)
(***********************************************************)

define_function addToHistory(char cmd[], char filters[], char description[])
{
    integer i;
    for (i=6;i>=2;i--) 
    {
	history[i].cmd = history[i-1].cmd
	history[i].filters = history[i-1].filters
	history[i].description = history[i-1].description
	}
	
    history[1].cmd=cmd;
    history[1].filters=filters;
	history[1].description=description;
	
    enableButton(btBack,(history[2].cmd<>''))
    send_string 0,"'Setting History: ',cmd,' ',filters"
}

define_function applyFilters(char filters[])
{
    char filter[256];
    char cmd[256];
    
    doCommand ("'Set',gsFilterContext[giBrowsingMedia],'Filter Clear'")
        
    gsFilters=''
    GetField (filters,filter)
    while (filter<>'')
    {	
		send_string 0,"'Setting Back Filter: ',filter"
		gsFilters = "gsFilters,filter,' '"
		doCommand ("'Push',gsFilterContext[giBrowsingMedia],'Filter ',filter")
		GetField(filters,filter)
    }
}

define_function browseAlbum(char sGUID[])
{
	setFilter(MEDIA_AUDIO,"'Album=',sGUID",false);
	gsGuid[giMaxListItems+1]=sGUID;
	browseList ("'Titles'", 1, giMaxListItems);
	enableButton(btSynopsis,0);
	pageFlip('MCS_Browse_Album');
	refreshBrowseAlbumDetail("'BrowseAlbum'", btBrowseArt, sGUID);
}

define_function browseMovie(char sGUID[])
{
	setFilter(MEDIA_MOVIES,"'MovieTitle=',sGUID",false);
	gsGUID[giMaxListItems+1]=sGUID;
	doCommand ("'GetMovieProperties ',sGUID");
	browseList ("'MovieChapters'",1,giMaxListItems);
	pageFlip ('MCS_Browse_Movie');
	refreshBrowseAlbumDetail("'BrowseAlbum'", btBrowseArt, sGUID);
	enableButton(btSynopsis,1);
}

define_function browseList(char sList[], integer start, integer count)
{
    char cmd[64];
    
    if (start > 32767) start=1;
    giListStartPos=start;
    giPreviousItems=(start>1);
 
    //setText(btStatus,"'Working...'");
    setText(btListPosition,"''");
    clearList();
    
    cmd = "'Browse',sList,' ',itoa(start),' ',itoa (count)";
    doCommand (cmd);
    addToHistory (cmd, gsFilters, gsFiltersDesc);
} 

define_function browseNowPlaying()
{
	switch (giNowPlayingType)
	{
	    case MEDIA_AUDIO:	browseAlbum (gsNowPlayingGUID)
	    case MEDIA_MOVIES:	browseMovie (gsNowPlayingGUID)
	}
}		
			
define_function getField(char in[],char field[])
{
    integer ibyte;
    integer iInString;
    integer iInEscape;
    char sGather[10000];
    
    iInString=0;
    iInEscape=0;
    
    
    While (left_string(In,1)=32) {ibyte=get_buffer_char(In);}
 
    iByte=1;
    While (ibyte<>0)
    {
		ibyte=get_buffer_char(In);
		
		switch(iByte)
		{
			//term on space, unless in a quoted string
			case 32: //space
			{	if (iInString=0)
				{	
				    ibyte=0;
				}
				else sGather = "sGather,32"; 
			}
			
			//handle quotes
			case 34: //quote (")
			{	if (iInString=1)
				{   //escape embedded quote
					if (iInEscape=1)
					{    sGather = "sGather,34";
						 iInEscape=0;
					}
					//end quote.
					else
					{    ibyte=0;
					}
				}
				else
				{   //begin quote 
					iInString=1;
				}
			}
						
			//escape character
			case 92: //escape character ('\')
			{   if (iInEscape=1)
				{   
				    sGather = "sGather,92";
				    iInEscape=0;
				}
				else if (iInString=1)
				{   
				    iInEscape=1;
				}
			}
			
			case 110:  //embedded carrage return
			{   
			    if (iInEscape=1)
			    {
				sGather = "sGather,13,10";
				iInEscape=0;
			    }
			    else
			    {
				sGather = "sGather,110";
			    }
			}
			
			default:
			{	if (ibyte<>0)
				{					
					sGather="sGather,ibyte"; 
					iInEscape=0;
				}
			}
		}
    } 
    field=sGather;
}

define_function integer getListItemsCount(char In[])
{
    integer iPos;
    char sCount[5];
	
    iPos = find_string(In,'Total=',1);
    
    if (iPos <> 0 && (length_string(In) > iPos+5))
    {	
	sCount = mid_string(In,iPos+6,length_string(In)-iPos+5);
	return (atoi(sCount));
    }
    else return (0);
}

define_function goToNextPage()
{
    integer start;
    integer count;
    
    start = giListStartPos + giMaxListItems;
    if (start > giListCount) start = giListCount;
    count = giMaxListItems;
    if (start = giListcount) count = 1;
    BrowseList (gsBrowse, start, count);
}

define_function goToPreviousPage()
{
    integer start;
    integer count;
    
    start = giListStartPos-giMaxListItems;
    if (start > 32767 || start < 1) start = 1;
    count = giMaxListItems;
    browseList (gsBrowse, start, count);
}

define_function jumpToItem(char sGUID[])  //jumps to an item in the queue
{
    char cmd[256];
    cmd = "'JumpToNowPlayingItem ',sGUID";
    doCommand (cmd);
}

define_function parseServerName(char sName[])
{
	char newName[128];
	integer t1;
	integer t2;
	
	t1 = find_string(sName,'@',1);
	t2 = find_last(sName,'@');
	
	if (t1>0) {
		newName = left_string(sName,t1-1);
		newName = "newName,' on '";
		newName = "newName, mid_string(sName,t2+1,length_string(sName) - t2)";
	} else {
		newName = sName;
	};
	
	sName = newName;
}

define_function parseStateChange(char datum[])
{
    char session[128]
    char parm[64]
    char val[1024]
    integer t1
    integer t2
    integer t3
	
    t1 = find_string(datum,' ',1)
    t2 = find_string(datum,' ',t1+1)
    t3 = find_string(datum,'=',t2+1)
    
    session = mid_string(datum,t1+1,t2-t1-1)
    parm = mid_string(datum,t2+1,t3-t2-1)
    val = right_string(datum,length_string(datum)-t3)
    

    switch (parm)
    {   
	case 'BaseWebUrl':
	      iMCS_ART_PORT = atoi(right_string(val, length_string(val)-find_last(val,':')));
	      setDynamicImages();
			
	case 'ContextMenu':
		enableButton(btActions,stob(val));
	
	case 'Running': 
		{
			if (stob(val)=1) 
			{	
			    MCS_onStart(); 
			}
			else 
			{
			    MCS_onStop();
			}
		}
    
	case 'MediaControl':
	{   switch (val)
		{   
		    case 'Stop': 	giPlayState=fbStop
		    case 'Play': 	giPlayState=fbPlay
		    case 'Pause':	giPlayState=fbPause
		    case 'FF1': 	giPlayState=fbFwd
		    case 'FF2': 	giPlayState=fbFwd
		    case 'FF3': 	giPlayState=fbFwd
		    case 'Rewind1': 	giPlayState=fbRwd
		    case 'Rewind2': 	giPlayState=fbRwd
		    case 'Rewind3': 	giPlayState=fbRwd
		}
		refreshTransport();
	}

	case 'MetaData1': 	setText(btMetaData1, val); 
	case 'MetaData2': 	setText(btMetaData2, val); 
	case 'MetaData3': 	setText(btMetaData3, val); 
	case 'MetaData4': 	setText(btMetaData4, val); 
	
	case 'MetaLabel1': 	setText(btMetaLabel1, val); 
	case 'MetaLabel2': 	setText(btMetaLabel2, val); 
	case 'MetaLabel3': 	setText(btMetaLabel3, val); 
	case 'MetaLabel4': 	setText(btMetaLabel4, val); 
			
	case 'Mute': 
	{   giMuteState=stob(val)
		setIcon(btMute,fbMute+((giMuteState==True)*2))
	}
		
	case 'Repeat': 
	{   giRepeatState=stob(val)
	    setIcon(btRepeat,fbRepeat+((giRepeatState==True)*2))
	    setIcon(btRepeatLg,fbRepeatLg+((giRepeatState==True)*2))
	} 

	case 'RepeatAvailable':
	{
	    giRepeatEnabled = stob(val);
	    if (giRepeatEnabled)
	    {
		setIcon(btRepeat,fbRepeat+((giRepeatState==True)*2))
	    }
	    else
	    {
		setIcon(btRepeat,fbRepeatOff)
	    }
	}

	case 'Recording':
	{
	    setIcon(btRecord,fbRecordOff+((val=='True')*2));
	}
	
	
	case 'Shuffle': 
	{   giShuffleState=stob(val)
		setIcon(btShuffle,fbShuffle+((giShuffleState==True)*2))
		setIcon(btShuffleLg,fbShuffleLg+((giShuffleState==True)*2))
	}
	
	case 'ShuffleAvailable':
	{
	    giShuffleEnabled = stob(val);
	    if (giShuffleEnabled)
	    {
		setIcon(btShuffle,fbShuffle+((giShuffleState==True)*2))
	    }
	    else
	    {
		setIcon(btShuffle,fbShuffleOff)
	    }
	}
	
	case 'SupportsMusic':		supportsMusic = stob(val);
	case 'SupportsVideos':		supportsVideo = stob(val);
	case 'SupportsLiveTv':		supportsLiveTv = stob(val);
	case 'SupportsRecordedTv':	supportsRecordedTv = stob(val);
	case 'SupportsEpg':		supportsEpg = stob(val);
	case 'SupportsMovies':		supportsMovies = stob(val);
	case 'SupportsPictures':	supportsPictures = stob(val);
	case 'SupportsRadio':		supportsRadio = stob(val);
	case 'SupportsVolumeUpDown':	supportsVolume = stob(val);
	case 'SupportsStatus':		updateUICapibilities(); 
	
	case 'ThumbsDown':
	    send_string 0,"'ThumbsDown=',val";
	    if (val<>'-1')
	    {
		enableButton(btThumbsDown,1);
		if (val=='1') on [dvTP,btThumbsDown] else off [dvTP,btThumbsDown];
	    }
	    else
	    {
		enableButton(btThumbsDown,0);
	    }
	
	case 'ThumbsUp':
	    send_string 0,"'ThumbsUp=',val";
	    if (val<>'-1')
	    {
		enableButton(btThumbsUp,1);
		if (val=='1') on [dvTP,btThumbsUp] else off [dvTP,btThumbsUp];
	    }
	    else
	    {
		enableButton(btThumbsUp,0);
	    }
	

	case 'MediaArtChanged': refreshNowPlayingArt();
	
	case 'NowPlayingGuid': 
	{	
	    if (left_string(val,1)='{') val=mid_string(val,2,length_string(val)-2)
	    gsNowPlayingGUID=val;
	}
	
	case 'NowPlayingType':	
	{
		switch(val)
		{
			case 'Music':		
			{
			    giNowPlayingType=MEDIA_AUDIO
			    if (supportsMusicOnly = false) doCommand('navigate nowplaying');
			}
			
			case 'Movie':		giNowPlayingType=MEDIA_MOVIES
			case 'Dvr':		giNowPlayingType=MEDIA_RECORDEDTV
			case 'Pictures':	giNowPlayingType=MEDIA_PICTURES
			case 'Video':		giNowPlayingType=MEDIA_VIDEOS
			case 'LiveTv':		giNowPlayingType=MEDIA_OTHER
			default:		giNowPlayingType=MEDIA_OTHER
		}
		
	}
	
	//case 'MediaName':   setText(btMetaData3,val);

	case 'TrackTime': SetTrackTime(val);
	
	case 'TrackDuration': setTrackLen(val);
	
	//case 'ArtistName': setText(btMetaData3,val);
	
	case 'TrackNumber': setText(btTrackNumber,val);
	
	//case 'TrackName': setText(btMetaData4, val);
	
	case 'Volume': 
	{   giVol=atoi(val)
		if (!giBusy) setLevel(btVolumeBar,giVol);
	}
	
	case 'ParentalAdvisoryRating': {}//setText(btMetaData3,val);
	
	case 'TotalTracks': 
	{
		giTotalTracks=atoi(val);
		if (giTotalTracks > 0) 
		{
			msgBox("itoa(giTotalTracks),' Песня в очереди'");
			if (gbJump=1)  //User Initiated a Play Now.
			{	
			 doCommand ("'JumpToNowPlayingItem ',itoa(giTotalTracks)");
			 doCommand ("'Mute False'");
			 gbJump=0;
			}
		}
	}
	
	case 'UI':
	{
	    char type[16];
	    type = remove_string(val,' ',1);
	    switch(type)
	    {
		case 'Clear ':
		{
		    killPopup('MCS_Dialog');
		}

		case 'InputBox ':
		{
		    getKBInputUI(val);
		}
		
		case 'MessageBox ':
		{
		    showMessageBox(val);
		}
		
		case 'Navigate ':
		{
		    pageFlip('MCS_Now_Playing');
		}
		
		case 'StatusMessage ':
		{
		    msgBox(mid_string(val,2,length_string(val)-2));
		}
	    }
	}
    }
}

define_function parseProperty(char datum[])
{
	char name[64];
	char val[10000];
	
	name=remove_string(datum,' ',1)
	name=remove_string(datum,'=',1)
	if (length_string(name)>0)
	{
		getField(datum,val)
	
		switch (name)
		{
			case 'Minutes=': 	gsMediaDuration=val;
			case 'Location=': 	gsMediaLocation=val;
			case 'Rating=':		gsMediaRating=val;
			case 'Year=':		gsMediaYear=val;
			case 'Genre=':		gsMediaGenre=val;
			case 'Directors=':	gsMediaDirectors=val;
			case 'Actors=':		gsMediaCast=val;
			case 'Synopsis=':	gsMediaSynopsis=val;
			case 'CanEject=':		
			{
				enableButton(btEject,stob(val))
				displayMovieInfo()
			}
		}
	}
}

define_function playItem(char type[], char item[], integer enqueue)
{
    char cmd[512];
		    
    giOldTrackCount = giTotalTracks;
    
    //translations
	switch (type) 
	{
		case 'PictureFolder':
		case 'PictureFile':		type = 'SlideShow'
		case 'VideoFolder':		
		case 'VideoFile':		type = 'Video'
		default:{}
	}
	
	cmd = "'Play',type,' ',item"
	
	if (enqueue = false)
	{
	    cmd = "cmd,' False'";
	}
	else if (giBrowsingMedia == MEDIA_AUDIO && giNowPlayingType == MEDIA_AUDIO && giOldTrackCount>0)
	{
		cmd = "cmd,' True'"
		gbJump = !enqueue
		if (gbJump) doCommand ("'Mute True'");
	} 
	else
	{
		gbJump=0;
	}
		
    doCommand (cmd);
}

define_function processListEnd()
{
    integer i;
    
    enableButton(btNextPage,(giMoreItems || giPreviousItems))
    enableButton(btPrevPage,(giMoreItems || giPreviousItems))
    enableButton(btScrollbar,(giMoreItems || giPreviousItems))
        
	for (i=giListIndex+1;i<=giMaxListItems;i++)
	{
		enableButton (btItems+i,0);
		enableButton (btAddItemToQueue+i,0);
		enableButton (btBrowseAlbumArt+i,0);
		enableButton (btTitleListTime+i,0);
	}

    gbFetchingList=0;
}

define_function processListItem(char In[])
{
    char sType[25];
    char sPort[5];
    char sTime[8];
    char sTrash[64];
	
    giListIndex=giListIndex+1;
    
    In = right_string(In,length_string(In)-2);

    getField(In,gsType[giListIndex]);  
    getField(In,gsGuid[giListIndex]);
    getField(In,gsItem[giListIndex]); 

    //fix guid
    if (left_string(gsGUID[giListIndex],1)='{')
    {
	gsGUID[giListIndex]=mid_string(gsGUID[giListIndex],2,length_string(gsGUID[giListIndex])-2)
    }
  
    //get time for titles
    if (gsType[giListIndex] == 'Title') 
    {
	GetField(In,stime);
	if (left_string(sTime,3)='00:') sTime = mid_string(sTime,4,5);
	if (left_string(sTime,1)='0') sTime = mid_string(sTime,2,4);
    }
    else
    {
	sTime='';
    }
    
    //get instance information
    if (gsType[giListIndex] == 'InstanceInfoEx') 
    {
	getField(In, sPort);
	getField(In, sTrash);
	getField(In, gsServer[giListIndex]);
	giCtlPort[giListIndex] = atoi(sPort);
	gsInstance[giListIndex] = left_string(gsItem[giListIndex],find_last(gsItem[giListIndex],'@')-1);
	parseServerName(gsItem[giListIndex]);
	if (debug>0) send_string 0,"'Server Name:   ', gsItem[giListIndex]";
	if (debug>0) send_string 0,"'Server IP:     ', gsServer[giListIndex]";
	if (debug>0) send_string 0,"'Instance:      ', gsInstance[giListIndex]";
	if (debug>0) send_string 0,"'Port:          ', itoa(giCtlPort[giListIndex])";
    }
	
    //capture fourth field (title) for pictures and videos
    if (gsType[giListIndex] == 'PictureFile' || gsType[giListIndex] == 'VideoFile' || gsType[giListIndex] == 'PictureFolder' || gsType[giListIndex] == 'VideoFolder') 
    {
	getField(In,gsItem[giListIndex]);
    }
	
    //Capture Program Information for EPG
    if (gsType[giListIndex] == 'EpgStation') 
    {
	sTime = gsItem[giListIndex];
	getField(In,gsItem[giListIndex]);  //Channel
	getField(In,sTrash); //Skip Station Description.
	getField(In,sTrash);
	gsItem[giListIndex] = "gsItem[giListIndex], ' ', sTrash";
    }
    
    //Capture Radio Station Information
    if (gsType[giListIndex] == 'RadioStation')
    {
	char description[128];
	char icon[1];
	char action[128];

	getField(In,description);
	getField(In,icon);
	getField(In,action);
	
	if (icon=='6') 
	{
	    enableButton(btAddItemToQueue+giListIndex,1);
	    setIcon(btAddItemToQueue+giListIndex,fbEditItem);
	}
	
	if (action<>'') gsActions[giListIndex] = action;
    }
    else
    {
	gsActions[giListIndex] = '';
    }
		
    setText(btItems+giListIndex,gsItem[giListIndex])
    setText(btTitleListTime+giListIndex,sTime)
    
    enableButton(btItems+giListIndex,1)
    enableButton(btTitleListTime+giListIndex,1)
    enableButton(btAddItemToQueue+giListIndex,1)
    enableButton(btBrowseAlbumArt+giListIndex,(giButtonState>0))
        
    //set album artistlist
    refreshBrowseAlbumArt("'BrowseAlbumList',itoa(giListIndex)",btBrowseAlbumArt+giListIndex,gsGUID[giListIndex])
}

define_function	processNewList(Char In[])
{
    char sToken[128];
    integer ilast;
    integer addicon;
        
    //determine the type of list
    sToken = mid_string(In,6,length_string(In)-5);
    gsBrowse = left_string(sToken, find_string(sToken,'Total',1)-2);
    
    //page flips.
    addicon=fbAddItem;
    switch (gsBrowse)
    {
		case 'DvrTitles':		
		case 'Artists':			
		case 'Genres':			
		case 'Albums':			pageFlip('MCS_Browse_AlbumList');
						
		case 'Playlists':		addicon=fbAddItem;
						pageFlip('MCS_Browse');
						enableButton(btClearQueue,0);
						
		case 'NowPlaying': 		pageFlip('MCS_Browse');
						enableButton(btClearQueue,1);
						enableButton(btSaveQueue,1);
						addicon = fbDelItem;
						gsListType = 'NowPlaying';
						setText(btStatus,'Очередь');
						if (giListCount==0) clearFeedback();
				   
		case 'Titles':	   		{}
		
		case 'MovieChapters':		addicon=fbPlayItem;
		
		case 'RadioStations':		addicon=fbNoIcon;
						pageFlip('MCS_Browse_AlbumList');
						
		case 'MovieTitles':								
		case 'Pictures':		
		case 'Videos':			addicon=fbPlayItem;
						pageFlip('MCS_Browse_AlbumList');
				
		default:			addicon=fbNoIcon;
						pageFlip('MCS_Browse');
						enableButton(btClearQueue,0);
						
    }
    
    //Set Add / Del button icons
    setQueueButtons(addIcon);
    
    //set flags 
    giListCount = GetListItemsCount(In);
    gbFetchingList=1;
    giListIndex=0;
    
    //mark position
    ilast=giListStartPos+giMaxListItems-1;
    if (ilast>giListCount) {ilast=giListCount};
    
    //scroll bar feedback
    if (giListCount>0)
    {	setText(btListPosition,"itoa(giListStartPos),'-',itoa(ilast),' с ',itoa(giListCount)")}
    else
    {	setText(btListPosition,'')
	setText(btStatus,'Ничего не найдено')
    }
	
    if (giListcount <> 0)
    {
	setLevel(btScrollbar,((((giListStartPos-1)*100)/giListCount)));
    }
		    
    if (gsBrowse == 'NowPlaying') 
    {   setText(btStatus,'Очередь');
		gsListType='NowPlaying';
		giButtonState = BUTTON_STATE_QUEUE;
		if (giListCount==0){clearFeedback();}
    }
	
    else if (find_string(gsBrowse,'Filter',1))
    {	giButtonState = BUTTON_STATE_OFF;
    }
    
    else if (find_string(gsBrowse,'Instance',1))
    {	setText(btStatus,'Источник');
	    giButtonState = BUTTON_STATE_OFF;
    }

    else if (find_string(gsBrowse,'Epg',1))
    {	setText(btStatus,'Browsing Live TV');
	    giButtonState = BUTTON_STATE_OFF;
    }
	
    else
    {   
	giButtonState = BUTTON_STATE_BROWSE;
	    if (gsFiltersDesc == '') 
	    {
		setText(btStatus,gsBrowse);
	    }
	    else 
	    {
		setText(btStatus,gsFiltersDesc);
	    }
    }
}

define_function processToken (char datum[])  
{
	
	if (Debug>0) send_string 0,"'IN: ',datum"
	
    select
    {
		active (left_string(datum,12) == 'TestEncoding'):
		{   setText(btStatus,datum);
		}
	
		active (left_string(datum,5) == 'Begin'):	//List Token.
		{	ProcessNewList(datum);
		}
			
		active (left_string(datum,2)=='  '):
		{	If (gbFetchingList) ProcessListItem(datum);	//List Item.
		}
			
		active (left_string(datum,3)='End'):		//End List 
		{	giMoreItems = (find_string(datum,' More',1) > 0)
			processListEnd()
		}
		
		active (left_string(datum,13)='MovieProperty'): parseProperty(datum)

		active (find_string(datum, 'StateChanged ',1)>0 || find_string(datum, 'ReportState ',1)>0):
		{	parseStateChange (datum)
		}
			
		active (find_string(datum, 'PushMusicFilter',1)>0 || find_string(datum, 'PushMovieFilter',1)>0 || find_string(datum, 'PushDvrFilter',1)>0 || find_string(datum, 'PushRadioFilter',1)>0):
		{	
			//setFilterDescription(datum);
			if (gbSearch=1)
			{   
			    browseList(gsBrowse,1,giMaxListItems);
			    gbSearch=0
			}
		}
		
		active (find_string(datum, 'SavePlaylist Ok',1)>0):
		{	msgBox ('Плейлист сохранен.')
		}
		
		active (left_string(datum,28)='Error: Registration required'):
		{	setText(btStatus,'Ошибка: Нет лицензии.'); // Error: Unlicensed, Registration Required.
		}
	
		active (find_string(datum, 'Error: MCE shell not started.',1)>0):
		{    off[vdvMCS,1]
		}
		
		active (find_string(datum,'Error: No Instances',1)>0): 
		{   off[vdvMCS,1]
			setText (btStatus,datum)
			enableButton (btStartMCE,1)
		}
		
		active (find_string(datum,'Error: ',1)>0): 
		{   //setText (btStatus,datum)
		}
    }
}

define_function recallHistory()
{
    integer i;
    char trash[48];
    char count[4];
    
    if (history[2].cmd<>'') 
    {
		clearList()
		
		applyFilters(history[2].filters)
		doCommand(history[2].cmd)
		gsFiltersDesc = history[2].description
		
		trash=history[2].cmd
		count = remove_string(trash,' ',1)
		count = remove_string(trash,' ',1)
		giListStartPos=atoi(count)
		
			
		for (i=1;i<=5;i++) 
		{
			history[i].cmd = history[i+1].cmd
			history[i].filters = history[i+1].filters
			history[i].description = history[i+1].description
		}
		
		history[6].cmd = '';
		history[6].filters = '';
		history[6].description = '';
    }
   
    enableButton(btBack,history[2].cmd<>'');
}

define_function removeItem(char sGUID[])  //removes a title from the queue
{
    char cmd[256];
    cmd = "'RemoveNowPlayingItem ',sGUID";
    doCommand (cmd);
    msgBox ('Песня удалена с очереди')
    BrowseList(gsBrowse,giListStartPos,giMaxListItems);
}


define_function searchMedia(char search[])
{
    gbSearch=1		//will trigger a browse when PushMediaFilter OK is received.
    setFilter(giBrowsingMedia,"'Search="',search,'*"'",false)
    send_string 0,"search";
}

define_function setFilter(integer context, char filter[],integer append)
{
    if (!append)
    {	
	doCommand("'Set',gsFilterContext[context],'Filter Clear'")
	gsFilters=''
    }
    
    if (filter <> '') 
	{
	    doCommand ("'Push',gsFilterContext[context],'Filter ', filter")
	    gsFilters = "gsFilters, ' ', filter"
	}
}

define_function updateUICapibilities()
{             
	supportsMusicOnly = (supportsMusic && supportsVideo = false && supportsRecordedTv = false && supportsMovies = false && supportsPictures = false);
	if (supportsMusicOnly=false) 
	{
	    pageFlip ('MCS_Home'); 
	    setText(btMusic,'МУЗЫКА');
	    setText(btRecordedTV,'ЗАПИСАНОЕ ТВ');
	    setText(btMyMovies,'ФИЛЬМЫ');
	    setText(btMyVideos,'ВИДЕО');
	    setText(btMyPictures,'КАРТИНКИ');
	    enableButton(btMyPictures,1);
	    
	}
	else
	{
	    setText(btMusic,'Альбом');
	    setText(btRecordedTV,'Артист');
	    setText(btMyMovies,'Жанры');
	    setText(btMyVideos,'Плейлист');
	    if (supportsRadio = true) 
	    {
		enableButton(btMyPictures,1);
		setText(btMyPictures,'Радио');
	    }
	    else
	    {
		enableButton(btMyPictures,0);
	    }
	    
	    
	    pageFlip('MCS_Now_Playing');
	    giBrowsingMedia=MEDIA_AUDIO;
	}
}


(***********************************************************)
(*User Interface Functions				   *)
(***********************************************************)
define_function browseFilters(integer chan)
{
	enableButton(btClearQueue,0);
	enableButton(btSaveQueue,0);
	
	switch (chan)
	{
		case btMusic:	{   if (supportsMusicOnly=true)
				    {
					gsFiltersDesc='Albums';
					doCommand('SetMusicFilter Clear');
					browseList ("'Albums'", 1, giMaxListItems);
					setMediaMode(MEDIA_AUDIO);
					enableButton(btSearch,1);
				    }
				    else
				    {
					gsFiltersDesc='Music';
					setText(btStatus,gsFiltersDesc);
					processToken ('BeginMusicFilters Total=4');
					processToken ('  MusicFilter {1} Albums');
					processToken ('  MusicFilter {1} Artists');
					processToken ('  MusicFilter {1} Genres');
					processToken ('  MusicFilter {1} Playlists');
					if (supportsRadio = true) {processToken ('  MusicFilter {1} Radio')};
					processToken ('EndMusicFilters NoMore');
					setMediaMode(MEDIA_AUDIO);
					enableButton(btSearch,0);
				    }
					
				}
							
		case btMyMovies:{   if (supportsMusicOnly=true)
				    {
					gsFiltersDesc='Genres';
					doCommand('SetMusicFilter Clear');
					browseList ("'Genres'", 1, giMaxListItems);
					setMediaMode(MEDIA_AUDIO);
					enableButton(btSearch,1);
				    }
				    else
				    {
					gsFiltersDesc='Movies';
					setText(btStatus,gsFiltersDesc);
					processToken ('BeginMovieFilters Total=5')
					processToken ('  MovieFilter 0 Titles')
					processToken ('  MovieFilter 0 Genres')
					processToken ('  MovieFilter 0 People')
					processToken ('  MovieFilter 0 Ratings')
					processToken ('  MovieFilter 0 Years')
					processToken ('EndMovieFilters NoMore')
					setMediaMode(MEDIA_MOVIES)
					enableButton(btSearch,0);
				    }
				}
							
		case btRecordedTV:{  if (supportsMusicOnly=true)
					{
					    gsFiltersDesc='Artists';
					    doCommand('SetMusicFilter Clear');
					    browseList ("'Artists'", 1, giMaxListItems);
					    setMediaMode(MEDIA_AUDIO);
					    enableButton(btSearch,1);
					}
					else
					{
					    gsFiltersDesc='Recorded TV';
					    setText(btStatus,gsFiltersDesc);
					    processToken ('BeginDVRFilters Total=5')
					    processToken ('  DVRFilter 0 Titles')
					    processToken ('  DVRFilter 0 Genres')
					    processToken ('  DVRFilter 0 Ratings')
					    processToken ('  DVRFilter 0 Recorded Date')
					    processToken ('  DVRFilter 0 Stations')
					    processToken ('EndDVRTitles NoMore')
					    setMediaMode(MEDIA_RECORDEDTV)
					    enableButton(btSearch,0);
					}
				    }
		
		case btMyPictures:
				{   if (supportsMusicOnly=true)
				    {
					gsFiltersDesc='Radio Stations';
					doCommand('SetRadioFilter Clear');
					pageFlip('MCS_Browse')
					browseList ("'RadioSources'", 1, giMaxListItems)
					enableButton(btSearch,1);
					setMediaMode(MEDIA_RADIO);
				    }
				    else
				    {
					gsFiltersDesc='Pictures';
					browseList('Pictures',1,giMaxListItems);
					setMediaMode(MEDIA_PICTURES)
					enableButton(btSearch,0);
				    }
				}
												
		case btMyVideos:{   if (supportsMusicOnly=true)
				    {
					gsFiltersDesc='Playlists';
					doCommand('SetMusicFilter Clear');
					browseList ("'Playlists'", 1, giMaxListItems);
					setMediaMode(MEDIA_AUDIO);
					enableButton(btSearch,0);
				    }
				    else
				    {
					gsFiltersDesc='Videos';
					browseList('Videos',1,giMaxListItems);
					setMediaMode(MEDIA_VIDEOS)
					enableButton(btSearch,0);
				    }
				}
		
		case btFavorites:{ 	gsFiltersDesc='Favorites';
					browseList('Favorites',1,giMaxListItems);
					setMediaMode(MEDIA_AUDIO);
					enableButton(btSearch,0);
				 }
							
	}
}

define_function clearAll()
{
    clearList();
    clearFeedback();
}

define_function clearFeedback()
{
    setText(btMetaData2,'');
    setText(btMetaData4,'');
    setText(btMetaData3,'');
    setText(btTrackNumber,'');
    setText(btTrackLen,'');
    setText(btTrackTime,'');
    setLevel(btTrackProgressBar,0);
    
}

define_function clearList()
{
    integer i;
    for (i=1;i<=giMaxListItems;i=i+1)
    {	
	enableButton(btItems+i,0)
	enableButton(btAddItemToQueue+i,0)
	enableButton(btTitleListTime+i,0)
	enableButton(btClearQueue,0);
	enableButton(btSaveQueue,0);
   }
    
    //enableButton(btSearch,0)
}

define_function displayMovieInfo()
{
	setText(btMediaInfo1,gsMediaGenre);
	setText(btMediaInfo2,gsMediaRating);
	setText(btMediaInfo3,gsMediaDuration);
	setText(btMediaInfo4,gsMediaYear);
	setText(btMediaInfo5,gsMediaCast);
	setLongText (btMediaInfo6,gsMediaSynopsis);
}

define_function getKBInput (integer iKB)
{
    char sPrompt[64];
        
    switch (iKB)
    {
	case kbSearch: 
	{
	    sPrompt= "'Search: ', gsFiltersDesc";
	    setText(btMsgText,'Введите первые буквы композиции, которую ищите и нажмите Enter.'); // Enter the first few letters of the item you want to find and press enter
	}
	
	case kbSaveQueue: 
	{
	    sPrompt= 'Save Current Queue As...';
	    setText(btMsgText,'Выберите песни в Ваш новый плейлист');  //Enter a title for your new playlist
	}
    }
	
    giKB=iKB;
    send_command dvTP,"'@PPN-_keyboard'"
}

define_function getKBInputUI (char parms[])
{
    char guid[64];
    char caption[128];
    char message[256];
    char timeout[8];
    char value[128];
    
    getField(parms,guid);
    getField(parms,caption);
    getField(parms,message);
    getField(parms,timeout);
    getField(parms,value);
    getField(parms,gsMsgActions[1]);
        
    setText(btMsgText,message);
    if (caption<>"") send_command dvTP,"'@AKB-;',caption"
    giKB=kbUI;
}

define_function getNumberInput (char sDefault[], char sprompt[])
{
	send_command dvTP,"'@EKP-',sDefault,';',sprompt";
}

define_function listSelect(integer listIndex)
{
    char cmd[256];
    char sBrowseList[64];
	
    gsListType=gsType[listindex];
    gsFiltersDesc = gsItem[listindex];

    if (gsActions[listIndex]<>'') 
    {
	doCommand(gsActions[listIndex]);
    }
    
    
    switch(gsType[listindex])
    {
		case 'InstanceInfoEx':
		{		
			gsItem[giMaxListItems+1] = "'Connected to ',gsItem[listIndex]";
			if (gsServer[listIndex]='127.0.0.1') { // local host
				doCommand("'SetInstance ', gsInstance[listIndex]");
				MCS_onConnect();
			} else {
				gsServer[giMaxListItems+1] = gsServer[listIndex];   //save current server
				gsCurrentIPAddress = gsServer[listIndex];
				gsInstance[giMaxListItems+1] = gsInstance[listIndex]; //save current instance
				cmd = "'Connect:',gsServer[listIndex],':',itoa(giCtlPort[listIndex])";
				setText (btStatus,'Идет соединение: пожалуйста, подождите ...') // Attempting to connect: please wait...
				enableButton (btStartMCE,0)
				if (debug>0) send_string 0,cmd;
				doCommand(cmd);
			}
		}
		
		case 'InstanceInfo':
		{
			gsItem[giMaxListItems+1] = "'Connected to ',gsItem[listIndex]";
			doCommand ("'SetInstance ', gsItem[listIndex]");
			MCS_onConnect();
		}
					
		case 'MusicFilter':
		{
			doCommand('SetMusicFilter Clear');
			gsFiltersDesc = gsItem[listindex];
			if (gsItem[listIndex]='Albums')
			{
			    pageFlip('MCS_Browse_AlbumList')
			    browseList ("'Albums'", 1, giMaxListItems)
			    enableButton(btSearch,1);
			}
			else if (gsItem[listIndex]='Radio')
			{
			    doCommand('SetRadioFilter Clear');
			    pageFlip('MCS_Browse')
			    browseList ("'RadioSources'", 1, giMaxListItems)
			    enableButton(btSearch,0);
			}
			else
			{
				pageFlip('MCS_Browse')
				browseList (gsItem[listindex], 1, giMaxListItems)
				enableButton(btSearch,1);
			}
		}
		
		case 'MovieFilter':
		{
			doCommand('SetMovieFilter Clear')
			gsFiltersDesc = gsItem[listindex]
			if (gsItem[listIndex]='Titles')
			{
				pageFlip('MCS_Browse_AlbumList')
				browseList ("'MovieTitles'", 1, giMaxListItems)
				enableButton(btSearch,1);
			}
			else
			{
				pageFlip('MCS_Browse')
				sBrowseList = "'Movie',gsItem[listIndex]"
				browseList (sBrowseList, 1, giMaxListItems)
				enableButton(btSearch,0);
			}
		}
		
		case 'DVRFilter':
		{
			doCommand("'SetDVRFilter Clear'")
			gsFiltersDesc = gsItem[listindex]
			sBrowseList = "'DVR',gsItem[listIndex]"
			if (sBrowseList = 'DVRRecorded') sBrowseList='DVRRecordDates';
			if (sBrowseList = 'DVRTitles')
			{
				pageFlip('MCS_Browse_AlbumList')
				browseList ('DVRTitles', 1, giMaxListItems)
				enableButton(btSearch,1);
			}
			else
			{
				pageFlip('MCS_Browse')
				browseList (sBrowseList, 1, giMaxListItems)
				enableButton(btSearch,0);
			}
		}

		case 'PictureFolder':
		{
			setFilter (MEDIA_PICTURES,"'PictureFolder=',gsGuid[listIndex]",false);
			browseList('Pictures', 1,  giMaxListItems);
			pageFlip('MCS_Browse_AlbumList');
			enableButton(btSearch,0);
		}
		
		case 'PictureFile':
		{
			playItem('SlideShow', gsGuid[listIndex], false);
		}	
						
		case 'VideoFolder':
		{
			setFilter (MEDIA_VIDEOS,"'VideoFolder=',gsGuid[listIndex]",false);
			browseList('Videos', 1, giMaxListItems);
			pageFlip('MCS_Browse_AlbumList');
			enableButton(btSearch,0);
		}
			
		case 'VideoFile':
		{
			playItem('Video',gsGuid[listIndex],false);
		}
				
		case 'Genre':
		{   
		    setFilter (MEDIA_AUDIO,"'Genre=',gsGUID[listIndex]",false)
		    browseList ("'Albums'", 1, giMaxListItems)
		    if (find_string(gsItem[listindex],"'All Songs'",1)>0)
		    {
			pageFlip('MCS_Browse')
		    }
		    else
		    {
			pageFlip('MCS_Browse_AlbumList')
		    }
		    enableButton(btSearch,1);
		}
			
		case 'Artist':
		{   
		    setFilter (MEDIA_AUDIO,"'Artist=',gsGUID[listindex]",false)
		    browseList ("'Albums'", 1, giMaxListItems)
		    if (find_string(gsItem[listindex],"'All Songs'",1)>0)
		    {
			pageFlip('MCS_Browse')
		    }
		    else
		    {
			pageFlip('MCS_Browse_AlbumList')
		    }
		    enableButton(btSearch,1);
		}
			
		case 'Album':	browseAlbum(gsGuid[listIndex])
				enableButton(btSearch,1);
			
		case 'Playlist':
		{   
		    setFilter(MEDIA_AUDIO,"'Playlist=',gsGUID[listindex]",false)
		    browseList ("'Titles'", 1, giMaxListItems);
		    pageFlip('MCS_Browse')
		    enableButton(btSearch,1);
		}
			
		case 'Title':
		{ 
		    if (giButtonState = BUTTON_STATE_QUEUE)
		    {   
			cmd = "'JumpToNowPlayingItem ',gsGUID[listindex]"
			doCommand(cmd);
		    }
		    else
		    {   
			PlayItem ('Title', gsGUID[listindex], 0)
		    }
		}

		case 'Favorite':
		{   
		    PlayItem ('Favorite', gsGUID[listindex], 0)
		}
		
		case 'RadioSource':
		{
		    setMediaMode (MEDIA_RADIO);
		    setFilter (MEDIA_RADIO,"'RadioSource=',gsGUID[listIndex]", false);
		    if (find_string(gsItem[listindex],"'Satellite'",1)>0)
		    {
			browseList ("'RadioGenres'",1,giMaxListItems);
		    }
		    else
		    {
		        browseList ("'RadioStations'",1,giMaxListItems);
		    }
		    
		    enableButton(btSearch,1);
		}
		
		case 'RadioGenre':
		{
		    setFilter(MEDIA_RADIO,"'RadioGenre=',gsGUID[listIndex]", true);
		    browseList ("'RadioStations'",1,giMaxListItems);
		}
		    
		case 'RadioStation':
		{
		    PlayItem('RadioStation', gsGUID[listindex], 0)
		}
				
		case 'EpgGenre':
		{	
		    setMediaMode(MEDIA_TV);
		    setFilter (MEDIA_TV,"'Genre=',gsGUID[listIndex]", false);
		    browseList ("'EpgStations'",1,giMaxListItems);
		    enableButton(btSearch,1);
		}

		case 'EpgStation':
		{	setMediaMode(MEDIA_TV);
			PlayItem ('EpgStation', gsGUID[listIndex], 0);
		}

		case 'MovieTitle': browseMovie(gsGUID[listIndex])
		
		case 'MovieChapter':
		{	doCommand("'PlayMovieChapter ',gsGUID[listIndex]");
		}
		
		case 'MovieGenre':
		{	setFilter (MEDIA_MOVIES,"'MovieGenre=',gsGUID[listIndex]",false);
			browseList ("'MovieTitles'",1,giMaxListItems);
			enableButton(btSearch,1);
			pageFlip ("'MCS_Browse'");
		}
		
		case 'MoviePerson':
		{	setFilter (MEDIA_MOVIES,"'MoviePerson=',gsGUID[listIndex]",false)
			browseList ("'MovieTitles'",1,giMaxListItems)
			enableButton(btSearch,1);
			pageFlip ("'MCS_Browse'")
		}	
		
		case 'MovieRating':
		{	setFilter (MEDIA_MOVIES,"'MovieRating=',gsGUID[listIndex]",false)
			browseList ("'MovieTitles'",1,giMaxListItems)
			enableButton(btSearch,1);
			pageFlip ("'MCS_Browse'")
		}
		
		case 'MovieYear':
		{	setFilter (MEDIA_MOVIES,"'MovieYear=',gsGUID[listIndex]",false)
			browseList ("'MovieTitles'",1,giMaxListItems)
			enableButton(btSearch,1);
			pageFlip ("'MCS_Browse'")
		}
		
		case 'DvrTitle':
		{	playItem ('DvrTitle',gsGUID[listIndex],0)
		}
		
		case 'DvrStation':
		{	setFilter (MEDIA_RECORDEDTV,"'DvrStation=',gsGUID[listIndex]",false)
			browseList ("'DvrTitles'",1,giMaxListItems)
			enableButton(btSearch,1);
			pageFlip ("'MCS_Browse'")
		}
		
		case 'DvrGenre':
		{	setFilter (MEDIA_RECORDEDTV,"'DvrGenre=',gsGUID[listIndex]",false)
			browseList ("'DvrTitles'",1,giMaxListItems)
			enableButton(btSearch,1);
			pageFlip ("'MCS_Browse'")
		}
		case 'DvrRating':
		{	setFilter (MEDIA_RECORDEDTV,"'DvrRating=',gsGUID[listIndex]",false)
			browseList ("'DvrTitles'",1,giMaxListItems)
			enableButton(btSearch,1);
			pageFlip ("'MCS_Browse'")
		}
		
		case 'DvrRecordDate':
		{	setFilter (MEDIA_RECORDEDTV,"'DvrRecordDate=',gsGUID[listIndex]",false)
			browseList ("'DvrTitles'",1,giMaxListItems)
			enableButton(btSearch,1);
			pageFlip ("'MCS_Browse'")
		}
		
		case 'PickListItem':
		{
		    doCommand("'AckPickItem ', gsGUID[listIndex]")
		}
	}
}

define_function makeTimeString (char secs[])
{
    char myTime[20]
    integer hour
    integer mins
    integer sec
	
    sec = atoi(secs)
    mins = sec / 60
    sec = sec MOD 60
    hour = mins / 60
    mins = mins MOD 60
 
    if (hour>0) myTime = "format('%1d',hour),':',format('%02d',mins),':',format('%02d',sec)"
    	else myTime = "format('%1d',mins),':',format('%02d',sec)"
  
    secs=myTime
}

define_function MCS_onConnect() 
{
	giOnline=1;
	setText (btStatus,'Соединение устанавливается...'); // Connection Established
	setText (btConnection,gsItem[giMaxListItems+1]);
	enableButton (btStartMCE,0);
	
	if (gsInstance[giMaxListItems+1]<>'') doCommand ("'SetInstance ',gsInstance[giMaxListItems+1]");
	doCommand ('SubscribeEvents');
	doCommand ('GetMCEStatus');
	doCommand ("'SetPicklistCount ',itoa(giMaxListItems)");
	setDynamicImages();
	killPopup('MCS_Dialog');
}

define_function MCS_onDisconnect() 
{
	giOnline=0;
	setText (btStatus,'Нет соединения с сервером'); // No Connection to Server
	setText (btStartMCE,'Соединение'); // Connect
	enableButton (btStartMCE,1);
	pageFlip('MCS_Offline');
}

define_function MCS_onStop()
{
	giMCE=0;
	setText (btStatus,'Сервер не запущен'); // Media Server is not running on the host
	setText (btStartMCE,'Старт WMC'); //  Start WMC
	enableButton (btStartMCE,1);
	pageFlip('MCS_Offline');
}

define_function MCS_onStart()
{
	giMCE=1;
	clearFeedback();
	setText (btStatus,'Есть соединение с медиасервером'); // Media Server Connected
	enableButton (btStartMCE,0);
	pageFlip('MCS_Home');
	refreshNowPlayingArt();
}

define_function refreshBrowseAlbumArt(char sResource[],integer iChan, char sGuID[])
{
    if (left_string(sGuid,1)='{') sGuID=mid_string(sGuid,2,length_string(sGuID)-2)
    send_command dvTP,"'^RMF-',sResource,',%Fgetart?guid=',sGuID,'&w=96&fmt=png'"
    send_command dvTP,"'^RFR-',sResource"
}

define_function refreshBrowseAlbumDetail(char sResource[],integer iChan, char sGuID[])
{
    if (left_string(sGuid,1)='{') sGuID=mid_string(sGuid,2,length_string(sGuID)-2)
    send_command dvTP,"'^RMF-',sResource,',%Fgetart?guid=',sGuID,'&h=191&w=173&c=1&rfle=3&rflh=30&rflo=80&rz=15&fmt=png'"
    send_command dvTP,"'^RFR-',sResource"
}

define_function refreshData()
{
	clearAll();
	doCommand ("'GetMCEStatus'")
}

define_function refreshNowPlayingArt()
{
	send_command dvTP,"'^RMF-NowPlaying,%Fgetart?guid=',gsNowPlayingGUID,'&h=274&w=226&c=1&rfle=3&rflh=30&rflo=80&rz=15&fmt=png'"
	send_command dvTP,"'^RFR-NowPlaying'"
}

define_function refreshTransport()
{
    integer iStop
    integer iPlay
    integer iFwd
    integer iRew
    
    iStop = fbStop +((giPlayState==fbStop)*2)
    iPlay = fbPlayPause +((giPlayState==fbPlay)*2)+((giPlayState==fbPause)*4)
    iFwd = fbFwd + ((giPlayState==fbFwd)*2)
    iRew = fbRwd + ((giPlayState==fbRwd)*2)
               
    setIcon (btStop, iStop)
    setIcon (btPlayPause, iPlay)
    setIcon (btFwd, iFwd)
    setIcon (btRew, iRew)
}

define_function setDynamicHost(char sResource[])
{
    send_command dvTP,"'^RMF-',sResource,',%P0%H',gsCurrentIPAddress,':',itoa(iMCS_ART_PORT),'%A%Ffile'"
}

define_function setDynamicImages()
{
    integer i;
    for (i=1;i<=giMaxListItems;i++) {setDynamicHost("'BrowseAlbumList',itoa(i)")}
    setDynamicHost("'NowPlaying'")
    setDynamicHost("'BrowseAlbum'")
}
   
define_function setFilterDescription(char datum[])
{
	integer pos;
	pos=find_string(datum, 'Ok', 1);
	gsFiltersDesc=mid_string(datum,pos+4,length_string(datum)-(pos+4))
	setText (btStatus,gsFiltersDesc);
}

define_function setMediaMode (integer iMode)
{
    
	setfilter (iMode,'',0);
	giBrowsingMedia=iMode;
		
	//Text
	/*switch (iMode)
	{
	    case MEDIA_AUDIO: setText(btStatus,'Music')
	    case MEDIA_MOVIES:setText(btStatus,'Movies')
	    case MEDIA_RECORDEDTV: setText (btStatus,'Recorded TV')
	    case MEDIA_PICTURES: setText (btStatus,'Pictures')
	    case MEDIA_VIDEOS: setText (btStatus,'Videos')
	    case MEDIA_TV: setText (btStatus, 'Live TV')
	    case MEDIA_RADIO: setText (btStatus, 'Radio Stations');
	    default: setText (btStatus,'')
	}*/
	
	enableButton(btAddListToQueue,iMode=MEDIA_AUDIO)
}

define_function setTrackLen(char secs[])
{
    giTrackLen = atoi(secs);
    MakeTimeString(secs);
    setText(btTrackLen,"secs");
}

define_function setTrackTime(char secs[])
{
    giTrackTime = atoi(secs);
    MakeTimeString(secs);
    setText(btTrackTime,secs);
    
    if (giTrackLen >0) 
    {	
	setLevel(btTrackProgressBar,(65535/giTrackLen)*giTrackTime);
    }
    else
    {
	setLevel(btTrackProgressBar,0);
    }
    
    giTick=giTick+1;
    if (giTick>=120)
    {  
       giTick=0;
    }
}

define_function setSearch(integer iMode)
{
/*	switch (iMode)
	{
		
		CASE MEDIA_AUDIO: {
			setText (btSearchCategory,'Albums');
			setText (btSearchCategory+1,'Artists');
			setText (btSearchCategory+2,'Genres');
			setText (btSearchCategory+3,'Playlists');
			setText (btSearchCategory+4,'Queue');
			enableButton (btSearchCategory+5,1);
		}
		
		CASE MEDIA_MOVIES: {
			setText (btSearchCategory,'Movie');
			setText (btSearchCategory+1,'People');
			setText (btSearchCategory+2,'Genres');
			setText (btSearchCategory+3,'Year');
			setText (btSearchCategory+4,'Rating');
			enableButton (btSearchCategory+5,0);
		}
		
		default: {
			enableButton (btSearch,0);
		}
	}
*/
}
			

define_function setQueueButtons(integer icon)
{
    integer i
    for (i=1;i<=giMaxListItems;i++)
    {
	setIcon (btAddItemToQueue+i,icon)
    }
}

DEFINE_START

	gsCurrentIPAddress = cMCS_SERVER_IP;
	
(***********************************************************)
(*EVENT PROCEDURES										   *)
(***********************************************************)
DEFINE_EVENT

channel_event [vdvMCS,1]	    //Connect Channel
{
	on:  doCommand ('Connect:');
	off: doCommand ('Disconnect');
}

channel_event [vdvMCS,2]	//Enable Page Flips
{
	on:  giEnablePages=1;
	off: giEnablePages=0;
}

channel_event [vdvMCS,3]
{
	off: doCommand('Stop')
}

channel_event [vdvMCS,100]		//AC Server Status
{
	on:  MCS_onConnect();
	off: MCS_onDisconnect();
}

data_event [vdvMCS]
{
    string:
    {	
		char datum[16000]
		datum = data.text
				
		switch (datum)
		{
			case 'CFO': //Connection Refused.
			case 'CTO': //Connection Timed Out.
			{
				pageFlip ('MCS_Offline')
				setText (btStatus,"'Host Unreachable.  ',
					   'Make sure the Media Server is running or ',
					   'press and hold the blue Autonomic Orb (upper left) ',
					   'to provide the IP address of your Media Server'")
			}
			
			default:	processToken(datum)
		}
    }
}

data_event [dvTP]
{
    online:
    {
	setDynamicImages();
			
	if (giOnline) 
	{   if (giMCE==1)
	    {   
		pageFlip ('MCS_Home')
		refreshData()
		refreshNowPlayingArt()
	    }
	    else
	    {	
		MCS_onStop();
	    }
	}
	else
	{
	    MCS_onDisconnect();
	}
    }
    
    offline:
    {	
        gsMediaName='';
    }
    
    command:
    {
	if (find_string(data.text,'Search',1)) getKBInput(kbSearch);
	if (find_string(data.text,'Save Queue',1)) getKBInput(kbSaveQueue);
	if (find_string(data.text,'MCE:',1));
	{
	    doCommand (mid_string(data.text,5,length_string(data.text)-4));
	}

    }
    
    string:
    {
	char sKB[128]
	
	send_string 0,data.text
	
	if ((left_string (data.text,5) = "'KEYB-'" || left_string (data.text,5) = "'KEYP-'" ) && find_string(data.text,'ABORT',1)==0 && giKB<>0)
	{
		sKB = mid_string(data.text,6,length_string(data.text)-5)
		if (debug>0) send_string 0,"'giKB=',itoa(giKB)";
		switch (giKB)
		{
			case kbUI:			doCommand("gsMsgActions[1],' OK "',sKB,'"'");
			
			case kbSearch:			searchMedia(sKB);
			
			case kbSaveQueue:		doCommand("'SavePlaylist "',sKB,'"'")
			
			case kbIPAddress:		
			{
				setText (btStatus,'Attempting to connect: please wait...')
				enableButton (btStartMCE,0)
				gsInstance[giMaxListItems+1]='';
				doCommand("'Connect:',sKB")
				gsCurrentIPAddress = sKB;
			}
		}
	}
	
	else if (find_string(data.text,'ABORT',1)>0 && giKB==kbUI)
	{
	    doCommand("gsMsgActions[1],' CANCEL'");
	}
	

	if (find_string(data.text,'@PPF-MCS_Volume',1)) gbVolPopup=0;
	
	//if (find_string(data.text,'@PPN-MCS_Search',1)) setSearch(giBrowsingMedia);
	
	if (find_string(data.text,'PAGE-',1)<>0)
	{
		refreshNowPlayingArt()
	}
    }	
}

channel_event [dvTP,pgVolPopup]
{
    on:  gbVolPopup=1
    off: gbVolPopup=0
}

button_event [dvTP, btZones]
{
    push:
    {
	browseList('InstancesEX',1,giMaxListItems);
    }
}

//Pandora
button_event [dvTP, btActions]
{
    push:
    {
	doCommand('AckButton CONTEXT');
    }
}

//Navigation
button_event [dvTP,btStartMCE]
{
    push: 
    {
		if (giOnline=0)
		{
			enableButton(btStartMCE,0);
			setText(btStatus, 'Attempting to Connect...');
			on[vdvMCS,1];
		}
		else
		{
			enableButton(btStartMCE,0)
			setText (btStatus, 'Attempting to Start Media Center, Please Wait...')
			doCommand('StartMCE')
		}
    }
}

//Transports
button_event [dvTP,btStop]
button_event [dvTP,btPlayPause]
button_event [dvTP,btFwd]
button_event [dvTP,btRew]
button_event [dvTP,btSkip]
button_event [dvTP,btPrev]
button_event [dvTP,btMute]
button_event [dvTP,btShuffle]
button_event [dvTP,btRepeat]
button_event [dvTP,btShuffleLg]
button_event [dvTP,btRepeatLg]
button_event [dvTP,btVolUp]
button_event [dvTP,btVolDn]
button_event [dvTP,btRecord]
{
   push:
   {
		giLastPush=push_channel;
		switch (push_channel)
		{
			case btStop: doCommand('Stop')
			case btFwd: doCommand('SendRemote FastForward');
			case btRew: doCommand('SendRemote Rewind');
			case btSkip: doCommand('SkipNext');
			case btPrev: doCommand('SkipPrevious');
			case btPlayPause: doCommand('PlayPause');
			case btVolDn: doCommand('SendRemote VolumeDown');
			case btVolUp: doCommand('SendRemote VolumeUp');
			case btRecord: doCommand('SendRemote Record');
			case btMute:
			{
				switch (giMuteState)
				{
					case 0: doCommand('Mute True');
					default: doCommand('Mute False');
				}
			}
			
			case btShuffle:
			{
			    if (giShuffleEnabled == true)
			    {
				switch (giShuffleState)
				{
					case 0: doCommand('Shuffle True');
					default: doCommand('Shuffle False');
				}
			    }
			}
			
			case btRepeat:
			{
			    if (giRepeatEnabled == true)
{
				switch (giRepeatState)
				{
					case 0: doCommand('Repeat True');
					default: doCommand('Repeat False');
				}
			    }
			}
		}
    }

    release:
    {
		giHeld=0;
    }
    
    hold[1, repeat]:
    {
		//Volume repeater - hold for 4/10th, then repeat every 1/10th
		giHeld=giHeld+1;
		if (giHeld>4)
		{
			switch(giLastPush)
			{
				case btVolUp: doCommand('SendRemote VolumeUp')		    
				case btVolDn: doCommand('SendRemote VolumeDown')
			}
		}
    }
}

button_event [dvTP,btVolPopup]
{
    push:
    {
		if (gbVolPopup=1)
		{
			send_command dvTP, "'@PPK-MCS_Volume'"
			gbVolPopup=0
		}
		else
		{
			send_command dvTP, "'@PPN-MCS_Volume'"
			gbVolPopup=1
		}
    }
}

//Browse Commands
button_event [dvTP,btMusic]
button_event [dvTP,btMyMovies]
button_event [dvTP,btRecordedTV]
button_event [dvTP,btMyPictures]
button_event [dvTp,btMyVideos]
button_event [dvTp,btFavorites]
{
    push:
    {
	browseFilters (push_channel);
    }
}

button_event [dvTP,btShowQueue]
{
    push:
    {
	//pageFlip("'MCS_Queue'")
	setFilter(MEDIA_AUDIO,'',false);
	browseList('NowPlaying',1,giMaxListItems);
	enableButton(btSearch,0);
    }
} 	

button_event [dvTP,btClearQueue] 
{
    push:
    {
	msgBox("'Список очереди удален.'");
	DoCommand ("'ClearNowPlaying'");
	giTotalTracks=0;
	clearFeedback();
	if (gsListType=='NowPlaying') clearAll();
    }
}

button_event [dvTP,btSaveQueue]
{
    push: getKBInput(kbSaveQueue)
}

button_event [dvTP,btPrevPage]
{
    push: goToPreviousPage()
}

button_event [dvTP,btNextPage]
{
    push: goToNextPage()
}

button_event [dvTP,btBack]
{
    push: recallHistory();
}

button_event [dvTp,btSynopsis]
{
    release:
    {
	pageFlip('MCS_Browse_Movie');
    }
}

button_event [dvTp,btChapters]
{
    release:
    {
	pageFlip('MCS_Browse_Album');
    }
}

button_event [dvTP,btAddListToQueue]
button_event [dvTP,btPlayListNow]
{
	push:
	{
		switch (giBrowsingMedia)
		{	
			case MEDIA_AUDIO:
				playItem ('Album',gsGuid[giMaxListItems+1],push_channel==btAddListToQueue)
			case MEDIA_MOVIES:
				playItem ('MovieTitle',gsGuid[giMaxListItems+1],0)
		}
	}
}

button_event [dvTP,btAddItemToQueue+1]
button_event [dvTP,btAddItemToQueue+2]
button_event [dvTP,btAddItemToQueue+3]
button_event [dvTP,btAddItemToQueue+4]
button_event [dvTP,btAddItemToQueue+5]
button_event [dvTP,btAddItemToQueue+6]
button_event [dvTP,btAddItemToQueue+7]
button_event [dvTP,btAddItemToQueue+8]
button_event [dvTP,btAddItemToQueue+9] //Add more buttons as necessary for UI
{
    push:
    {
		giLastPush=push_channel-btAddItemToQueue;
		on [dvTP,push_channel]
		giHeld=0
    }
    
    release:
    {
		off [dvTP,giLastPush+btAddItemToQueue];
		
		if (!giHeld)
		{
			if (giButtonState = BUTTON_STATE_QUEUE)
			{	
				removeItem (gsGUID[giLastPush]);
			}
			else
			{   
				if (gsActions[giLastPush]<>'') 
				{
				    char cmd[128]
				    cmd = "gsActions[giLastPush],' ',gsGUID[giLastPush]";
				    doCommand(cmd);
				}
				else
				{
				    PlayItem (gsType[giLastPush], gsGUID[giLastPush],(giNowPlayingType==MEDIA_AUDIO));
				}
			}
		}
    }
    
    hold[5]:
    {
		giHeld=1
		off [dvTP,giLastPush+btAddItemToQueue]
		PlayItem (gsType[giLastPush], gsGUID[giLastPush],0);
    }
}

button_event [dvTP,btItems+1]
button_event [dvTP,btItems+2]
button_event [dvTP,btItems+3]
button_event [dvTP,btItems+4]
button_event [dvTP,btItems+5]
button_event [dvTP,btItems+6]
button_event [dvTP,btItems+7]
button_event [dvTP,btItems+8]
button_event [dvTP,btItems+9]  //Add more buttons as necessary for UI
{
    push:
    {
		giLastPush = push_channel
		to [dvTP,push_channel] 
		wait (1)
		{   
		    listSelect(giLastPush-btItems);
		}
    }
}

button_event [dvTP,btNowPlayingArt]
{
	push: browseNowPlaying()
}

button_event [dvTP,btBrowseAlbumArt+1]
button_event [dvTP,btBrowseAlbumArt+2]
button_event [dvTP,btBrowseAlbumArt+3]
button_event [dvTP,btBrowseAlbumArt+4]
button_event [dvTP,btBrowseAlbumArt+5]
button_event [dvTP,btBrowseAlbumArt+6]
button_event [dvTP,btBrowseAlbumArt+7]
button_event [dvTP,btBrowseAlbumArt+8]
button_event [dvTP,btBrowseAlbumArt+9]  //Add more buttons as necessary for UI
{
    push:
    {
		to [dvTP,push_channel]
		listSelect(push_channel-btBrowseAlbumArt)
    }
}

button_event [dvTP,btOrb]
{
	hold[20]:
	{
		giKB=kbIPAddress;
		if (gsCurrentIPAddress == '') gsCurrentIPAddress = cMCS_SERVER_IP
		getNumberInput(gsCurrentIPAddress,'Enter IP to Connect to:');
	}
}

button_event [dvTP, btScrollbar]
{
    release:
	{
		BrowseList (gsBrowse, giScroll, giMaxListItems);
	}
}

level_event [dvTP, btScrollbar]
{
	giScroll = (giListCount * level.value+1) / 100;
}

level_event [dvTP, btVolumeBar]
{
	giScroll = level.value
}

button_event [dvTP, btVolumeBar]
{
	release:
	{
		doCommand("'SetVolume ',itoa(giScroll)")
	}
}

button_event [dvTP,btThumbsDown] 
{
    push:
    {
	on[dvTP,btThumbsDown];
    }
    
    release: 
    {
	doCommand('ThumbsDown');
    }
}

button_event [dvTP,btThumbsUp] 
{
    push:
    {
	on[dvTP,btThumbsup];
    }
    
    release: 
    {
	doCommand('ThumbsUp');
    }
}

button_event [dvTP,btMSG1]
button_event [dvTP,btMSG2]
button_event [dvTP,btMSG3]
{
    release:
    {
	char cmd[256];
	cmd = gsMsgActions[release_channel-(btMSG1)+1];
	doCommand(cmd);
    }
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)

DEFINE_PROGRAM

//Button Feedback


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

