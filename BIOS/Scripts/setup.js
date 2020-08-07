jQuery.support.cors = true;

//------------------
// Global Constants
//------------------
var SYSTEM_REBOOT_TRUE            = "xREBOOTx=1";
var SYSTEM_REBOOT_FALSE           = "xREBOOTx=0";
var UPDATE_REMOTE_SERVER_WARNING  = "Depends on how many servers you select" + 
      ", the process time may take long time.<br />" + 
      "Please do <b>NOT</b> refresh this page.";

var FORM_SUBMIT_URL               = 'Actions/SubmitData.cgi?ef=';
var SETUP_FILE_GEN_TIME_URL       = 'Actions/XmlFileGenTime.cgi';
var READ_SYS_TIME_URL             = 'Actions/SysTime.cgi';
var DEFAULT_TAB_NAME              = "Main";
var SETUP_AJAX_TIMEOUT            = 5000;
var SETUP_AJAX_SUBMIT_TIME        = 10000;
var SETUP_SET_TIMEOUT_WORK_INTERVAL        = 10;
var SETUP_HTML_MIN_HEIGHT         = 600;
var SETUP_DFT_POPUP_FORM_HEIGHT   = 400;
var SYS_TIME_UPDATE_INTERVAL      = 60 * 1000;


//------------------
// Global variables
//------------------
//var gTotalUpperLayerHeight = 110 +10 + 12 + 60 + 4 + 2 + 4; // 202
var gTotalUpperLayerHeight;
//
// Keep uninitializing global variables uninitialized, or it may occur errors
//
var gSysTimeIntervalFd;
var gSysTimeArray;
var gSysTimeUpdateCount;
var gIsSetSysTime                 = false;
var gExitFun                      = 0;
var gPopupFrameStack              = null;
var gPopupFrameTitleStack         = null;
var gShowHelpMsg                  = false;

//var gDefatultTabFormHeight = (parseInt (document.documentElement.clientHeight) > (330 + 170)) ? (parseInt (document.documentElement.clientHeight) - 170) : 330;
//
// Do not initialize this global variable! 
// It would be changed when we use index.html to process xml and xslt, 
// because this variable will be loaded twice, and the second time initialization would be the last result.
//
var gDefatultTabFormHeight;
var gTempFormId = null;

//
// Operate after popup a loading page
//
var gThisNode = null;
var gAjaxServerInfo = null;
var gRemoteServers = new Array();
var gUploadFilesInfo = null;
var gAjaxSubmitObjs = null;
var gIsSubmitOneByOne = false;
var gAjaxFormData = null;
var gStopAction = false;
var gIsTxtConfig = false;
var gThisServerInfo = null;


//------------------
// Initilaizing
//------------------

$.ajaxSetup ({
  //
  // Disable caching of AJAX responses or it may cause problem on IE
  //
  cache: false
});

if ($.browser.msie) {
  //
  // Initializing value for IE
  //
  gTotalUpperLayerHeight = 90 + 10 + 12 + 60 + 8;
} else if ($('#OuterFrame').outerHeight(true) > 0) {
  gTotalUpperLayerHeight = $('#OuterFrame').outerHeight(true) + 2;
} else {
  //
  // We can get gTotalUpperLayerHeight from 
  // TopFrame (height: 110, 90 on IE), 
  // Banner (padding-top: 2)
  // Menu (height: 30px, padding-top: 8px => 8)
  // MainFrame (padding-top: 6 & padding-bottom: 6 ==> 12)
  // BottomFrame (height: 60, padding-top: 4px & padding-bottom: 4px ==> 68), 
  // InnerFrame (border-top-width: 2 & border-bottom-width: 2 ==> 4)
  // InfoBody (padding-top: 2 ==> 2)
  // *Form (padding-top: 4px & padding-bottom: 4 ==> 8)
  // Unknown -6
  //
  gTotalUpperLayerHeight = 110 + 2 + 8 + 12 + 68 + 4 + 2 + 8 - 6;
}


//------------------
// Functions
//------------------

function UpdateTimeField (response) {
  gSysTimeArray = { 
                  Second:response.substr(12, 2),
                  Minute:response.substr(10, 2), 
                  Hour:response.substr(8, 2), 
                  Day:response.substr(6, 2), 
                  Month:response.substr(4, 2), 
                  Year:response.substr(0, 4)
               }; 
  $('#SystemDate').html("[" + gSysTimeArray.Month + "/" + gSysTimeArray.Day + "/" + gSysTimeArray.Year + "]");
  $('#SystemTime').html("[" + gSysTimeArray.Hour + ":" + gSysTimeArray.Minute + ":" + gSysTimeArray.Second + "]");
}

function QueryServerDateTime () {
/*
  $.ajax({
    url: READ_SYS_TIME_URL,
    timeout: SETUP_AJAX_TIMEOUT,
    error: function(xhr) {
//      alert('Connection failed!');
    },
    success: function(response) {
      UpdateTimeField (response);
    }
  });
*/
	var today = new Date();
	
	var curDay = today.getDate();
	var curMon = today.getMonth() + 1;
	var curYear = today.getFullYear();

	var curSec = today.getSeconds();
	var curMin = today.getMinutes();
	var curHour = today.getHours();

	curSec = FillNumberWithZero(curSec);
	curMin = FillNumberWithZero(curMin);
	curHour = FillNumberWithZero(curHour);
	curDay = FillNumberWithZero(curDay);
	curMon = FillNumberWithZero(curMon);
		
	var dateStr = "" + curYear + curMon + curDay + curHour + curMin + curSec;

	UpdateTimeField (dateStr);
}

