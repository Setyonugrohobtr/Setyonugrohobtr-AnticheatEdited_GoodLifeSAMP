//Anti Illegal program by Igram
//Bug Fixed by Setyo Nugroho (GoodLife)


#include <a_samp>
#include <zcmd>
#pragma tabsize 4
#define PUB:%1(%2) forward %1(%2); public %1(%2)
#define FREEZE_SECONDS 4
#define COLOR_RED 0xFF0000FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_WHITE 0xFFFFFFFF

enum pinfo {
        firstspawn,
        pname[MAX_PLAYER_NAME],
        hacker
};
new gpInfo[MAX_PLAYERS][pinfo];
public OnPlayerConnect(playerid) {
        gpInfo[playerid][hacker] = 0;
        gpInfo[playerid][firstspawn] = 1;
        GetPlayerName(playerid, gpInfo[playerid][pname], MAX_PLAYER_NAME);
        SendClientMessage(playerid, COLOR_WHITE, "This server protected with {FF0000}[Hack Shield] {FFFF00}by igram/Heathrow.");
        return 1;
}
public OnPlayerSpawn(playerid) {
        	if(gpInfo[playerid][firstspawn] == 1) {
            gpInfo[playerid][firstspawn] = 0;
            SetCameraBehindPlayer(playerid);
            TogglePlayerControllable(playerid, 0);
            SetTimerEx("HackCheck", FREEZE_SECONDS * 1000, 0, "i", playerid);
            SendClientMessage(playerid, -1, "[Hack Shield]:You are currently being checked... please wait...");
        	}
        	return 1;
}
PUB:HackCheck(playerid)
		{
        new Float:x, Float:y, Float:z;
        GetPlayerCameraFrontVector(playerid, x, y, z);
        #pragma unused x
        #pragma unused y
        if(z < -0.8) {
        	new string[128];
            gpInfo[playerid][hacker] = 1;
            SendClientMessage(playerid, COLOR_RED, "[Hack Shield]: You have been kicked, Reason: Connected with illegal program. ");
			KickEx(playerid);
			format(string,sizeof(string),"[Hack Shield]: {FFFF00}%s {FFFFFF}has connected with Illegal program.{FFFF00}(Kicked)", gpInfo[playerid][pname]);
			SendClientMessageToAll(COLOR_RED, string);
        }
        else {
        }
        TogglePlayerControllable(playerid, 1);
        SendClientMessage(playerid, COLOR_GREY, "[Hack Shield]: You have been succesfully checked. ");
        return 1;
}
CMD:hackers(playerid, params[]) {
        if(!IsPlayerAdmin(playerid)) return 0;
        SendClientMessage(playerid, -1, "Hackers online:");
        new string[128];
        for(new i=0; i<MAX_PLAYERS;++i) {
            if(gpInfo[i][hacker] == 1) {
                format(string, sizeof string, "%s[%d]", gpInfo[i][pname], i);
                SendClientMessage(playerid, -1, string);
                }
        }
        return 1;
}
forward KickPublic(playerid);
public KickPublic(playerid)
{
    Kick(playerid);
}
KickEx(playerid)
{
    SetTimerEx("KickPublic", 1000, 0, "d", playerid);
}
