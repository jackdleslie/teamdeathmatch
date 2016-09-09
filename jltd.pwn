/*
	Jack Leslie's Team Deathmatch Starter Script
	Copyright Jack Leslie 2016c All Rights Reserved
	You do not have permission to publish this material as your own
	You do not have permission to remove this copyright notice
	You do have permission to publish this script as an edit with original credit
	
	This is the y_ini file version for public use
	A mysql version will be released shortly after for private use

	Respective credits to the respective creators and developers of includes used
	'Pawno color generator' by Red John used to generate colors for quicker scripting
*/

// Includes
#include <a_samp>
#include <YSI\y_ini>
#include <YSI\y_classes>
#include <streamer>
#include <sscanf2>

// Defines
#define PATH "/accounts/%s.ini"

#define serverName "Los Santos Gang Wars"

#define COLOR_GROVE 0x008000FF
#define COLOR_BALLAS 0x800080FF
#define COLOR_AZTECAS 0x00FFFFFF
#define COLOR_VAGOS 0xFFFF00FF
#define COLOR_NANG 0x808000FF
#define COLOR_RIFA 0x408080FF
#define COLOR_TRIADS 0x494747FF
#define COLOR_BIKERS 0x800000FF
#define COLOR_RMAFIA 0x8080C0FF
#define COLOR_IMAFIA 0x804000FF
#define COLOR_DARKGREY 0x808080FF
#define COLOR_LIGHTGREY 0xC0C0C0FF
#define COLOR_POLICE 0x0000FFFF

#define DIALOG_LOGIN                	1
#define DIALOG_REGISTER             	2

// Enumerations and Variables
new teamGrove;
new teamBallas;
new teamAztecas;
new teamVagos;
new teamNang;
new teamRifa;
new teamBikers;
new teamRMafia;
//new teamIMafia;
new teamPolice;

new Text:classSelectionTextdraw1[MAX_PLAYERS];
new Text:classSelectionTextdraw2[MAX_PLAYERS];
new Text:classSelectionTextdraw3[MAX_PLAYERS];
new Text:classSelectionTextdraw4[MAX_PLAYERS];
new Text:classSelectionTextdraw5[MAX_PLAYERS];

new gIsPlayerLoggedIn[MAX_PLAYERS];
new gIsPlayerRegistered[MAX_PLAYERS];


enum account_Data {
	pPassword,
	pTeam,
	pAdminLevel,
	pAdminKey,
	pKills,
	pDeaths,
	Float:pHealth,
	Float:pArmour,
	pMoney,
	pSkin
};
new accountData[MAX_PLAYERS][account_Data];

// Callbacks

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
	INI_Int("Password", accountData[playerid][pPassword]);
	INI_Int("AdminLevel", accountData[playerid][pAdminLevel]);
	INI_Int("AdminKey", accountData[playerid][pAdminKey]);
	INI_Int("Kills", accountData[playerid][pKills]);
    INI_Int("Deaths", accountData[playerid][pDeaths]);
    INI_Float("Health", accountData[playerid][pHealth]);
    INI_Float("Armour", accountData[playerid][pArmour]);
    INI_Int("Money", accountData[playerid][pMoney]);
    INI_Int("Skin", accountData[playerid][pSkin]);
    INI_Int("Team", accountData[playerid][pTeam]);
 	return 1;
}

forward SetPlayerLocation(playerid, team);
public SetPlayerLocation(playerid, team)
{
	new Float: x, Float: y, Float: z, Float: a;
	switch(team)
	{
		case 1: { x = 2493.9133; y = -1682.3986; z = 13.3382; a = 0.00; }
		case 2: { x = 2005.2261; y = -1119.7739; z = 26.7813; a = 172.7240; }
	    case 3: { x = 2652.2991; y = -2012.1755; z = 13.5547; a = 296.3887; }
	    case 4: { x = 1883.0979; y = -2002.1365; z = 13.5469; a = 178.5362; }
	    case 5: { x = 1617.1896; y = -1843.7661; z = 13.5332; a = 204.6284; }
	    case 6: { x = 310.1770; y = -1770.2499; z = 4.5789; a = 233.9678; }
	    case 7: { x = 681.0540; y = -476.5241; z = 16.3359; a = 177.9371; }
	    case 8: { x = 1025.9265; y = -1123.8169; z = 23.8770; a = 197.2713; }
	    case 9: { x = 1583.7803; y = -1631.9534; z = 13.3828; a = 73.0974; }
	    default: { x = 0.00; y = 0.00; z = 0.00; a = 0.00; }
	}
	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, a);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	return 1;
}