function AutoAdjustDateTime () {
  var Year, Month, Day, Hour, Minute, Second;
  var DateObj, NewDateObj;
  var OriginalTimeNum;
  
  if (gIsSetSysTime == false) {
    gSysTimeUpdateCount++;
    if ((gSysTimeUpdateCount * 1000) >= SYS_TIME_UPDATE_INTERVAL) {
      //
      // If system time is set by user, we don't flush timer from server
      //
      QueryServerDateTime ();
      gSysTimeUpdateCount = 0;
    }
  }
  
  DateObj = new Date ();
  /*
  DateObj = new Date (
    gSysTimeArray.Year, 
    gSysTimeArray.Month - 1, 
    gSysTimeArray.Day, 
    gSysTimeArray.Hour, 
    gSysTimeArray.Minute, 
    gSysTimeArray.Second
  );
  
  OriginalTimeNum = Date.parse (DateObj.toString());
  OriginalTimeNum += 1000;
  	
  DateObj.setTime(OriginalTimeNum);
  */
  gSysTimeArray.Year = DateObj.getFullYear ();
  gSysTimeArray.Month = DateObj.getMonth () + 1;
//  gSysTimeArray.Day = (parseInt (DateObj.getDate ()) + 1).toString ();
  gSysTimeArray.Day = DateObj.getDate ();
  gSysTimeArray.Hour = DateObj.getHours ();
  gSysTimeArray.Minute = DateObj.getMinutes ();
  gSysTimeArray.Second = DateObj.getSeconds ();
  
  Second = FillNumberWithZero (gSysTimeArray.Second);
  Minute = FillNumberWithZero (gSysTimeArray.Minute);
  Hour = FillNumberWithZero (gSysTimeArray.Hour);
  Day = FillNumberWithZero (gSysTimeArray.Day);
  Month = FillNumberWithZero (gSysTimeArray.Month);
  Year = gSysTimeArray.Year;

//  alert (Month + "/" + Day +"/" + Year + " " + Hour + ":" +Minute + ":"+ Second);
  $('#SystemDate').html("[" + Month + "/" + Day + "/" + Year + "]");
  $('#SystemTime').html("[" + Hour + ":" + Minute + ":" + Second + "]");
  
  if ((gIsSetSysTime == true) && ($('#EditSystime').css("display") == "none")) {
    $('#Year').val(Year);
    $('#Month').val(Month);
    $('#Day').val(Day);
    $('#Hour').val(Hour);
    $('#Minute').val(Minute);
    $('#Second').val(Second);
  }
}

function InitSystemTimer () {
  QueryServerDateTime ();
  gSysTimeIntervalFd = setInterval (AutoAdjustDateTime, 1000);
  gSysTimeUpdateCount = 0;

  $("#Month, #Day, #Year, #Hour, #Minute, #Second").change (function () {
    var Node = $(this);
    var Value = parseInt ($(this).val());

    if (Value < 0) {
      alert ("Error:" +Value);
      return;
    }
    //
    // Timer is set by user, we don't flush timer from server
    //
    gIsSetSysTime = true;
    
    if (Node.attr('id') == 'Month') {
      if ((Value > 0) && (Value < 13)) {
        gSysTimeArray.Month = Value;
      }
    } else if (Node.attr('id') == 'Day') {
      if ((Value > 0) && (Value < 32)) {
        gSysTimeArray.Day = Value;
      }
    } else if (Node.attr('id') == 'Year') {
      gSysTimeArray.Year = Value;
    } else if (Node.attr('id') == 'Hour') {
      if ((Value >= 0) && (Value < 24)) {
        gSysTimeArray.Hour = Value;
      }
    } else if (Node.attr('id') == 'Minute') {
      if ((Value >= 0) && (Value < 60)) {
        gSysTimeArray.Minute = Value;
      }
    } else if (Node.attr('id') == 'Second') {
      if ((Value >= 0) && (Value < 60)) {
        gSysTimeArray.Second = Value;
      }
    }
  });
/*
  $('#Systime .TimeContentField').click(function () {
    //
    // Time has been set, clear those input field
    //
    $('#Systime').css("display", "none");
    $('#EditSystime').css("display", "");
    $('#Year').val("");
    $('#Month').val("").focus();
    $('#Day').val("");
    $('#Hour').val("");
    $('#Minute').val("");
    $('#Second').val("");
  });

  $('#EditSystime :input').keyup(function (event) {
    if(event.keyCode == 13) {
      $('#EditSystime').css("display", "none");
      $('#Systime').css("display", "");
    }
  });
*/
}

function InitGlobalObjects () {
  gUploadFilesInfo = null;
  //
  // Server information is an JSON object
  //
  if (!gThisServerInfo) {
    gThisServerInfo = GetServerInfo ();
    if (!gThisServerInfo) {
      return false;
    }
  }
  if (gRemoteServers.length > 0) {
    gRemoteServers.splice (0, gRemoteServers.length);
  }
  
  return true;
}

function SubmitData (FunNum, IsReboot) {
  /*
  var HttpLink = "";
  var RestartInfo = "";
  var PopupMsg;
  
  if (IsReboot == true) {
    RestartInfo = "&" + SYSTEM_REBOOT_TRUE;
    PopupMsg = "Processing...<br /><br />" + 
      "<b>System will reboot when operation is finished</b><br /><br />" + 
      "Please do <b>NOT</b> refresh this page!";
  } else {
    PopupMsg = "Processing...<br /><br />" + 
      "Please do <b>NOT</b> refresh this page!";
  }
  PopupInfo ("Send request", PopupMsg);
  */
  
  //
  // Check if connection still alive
  //
  /*
  if (CheckConnection () == true) {
    SetPopupContent ("Can't connect with server");
    SetOkBtnAndContent (POPUP_WIN_BTN_OK, ClosePopup);
    return;
  }
  */

  //
  // To reflect floating timer
  //
  /*
  if (gIsSetSysTime == true) {
    $('#Month').val (gSysTimeArray.Month);
    $('#Day').val (gSysTimeArray.Day);
    $('#Year').val (gSysTimeArray.Year);
    $('#Hour').val (gSysTimeArray.Hour);
    $('#Minute').val (gSysTimeArray.Minute);
    $('#Second').val (gSysTimeArray.Second);
  }
  */

  //
  // When default is disabled, those attribute should be removed before post
  //
  
  //-[start-121225-IB10500006-modify]
  $(':input').not ('.NoSend').removeAttr("disabled");
  //$(':input').removeAttr("disabled");
  //-[end-121225-IB10500006-modify]
  /*
  $.ajax({
    url: FORM_SUBMIT_URL + FunNum + "&func=sef",
    type: "POST", 
    dataType: "json",
    data: $('#DataForm').serialize() + RestartInfo,
    complete: function (jqXHR, textStatus) {
      //
      // Replace message with data
      //
      PopupInfo ("Server response", PopupMsg);
      
      if (textStatus == "success") {
        var Data = $.parseJSON (jqXHR.responseText);
        
        if (!Data) {
          SetPopupContent ("Server exists but doesn't support this feature");
        } else if (!Data.StatusCode) {
          SetPopupContent (Data.resp + "<br /><br />Press OK to <b>RELOAD</b>");
        } else {
          alert ("Parse response failed");
//          SetPopupContent (Data.resp);
        }
        
      } else if (textStatus == "parsererror") {
        SetPopupContent ("Parse response failed");
      } else {
        SetPopupContent (textStatus);
      }
      switch (parseInt(FunNum)) {
      case 1: // Save changes and exit
      case 3: // Save changes
      case 5: // Load optimal defaults
      case 6: // Load customized defaults
		SetCtrlButtons (POPUP_WIN_BTN_OK, function () {
          window.location.reload (true);
        });
        break;
      
      case 7: // Save customized defaults
      case 0:
      default:
        SetCtrlButtons (POPUP_WIN_BTN_OK, ClosePopup);
        break;
      }
    }
  });
  */

  // Submit form data and exit
  switch (parseInt(FunNum)) {
  case 1: // Save changes and exit
  case 3: // Save changes
  case 7: // Save customized defaults
	$('#DataForm').submit();
  }
  window.location.href='ExitBtn:' + FunNum;
}

function SubmitAndRestartSystem (FunNum) {  
  PopupInfo ("Reboot confirm", "Are you going to <b>reboot</b> server after this action?");
  SetCtrlButtons (POPUP_WIN_BTN_YES, function () {
    SubmitData (FunNum, true);
  });
  SetCtrlButtons (POPUP_WIN_BTN_NO, function () {
    SubmitData (FunNum, false);
  });
}

function ConfirmMsg (FunNum, FunMsg, AskIfReboot) {
  PopupInfo ("Confirm Message", "Are you sure to <b>" + FunMsg + "</b>");
  
  SetCtrlButtons (POPUP_WIN_BTN_NO, ClosePopup);
  
  switch (parseInt(FunNum)) {
    
  case 7: // Save customized defaults
  case 1: // Save changes and exit
  case 3: // Save changes
  case 5: // Load optimal defaults
  case 6: // Load customized defaults
    if (AskIfReboot == true) {
      SetCtrlButtons (POPUP_WIN_BTN_YES, function () {
        SubmitAndRestartSystem (FunNum);
      });
    } else {
      SetCtrlButtons (POPUP_WIN_BTN_YES, function () {
        SubmitData (FunNum, false);
      });
    }
    break;
    
  case 2: // Discard changes and exit
    SetCtrlButtons (POPUP_WIN_BTN_YES, function () {
      window.location.href='ExitBtn:' + FunNum;
    });
	break;
	
  case 4: // Discard changes
    //
    // Close this window without popup another confirm window
    //
    SetCtrlButtons (POPUP_WIN_BTN_YES, function () {
      window.location.reload (true);
    });
    break;
    
  case 0: // Function number is not set
  default: // This case won't happen
    break;
  }
}

$('#ExitInfo .ExitBtn').click (function () {
  var Node = $(this);
  var FuncNumber = Node.attr("funnum");
  var NodtTitle = Node.find('span').html();
  //var Newhref = 'ExitBtn:' + FuncNumber;
  
  switch (parseInt(FuncNumber)) {
    
  case 3: // Save changes
  case 1: // Save changes and exit
  case 7: // Save customized defaults
	//$('#DataForm').submit();
	//window.location.href=Newhref;
	//break;
	
  case 2: // Discard changes and exit
  case 5: // Load optimal defaults
  case 6: // Load customized defaults
	//window.location.href=Newhref;
    //ConfirmMsg (FuncNumber, Node.find('span').html(), true);
    //break;
    
  case 4: // Discard changes
    ConfirmMsg (FuncNumber, Node.find('span').html(), false);
    break;
    
  case 0: // Function number is not set
  default: // This case won't happen
    break;
  }
});

function ReadFileGenTime () {

  $.ajax({
    url: SETUP_FILE_GEN_TIME_URL,
    timeout: SETUP_AJAX_TIMEOUT,
    error: function(xhr) {
    },
    success: function(response) {
      $('#FileGenTime').val(response);
    }
  });
}

function ClickTab (NodeName) {
  var ThisObj;
  var TargetObj;
  var StdObj = $("#StdBody");
  var InnObj = $("#InnerBody");
  var MngObj = $("#MngBody");
  var HideObj = null;
    
  if (StdObj.is (":visible")) {
    //
    // Still on the top level of menu
    //
    if (StdObj.attr ("show") != undefined) {
      StdObj.removeAttr ("show");
    }
    ThisObj = StdObj.find ("div.FormFrame").filter(":visible");
    if (ThisObj.attr ("id") == (NodeName + "Info")) {
      return;
    }
    ThisObj.css ("display", "none");
  } else if (InnObj.is (":visible")) {
    HideObj = InnObj;
    if (HideObj.attr ("show") != undefined) {
      HideObj.removeAttr ("show");
    }
  } else if (MngObj.is (":visible")) {
    HideObj = MngObj;
    //
    // Clear font color in management of menu list
    //
    $("#ManagementTool").siblings ().find ("div.SubTreeNode").css ("color", "");
//    $("#ManagementTool").siblings ().find ("div.SubTreeNode").removeClass ("TgtLinkColor");
  } else {
    alert ("Is no presented frame?");
  }
  if (HideObj) {
    HideObj.find ("div.FormFrame").filter(":visible").css ("display", "none");
    HideObj.css ("display", "none");
    StdObj.css ("display", "");
  }

  //
  // Clear stack
  //
  if (gPopupFrameStack && (gPopupFrameStack.length > 0)) {
    gPopupFrameStack.splice(0, gPopupFrameStack.length);
  }
  if (gPopupFrameTitleStack && (gPopupFrameTitleStack.length > 0)) {
    gPopupFrameTitleStack.splice(0, gPopupFrameTitleStack.length);
  }

  //
  // Back from other FormFrame
  //
  ThisObj = StdObj.find ("div.FormFrame").filter(":visible");
  if (ThisObj.attr ("id") == (NodeName + "Info")) {
    return;
  }
  ThisObj.css ("display", "none");
  TargetObj = $("#" + NodeName + "Info");
  TargetObj.css ("display", "");
  ControlFormRow ($(TargetObj));
}

function InitTab () {
  $("#MainInfo").css ("display", "");
  ControlFormRow ($("#MainInfo"));
  //
  // Set initialing item highlight
  //
  $("#MenuList").find ("div.TreeNode[run='run']").find (".SubMenu :first-child")
    .css ("color", TREE_TGT_NODE_COLOR)
//    .addClass ("TgtLinkColor")
    .attr ("tab", "tab");
}

function ClickCleanAllInput () {
  var RowNodes = $("div.ServersAddr");
  var Idx;
  
  if (RowNodes.length > 0) {
    $(RowNodes[0]).find(".ServerIp").val("");
    $(RowNodes[0]).find(".ServerPort").val("80");
    $(RowNodes[0]).find(".StatePass").css("display", "none");
    $(RowNodes[0]).find(".StateFail").css("display", "none");
//    $(RowNodes[0]).find(".StateMsg").css("display", "none");
    $(RowNodes[0]).find(".StateMsg").empty();
    
    for (Idx = 1; Idx < RowNodes.length; Idx++) {
      $(RowNodes[Idx]).remove();
    }
  }
  ClosePopup ();
}