main()
{
	print("\n----------------------------------------------");
	print(" Jack Leslie's Team Deathmatch Starter Script ");
	print("----------------------------------------------\n");
}



public OnGameModeInit()
{
	SetGameModeText("JL:TD");
	
	teamGrove = Class_Add(105, 2493.9133, -1682.3986, 13.3382, 0.0, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
	teamBallas = Class_Add(102, 2005.2261, -1119.7739, 26.7813, 172.7240, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
	teamAztecas = Class_Add(114, 2652.2991, -2012.1755, 13.5547, 296.3887, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
	teamVagos = Class_Add(108, 1883.0979, -2002.1365, 13.5469, 178.5362, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
	teamNang = Class_Add(121, 1617.1896, -1843.7661, 13.5332, 204.6284, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
    teamRifa = Class_Add(173, 310.1770, -1770.2499, 4.5789, 233.9678, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
    teamBikers = Class_Add(254, 681.0540,-476.5241,16.3359,177.9371, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
    teamRMafia = Class_Add(111, 1025.9265, -1123.8169, 23.8770, 197.2713, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
    teamPolice = Class_Add(281, 1583.7803, -1631.9534, 13.3828, 73.0974, WEAPON_MP5, 500, WEAPON_ARMOUR, 50);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    new string[124];
    
	if(fexist(UserPath(playerid)))
	{
	    gIsPlayerRegistered[playerid] = 1;
	    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
		SetPlayerPos(playerid, 1358.289, -950.175, -5.00);
		SetPlayerCameraPos(playerid, 1358.289, -950.175, 33.669);
		SetPlayerCameraLookAt(playerid, 1359.223, -947.474, 34.187);
		format(string, sizeof(string), "{FFFFFF}Welcome back to %s,\n\nPlease enter your password to login.", serverName);
  		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF}Login to an Existing Account", string, "Login", "Leave");

		return 1;
	}
	else
	{
		TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
		TextDrawShowForPlayer(playerid, classSelectionTextdraw2[playerid]);
		TextDrawShowForPlayer(playerid, classSelectionTextdraw3[playerid]);
		TextDrawShowForPlayer(playerid, classSelectionTextdraw4[playerid]);
		TextDrawShowForPlayer(playerid, classSelectionTextdraw5[playerid]);

	 	if(classid == teamGrove)
	  	{
			SetPlayerPos(playerid, 2458.6174, -1696.0648, 0.0);
	  		SetPlayerCameraPos(playerid, 2458.278, -1684.794, 28.413);
			SetPlayerCameraLookAt(playerid, 2493.913, -1682.398, 13.338);
			format(string, sizeof(string), "Grove St. Families");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_GROVE);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 1;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}

		if(classid == teamBallas)
		{
			SetPlayerPos(playerid, 1985.7264, -1143.9445, 0.00);
	   		SetPlayerCameraPos(playerid, 1975.772, -1150.537, 32.866);
			SetPlayerCameraLookAt(playerid,1992.586, -1140.681, 25.529);
			format(string, sizeof(string), "Glen Park Ballas");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_BALLAS);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 2;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}

		if(classid == teamAztecas)
		{
	 		SetPlayerPos(playerid, 2697.3435, -1985.8120, -5.00);
			SetPlayerCameraPos(playerid, 2702.148, -1992.939, 16.302);
			SetPlayerCameraLookAt(playerid, 2695.805, -1998.054, 13.547);
			format(string, sizeof(string), "Los Aztecas");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_AZTECAS);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 3;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}

		if(classid == teamVagos)
		{
	 		SetPlayerPos(playerid, 1881.8694,-2050.1892,-5.00);
			SetPlayerCameraPos(playerid,1878.353,-2057.771,14.329);
			SetPlayerCameraLookAt(playerid,1878.866,-2051.116,13.382);
			format(string, sizeof(string), "Los Santos Vagos");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_VAGOS);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 4;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}

		if(classid == teamNang)
		{
	 		SetPlayerPos(playerid, 2697.3435, -1985.8120, -5.00);
			SetPlayerCameraPos(playerid,1613.528,-1784.622,14.131);
			SetPlayerCameraLookAt(playerid,1614.588,-1787.776,13.471);
			format(string, sizeof(string), "Da Nang Boys");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_NANG);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 5;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}

	    if(classid == teamRifa)
		{
	 		SetPlayerPos(playerid, 1617.1896,-1843.7661,-5.00);
			SetPlayerCameraPos(playerid,277.441,-1799.912,8.431);
			SetPlayerCameraLookAt(playerid,286.225,-1796.259,4.390);
			format(string, sizeof(string), "Los Santos Rifa");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_RIFA);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 6;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}

		if(classid == teamBikers)
		{
	 		SetPlayerPos(playerid, 674.4105, -475.4872, -5.00);
			SetPlayerCameraPos(playerid,663.823,-494.759,17.524);
			SetPlayerCameraLookAt(playerid,667.020,-490.379,16.335);
			format(string, sizeof(string), "Los Santos Bikies");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_BIKERS);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 7;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}

	    if(classid == teamRMafia)
		{
	 		SetPlayerPos(playerid, 1025.5427, -1138.2739, -5.00);
			SetPlayerCameraPos(playerid, 1027.122, -1151.055, 27.167);
			SetPlayerCameraLookAt(playerid,1025.542, -1138.273, 23.656);
			format(string, sizeof(string), "Russian Mafia");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_RMAFIA);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 8;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}

	    /*if(classid == teamIMafia)
		{
	 		SetPlayerPos(playerid, 335.5112,-1588.2958,-5.00);
			SetPlayerCameraPos(playerid,341.054,-1609.225,44.013);
			SetPlayerCameraLookAt(playerid,335.511,-1588.295,33.101);
			format(string, sizeof(string), "Italian Mafia");
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_IMAFIA);
		}*/

		if(classid == teamPolice)
		{
	 		SetPlayerPos(playerid, 1509.8518,-1612.1667,-5.00);
			SetPlayerCameraPos(playerid,1506.578,-1608.765,14.616);
			SetPlayerCameraLookAt(playerid,1509.851,-1612.166,14.046);
			format(string, sizeof(string), "Los Santos Police Department");
			TextDrawColor(classSelectionTextdraw1[playerid], COLOR_POLICE);
			TextDrawSetString(classSelectionTextdraw1[playerid], string);
	        TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
			TextDrawShowForPlayer(playerid, classSelectionTextdraw1[playerid]);
			accountData[playerid][pTeam] = 9;
			accountData[playerid][pSkin] = GetPlayerSkin(playerid);
			return 1;
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	gIsPlayerLoggedIn[playerid] = 0;
	gIsPlayerRegistered[playerid] = 0;
	SetSpawnInfo(playerid, 0, 0, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);
	
	classSelectionTextdraw1[playerid] = TextDrawCreate(144.000000, 140.000000, "Grove Street Families");
	TextDrawBackgroundColor(classSelectionTextdraw1[playerid], 255);
	TextDrawFont(classSelectionTextdraw1[playerid], 0);
	TextDrawLetterSize(classSelectionTextdraw1[playerid], 0.819999, 2.499999);
	TextDrawColor(classSelectionTextdraw1[playerid], 16711935);
	TextDrawSetOutline(classSelectionTextdraw1[playerid], 0);
	TextDrawSetProportional(classSelectionTextdraw1[playerid], 1);
	TextDrawSetShadow(classSelectionTextdraw1[playerid], 1);

	classSelectionTextdraw2[playerid] = TextDrawCreate(149.000000, 225.000000, "Please choose your team carefully.");
	TextDrawBackgroundColor(classSelectionTextdraw2[playerid], 255);
	TextDrawFont(classSelectionTextdraw2[playerid], 1);
	TextDrawLetterSize(classSelectionTextdraw2[playerid], 0.330000, 1.200000);
	TextDrawColor(classSelectionTextdraw2[playerid], COLOR_LIGHTGREY);
	TextDrawSetOutline(classSelectionTextdraw2[playerid], 0);
	TextDrawSetProportional(classSelectionTextdraw2[playerid], 1);
	TextDrawSetShadow(classSelectionTextdraw2[playerid], 1);

	classSelectionTextdraw3[playerid] = TextDrawCreate(147.000000, 236.000000, "You can only change your team by registering a new account.");
	TextDrawBackgroundColor(classSelectionTextdraw3[playerid], 255);
	TextDrawFont(classSelectionTextdraw3[playerid], 1);
	TextDrawLetterSize(classSelectionTextdraw3[playerid], 0.330000, 1.200000);
	TextDrawColor(classSelectionTextdraw3[playerid], COLOR_LIGHTGREY);
	TextDrawSetOutline(classSelectionTextdraw3[playerid], 0);
	TextDrawSetProportional(classSelectionTextdraw3[playerid], 1);
	TextDrawSetShadow(classSelectionTextdraw3[playerid], 1);

	classSelectionTextdraw4[playerid] = TextDrawCreate(147.000000, 248.000000, "You can change your skin inside your teams headquarters.");
	TextDrawBackgroundColor(classSelectionTextdraw4[playerid], 255);
	TextDrawFont(classSelectionTextdraw4[playerid], 1);
	TextDrawLetterSize(classSelectionTextdraw4[playerid], 0.330000, 1.200000);
	TextDrawColor(classSelectionTextdraw4[playerid], COLOR_DARKGREY);
	TextDrawSetOutline(classSelectionTextdraw4[playerid], 0);
	TextDrawSetProportional(classSelectionTextdraw4[playerid], 1);
	TextDrawSetShadow(classSelectionTextdraw4[playerid], 1);

	classSelectionTextdraw5[playerid] = TextDrawCreate(500.000000, 225.000000, "     ");
	TextDrawBackgroundColor(classSelectionTextdraw5[playerid], 255);
	TextDrawFont(classSelectionTextdraw5[playerid], 1);
	TextDrawLetterSize(classSelectionTextdraw5[playerid], 0.500000, 1.000000);
	TextDrawColor(classSelectionTextdraw5[playerid], -1);
	TextDrawSetOutline(classSelectionTextdraw5[playerid], 0);
	TextDrawSetProportional(classSelectionTextdraw5[playerid], 1);
	TextDrawSetShadow(classSelectionTextdraw5[playerid], 1);
	TextDrawUseBox(classSelectionTextdraw5[playerid], 1);
	TextDrawBoxColor(classSelectionTextdraw5[playerid], 55);
	TextDrawTextSize(classSelectionTextdraw5[playerid], 130.000000, 33.000000);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new Float:health, Float:armour;
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, armour);
	
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File, "Password", accountData[playerid][pPassword]);
	INI_WriteInt(File, "Money", GetPlayerMoney(playerid));
	INI_WriteInt(File, "AdminLevel", accountData[playerid][pMoney]);
	INI_WriteInt(File, "Kills", accountData[playerid][pKills]);
	INI_WriteInt(File, "Deaths", accountData[playerid][pDeaths]);
	INI_WriteInt(File, "Team", accountData[playerid][pTeam]);
	INI_WriteInt(File, "Skin", accountData[playerid][pSkin]);
	INI_WriteInt(File, "AdminKey", accountData[playerid][pAdminKey]);
	INI_Close(File);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(gIsPlayerLoggedIn[playerid] == 0 && gIsPlayerRegistered[playerid] == 1) return 1;
	else
	{
	    TextDrawHideForPlayer(playerid, classSelectionTextdraw1[playerid]);
	    TextDrawHideForPlayer(playerid, classSelectionTextdraw2[playerid]);
	    TextDrawHideForPlayer(playerid, classSelectionTextdraw3[playerid]);
	    TextDrawHideForPlayer(playerid, classSelectionTextdraw4[playerid]);
	    TextDrawHideForPlayer(playerid, classSelectionTextdraw5[playerid]);
	    if(gIsPlayerRegistered[playerid] == 0)
	    {
	        gIsPlayerRegistered[playerid] = 1;
			SetPlayerPos(playerid, 1358.289, -950.175, -5.00);
			SetPlayerCameraPos(playerid, 1358.289, -950.175, 33.669);
			SetPlayerCameraLookAt(playerid, 1359.223, -947.474, 34.187);
	        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "{FFFFFF}Register a New Account", "{FFFFFF}You've chosen your team,\n\nNow please enter a password to protect your account", "Submit", "Leave");
	        return 1;
	    }
	    SetPlayerLocation(playerid, accountData[playerid][pTeam]);
	    SetPlayerSkin(playerid, accountData[playerid][pSkin]);
	    GivePlayerMoney(playerid, accountData[playerid][pMoney]);
	    SetPlayerHealth(playerid, accountData[playerid][pHealth]);
	    SetPlayerArmour(playerid, accountData[playerid][pArmour]);
	    TogglePlayerControllable(playerid, 1);
	}

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SetPlayerLocation(playerid, accountData[playerid][pTeam]);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new string[1024];
	switch(dialogid)
    {
        case DIALOG_REGISTER:
        {
            SendClientMessage(playerid, -1, "dialog_Register");
       		TogglePlayerControllable(playerid, 0);
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "{FFFFFF}Register a New Account", "{FFFFFF}You've chosen your team,\n\nNow please enter a password to protect your account.", "Submit", "Leave");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File, "data");
                
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File, "Money", 0);
                INI_WriteInt(File, "AdminLevel", 0);
                INI_WriteInt(File, "AdminKey", 1234);
                INI_WriteInt(File, "Kills", 0);
                INI_WriteInt(File, "Deaths" ,0);
                INI_WriteFloat(File, "Health", 100);
                INI_WriteFloat(File, "Armour", 0);
                INI_WriteInt(File, "Team", accountData[playerid][pTeam]);
                INI_WriteInt(File, "Skin", accountData[playerid][pSkin]);
                INI_Close(File);

                gIsPlayerRegistered[playerid] = 1;
                accountData[playerid][pHealth] = 100;
				
				new name[MAX_PLAYER_NAME];
				GetPlayerName(playerid, name, sizeof(name));
				format(string, sizeof(string), "Thanks for registering an acccount, %s! Have fun and stay alive.", name);
				SendClientMessage(playerid, COLOR_LIGHTGREY, string);
				return 1;
			}
        } // end of

        case DIALOG_LOGIN:
        {
       		TogglePlayerControllable(playerid, 0);
            if (!response) return Kick (playerid);
            if(response)
            {
                if(udb_hash(inputtext) == accountData[playerid][pPassword])
                {
					gIsPlayerLoggedIn[playerid] = 1;
     				SpawnPlayer(playerid);
                }
                else
                {
                    format(string, sizeof(string), "{FFFFFF}Welcome back to %s,\n\nYou have entered an incorrect password.", serverName);
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF}Login to an Existing Account", string, "Login", "Leave");
                }
                return 1;
            }
        } // end of
    }
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

stock UserPath(playerid)
{
	new string[128],playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	format(string,sizeof(string),PATH,playername);
	return string;
}

/*Credits to Dracoblue*/
stock udb_hash(buf[]) {
	new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}