function CloseMPage (PageObj) {
  var ShowForm;
  var BackObj;

  $("#MngBody").css ("display", "none");
  PageObj.css("display", "none");
  
  BackObj = $("#StdBody");
  if (BackObj.attr ("show") == undefined) {
    BackObj = $("#InnerBody");
  }
  BackObj.removeAttr ("show");
  BackObj.css ("display", "");
  
  $("#ManagementTool").siblings ().find ("div.SubTreeNode").css ("color", "");
//  $("#ManagementTool").siblings ().find ("div.SubTreeNode").removeClass ("TgtLinkColor");
  
  if (gTempFormId) {
    gTempFormId.css ("color", TREE_TGT_NODE_COLOR);
//    gTempFormId.addClass ("TgtLinkColor");
    gTempFormId = null;
  }
}

function ClickMPageBtn (PageName) {
  var MngBody = $("#MngBody");
  var PageObj = $("#" + PageName);
  var RunningPageObj = MngBody.find ("div.FormFrame").filter (":visible");
  var BackObj;

  if (!MngBody.is (":visible")) {
    BackObj = $("#StdBody");
    gTempFormId = $("#MenuList").find ("div.TreeNode[run='run']").find ("span.MenuLink[tab='tab']");
    gTempFormId.css ("color", "");
    if (!BackObj.is (":visible")) {
      BackObj = $("#InnerBody");
    }
    BackObj.attr ("show", true);
    BackObj.css ("display", "none");
    MngBody.css ("display", "");
  }
  
  if ((RunningPageObj.length > 0) && (RunningPageObj.attr ("id") != PageName)) {
    RunningPageObj.css ("display", "none");
    PageObj.css("display", "");
  } else if (!PageObj.is (":visible")) {
    PageObj.css("display", "");
  } else {
//    CloseMPage (PageObj);
  }
}

function SubmitDataOneByOne () {
  var TargetUrl;
  var FormData = "";
 
  if (!gAjaxSubmitObjs) {
    gIsSubmitOneByOne = false;
    gAjaxFormData = null;
    ClosePopup ();
    return;
  }
  if (!gUploadFilesInfo) {
//    alert ("Error! Can't fetch uploaded file name");
    SetOkBtnAndContent ("Error! Can't fetch uploaded file name", ClosePopup);
    return;
  }
  if (gAjaxSubmitObjs.reboot == true) {
    FormData = SYSTEM_REBOOT_TRUE;
  }
  if (!gIsTxtConfig) {
    TargetUrl = "Actions/ProxyFwScuProcess.cgi?func=urs&ef=" + gAjaxSubmitObjs.funno +
      "&ip=" + gAjaxSubmitObjs.ip + "&port=" + gAjaxSubmitObjs.port + 
      "&fn=" + gUploadFilesInfo.fn + "&hport=" + document.location.port;
  } else {
    TargetUrl = "Actions/ProxyFwScuProcess.cgi?func=cst" +
      "&ip=" + gAjaxSubmitObjs.ip + "&port=" + gAjaxSubmitObjs.port + 
      "&fn=" + gUploadFilesInfo.fn + "&hport=" + document.location.port;
  }
  $.ajax({
    url: TargetUrl,
    data: FormData,
    type: "POST",
    complete: function (jqXHR, textStatus) {
      var ThisObj = gAjaxSubmitObjs;
      var MsgNode = $(ThisObj.msgobj);
      var ProcessTime, ProcessSec;
      var RespObj;
      
      if (textStatus == "success") {
        RespObj = $.parseJSON (jqXHR.responseText);
        if (!RespObj.StatusCode) {
          if (RespObj.iserr == "false") {
            PrintServerResult (ThisObj, RespObj.resp, true);
          } else {
            PrintServerResult (ThisObj, RespObj.resp, false);
          }
//          PrintServerResult (ThisObj, RespObj.resp, true);
        }
      } else {
        PrintServerResult (ThisObj, textStatus, false);
      }
      if (gRemoteServers.length > 0) {
        ProcessMin = parseInt ((gRemoteServers.length * (SETUP_AJAX_SUBMIT_TIME / 1000)) / 60);
        ProcessSec = parseInt ((gRemoteServers.length * (SETUP_AJAX_SUBMIT_TIME / 1000)) % 60);
        SetPopupContent (
          "Processing...<br />It will be completed within " +  
          ProcessMin + ":" + ProcessSec);
        
        setTimeout (TestConnOneByOne, 20);
      } else {
        gIsSubmitOneByOne = false;
        gAjaxFormData = null;
        SetOkBtnAndContent ("Update process complete", ClosePopup);
      }
    }
  });
}

function UpdateSelfTxtConfig (RespJsonObj) {
  //
  // Timeout can NOT be too short, flash process need 10~20 seconds.
  //
  $.ajax({
    url: "Actions/SubmitData.cgi?func=stc&fn=" + RespJsonObj.fn,
    timeout: 60000,
    complete: function (jqXHR, textStatus) {
      var MsgNode = $("#UploadMessage");
      var MsgStr;
      
      if (textStatus == "success") {
        var JsonObj;
        
        try {
          JsonObj = $.parseJSON (jqXHR.responseText);
          if (JsonObj.iserr == "false") {
            MsgStr = "<span style=\"color: green\">" + JsonObj.resp + "</span>";
          } else {
            MsgStr = "<span style=\"color: red\">" + JsonObj.resp + "</span>";
          }
        } catch (e) {
          MsgStr = "<span style=\"color: red\">" + jqXHR.responseText + "</span>";
        }
      } else {
        MsgStr = textStatus;
      }
      MsgNode.html(MsgStr);
      SetOkBtnAndContent ("Update settings with text configuration file complete", ClosePopup);
    }
  });
}

function UploadTxtConfigComplete (Msg, IsErr) {
  var RespJsonObj;
  
  if (IsErr) {
    FileUploadComplete (Msg, IsErr);
    return;
  } else {
    RespJsonObj = $.parseJSON (Msg);
    FileUploadComplete (RespJsonObj.resp, IsErr);
  }
  
  gUploadFilesInfo = RespJsonObj;
  if (gRemoteServers.length == 0) {
    //
    // Update text config on connected server
    //
    PopupLoading ("Update settings, please wait...", false);
    UpdateSelfTxtConfig (RespJsonObj);
  } else {
    //
    // Update text config on remote server
    //
    SetPopupContent (UPDATE_REMOTE_SERVER_WARNING);
    TestConnOneByOne ();
  }
}

function SubmitClientSettingsComplete (Msg, IsErr) {
  if (IsErr) {
    SetOkBtnAndContent (Msg, ClosePopup);
    return;
  }
  SetUploadMsgVisiblility (false);
  try {
    gUploadFilesInfo = $.parseJSON (Msg);
  } catch (e) {
    SetOkBtnAndContent ("Parse response failed", ClosePopup);
    return;
  }
  SetPopupContent ("Notify remote servers to update settings...");
  TestConnOneByOne ();
}

function TestConnOneByOne () {
  if (gRemoteServers.length <= 0) {
    gIsSubmitOneByOne = false;
    gAjaxFormData = null;
    gStopAction = false;
    ClosePopup ();
    return;
  }
  $.ajax({
    url: "Actions/ProxyTestConn.cgi?ip=" + gRemoteServers[0].ip + "&port=" + gRemoteServers[0].port + "&func=conn",
    timeout: SETUP_AJAX_TIMEOUT,
    dataType: "json",
    complete: function (jqXHR, textStatus) {
      var ThisObj = gRemoteServers.splice (0, 1);
      var ProcessTime, ProcessSec;
      var RespStr;
      var IsSubmitData = false;
      var ServerInfo = null;
      
      if (textStatus == "success") {
        ServerInfo = $.parseJSON (jqXHR.responseText);
        if (ServerInfo.StatusCode) {
          PrintServerResult (ThisObj[0], ServerInfo.Response, false);
        } else if ((gAjaxServerInfo.ModelName == ServerInfo.ModelName) && 
          (gAjaxServerInfo.ModelVersion == ServerInfo.ModelVersion)) {
          
          //
          // Same platform
          //
          if (gIsSubmitOneByOne) {
            gAjaxSubmitObjs = ThisObj[0];
            IsSubmitData = true;
          } else {
            PrintServerResult (ThisObj[0], "Connection test passed", true);
          }
        } else if (gAjaxServerInfo.ModelName == ServerInfo.ModelName) {
          if (gIsSubmitOneByOne && gRemoteServers[0].forcew) {
            //
            // Force write if it's same platform but different version
            //
            gAjaxSubmitObjs = ThisObj[0];
            IsSubmitData = true;
          } else {
            PrintServerResult (ThisObj[0], "Same platform, different version", false);
          }
        } else {
          PrintServerResult (ThisObj[0], "Different platform", false);
        }
      } else if (textStatus == "parsererror") {
        PrintServerResult (ThisObj[0], "Server exists but doesn't support this feature", false);
      } else {
        PrintServerResult (ThisObj[0], textStatus, false);
      }
      if (gStopAction == true) {
        gRemoteServers.splice(0, gRemoteServers.length);
        gStopAction = false;
      }
      if (IsSubmitData == false) {
        if ((gRemoteServers.length > 0)) {
          if (gIsSubmitOneByOne == false) {
            ProcessMin = parseInt ((gRemoteServers.length * (SETUP_AJAX_TIMEOUT / 1000)) / 60);
            ProcessSec = parseInt ((gRemoteServers.length * (SETUP_AJAX_TIMEOUT / 1000)) % 60);
          } else {
            ProcessMin = parseInt ((gRemoteServers.length * (SETUP_AJAX_SUBMIT_TIME / 1000)) / 60);
            ProcessSec = parseInt ((gRemoteServers.length * (SETUP_AJAX_SUBMIT_TIME / 1000)) % 60);
          }
          SetPopupContent (
            "Processing...<br />It will be completed within " + 
            ProcessMin + ":" + ProcessSec);
          setTimeout (TestConnOneByOne, 20);
        } else {
          gIsSubmitOneByOne = false;
          gAjaxFormData = null;
          ClosePopup ();
        }
      } else {
        setTimeout (SubmitDataOneByOne, 20);
      }
    }
  });
}

function ClickFuncCtrl () {
  var Func = $(this);
  var FuncIndex = parseInt (Func.attr("func"));
  var RowNode = Func.parents(".Row");
  var Count = 0;
  var ServerIpObj;
  var ServerPortObj;

  if (FuncIndex == 1) {
    var NextRow;
    //
    // Insert a row
    //
    RowNode.clone(true).insertAfter(RowNode);
    NextRow = RowNode.next();
    NextRow.find(".ServerReboot").removeAttr("checked");
    NextRow.find(".ServerForceWrite").removeAttr("checked");
    NextRow.find(".ServerFunc").val("1");
    NextRow.find(".ServerIp").val("").css("background-color", "#ffffff");
    NextRow.find(".ServerPort").val("").css("background-color", "#ffffff");
    NextRow.find(".StatePass, .StateFail").css("display", "none");
    NextRow.find(".StateMsg").empty().height("auto").css("display", "none");
  } else if (FuncIndex == 2) {
    //
    // Remove this row
    //
    if (RowNode.siblings().length > 0) {
      RowNode.remove();
    }
  } else if (FuncIndex == 3) {
    //
    // Test connection
    //
    var RtnMsgNode = RowNode.find(".StateMsg");
    var ProcessTime, ProcessSec;
    var FontSize;
    
    
    PopupLoading ("Processing...<br />Please wait", false);
    SetCtrlButtons (POPUP_WIN_BTN_STOP, function () {
      EnableCtrlBtn (false);
      gStopAction = true;
    });

    gAjaxServerInfo = GetServerInfo ();
        
    if (!ParseAddrAndResetMsgObj (RowNode, null)) {
      RtnMsgNode.html("Format of ip/port is wrong<br />");
      return;
    }    

    FontSize = parseInt (RtnMsgNode.css("font-size").replace("px", ""));
    if (gRemoteServers.length > 5) {
      RtnMsgNode.height(FontSize * 6);
    } else {
      RtnMsgNode.height("auto");
    }
    ProcessMin = parseInt ((gRemoteServers.length * (SETUP_AJAX_TIMEOUT / 1000)) / 60);
    ProcessSec = parseInt ((gRemoteServers.length * (SETUP_AJAX_TIMEOUT / 1000)) % 60);
    SetPopupContent ("<div style='text-align: center'>" + 
      "Processing...<br />It will be completed within " +  ProcessMin + ":" + ProcessSec + 
      "</div>");
    TestConnOneByOne ();
  }
}

function AddServerToList (AddrObj, PassParams) {
  gRemoteServers.push ({
    ip: AddrObj.ip, 
    port: AddrObj.port, 
    msgobj: PassParams.msgobj,
    reboot: PassParams.isreboot,
    forcew: PassParams.iffrw,
    funno: PassParams.funno
  });
}

function ParseAddrAndResetMsgObj (AddrObj, ErrCtrlCallback) {
  var IpObj, PortObj, MsgObj, RebootObj, FrWriteObj, FuncObj;
  var IsReboot = false, IsFroceWrite = false;
  var PassParams;
  
  IpObj = AddrObj.find(".ServerIp");
  IpObj.css("background-color", "#ffffff");

  PortObj = AddrObj.find(".ServerPort");
  PortObj.css("background-color", "#ffffff");

  MsgObj = AddrObj.find(".StateMsg");
  MsgObj.empty().css("display", "").height("auto");

  RebootObj = AddrObj.find(".ServerReboot");
  FrWriteObj = AddrObj.find(".ServerForceWrite");
  FuncObj = AddrObj.find(".ServerFunc");
  
  AddrObj.find(".StatePass").css("display", "none");
  AddrObj.find(".StateFail").css("display", "none");
  
  if (RebootObj.attr("checked")) {
    IsReboot = true;
  }
  if (FrWriteObj.attr("checked")) {
    IsFroceWrite = true;
  }
  
  PassParams = {msgobj: MsgObj, isreboot: IsReboot, 
    iffrw: IsFroceWrite, funno: FuncObj.val()};
    
  if (ParseServerAddr (IpObj, PortObj, AddServerToList, 
    PassParams) == false) {
    
    if (ErrCtrlCallback) {
      ErrCtrlCallback ();
    }
    return false;
  }
  return true;
}

function PrepareTempFile () {
  var ClientId = GetClientId ();
  
  SetPopupContent ("Uploading settings...");
  if ($("#RemoteCtrlPage .RadioOption input[type=radio]:checked").val() == "txt") {
    //
    // Upload text configuration file
    //
    gIsTxtConfig = true;
    if (IsInputFileEmpty ()) {
      SetOkBtnAndContent ("Choose a file to upload!", ClosePopup);
      return;
    }
    DoSubmitUploadForm (null);
  } else {
    //
    // Use form settings to update scu
    //    
    gIsTxtConfig = false;
    $('div.FormFrame :input').removeAttr("disabled");
    $.ajax({
      url: "Actions/ProxyFwScuProcess.cgi?func=scs&id=" + ClientId,
      data: $('#DataForm').serialize(),
      type: "POST",
      timeout: 60000, // 1 minute
      complete: function (jqXHR, textStatus) {
        var JsonObj;
        
        if (textStatus == "success") {
          //
          // Insert returned javascript then it run a 
          // javascript callback automatically
          //
          try {
            JsonObj = $.parseJSON (jqXHR.responseText);
            if (JsonObj.iserr == "false") {
              SubmitClientSettingsComplete ('{"fn":"' + JsonObj.fn + '", "resp":"' + JsonObj.resp + '"}', false);
            } else {
              SubmitClientSettingsComplete (JsonObj.resp, true);
            }
          } catch (e) {
            SetOkBtnAndContent (e.message, ClosePopup);
          }
          /*
          try {
            $("#InsertedJsCbArea").html(jqXHR.responseText);
          } catch (e) {
            SetOkBtnAndContent (e.message, ClosePopup);
          }
          */
        } else {
          SetOkBtnAndContent ("Upload file failed", ClosePopup);
        }
      }
    });
  }
}

function ClickSendToServers () {
  var ServersAddrs = $("#SettingContent .ServersAddr");
  var Idx, SubIdx;
  var IsServerPass = false;
  var ServerReboot, ServerIpObj, ServerPortObj, ServerMsgObj, ServerFunction, ServerForceWrite;
  var Count = 0, BaseAmount = 0;
  
  //
  // Get platform information
  //
  gAjaxServerInfo = GetServerInfo ();
  if (!InitGlobalObjects ()) {
    SetOkBtnAndContent ("Can't connect to server", ClosePopup);
    return;
  }
  gIsSubmitOneByOne = true;
  
  //
  // Parse ip addresses
  //
  for (Idx = 0; Idx < ServersAddrs.length; Idx++) {
    Server = $(ServersAddrs[Idx]);
    ServerMsgObj = Server.find (".StateMsg");
    
    if (!ParseAddrAndResetMsgObj (Server, function () {
      ServerMsgObj.html("Format error<br />");
    })) {
      continue;
    }
    //
    // Caculate how height of message box can be
    //
    Count = gRemoteServers.length - BaseAmount;
    BaseAmount = gRemoteServers.length;
    if (Count > 5) {
      ServerMsgObj.height(parseInt (ServerMsgObj.css("font-size").replace("px", "")) * 6);
    } else {
      ServerMsgObj.height("auto");
    }
  } // End of for loop
  if (gStopAction == true) {
    gRemoteServers.splice(0, gRemoteServers.length);
    gStopAction = false;
  }
  PrepareTempFile ();
}

function ClickOperatingFormData () {
  var Func = gThisNode;
  var FuncIndex = parseInt (Func.attr("func"));
  var RtnInfo;
  var PostData;
  var Datas;
  var InputFileName;
  
  if ((FuncIndex == 2) || (FuncIndex == 3)) {
    InputFileName = $("#TempSettingFile").val ();
    if (InputFileName.length == 0) {
      PopupInfo ("Settings as Temp File", null);
      SetOkBtnAndContent ("Please input a file name", ClosePopup);
      return;
    }
  }
  if (FuncIndex == 2) {
    //
    // Save
    //
    RtnInfo = SavePostDataToTempFile (InputFileName);
  } else if (FuncIndex == 3) {
    //
    // Load
    //
    PostData = LoadPostDataFromTempFile (InputFileName);
    if (!PostData) {
      SetOkBtnAndContent ("No saved data exists", ClosePopup);
      return;
    }
    Datas = PostData.resp.split ("::");
    RestorePostDataToForm ($("#DataForm"), Datas[0]);
    RestoreServerAddrInfoToForm ($("#RemoteCtrlForm"), Datas[1]);
  }
  
  ClosePopup ();
}

function ChangeInputValue () {
  var ThisNode = $(this);
  var RowObj = ThisNode.parents('.Row');
  
  if ((this.tagName).toLowerCase() == "input") {
    ValidateInputValue (ThisNode);
  }
  //
  // Save value to row object to reduce operating time in getting value 
  // from :input object
  //
  RowObj.attr ("value", ThisNode.val());
  
  ControlFormRow (RowObj.parents(".FormFrame"));
}

function SelectTargetForm (InnerBody, TgtFormId, TitleStr) {
  var PreFormIndex;
  var TargetForm = $(TgtFormId);
  var TargetTitle = TargetForm.attr('title');
  var InnerBodyTitleObj = InnerBody.find('.InnerTitle');
  
  //
  // Set Popup frame title
  //  
  if ((TargetTitle == '') || (TargetTitle == ' ')) {
    InnerBodyTitleObj.html (TitleStr);
  } else {
    InnerBodyTitleObj.html (TargetTitle);
  }
  if (gPopupFrameStack.length > 1) {
    $(gPopupFrameStack[gPopupFrameStack.length - 1]).css ("display", "none");
  }

  gPopupFrameStack.push (TgtFormId);
  gPopupFrameTitleStack.push (InnerBodyTitleObj.html ());
  
  TargetForm.css ("display", "");
}

function ClickPopupFromInfo () {
  var TgtFormId = "#form" + gThisNode.attr(EXP_STR_ATTR_FORMID);
  var ThisForm = gThisNode.parents('.FormFrame');
  var ThisFormId = ThisForm.attr("id");
  var MemuLink;
  var InnerBody = $('#InnerBody');
  
  if (gPopupFrameStack == null) {
    gPopupFrameStack = new Array();
  }
  if (gPopupFrameTitleStack == null) {
    gPopupFrameTitleStack = new Array();
  }
  
  if (gPopupFrameStack.length == 0) {
    ThisForm.css('display', 'none');
    $("#StdBody").css('display', 'none');
    InnerBody.css("display", "");
//    MemuLink = ThisFormId.split ("Info");
//    $('span.MenuLinkField').not('#' + MemuLink[0] + "Link").children().css('visibility', 'hidden');
//    $('#' + MemuLink[0] + "Link").children().css('disabled', true);
    gPopupFrameStack.push ("#" + ThisFormId);
  }
  
  SelectTargetForm (InnerBody, TgtFormId, gThisNode.html());
  ControlFormRow ($(TgtFormId));
  
  ClosePopup ();
}

function OperateWithLoadingPage () {
  var NodeId = $(this).attr("id");
  var NodeClass = $(this).attr("class");
  
  gThisNode = $(this);
  //
  // Show popup frame
  //
  PopupLoading ("Loading...", false);
  
  if (NodeId == "SendToServers") {
    SetPopupContent ("Processing...<br />Refresh page might cause unexpected error!");
    SetCtrlButtons (POPUP_WIN_BTN_STOP, function () {
      EnableCtrlBtn (false);
      gStopAction = true;
    });
    setTimeout (ClickSendToServers, SETUP_SET_TIMEOUT_WORK_INTERVAL);
  } else if (NodeId == "CleanAllInput") {
    setTimeout (ClickCleanAllInput, SETUP_SET_TIMEOUT_WORK_INTERVAL);
  } else if (NodeClass.indexOf("ToPopupTitle") == 0) {
    setTimeout (ClickPopupFromInfo, SETUP_SET_TIMEOUT_WORK_INTERVAL);
  }
}

function OperateToolFunc () {
  var FuncIndex = parseInt ($(this).attr("func"));
  var ShowForm;

  gThisNode = $(this);

  if ((FuncIndex == 2) || (FuncIndex == 3)) {
    PopupLoading ("Loading...", false);
    
    setTimeout (ClickOperatingFormData, SETUP_SET_TIMEOUT_WORK_INTERVAL);
  } else if (FuncIndex == 1) {
    //
    // Fetch document from server, set false would use cached data
    //
    window.location.reload (true);
  }
}

function MouseOverHelpContent () {
  var HelpObj;

  if (!gShowHelpMsg) {
    return;
  }
  
  HelpObj = $(this).siblings(".HelpField");
  if (HelpObj.length > 0) {
//    $('#HelpBody').html(ParseTxtNewLineToHtmlBr (HelpObj.html()));
    HelpObj.css ("display", "");
    HelpObj.find (".HelpPopMsg").html (ParseTxtNewLineToHtmlBr (HelpObj.find (".HelpContent").html()));
  }
}

function MouseOutHelpContent () {
  var HelpObj;

  if (!gShowHelpMsg) {
    return;
  }
  
  HelpObj = $(this).siblings(".HelpField");
  
  if (HelpObj.css ("display") != "none") {
    HelpObj.css ("display", "none");
  }
}

function ReadLoadTime () {
  var RefreshTime = new Date ();
    
  $("#FixedBottomInfo").html (
    "Last Refresh Time: " + 
    RefreshTime.getHours() + ":" + 
    RefreshTime.getMinutes() + ":" +
    RefreshTime.getSeconds()
  );
}

//
// Initialize all objects those need to bind functions
//
function InitFunctionBinding () {
  var Node;

  $('#SaveTempFileBtn')
    .click (function () {
      $(this).siblings ().css ("color", "");
      $(this).css ("color", TREE_TGT_NODE_COLOR);
//      $(this).siblings ().removeClass ("TgtLinkColor");
//      $(this).addClass ("TgtLinkColor");
      ClickMPageBtn ("SaveTFilePage");
    })
    .mouseover (MouseOverHelpContent)
    .mouseout (MouseOutHelpContent);
    
  $('#RemoteCtrlBtn')
    .click (function () {
      $(this).siblings ().css ("color", "");
      $(this).css ("color", TREE_TGT_NODE_COLOR);
//      $(this).siblings ().removeClass ("TgtLinkColor");
//      $(this).addClass ("TgtLinkColor");
      ClickMPageBtn ("RemoteCtrlPage");
    })
    .mouseover (MouseOverHelpContent)
    .mouseout (MouseOutHelpContent);

  $("#SendToServers, #CleanAllInput")
    .click(OperateWithLoadingPage)
    .mouseover (MouseOverHelpContent)
    .mouseout (MouseOutHelpContent);

  $('#SettingContent .FuncCtrl')
    .click (ClickFuncCtrl)
    .mouseover (MouseOverHelpContent)
    .mouseout (MouseOutHelpContent);
    
  $("#SettingContent").find (".ServerIp, .ServerPort, .ServerReboot, .ServerForceWrite, .ServerFunc")
    .mouseover (MouseOverHelpContent)
    .mouseout (MouseOutHelpContent);
    
  $("#UploadFrame")
    .mouseover (MouseOverHelpContent)
    .mouseout (MouseOutHelpContent);

  $("div.FormFrame .MPageClose").click (function () {
    CloseMPage ($(this).parents (".FormFrame"));
  });

  $('#SaveTFilePage span.ToolFunc')
    .click (OperateToolFunc)
    .mouseover (function () {
      var HelpObj = $(this).next();
      
      if (HelpObj.length > 0) {
        $('#HelpBody').html (ParseTxtNewLineToHtmlBr (HelpObj.html()));
      }
    })
    .mouseout(function () {
      $('#HelpBody').empty();
    });

  Node = $("div.FormFrame");

  Node.on("mouseover", ".Row", function () {
    var RowNode = $(this);
    
    RowNode.find(":input").unbind("change");
    RowNode.find(":input").change(ChangeInputValue);
    RowNode.find(".ToPopupTitle").unbind("click");
    RowNode.find(".ToPopupTitle").click(OperateWithLoadingPage);
    RowNode.find(".TitleField, .ToPopupTitle").unbind("mouseover");
    RowNode.find(".TitleField, .ToPopupTitle").mouseover(MouseOverHelpContent);
    RowNode.find(".TitleField, .ToPopupTitle").unbind("mouseout");
    RowNode.find(".TitleField, .ToPopupTitle").mouseout(MouseOutHelpContent);
  });

  $('#InnerBody .InnerBoddyClose').click(function() {
    var InnerBody = $(this).parents('#InnerBody');
    var TgtFormId = null;
    var MemuLink;
    var OuterFrame;
    var LinkObj;
    
    TgtFormId = gPopupFrameStack[gPopupFrameStack.length - 1];
    $(TgtFormId).css('display', 'none');

    gPopupFrameStack.splice (gPopupFrameStack.length - 1, 1);
    gPopupFrameTitleStack.splice (gPopupFrameTitleStack.length - 1, 1);

    TgtFormId = gPopupFrameStack[gPopupFrameStack.length - 1];
    
    if (gPopupFrameStack.length > 1) {
      $(TgtFormId).css ('display', '');
      InnerBody.find ('.InnerTitle').html (gPopupFrameTitleStack[gPopupFrameTitleStack.length - 1]);
    } else if (gPopupFrameStack.length == 1) {
      InnerBody.css ('display', 'none');
      $("#StdBody").css ('display', '');
      $(TgtFormId).css ('display', '');
      //
      // MemuLink[0] include "#"
      //
      MemuLink = TgtFormId.split ("Info");
      $('span.MenuLinkField').not (MemuLink[0] + "Link").children ().css ('visibility', '');
      $(MemuLink[0] + "Link").children ().removeAttr ('disabled');
      gPopupFrameStack.splice (gPopupFrameStack.length - 1, 1);
    } else {
      alert ("Error: Stack errors");
    }
  });
  
  $("#RemoteCtrlPage .RadioOption input[type=radio]").click (function () {
    if ($(this).filter(":checked").val() == "txt") {
      $("#FileUploadSection").css ("display", "");
      AdjustSettingFormHeight ($("#FileUploadSection").outerHeight(true));
//      $("#RemoteCtrlPage").submit();
    } else {
      $("#FileUploadSection").css ("display", "none");
      AdjustSettingFormHeight (0);
    }
  });
  //
  // Default update method is of browser settings
  //
  /*
  $("#RemoteCtrlPage .RadioOption input[type=radio]")[0].checked = true;
  */
}

$('div.SubMenu .MenuLink').click (function () {
  var ThisBtn = $(this);
  
  ThisBtn.siblings (".MenuLink[tab='tab']").css ("color", "").removeAttr ("tab");
  ThisBtn.css ("color", TREE_TGT_NODE_COLOR).attr ("tab", "tab");
//  ThisBtn.siblings (".MenuLink[tab='tab']").removeClass ("TgtLinkColor").removeAttr ("tab");
//  ThisBtn.addClass ("TgtLinkColor").attr ("tab", "tab");
  ClickTab (ThisBtn.html());
});

$("#MenuList .TreeTitle").click (function () {
  var ThisNode = $(this);
  var ChildNode = ThisNode.next ();
  
  if (ChildNode) {
    if (ChildNode.is (":visible")) {
      ChildNode.css ("display", "none");
    } else {
      ChildNode.css ("display", "");
    }
  }
});

$("#HelpMsgSwitch").click (function () {
  if ($(this).find ("input").is (":checked")) {
    gShowHelpMsg = true;
  } else {
    gShowHelpMsg = false;
  }
});

function InitBootOrderTable () {
  var RowNodes = $('div#BootOrderTable').find ('span.BootDeviceRow');
  var RowTableheight = 0;
  var Order;

  $.each (RowNodes, function (index, obj) {
    //
    // Read order value
    //
    Order = parseInt($(obj).find('input').val());
    //
    // Set absolute position's top dependend on order value
    //
    $(obj).css('top', $(obj).outerHeight(true) * Order);
    //
    // Plus all row's height
    //
    RowTableheight += $(obj).outerHeight(true);
  });
  
  $('#BootOrderTable').height (RowTableheight);
  
  $('.BootOrderControl').click (function () {
    var Node = $(this).siblings('.BootOrder'); // input text
    var TotalNum = $('.BootOrder').length;
    var OthersRows;
    var ThisOrder = 0;
    var OtherOrder = 0;
    var IsUp = false;
    
    ThisOrder = parseInt(Node.val());
    //
    // Change order value
    //
    if ($(this).hasClass('BootOrderUp')) {
      if (ThisOrder == 0) {
        return;
      }
      IsUp = true;
      Node.val(ThisOrder - 1);
    } else {
      if ((ThisOrder + 1) == TotalNum) {
        return;
      }
      Node.val(ThisOrder + 1);
    }
    ThisOrder = parseInt(Node.val());
    //
    // Change absolute position
    //
    Node.parents('.BootDeviceRow').css('top', Node.parents('.BootDeviceRow').outerHeight(true) * ThisOrder);
    //
    // Change positions of other items
    //
    OthersRows = Node.parents('.BootDeviceRow').siblings();
    $.each(OthersRows, function (index, obj) {
      OtherOrder = parseInt ($(obj).find('input').val());
      if (ThisOrder == OtherOrder) {
        if (IsUp == true) {
          $(obj).find('input').val(OtherOrder + 1);
        } else {
          $(obj).find('input').val(OtherOrder - 1);
        }
        //
        // Read order value again
        //
        OtherOrder = parseInt($(obj).find('input').val());
        //
        // Set absolute position's top dependend on order value
        //
        $(obj).css('top', $(obj).outerHeight(true) * OtherOrder);
      }
    });
  });
  $('div#BootOrderLoading').css ("display", "none");
  $('div#BootOrderContent').css ("display", "");
}

function AsyncInitialization () {
  setTimeout (InitSystemTimer, 100);
  setTimeout (ReadFileGenTime, 600);
  //setTimeout (InitUploadFile, 1100); // Read and insert upload frame
  setTimeout (ReadLoadTime, 1600);
  //setTimeout (AutoCheckConnection, 2100);
  setTimeout (InitBootOrderTable, 2600);
}


