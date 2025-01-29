    AntiDeAMX()
    {
        new a[][] =
        {
            "Unarmed(Fist)",
            "BrassK",
            "SysCore"
        };
        #pragma unused a
    }
#define SSCANF_NO_NICE_FEATURES
#define Maxp 50
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define SetPlayerHealthAll(%0) for(new i; i < Maxp; i++) SetPlayerHealth(i,%0)
#define SetPlayerArmourAll(%0) for(new i; i < Maxp; i++) SetPlayerArmour(i,%0)
#define PlayAudioStreamForAll(%0) for(new i; i < Maxp; i ++) PlayAudioStreamForPlayer(i,%0)
#define ShowPlayerAnimTextDraw(%0) TextDrawShowForPlayer(%0,stopanimation) && TextDrawShowForPlayer(%0,enteranimlist)
#define HidePlayerAnimTextDraw(%0) TextDrawHideForPlayer(%0,stopanimation) && TextDrawHideForPlayer(%0,enteranimlist)
//====== Includes ======
#include <a_samp>
#include <DOF2>
#include <sscanf2>
#include <zcmd>
//====== Colors ======
#define White 0xFFFFFFFF
#define Red 0xFF0000FF
#define Blue 0x0080FFFF
#define Green 0x28cb00FF
#define Yellow 0xFFFF00FF
#define Lightblue 0x00FFFFFF
#define Lightgreen 0x00FF00FF
#define Gray 0xC0C0C0FF
#define Skyblue 0x40bfffAA
#define Skygreen 0x38ffd2AA
#define Gold 0xFFC600FF
#define Aqua 0x03FCDDFF
#define AquaGreen 0xe4de26FF
#define Prp 0x9901FEFF
#define TitanGold 0xdaa520ff
#define TeamAColor 0x00ebf3ff
#define TeamBColor 0xe60000ff
#define PositiveDamage 0x2aec3eff
#define NegetiveDamage 0xec2a2aff
#define Actcolor 0x47ddf2ff
//====== Teams ======
#define A 1
#define B 2
//====== Areas ======
#define Light 1
#define Heavy 2
#define War 3
#define RPG 4
#define Sniper 5
#define AP 6
#define WH 7
#define BR 8
#define GG 12
#define WarAct 13
#define KartAct 14
//========= [Activity Vars] =========
new OpenActivity;
new bool:RegisteredToAct[Maxp];
new PlayersInAct[10];
new bool:ActReg;
new bool:ActIsRunning;
#define open true
#define close false
#define none 0
#define gg_act 1
#define war_act 2
#define kart_act 3

#define losesound 31202
#define winsound 31205
#define leveldownsound 1055
#define levelupsound 21002
#define errorsound 1085
//=-======= [Kart Activity] ==========
new KartPlayer[5];
new Kart1,Kart2,Kart3,Kart4;
new Checkpoints[Maxp];
new bool:BoostCooldown[Maxp];
//=-======= [War Activity] ==========
new Float:WarActSpawns[][] =
{
	{-1132.6047,1023.4553,1345.7272,269.3028},//1
	{-1133.2439,1094.4086,1345.7997,268.4253},//2
	{-1056.6184,1067.3824,1341.3516,19.2522},//3
	{-1081.9878,1042.6143,1343.8086,269.3497},//4
	{-1008.9103,1022.6705,1341.0078,0.9221},//5
	{-973.9031,1095.1508,1344.9825,89.2669},//6
	{-969.4869,1026.2128,1345.0747,0.0053},//7
	{-1031.2400,1077.2662,1343.1211,175.3561},//8
	{-1129.3293,1057.7114,1346.4141,270.5198},//9
	{-1133.1982,1078.3855,1353.4482,268.6870},//10
	{-1009.4605,1073.8455,1341.2334,181.5515},//11
	{-1069.9253,1088.4108,1346.2660,91.1380},//12
	{-1060.2052,1074.7631,1341.3516,86.2656},//13
	{-1089.3711,1044.3966,1347.3386,318.9569},//14
	{-1129.7208,1057.6422,1346.4141,269.4889}//15
};
new WarWeapons[] =
{
    26, // Sawn-off Shotgun
    24, // Desert Eagle
    25, // Shotgun
    27, // Combat Shotgun
    28, // Uzi
    29, // MP5
    30, // AK-47
    31, // M4
    32, // Tec-9
    33, // Rifle
    34,  // Sniper Rifle
    24, // Desert Eagle
    25, // Shotgun
    27, // Combat Shotgun
    28, // Uzi
    29, // MP5
    30, // AK-47
    31, // M4
    32, // Tec-9
    33, // Rifle
    34  // Sniper Rifle
};
//=-======= [GG Activity] ==========
new Text:gungameleveltext[Maxp];
new Float:GGSpawns[][] =
{
    {1387.3025,2148.2285,18.6782,88.3709},
    {1315.8524,2168.8374,18.6782,269.8157},
    {1385.2765,2186.7666,11.0234,140.1179},
    {1367.7897,2107.4558,11.0156,1.0436},
    {1338.8641,2190.7144,11.0234,180.5618},
    {1304.1587,2174.3794,11.0234,270.4895},
    {1330.3875,2130.8613,11.0156,310.2835},
    {1372.6831,2144.8235,11.0156,55.2511},
    {1355.7158,2171.1086,11.0156,165.8822},
    {1349.8232,2110.0862,11.0156,55.2979}
};
#define level1weapon 23
#define level2weapon 22
#define level3weapon 24
#define level4weapon 25
#define level5weapon 26
#define level6weapon 29
#define level7weapon 30
#define level8weapon 38
#define level9weapon 16
#define level10weapon 8
new GGLevel[Maxp];
new GGDeath[Maxp];
//====== Dialogs ======
#define Dialog_Radio 2
#define Dialog_Teams 3
#define Dialog_Titan 4
#define Dialog_RPanel 5
#define Dialog_Fulledit 6
#define Dialog_Killfull 7
#define Dialog_Pec 8
#define Dialog_Cdedit 9
#define Dialog_Titanpanel 10
#define Dialog_Titansetpass 11
#define Dialog_Register 12
#define Dialog_Login 13
#define Dialog_Showpass 14
#define Dialog_Settings 15
#define Dialog_Hitsound 16
#define Dialog_Changepass 17
#define Dialog_Showpass2 18
#define Dialog_PInfo 19
#define Dialog_Texthit 20
#define Dialog_Changenick 21
#define Dialog_Acts 22
//====== Vars ======
new Text:PosDamage[Maxp];
new Text:NegDamage[Maxp];
new Text:stopanimation;
new Text:enteranimlist;
new pName[MAX_PLAYER_NAME];
new ChatLock;
new ChatAccess[Maxp];
new Team[Maxp];
new Mute[Maxp];
new KillFull = 0;
new TextHit;
new Freeze[Maxp];
new Admin[Maxp];
new InClass[Maxp];
new InSpec[Maxp];
new Area[Maxp];
new Kills[Maxp];
new iname[MAX_PLAYER_NAME];
new pname[MAX_PLAYER_NAME];
new TotalKills[Maxp];
new TotalDeaths[Maxp];
new VehicleGodMode[Maxp];
new str[500];
new HitSound[Maxp];
new SavedSkin[Maxp];
new reportedonsomeone[Maxp];
new TitanCode[128];
new LoggedToTitan[Maxp];
new Float:playerPos[MAX_PLAYERS][3];
new FakeUser[Maxp];
new Tag[Maxp][25];
new bool:InAnimation[Maxp];
#define SendFormatMessage(%0,%1,%2,%3) format(str, sizeof(str),%2,%3) && SendClientMessage(%0, %1, str)
#define SendFormatMessageToAll(%0,%1,%2) format(str, sizeof(str),%1,%2) && SendClientMessageToAll(%0, str)
new Text:C1,Text:C2,Text:C3;
new Text:time;
new Text:nametext[Maxp];
new AdminCanSeePM[Maxp];
new AdminCanSeeCMD[Maxp];
new bool:LoggedIn[Maxp];
new targetRe[Maxp];
new bool:AmramMode[Maxp];
new bool:ForcedToExitAmram[Maxp];
new PreSkin[Maxp];
new PreTag[Maxp];
new oldname[Maxp][MAX_PLAYER_NAME];
new ghour[Maxp];
new gminutes[Maxp];
new CDOn;
forward CountDown(cd);
//========= CW Vars ==========
new bool:CWOn = false;
new InCWTeam[Maxp];
new bool:GreenPlayer[Maxp][4];
new bool:OrangePlayer[Maxp][4];
new GreenCount = 0;
new OrangeCount = 0;
new GreenDeath = 0;
new OrangeDeath = 0;
new GreenScore = 0;
new OrangeScore = 0;
new bool:TeamHasChosen[3] = false;
new bool:DiedLastInCW[Maxp];
new TeamMembers = 0;
new CWMaxRounds = 5;
#define CW 9
#define CWVIEW 10
#define CWSPEC 11
#define CWGreenColor 0x44EE16FF
#define CWOrangeColor 0xFF9B00FF
#define None 0
#define TGreen 1
#define TOrange 2
new Float:CwSpecSpawns[][] =
{
	{1097.8845,1300.1615,16.3110,267.8501},
	{1097.8845,1305.1615,16.3110,267.8501},
	{1097.8845,1310.1615,16.3110,267.8501},
	{1097.8845,1315.1615,16.3110,267.8501}
};
new Float:CwViewersSpawns[][] =
{
    {1176.9910,1286.6106,16.3110,86.3684},
    {1176.6486,1277.5153,16.3110,86.3683},
    {1177.0830,1268.8840,16.3110,89.0396},
    {1176.7350,1259.7380,16.3110,82.8068},
    {1176.7257,1248.8624,16.3110,84.5067},
    {1176.7125,1281.0686,16.3110,86.9350},
    {1176.7850,1289.7222,16.3110,87.3397},
    {1176.8708,1297.9169,16.3110,93.6534},
    {1177.0085,1308.7780,16.3110,96.2437},
    {1176.6516,1316.6860,16.3110,87.2588},
    {1176.8910,1327.7734,16.3110,96.8912}
};
//=====================================
new Float:WarSpawns[][] =
{
    {-1425.2837,1252.2819,1039.8672,257.5489},
    {-1413.2968,1266.8794,1039.8672,218.6949},
    {-1410.8412,1224.9440,1039.8741,329.6159},
    {-1395.5059,1219.3857,1039.8672,1.8895}
};
//  <====== Mode ======>

main()
{
    print("\n----------------------------------");
    print("-- • Clan War - Gamemode by PreLoX • --");
    print("----------------------------------\n");
}
forward UpdateTimeText();
public UpdateTimeText()
{
    new hour, minute;
    gettime(hour, minute);
    new string[6];
    format(string, sizeof(string), "%02d:%02d", hour, minute);
    TextDrawSetString(time, string);
}
public OnGameModeInit()
{
    UsePlayerPedAnims();
	OpenActivity = none;
	SetGameModeText("ClanWar v3.0 (By PreLoX)");
    if(!DOF2_FileExists("RconOptions/Settings.ini"))
    {
    	DOF2_CreateFile("RconOptions/Settings.ini");
    	DOF2_SetInt("RconOptions/Settings.ini","Full",1);
    	//DOF2_SetInt("RconOptions/Settings.ini","AutoMessage",1);
    	DOF2_SetInt("RconOptions/Settings.ini","MaxCD",10);
    	DOF2_SetInt("RconOptions/Settings.ini","PlayerEnterCar",0);
    	DOF2_SetInt("RconOptions/Settings.ini","RegisteredPlayers",0);
    	DOF2_SetString("RconOptions/Settings.ini","TitanCode","titan5566");
    	DOF2_SetInt("RconOptions/Settings.ini","TextHit",1);
    }
    TextHit = DOF2_GetInt("RconOptions/Settings.ini","TextHit");
    TitanCode = DOF2_GetString("RconOptions/Settings.ini","TitanCode");
    if(!DOF2_FileExists("RconOptions/IPList.ini"))DOF2_CreateFile("RconOptions/IPList.ini");
    //if(!DOF2_FileExists("RconOptions/FakeUsers.ini"))DOF2_CreateFile("RconOptions/FakeUsers.ini");
    DOF2_SaveFile();
    //SetTimer("AutoMessage",60000*10,1);
//  Team A
    AddPlayerClass(1, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//0
    AddPlayerClass(2, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//1
    AddPlayerClass(267, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//2
    AddPlayerClass(268, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//3
    AddPlayerClass(269, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//4
    AddPlayerClass(270, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//5
    AddPlayerClass(271, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//6
//  Team B
    AddPlayerClass(1, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//7
    AddPlayerClass(2, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//8
    AddPlayerClass(267, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//9
    AddPlayerClass(268, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//10
    AddPlayerClass(269, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//11
    AddPlayerClass(270, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//12
    AddPlayerClass(271, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);//13

	C1 = TextDrawCreate(9.666666, 431.644449, "Clan War");
	TextDrawLetterSize(C1, 0.280455, 1.321261);
	TextDrawTextSize(C1, 70, 447);
	TextDrawAlignment(C1, 1);
	TextDrawColor(C1, 0xF2D231FF);
	TextDrawUseBox(C1, 0);
	TextDrawBoxColor(C1, 0x000000AA);
	TextDrawSetShadow(C1, 1);
	TextDrawSetOutline(C1, 0);
	TextDrawBackgroundColor(C1, 0x000000FF);
	TextDrawFont(C1, 3);
	TextDrawSetProportional(C1, 1);

	C2 = TextDrawCreate(56.333333, 431.644449, "Version v3.0");
	TextDrawLetterSize(C2, 0.280455, 1.321261);
	TextDrawTextSize(C2, 124.999999, 447);
	TextDrawAlignment(C2, 1);
	TextDrawColor(C2, 0xC1A61FFF);
	TextDrawUseBox(C2, 0);
	TextDrawBoxColor(C2, 0x000000AA);
	TextDrawSetShadow(C2, 1);
	TextDrawSetOutline(C2, 0);
	TextDrawBackgroundColor(C2, 0x000000FF);
	TextDrawFont(C2, 3);
	TextDrawSetProportional(C2, 1);

	C3 = TextDrawCreate(118.333333, 431.644449, "By PreLoX");
	TextDrawLetterSize(C3, 0.280455, 1.321261);
	TextDrawTextSize(C3, 179.666666, 447);
	TextDrawAlignment(C3, 1);
	TextDrawColor(C3, 0xF2D231FF);
	TextDrawUseBox(C3, 0);
	TextDrawBoxColor(C3, 0x000000AA);
	TextDrawSetShadow(C3, 1);
	TextDrawSetOutline(C3, 0);
	TextDrawBackgroundColor(C3, 0x000000FF);
	TextDrawFont(C3, 3);
	TextDrawSetProportional(C3, 1);

	time = TextDrawCreate(555.820078, 21.57037, "00:00");
	TextDrawLetterSize(time, 0.493055, 2.2);
	TextDrawTextSize(time, 605.820078, 39.237037);
	TextDrawAlignment(time, 1);
	TextDrawColor(time, 0xFFFFFFFF);
	TextDrawUseBox(time, 0);
	TextDrawBoxColor(time, 0x000000AA);
	TextDrawSetShadow(time, 0);
	TextDrawSetOutline(time, 1);
	TextDrawBackgroundColor(time, 0x000000FF);
	TextDrawFont(time, 3);
	TextDrawSetProportional(time, 1);
	SetTimer("UpdateTimeText", 60000, true);
	UpdateTimeText();

	stopanimation = TextDrawCreate(186.666666, 2.488888, "PRESS        TO STOP THE ANIMATION");
	TextDrawLetterSize(stopanimation, 0.404423, 1.762962);
	TextDrawTextSize(stopanimation, 463.666666, 22.088888);
	TextDrawAlignment(stopanimation, 1);
	TextDrawColor(stopanimation, 0xFFFFFFFF);
	TextDrawUseBox(stopanimation, 0);
	TextDrawBoxColor(stopanimation, 0x000000AA);
	TextDrawSetShadow(stopanimation, 0);
	TextDrawSetOutline(stopanimation, 1);
	TextDrawBackgroundColor(stopanimation, 0x000000FF);
	TextDrawFont(stopanimation, 3);
	TextDrawSetProportional(stopanimation, 1);
	
	enteranimlist = TextDrawCreate(232.666666, 2.074074, "ENTER");
	TextDrawLetterSize(enteranimlist, 0.404423, 1.762962);
	TextDrawTextSize(enteranimlist, 275.666667, 19.599999);
	TextDrawAlignment(enteranimlist, 1);
	TextDrawColor(enteranimlist, 0xC28400FF);
	TextDrawUseBox(enteranimlist, 0);
	TextDrawBoxColor(enteranimlist, 0x000000AA);
	TextDrawSetShadow(enteranimlist, 0);
	TextDrawSetOutline(enteranimlist, 1);
	TextDrawBackgroundColor(enteranimlist, 0x000000FF);
	TextDrawFont(enteranimlist, 3);
	TextDrawSetProportional(enteranimlist, 1);
	
// ========== Objects [Heavy] =============
    CreateObject(988,1360.1000000,2207.8999000,11.5000000,0.0000000,0.0000000,0.0000000); //object(ws_apgate) (1)
    CreateObject(988,1330.2000000,2207.3000000,11.6000000,0.0000000,0.0000000,0.0000000); //object(ws_apgate) (2)
    CreateObject(988,1300.5000000,2206.8000000,11.8000000,0.0000000,0.0000000,0.0000000); //object(ws_apgate) (3)
    CreateObject(988,1406.4000000,2183.2000000,11.5000000,0.0000000,0.0000000,270.0000000); //object(ws_apgate) (4)
    CreateObject(988,1405.6000000,2154.0000000,11.7000000,0.0000000,0.0000000,270.0000000); //object(ws_apgate) (5)
    CreateObject(988,1405.1000000,2123.8000000,11.9000000,0.0000000,0.0000000,270.0000000); //object(ws_apgate) (6)
    CreateObject(621,1305.1000000,2195.6001000,10.0000000,0.0000000,0.0000000,0.0000000); //object(veg_palm02) (1)
    CreateObject(621,1394.1000000,2105.5000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(veg_palm02) (2)
    CreateObject(621,1304.3000000,2107.8999000,10.0000000,0.0000000,0.0000000,0.0000000); //object(veg_palm02) (3)
    CreateObject(621,1391.5000000,2194.0000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(veg_palm02) (4)
    CreateObject(11445,1379.7000000,2117.1001000,10.0000000,0.0000000,0.0000000,38.0000000); //object(des_pueblo06) (1)
    CreateObject(11446,1376.9000000,2176.6001000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo07) (1)
    CreateObject(11442,1349.2000000,2176.3999000,10.0000000,0.0000000,0.0000000,18.0000000); //object(des_pueblo3) (1)
    CreateObject(11442,1332.9000000,2166.3000000,10.0000000,0.0000000,0.0000000,53.9960000); //object(des_pueblo3) (2)
    CreateObject(11442,1332.2000000,2124.5000000,10.0000000,0.0000000,0.0000000,111.9920000); //object(des_pueblo3) (3)
    CreateObject(11442,1376.7000000,2145.1001000,10.0000000,0.0000000,0.0000000,233.9890000); //object(des_pueblo3) (5)
    CreateObject(11442,1356.3000000,2133.2000000,10.0000000,0.0000000,0.0000000,233.9870000); //object(des_pueblo3) (6)
    CreateObject(11442,1316.5000000,2143.3999000,10.0400000,0.0000000,0.0000000,93.9870000); //object(des_pueblo3) (7)
    CreateObject(11444,1369.4000000,2160.7000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (1)
    CreateObject(11444,1344.4000000,2150.3000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (2)
    CreateObject(11444,1329.9000000,2138.8000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (3)
    CreateObject(11444,1359.5000000,2117.3999000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (4)
    CreateObject(11444,1312.1000000,2180.8999000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (5)
    CreateObject(11444,1374.7000000,2109.1001000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (6)
    CreateObject(11443,1358.3000000,2146.8999000,10.0000000,0.0000000,0.0000000,236.0000000); //object(des_pueblo4) (1)
    CreateObject(11443,1350.6000000,2112.2000000,10.0000000,0.0000000,0.0000000,235.9970000); //object(des_pueblo4) (2)
    CreateObject(11443,1321.5000000,2154.6001000,10.0000000,0.0000000,0.0000000,59.9970000); //object(des_pueblo4) (3)
    CreateObject(11443,1359.3000000,2171.8999000,10.0000000,0.0000000,0.0000000,117.9960000); //object(des_pueblo4) (4)
    CreateObject(11443,1323.8000000,2185.3999000,10.0000000,0.0000000,0.0000000,39.9930000); //object(des_pueblo4) (5)
    CreateObject(11443,1314.5000000,2119.3000000,10.0000000,0.0000000,0.0000000,145.9900000); //object(des_pueblo4) (6)
    CreateObject(11444,1344.0000000,2193.8000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (7)
    CreateObject(11444,1307.7000000,2156.7000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (8)
    CreateObject(11444,1387.0000000,2135.7000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(des_pueblo2) (9)
    CreateObject(3279,1315.5000000,2168.8000000,10.0000000,0.0000000,0.0000000,0.0000000); //object(a51_spottower) (1)
    CreateObject(3279,1389.8000000,2148.2000000,10.0000000,0.0000000,0.0000000,178.0000000); //object(a51_spottower) (2)
    CreateObject(8171,1300.0000000,2162.3000000,30.6000000,0.0000000,90.0000000,0.0000000); //object(vgssairportland06) (1)
    CreateObject(8171,1358.5000000,2103.0000000,30.3000000,0.0000000,90.0000000,90.0000000); //object(vgssairportland06) (2)
    CreateObject(8171,1369.0000000,2200.0000000,50.4000000,0.0000000,180.0000000,90.0000000); //object(vgssairportland06) (3)
    CreateObject(8171,1369.0000000,2161.7000000,50.4000000,0.0000000,180.0000000,90.0000000); //object(vgssairportland06) (4)
    CreateObject(8171,1369.1000000,2123.1001000,50.4000000,0.0000000,180.0000000,90.0000000); //object(vgssairportland06) (5)
    CreateObject(8171,1367.2000000,2217.2000000,30.4000000,0.0000000,270.0000000,90.0000000); //object(vgssairportland06) (6)
    CreateObject(8171,1415.8000000,2143.0000000,30.6000000,0.0000000,90.0000000,180.0000000); //object(vgssairportland06) (7)
    return 1;
}

public OnGameModeExit()return DOF2_SaveFile();
//==============================================================================
stock ShowPlayerRegisterDialog(playerid)
{
	ShowPlayerDialog(playerid,Dialog_Register,DIALOG_STYLE_INPUT,"{ffa200}Register System - מערכת הרשמה","{d2d2d2}:המשתמש שלך אינו רשום במערכת, אנא בחר סיסמה כדי להרשם","הרשם","ביטול");
	return 1;
}
stock ShowPlayerLoginDialog(playerid)
{
	ShowPlayerDialog(playerid,Dialog_Login,DIALOG_STYLE_INPUT,"{51d959}Login System - מערכת התחברות","{d2d2d2}:המערכת זיהתה כי התחברת עם אייפי שונה, אנא הקלד את סיסמתך למשתמש כדי להתחבר","התחבר","ביטול");
	return 1;
}
forward SendJoinMessage(playerid);
public SendJoinMessage(playerid)
{
    SendFormatMessageToAll(Lightgreen,"** %s has joined the server !",GetName(playerid));
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
    format(oldname[playerid],MAX_PLAYER_NAME,"%s",GetName(playerid));
	//titan gold = daa520
	SendClientMessage(playerid,Gray,"{acacac}<==========================================>");
	SendClientMessage(playerid,White,"{f1f1f1}• ! {e7c438}Clan War v3.0{f1f1f1} - ברוכים הבאים למוד האימונים");
    SendFormatMessage(playerid,White,"{f1f1f1}• ! {e7c438}%s{f1f1f1} התחברת עם הניק",GetName(playerid));
	SendClientMessage(playerid,White,"{f1f1f1}• ! {e7c438}/Help{f1f1f1} - מומלץ לחקור את המוד על ידי הפקודה");
	SendClientMessage(playerid,White,"{f1f1f1}• ! במוד קיימים מספר איזורים שונים והמון אופציות מגוונות, מומלץ לחקור את כולו");
    SendClientMessage(playerid,White,"{f1f1f1}• ! {e7c438}PreLoX{f1f1f1} המוד נבנה על ידי");
    SendClientMessage(playerid,Gray,"{acacac}<==========================================>");
//==============================================================================
//==== Activity Vars ====
    RegisteredToAct[playerid] = false;
    Checkpoints[playerid] = 0;
	GGLevel[playerid] = 0;
	GGDeath[playerid] = 0;
	BoostCooldown[playerid] = false;
	gungameleveltext[playerid] = TextDrawCreate(11.75, 306.824692, "GunGame Level: 1/10");
	TextDrawLetterSize(gungameleveltext[playerid], 0.383129, 1.659259);
	TextDrawTextSize(gungameleveltext[playerid], 145.863708, 326.113581);
	TextDrawAlignment(gungameleveltext[playerid], 1);
	TextDrawColor(gungameleveltext[playerid], 0xFFFFFFFF);
	TextDrawUseBox(gungameleveltext[playerid], 1);
	TextDrawBoxColor(gungameleveltext[playerid], 0x21BA40AA);
	TextDrawSetShadow(gungameleveltext[playerid], 1);
	TextDrawSetOutline(gungameleveltext[playerid], 0);
	TextDrawBackgroundColor(gungameleveltext[playerid], 0x000000FF);
	TextDrawFont(gungameleveltext[playerid], 3);
	TextDrawSetProportional(gungameleveltext[playerid], 1);
//=======================
	LoggedIn[playerid] = false;
	FakeUser[playerid] = 0;
	Mute[playerid] = 0;
    Area[playerid] = Light;
    InClass[playerid] = 1;
    targetRe[playerid] = -1;
	Admin[playerid] = 0;
    LoggedToTitan[playerid] = 0;
    AdminCanSeeCMD[playerid] = 0;
    AdminCanSeePM[playerid] = 0;
    ChatAccess[playerid] = 0;
	Freeze[playerid] = 0;
	Kills[playerid] = 0;
	TotalKills[playerid] = 0;
	TotalDeaths[playerid] = 0;
	VehicleGodMode[playerid] = 0;
	InSpec[playerid] = 0;
	InCWTeam[playerid] = None;
	GreenPlayer[playerid][1] = false,GreenPlayer[playerid][2] = false,GreenPlayer[playerid][3] = false;
    OrangePlayer[playerid][1] = false,OrangePlayer[playerid][2] = false,OrangePlayer[playerid][3] = false;
	AmramMode[playerid] = false;
	ghour[playerid] = 12;
	gminutes[playerid] = 0;
	InAnimation[playerid] = false;
//==============================================================================
	NegDamage[playerid] = TextDrawCreate(116.25, 367.224692, "10");
	TextDrawLetterSize(NegDamage[playerid], 0.302739, 1.370095);
	TextDrawTextSize(NegDamage[playerid], 152.863708, 388.958025);
	TextDrawAlignment(NegDamage[playerid], 1);
	TextDrawColor(NegDamage[playerid], NegetiveDamage);
	TextDrawUseBox(NegDamage[playerid], 0);
	TextDrawBoxColor(NegDamage[playerid], 0x000000AA);
	TextDrawSetShadow(NegDamage[playerid], 0);
	TextDrawSetOutline(NegDamage[playerid], 1);
	TextDrawBackgroundColor(NegDamage[playerid], 0x000000FF);
	TextDrawFont(NegDamage[playerid], 1);
	TextDrawSetProportional(NegDamage[playerid], 1);

	PosDamage[playerid] = TextDrawCreate(116.25, 367.224692, "10");
	TextDrawLetterSize(PosDamage[playerid], 0.302739, 1.370095);
	TextDrawTextSize(PosDamage[playerid], 152.863708, 388.958025);
	TextDrawAlignment(PosDamage[playerid], 1);
	TextDrawColor(PosDamage[playerid], PositiveDamage);
	TextDrawUseBox(PosDamage[playerid], 0);
	TextDrawBoxColor(PosDamage[playerid], 0x000000AA);
	TextDrawSetShadow(PosDamage[playerid], 0);
	TextDrawSetOutline(PosDamage[playerid], 1);
	TextDrawBackgroundColor(PosDamage[playerid], 0x000000FF);
	TextDrawFont(PosDamage[playerid], 1);
	TextDrawSetProportional(PosDamage[playerid], 1);
//==============================================================================
	new currentName[MAX_PLAYER_NAME];
	GetPlayerName(playerid,currentName,sizeof(currentName));
	new currentIP[50];
	GetPlayerIp(playerid,currentIP,sizeof(currentIP));
	if(strlen(DOF2_GetString("RconOptions/IPList.ini",currentIP)) > 3)
	{
	    if(strcmp(currentName,DOF2_GetString("RconOptions/IPList.ini",currentIP),false))
	    {
	        FakeUser[playerid] = 1;
			SendFormatMessageToAll(Yellow,".{56a7ef}%s{ffff00} מנסה להתחבר מבדוי, המשתמש המקורי שלו הוא {56a7ef}%s{ffff00} השחקן",DOF2_GetString("RconOptions/IPList.ini",currentIP),currentName);
		}
	}
//==============================================================================
    format(Tag[playerid], 25,"%s",DOF2_GetString(pFile(playerid),"Tag"));
    format(PreTag[playerid], 25,"%s",DOF2_GetString(pFile(playerid),"Tag"));
//==============================================================================
    TextDrawShowForPlayer(playerid,C1);
    TextDrawShowForPlayer(playerid,C2);
    TextDrawShowForPlayer(playerid,C3);
    TextDrawShowForPlayer(playerid,time);
    //TextDrawShowForPlayer(playerid,noncwtext);
    ShowPlayerNameText(playerid);
// -----------------------------------------------------------------------------
// ------------ Connect ------------
    if(!DOF2_FileExists(pFile(playerid)))
    {
        ShowPlayerRegisterDialog(playerid);
		return 0;
    }else{
		if(DOF2_FileExists(bFile(playerid)))
	    {
	        SendFormatMessage(playerid,Red,"You are banned from this server ! (Reason: %s)",DOF2_GetString(bFile(playerid),"Reason"));
	        SetTimerEx("DelayBan", 500, false, "d", playerid);
	        return 0;
	    }
		if(strcmp(GetIp(playerid),DOF2_GetString(pFile(playerid),"IP"),false))
	    {
	        ShowPlayerLoginDialog(playerid);
	        return 0;
	    }
		if(DOF2_GetInt(pFile(playerid),"Admin") > 0)
	    {
	    	Admin[playerid] = DOF2_GetInt(pFile(playerid),"Admin");
	    	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{00ff00}! ברוכים הבאים","{ffff00}.התחברת אוטומטית למערכת האדמינים\n{ffff00}/AHelp - השתמש בפקודה על מנת לקבל עזרה","אישור","ביטול");
		}
	}
	HitSound[playerid] = DOF2_GetInt(pFile(playerid),"HitSound");
	LoggedIn[playerid] = true;
	SetTimerEx("SendJoinMessage", 100, false, "d", playerid);
    return 1;
}
forward ShowPlayerNameText(playerid);
public ShowPlayerNameText(playerid)
{
	format(str,sizeof(str),"%s",GetName(playerid));
	nametext[playerid] = TextDrawCreate(107.820078, 410.251851, str);
	TextDrawLetterSize(nametext[playerid], 0.228377, 1.428806);
	TextDrawTextSize(nametext[playerid], 183.820078, 427.674074);
	TextDrawAlignment(nametext[playerid], 1);
	TextDrawColor(nametext[playerid], 0xFFFFFFFF);
	TextDrawUseBox(nametext[playerid], 0);
	TextDrawBoxColor(nametext[playerid], 0x000000AA);
	TextDrawSetShadow(nametext[playerid], 0);
	TextDrawSetOutline(nametext[playerid], 1);
	TextDrawBackgroundColor(nametext[playerid], 0x292200FF);
	TextDrawFont(nametext[playerid], 1);
	TextDrawSetProportional(nametext[playerid], 1);
	TextDrawShowForPlayer(playerid,Text:nametext[playerid]);
}
//==============================================================================
public OnPlayerDisconnect(playerid, reason)
{
    if(DOF2_GetInt(pFile(playerid),"Ban") == 1)return 0;
    DOF2_SaveFile();
    if(Area[playerid] == WarAct)
    {
        PlayersInAct[war_act] --;
		if(PlayersInAct[war_act] <= 1)
		{
			for(new i;i<Maxp;i++)
			{
			    if(IsPlayerConnected(i) && Area[i] == WarAct)
			    {
			        GameTextForPlayer(i,"~g~YOU WON THE WAR ACTIVITY !",3000,3);
			        PlayerPlaySound(i,winsound,0,0,0);
			        SendFormatMessageToAll(-1,"{48e832}[{e86f32}War Activity{48e832}] ! ניצח את פעילות הוואר %s השחקן",GetName(i));
			        Area[i] = Light;
			        SpawnPlayer(i);
			        SetPlayerVirtualWorld(i,0);
			        break;
			    }
			}
			OpenActivity = none;
			PlayersInAct[war_act] = 0;
			ActIsRunning = false;
		}
    }
    if(Area[playerid] == KartAct)
    {
		PlayersInAct[kart_act] --;
        DestroyVehicle(GetPlayerVehicleID(playerid));
		if(KartPlayer[1] == playerid)KartPlayer[1] = -1;
		if(KartPlayer[2] == playerid)KartPlayer[2] = -1;
		if(KartPlayer[3] == playerid)KartPlayer[3] = -1;
		if(KartPlayer[4] == playerid)KartPlayer[4] = -1;
		DisablePlayerRaceCheckpoint(playerid);
		Checkpoints[playerid] = 0;
		if(PlayersInAct[kart_act] <= 1)
	    {
			OpenActivity = none;
			PlayersInAct[kart_act] = 0;
			ActIsRunning = false;
			for(new i; i<Maxp; i++)
			{
			    if(IsPlayerConnected(i) && Area[i] == KartAct)
			    {
			        DestroyVehicle(GetPlayerVehicleID(i));
			        PlayerPlaySound(i,winsound,0,0,0);
			        GameTextForPlayer(i,"~g~YOU WON THE KART RACING !",3000,3);
			        SendFormatMessageToAll(-1,"{48e832}[{ebf51b}Kart Activity{48e832}]{00ff00} ! ניצח את פעילות הקארטינג %s השחקן",GetName(i));
	                SetPlayerVirtualWorld(i,0);
	                SetPlayerInterior(i,0);
	                SetPlayerPos(i,1137.2332,1335.9259,10.8203);
					Area[i] = Light;
					Checkpoints[i] = 0;
					SpawnPlayer(i);
					DisablePlayerRaceCheckpoint(i);
					//DisableRemoteVehicleCollisions(i,false);
			        break;
			    }
			}
	    }
    }
    switch(reason)
    {
        case 0:SendFormatMessageToAll(Red,"** %s has left the server{BABABA} (Crash)",GetName(playerid));
        case 1:SendFormatMessageToAll(Red,"** %s has left the server{BABABA} (Leave)",GetName(playerid));
        case 2:SendFormatMessageToAll(Red,"** %s has left the server{BABABA} (Kick/Ban)",GetName(playerid));
    }
	if(CWOn == true)
	{
		if(InCWTeam[playerid] == TGreen)GreenCount --;
		if(InCWTeam[playerid] == TOrange)OrangeCount --;
	}
	SetPlayerName(playerid,oldname[playerid]);
    return 1;
}
//==============================================================================
public OnPlayerSpawn(playerid)
{
    AntiDeAMX();
	if(AmramMode[playerid] == true)SetPlayerSkin(playerid,267);
	else SetPlayerSkin(playerid,SavedSkin[playerid]);
	if(Area[playerid] != GG)SetPlayerArmour(playerid,100);
	if(Area[playerid] == GG)
	{
		new ggrand = random(sizeof(GGSpawns));
		SetPos(playerid,GGSpawns[ggrand][0],GGSpawns[ggrand][1],GGSpawns[ggrand][2],GGSpawns[ggrand][3]);
		if(GGLevel[playerid] == 1)GivePlayerWeapon(playerid,level1weapon,9999);
		if(GGLevel[playerid] == 2)GivePlayerWeapon(playerid,level2weapon,9999);
		if(GGLevel[playerid] == 3)GivePlayerWeapon(playerid,level3weapon,9999);
		if(GGLevel[playerid] == 4)GivePlayerWeapon(playerid,level4weapon,9999);
		if(GGLevel[playerid] == 5)GivePlayerWeapon(playerid,level5weapon,9999);
		if(GGLevel[playerid] == 6)GivePlayerWeapon(playerid,level6weapon,9999);
		if(GGLevel[playerid] == 7)GivePlayerWeapon(playerid,level7weapon,9999);
		if(GGLevel[playerid] == 8)GivePlayerWeapon(playerid,level8weapon,9999);
		if(GGLevel[playerid] == 9)GivePlayerWeapon(playerid,level9weapon,9999);
		if(GGLevel[playerid] == 10)GivePlayerWeapon(playerid,level10weapon,1);
	}
	if(CWOn == true)
	{
		if(Area[playerid] == CWSPEC)SpawnPlayerToSpecCw(playerid);
		if(DiedLastInCW[playerid] == true)
		{
		    DiedLastInCW[playerid] = false;
		    SetTimer("StartRound",250,false);
		}
	}
    if(Area[playerid] == Light)
    {
        SetPlayerInterior(playerid,0);
        if(Team[playerid] == A)
        {
            SetPlayerPos(playerid,1137.2332,1335.9259,10.8203) && SetPlayerFacingAngle(playerid,179.2149);//A
			if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
            if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		}
        if(Team[playerid] == B)
        {
            SetPlayerPos(playerid,1137.2517,1235.1417,10.8203) && SetPlayerFacingAngle(playerid,359.0700);//B
			if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
            if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		}
    }
    if(Area[playerid] == War)
    {
        SetPlayerInterior(playerid,16);
        new warrand = random(sizeof(WarSpawns));
        SetPlayerPos(playerid,WarSpawns[warrand][0],WarSpawns[warrand][1],WarSpawns[warrand][2]);
        SetPlayerFacingAngle(playerid,WarSpawns[warrand][3]);
		if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
  		if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
	}
    if(Area[playerid] == AP)
    {
        SetPlayerInterior(playerid,0);
        if(Team[playerid] == A)
        {
            SetPlayerPos(playerid,1320.6469,1375.3042,10.8203) && SetPlayerFacingAngle(playerid,179.3954);
			if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
            if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		}
        if(Team[playerid] == B)
        {//357.7778
            SetPlayerPos(playerid,1320.3190,1309.4552,10.8203) && SetPlayerFacingAngle(playerid,357.7778);
			if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
            if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		}
    }
    if(Area[playerid] == WH)
    {
        SetPlayerInterior(playerid,1);
        if(Team[playerid] == A)
        {
            SetPlayerPos(playerid,1411.8306,-19.3712,1000.9240) && SetPlayerFacingAngle(playerid,90.8042);
			if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
            if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		}
        if(Team[playerid] == B)
        {//357.7778
            SetPlayerPos(playerid,1365.4437,-20.2236,1000.9219) && SetPlayerFacingAngle(playerid,269.0927);
			if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
            if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		}
    }
    if(Area[playerid] == BR)
    {
        SetPlayerInterior(playerid,15);
		//-1458.1985,995.3450,1024.8131,269.8115 a
		//-1398.2206,994.9816,1024.0901,88.3741 b
        if(Team[playerid] == A)
        {
            SetPlayerPos(playerid,-1458.1985,995.3450,1024.8131) && SetPlayerFacingAngle(playerid,269.8115);
			if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
            if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		}
        if(Team[playerid] == B)
        {
            SetPlayerPos(playerid,-1398.2206,994.9816,1024.0901) && SetPlayerFacingAngle(playerid,88.3741);
			if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
            if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		}
    }
    return 1;
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
    SendDeathMessage(killerid, playerid, reason);
    if(KillFull == 1 && Area[killerid] != CW && Area[killerid] != GG && Area[killerid] != WarAct) SetPlayerHealth(killerid,100) && SetPlayerArmour(killerid,100);
    if(killerid != INVALID_PLAYER_ID && killerid != playerid)
    {
        new killerScore = GetPlayerScore(killerid);
        SetPlayerScore(killerid, killerScore + 1);
        TotalKills[killerid]++;
        TotalDeaths[playerid]++;
    	Kills[killerid] ++;
    	Kills[playerid] = 0;
    }
    if(Area[killerid] != GG)
    {
	    if(Kills[killerid] == 5) format(str,sizeof(str),"{eacf54}• ברצף של 5 הריגות {57d3db}%s{eacf54} •",GetName(killerid)) && SendClientMessageToAll(Gold,str);
	    if(Kills[killerid] == 10) format(str,sizeof(str),"{eacf54}• ברצף של 10 הריגות {57d3db}%s{eacf54} •",GetName(killerid)) && SendClientMessageToAll(Gold,str);
	    if(Kills[killerid] == 15) format(str,sizeof(str),"{eacf54}• ברצף של 15 הריגות {57d3db}%s{eacf54} •",GetName(killerid))&& SendClientMessageToAll(Gold,str);
	    if(Kills[killerid] == 20) format(str,sizeof(str),"{eacf54}• ברצף של 20 הריגות {57d3db}%s{eacf54} •",GetName(killerid)) && SendClientMessageToAll(Gold,str);
	    if(Kills[killerid] == 25) format(str,sizeof(str),"{eacf54}• ברצף של 25 הריגות {57d3db}%s{eacf54} •",GetName(killerid)) && SendClientMessageToAll(Gold,str);

		if(Kills[killerid] == 2) GameTextForPlayer(killerid,"~w~] ~g~~h~~h~Double Kill ~w~]",1500,4);
		if(Kills[killerid] == 3) GameTextForPlayer(killerid,"~w~] ~g~~h~~h~Triple Kill ~w~]",1500,4);
		if(Kills[killerid] == 4) GameTextForPlayer(killerid,"~w~] ~g~~h~~h~Quad Kill ~w~]",1500,4);
		if(Kills[killerid] == 5) GameTextForPlayer(killerid,"~w~] ~r~~h~Fantastic ~w~]",1500,4);
		if(Kills[killerid] == 6) GameTextForPlayer(killerid,"~w~] ~r~~h~Amazing ~w~]",1500,4);
		if(Kills[killerid] == 7) GameTextForPlayer(killerid,"~w~] ~r~~h~Incredible ~w~]",1500,4);
		if(Kills[killerid] == 8) GameTextForPlayer(killerid,"~w~] ~p~Superstar ~w~]",1500,4);
	}
	if(Area[playerid] == WarAct)
	{
	    SetPlayerVirtualWorld(playerid,0);
		PlayersInAct[war_act] --;
		Area[playerid] = Light;
		SendClientMessage(playerid,Gray,"הפסדת בפעילות וחזרת לאיזור הקלים");
		PlayerPlaySound(playerid,losesound,0,0,0);
		if(PlayersInAct[war_act] == 1)
		{
			for(new i;i<Maxp;i++)
			{
			    if(IsPlayerConnected(i) && Area[i] == WarAct)
			    {
			        GameTextForPlayer(i,"~g~YOU WON THE WAR ACTIVITY !",3000,3);
			        PlayerPlaySound(i,winsound,0,0,0);
			        SendFormatMessageToAll(-1,"{48e832}[{e86f32}War Activity{48e832}] ! ניצח את פעילות הוואר %s השחקן",GetName(i));
			        Area[i] = Light;
			        SpawnPlayer(i);
			        SetPlayerVirtualWorld(i,0);
			        break;
			    }
			}
			OpenActivity = none;
			PlayersInAct[war_act] = 0;
			ActIsRunning = false;
		}
	}
    if(Area[playerid] == KartAct)
    {
		PlayersInAct[kart_act] --;
        DestroyVehicle(GetPlayerVehicleID(playerid));
		if(KartPlayer[1] == playerid)KartPlayer[1] = -1;
		if(KartPlayer[2] == playerid)KartPlayer[2] = -1;
		if(KartPlayer[3] == playerid)KartPlayer[3] = -1;
		if(KartPlayer[4] == playerid)KartPlayer[4] = -1;
		DisablePlayerRaceCheckpoint(playerid);
		Checkpoints[playerid] = 0;
		Area[playerid] = Light;
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		if(PlayersInAct[kart_act] <= 1)
	    {
			OpenActivity = none;
			PlayersInAct[kart_act] = 0;
			ActIsRunning = false;
			for(new i; i<Maxp; i++)
			{
			    if(IsPlayerConnected(i) && Area[i] == KartAct)
			    {
			        DestroyVehicle(GetPlayerVehicleID(i));
			        PlayerPlaySound(i,winsound,0,0,0);
			        GameTextForPlayer(i,"~g~YOU WON THE KART RACING !",3000,3);
			        SendFormatMessageToAll(-1,"{48e832}[{ebf51b}Kart Activity{48e832}]{00ff00} ! ניצח את פעילות הקארטינג %s השחקן",GetName(i));
	                SetPlayerVirtualWorld(i,0);
	                SetPlayerInterior(i,0);
	                SetPlayerPos(i,1137.2332,1335.9259,10.8203);
					Area[i] = Light;
					Checkpoints[i] = 0;
					SpawnPlayer(i);
					DisablePlayerRaceCheckpoint(i);
					//DisableRemoteVehicleCollisions(i,false);
			        break;
			    }
			}
	    }
    }
	if(Area[playerid] == GG)
	{
		GGDeath[playerid] ++;
		if(GGDeath[playerid] == 2)
		{
		    if(GGLevel[playerid] > 1)
		    {
		        GGLevel[playerid] --;
		        GGDeath[playerid] = 0;
		        GameTextForPlayer(playerid,"~r~- LEVEL DOWN -",1000,3);
		        SendFormatMessage(playerid,Lightgreen,"[GunGame]{ff0000} ! %d איזה זין.. ירדת לרמה",GGLevel[playerid]);
				PlayerPlaySound(playerid,leveldownsound,0,0,0);
				format(str,sizeof(str),"GUNGAME LEVEL: %d/10",GGLevel[playerid]);
				TextDrawSetString(gungameleveltext[playerid],str);
			}
		}
		GGLevel[killerid] ++;
		ResetPlayerWeapons(killerid);
		PlayerPlaySound(killerid,levelupsound,0,0,0);
		if(GGLevel[killerid] != 11)SendFormatMessage(killerid,Lightgreen,"[Gun Game] ! %d כל הכבוד, עלית לרמה",GGLevel[killerid]);
		GGDeath[killerid] = 0;
		format(str,sizeof(str),"GUNGAME LEVEL: %d/10",GGLevel[killerid]);
		TextDrawSetString(gungameleveltext[killerid],str);
		if(GGLevel[killerid] != 11)GameTextForPlayer(killerid,"~g~+ LEVEL UP +",1000,3);
		if(GGLevel[killerid] == 2)GivePlayerWeapon(killerid,level2weapon,9999);
		if(GGLevel[killerid] == 3)GivePlayerWeapon(killerid,level3weapon,9999);
		if(GGLevel[killerid] == 4)GivePlayerWeapon(killerid,level4weapon,9999);
		if(GGLevel[killerid] == 5)GivePlayerWeapon(killerid,level5weapon,9999);
		if(GGLevel[killerid] == 6)GivePlayerWeapon(killerid,level6weapon,9999);
		if(GGLevel[killerid] == 7)GivePlayerWeapon(killerid,level7weapon,9999);
		if(GGLevel[killerid] == 8)GivePlayerWeapon(killerid,level8weapon,9999);
		if(GGLevel[killerid] == 9)GivePlayerWeapon(killerid,level9weapon,9999);
		if(GGLevel[killerid] == 10)GivePlayerWeapon(killerid,level10weapon,1);
		if(GGLevel[killerid] == 11)
		{
			OpenActivity = none;
			PlayerPlaySound(killerid,winsound,0,0,0);
			GameTextForPlayer(killerid,"~g~~h~YOU WON THE GUNGAME !",3000,3);
			SendFormatMessageToAll(Lightgreen,"[Gun Game] ! ניצח את איזור הגאן גיים %s השחקן",GetName(killerid));
			for(new i;i<Maxp;i++)
			{
			    if(IsPlayerConnected(i) && Area[i] == GG)
			    {
			        Kills[i] = 0;
			        GGLevel[i] = 0;
			        GGDeath[i] = 0;
			        TextDrawHideForPlayer(i,gungameleveltext[i]);
                    if(i != killerid)PlayerPlaySound(i,6402,0.0,0.0,0.0),GameTextForPlayer(i,"~r~YOU LOST THE GUNGAME !",3000,3);
					Area[i] = Light;
					if(GetPlayerState(i) != PLAYER_STATE_WASTED)SpawnPlayer(i);
			    }
			}
		}
	}
	if(CWOn == true && Area[playerid] == CW)
	{
	    if(InCWTeam[playerid] == TGreen)
	    {
	        GreenDeath ++;
			if(GreenDeath == GreenCount)
			{
			    OrangeScore ++;
				if(OrangeScore == CWMaxRounds)
				{
				    for(new i = 0; i < Maxp; i++)
				    {
				        if(IsPlayerConnected(i) && InCWTeam[i] == TOrange)
				        {
				            GameTextForPlayer(i, "~w~you ~g~~h~won ~w~the clan war !", 3000, 3);
				        }
				        if(IsPlayerConnected(i) && InCWTeam[i] == TGreen)
				        {
				            GameTextForPlayer(i, "~w~you ~r~~h~lost ~w~the clan war !", 3000, 3);
				        }
				    }
				    SendClientMessageToAll(Yellow,"{878787}------------------------------------------------------------");
				    SendClientMessageToAll(Yellow,"[Clan-War] ! הקבוצה הכתומה ניצחה את הקלאן וואר");
				    SendFormatMessageToAll(Yellow,"[Clan-War] ({44EE16}Green: %d{ffff00} | {FF9B00}Orange: %d{ffff00}) :תוצאות המשחק",GreenScore,OrangeScore);
                    SendClientMessageToAll(Yellow,"{878787}------------------------------------------------------------");
     				CWEnd();
				}else{
					DiedLastInCW[playerid] = true;
					GreenDeath = 0;
					OrangeDeath = 0;
					SendFormatMessageToAll(Yellow,"[Clan-War] {878787}({44EE16}Green: %d{878787} | {FF9B00}Orange: %d{878787}){ffff00}  :הקבוצה הכתומה ניצחה את הראונד ! תוצאה",GreenScore,OrangeScore);
				}
			}else{
				Area[playerid] = CWSPEC;
				SendClientMessage(playerid,Yellow,"! מתת במהלך ראונד בקלאן וואר ועברת למצב צפייה עד שיתחיל ראונד חדש");
			}
	    }
		else if(InCWTeam[playerid] == TOrange)
		{
	        OrangeDeath ++;
			if(OrangeDeath == OrangeCount)
			{
			    GreenScore ++;
				if(GreenScore == CWMaxRounds)
				{
				    for(new i = 0; i < Maxp; i++)
				    {
				        if(IsPlayerConnected(i) && InCWTeam[i] == TGreen)
				        {
				            GameTextForPlayer(i, "~w~you ~g~~h~won ~w~the clan war !", 3000, 3);
				        }
				        if(IsPlayerConnected(i) && InCWTeam[i] == TOrange)
				        {
				            GameTextForPlayer(i, "~w~you ~r~~h~lost ~w~the clan war !", 3000, 3);
				        }
				    }
				    SendClientMessageToAll(Yellow,"{878787}------------------------------------------------------------");
				    SendClientMessageToAll(Yellow,"[Clan-War] ! הקבוצה הירוקה ניצחה את הקלאן וואר");
				    SendFormatMessageToAll(Yellow,"[Clan-War] ({44EE16}Green: %d{ffff00} | {FF9B00}Orange: %d{ffff00}) :תוצאות המשחק",GreenScore,OrangeScore);
                    SendClientMessageToAll(Yellow,"{878787}------------------------------------------------------------");
					CWEnd();
				}else{
					DiedLastInCW[playerid] = true;
					GreenDeath = 0;
					OrangeDeath = 0;
					SendFormatMessageToAll(Yellow,"[Clan-War] {878787}({44EE16}Green: %d{878787} | {FF9B00}Orange: %d{878787}){ffff00}  :הקבוצה הירוקה ניצחה את הראונד ! תוצאה",GreenScore,OrangeScore);
				}
			}else{
				Area[playerid] = CWSPEC;
				SendClientMessage(playerid,Yellow,"! מתת במהלך ראונד בקלאן וואר ועברת למצב צפייה עד שיתחיל ראונד חדש");
			}
		}
	}
    return 1;
}
//==============================================================================
public OnPlayerUpdate(playerid)
{
    if(VehicleGodMode[playerid] == 1 || Area[playerid] == KartAct)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            SetVehicleHealth(vehicleid, 1000.0);
            RepairVehicle(vehicleid);
        }
    }
    if(Area[playerid] == War)
	{
        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerid,x,y,z);
        if(Float:z < 1036.5)return SpawnPlayerToWar(playerid);
	}
	if(Area[playerid] == CWVIEW || Area[playerid] == CWSPEC)
	{
		new Float:Health,Float:Armour;
  		if(GetPlayerHealth(playerid,Health) != 100 && GetPlayerArmour(playerid,Armour) != 100)
  		{
  		    SetPlayerHealth(playerid,100);
  		    SetPlayerArmour(playerid,100);
  		}
		if(Area[playerid] == CWVIEW)
		{
		    new Float:x,Float:y,Float:z;
		    GetPlayerPos(playerid,x,y,z);
		    if(Float:z < 13.0) return SpawnPlayerToCw(playerid);
	    }else{
		    new Float:x,Float:y,Float:z;
		    GetPlayerPos(playerid,x,y,z);
		    if(Float:z < 13.0) return SpawnPlayerToSpecCw(playerid);
		}
	}
    return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID && HitSound[issuerid] == 1) PlayerPlaySound(issuerid,17802,0,0,0); // hit sound
	if(AmramMode[issuerid] == true && weaponid == 5)SetPlayerHealth(playerid,0) && SendClientMessage(playerid,White,"! הושפלת על ידי עמרם הגדול");
	if(TextHit == 1)
	{
		format(str,sizeof(str),"%0.1f",amount);
		TextDrawSetString(PosDamage[issuerid],str);
		TextDrawHideForPlayer(issuerid,NegDamage[issuerid]);
		TextDrawShowForPlayer(issuerid,PosDamage[issuerid]);
		SetTimerEx("HidePosDamage",1500,false,"u",issuerid);
		
		format(str,sizeof(str),"%0.1f",amount);
		TextDrawSetString(NegDamage[playerid],str);
		TextDrawHideForPlayer(playerid,PosDamage[playerid]);
		TextDrawShowForPlayer(playerid,NegDamage[playerid]);
		SetTimerEx("HideNegDamage",1500,false,"u",playerid);
	}
	return 1;
}
forward HidePosDamage(issuerid);
public HidePosDamage(issuerid)
{
	TextDrawHideForPlayer(issuerid,PosDamage[issuerid]);
	return 1;
}
forward HideNegDamage(playerid);
public HideNegDamage(playerid)
{
	TextDrawHideForPlayer(playerid,NegDamage[playerid]);
	return 1;
}
//==============================================================================
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    if(source == CLICK_SOURCE_SCOREBOARD) // בודק אם הלחיצה הגיעה מ-TAB
    {
	    new str1[128];
		new timestring[10];
		format(timestring,sizeof(timestring),"%02d:%02d",ghour[clickedplayerid],gminutes[clickedplayerid]);
		format(str1,sizeof(str1),"{74c4ff}%s{bfbfbf} - פרטים על השחקן",GetName(clickedplayerid));
		if(Admin[playerid] > 0)
		{
			format(str,sizeof(str),"{74a0ff}Admin:{bfbfbf} %d\n{74a0ff}Hit Sound:{bfbfbf} %d\n{74a0ff}Time:{bfbfbf} %s\n{74a0ff}TMP:{bfbfbf} Kills: %d / Deaths: %d\n{74a0ff}Original Name:{bfbfbf} %s",Admin[clickedplayerid],HitSound[clickedplayerid],timestring,TotalKills[clickedplayerid],TotalDeaths[clickedplayerid],oldname[clickedplayerid]);
			ShowPlayerDialog(playerid,Dialog_PInfo,DIALOG_STYLE_LIST,str1,str,"אישור","ביטול");
		}else{
			format(str,sizeof(str),"{74a0ff}Admin:{bfbfbf} %d\n{74a0ff}Hit Sound:{bfbfbf} %d\n{74a0ff}Time:{bfbfbf} %s\n{74a0ff}TMP:{bfbfbf} Kills: %d / Deaths: %d",Admin[clickedplayerid],HitSound[clickedplayerid],timestring,TotalKills[clickedplayerid],TotalDeaths[clickedplayerid]);
			ShowPlayerDialog(playerid,Dialog_PInfo,DIALOG_STYLE_LIST,str1,str,"אישור","ביטול");
		}
	}
    return 1;
}
//==============================================================================
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(Admin[playerid] > 0)
    {
        if(Area[playerid] == CW || Area[playerid] == CWSPEC || Area[playerid] == CWVIEW)return SendClientMessage(playerid,Red,"! CW לא ניתן לבצע את השיגור בעולם ה");
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)return SetVehiclePos(GetPlayerVehicleID(playerid),fX,fY,fZ);
        SetPlayerPosFindZ(playerid, fX, fY, fZ);
        SetPlayerPos(playerid,fX,fY,fZ);
        SendFormatMessage(playerid,Lightgreen,"! [{ffff00}%f,%f,%f{00ff00}] השתגרת אל הנקודה במפה",fX,fY,fZ);
    }
    return 1;
}
//==============================================================================
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    return 1;
}
//==============================================================================
public OnVehicleSpawn(vehicleid)
{
    return 1;
}
//==============================================================================
public OnVehicleDeath(vehicleid, killerid)
{
    return 1;
}
//==============================================================================
public OnPlayerText(playerid, text[])
{
    printf("[Chat] %s: %s",GetName(playerid),text);
    if(InClass[playerid] == 1)return SendClientMessage(playerid,Red,"! אינך יכול לשלוח הודעות כשאתה במסך הבחירה"),0;
    if(Mute[playerid] == 1)return SendClientMessage(playerid,Red,"! אינך יכול לשלוח הודעות במיוט"),0;
    if(ChatLock == 1 && ChatAccess[playerid] == 0 && Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! הצ'אט נעול"),0;
//================================== ADMINS CHAT ===============================
	if (Admin[playerid] > 0 && text[0] == '$') //Admin Chat
    {
        new message[144];
        strmid(message, text, 1, sizeof(message), sizeof(message));
        for (new i = 0; i < Maxp; i++)
        {
            if (IsPlayerConnected(i) && Admin[i] > 0)
            {
                SendFormatMessage(i,Yellow,"{00ffff}[AC]{00e8ff} %s (%d): %s",GetName(playerid),playerid,message);
            }
        }
        return 0;
    }
//================================== VWORLD CHAT ===============================
    if (text[0] == '#') //VW CHAT
    {
        new playerWorld = GetPlayerVirtualWorld(playerid);
        new message[144];
        strmid(message, text, 1, sizeof(message), sizeof(message));
        for (new i = 0; i < Maxp; i++)
        {
            if (IsPlayerConnected(i) && GetPlayerVirtualWorld(i) == playerWorld)
            {
                SendFormatMessage(i,Yellow,"{dcc230}[VW] %s (%d): {dcd430}%s",GetName(playerid),playerid,message);
            }
        }
        return 0;
    }
/*
#define CWGreenColor 44EE16
#define CWOrangeColor FF9B00
*/
//================================== TEAM A CHAT ===============================
    if (text[0] == '@')
    {
		if(InCWTeam[playerid] == TGreen || InCWTeam[playerid] == TOrange)
		{
		    if(InCWTeam[playerid] == TGreen)
		    {
	            new message[144];
	            strmid(message, text, 1, sizeof(message), sizeof(message));

	            for (new i = 0; i < Maxp; i++)
	            {
	                if (IsPlayerConnected(i) && InCWTeam[i] == TGreen)
	                {
	                    SendFormatMessage(i,Yellow,"{44EE16}[CW Green]{c8c8c8} %s (%d): {c8c8c8}%s",GetName(playerid),playerid,message);
					}
	            }
		    }else{
	            new message[144];
	            strmid(message, text, 1, sizeof(message), sizeof(message));

	            for (new i = 0; i < Maxp; i++)
	            {
	                if (IsPlayerConnected(i) && InCWTeam[i] == TOrange)
	                {
	                    SendFormatMessage(i,Yellow,"{FF9B00}[CW Orange]{c8c8c8} %s (%d): {c8c8c8}%s",GetName(playerid),playerid,message);
					}
	            }
			}
		}
		else
		{
	        if (Team[playerid] == A)
	        {
	            new message[144];
	            strmid(message, text, 1, sizeof(message), sizeof(message));

	            for (new i = 0; i < Maxp; i++)
	            {
	                if (IsPlayerConnected(i) && Team[i] == A)
	                {
	                    SendFormatMessage(i,Yellow,"{00ebf3}[TEAM]{c8c8c8} %s (%d): {c8c8c8}%s",GetName(playerid),playerid,message);
					}
	            }
	        }
//================================== TEAM B CHAT ===============================
			else if (Team[playerid] == B)
	        {
	            new message[144];
	            strmid(message, text, 1, sizeof(message), sizeof(message));

	            for (new i = 0; i < Maxp; i++)
	            {
	                if (IsPlayerConnected(i) && Team[i] == B)
	                {
	                    SendFormatMessage(i,Yellow,"{e60000}[TEAM]{c8c8c8} %s (%d): {c8c8c8}%s",GetName(playerid),playerid,message);
					}
	            }
	        }
        }
        return 0;
    }
//================================== NORMAL CHAT ===============================
	if(CWOn == true && InCWTeam[playerid] == TGreen || InCWTeam[playerid] == TOrange)
	{
		if(InCWTeam[playerid] == TGreen)
		{
		    if(Admin[playerid] > 0)
		    {
				if(strlen(Tag[playerid]) < 3)
				{
    				format(str,sizeof(str),"{ffffff}[CW] {44EE16}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff}]",GetName(playerid),text,playerid);
				}else{
                	format(str,sizeof(str),"{ffffff}[CW] {44EE16}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff} | %s]",GetName(playerid),text,playerid,Tag[playerid]);
				}
		    }else{
		        if(strlen(Tag[playerid]) < 3)
		        {
		    		format(str,sizeof(str),"{ffffff}[CW] {44EE16}%s:{ffffff} %s [id: %d]",GetName(playerid),text,playerid);
				}else{
                    format(str,sizeof(str),"{ffffff}[CW] {44EE16}%s:{ffffff} %s [id: %d | %s]",GetName(playerid),text,playerid,Tag[playerid]);
				}
			}
		}else if(InCWTeam[playerid] == TOrange)
		{
		    if(Admin[playerid] > 0)
		    {
		        if(strlen(Tag[playerid]) < 3)
		        {
		        	format(str,sizeof(str),"{ffffff}[CW] {FF9B00}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff}]",GetName(playerid),text,playerid);
				}else{
                    format(str,sizeof(str),"{ffffff}[CW] {FF9B00}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff} | %s]",GetName(playerid),text,playerid,Tag[playerid]);
				}
			}else{
			    if(strlen(Tag[playerid]) < 3)
			    {
					format(str,sizeof(str),"{ffffff}[CW] {FF9B00}%s:{ffffff} %s [id: %d]",GetName(playerid),text,playerid);
				}else{
                    format(str,sizeof(str),"{ffffff}[CW] {FF9B00}%s:{ffffff} %s [id: %d | %s]",GetName(playerid),text,playerid,Tag[playerid]);
				}
			}
		}
	}else{
	    if(LoggedToTitan[playerid] == 1)
	    {
			if(Admin[playerid] > 0)
			{
			    if(strlen(Tag[playerid]) < 3)
			    {
			    	format(str,sizeof(str),"{daa520}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff}]",GetName(playerid),text,playerid);
				}else{
                    format(str,sizeof(str),"{daa520}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff} | %s]",GetName(playerid),text,playerid,Tag[playerid]);
				}
			}else{
			//daa520
                if(strlen(Tag[playerid]) < 3)
                {
			    	format(str,sizeof(str),"{daa520}%s:{ffffff} %s [id: %d]",GetName(playerid),text,playerid);
				}else{
                    format(str,sizeof(str),"{daa520}%s:{ffffff} %s [id: %d | %s]",GetName(playerid),text,playerid,Tag[playerid]);
				}
			}
	    }else{
			if(Team[playerid] == A)
		    {
		        if(Admin[playerid] > 0)
		        {
		            if(strlen(Tag[playerid]) < 3)
		            {
		            	format(str,sizeof(str),"{00ebf3}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff}]",GetName(playerid),text,playerid);
					}else{
                        format(str,sizeof(str),"{00ebf3}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff} | %s]",GetName(playerid),text,playerid,Tag[playerid]);
					}
				}else{
				    if(strlen(Tag[playerid]) < 3)
				    {
		        		format(str,sizeof(str),"{00ebf3}%s:{ffffff} %s [id: %d]",GetName(playerid),text,playerid);
					}else{
                        format(str,sizeof(str),"{00ebf3}%s:{ffffff} %s [id: %d | %s]",GetName(playerid),text,playerid,Tag[playerid]);
					}
				}
			}
		    if(Team[playerid] == B)
		    {
		        if(Admin[playerid] > 0)
		        {
		            if(strlen(Tag[playerid]) < 3)
		            {
		            	format(str,sizeof(str),"{e60000}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff}]",GetName(playerid),text,playerid);
					}else{
                        format(str,sizeof(str),"{e60000}%s:{ffffff} %s [id: %d | {00ff00}Admin{ffffff} | %s]",GetName(playerid),text,playerid,Tag[playerid]);
					}
				}else{
				    if(strlen(Tag[playerid]) < 3)
				    {
		        		format(str,sizeof(str),"{e60000}%s:{ffffff} %s [id: %d]",GetName(playerid),text,playerid);
					}else{
                        format(str,sizeof(str),"{e60000}%s:{ffffff} %s [id: %d | %s]",GetName(playerid),text,playerid,Tag[playerid]);
					}
				}
			}
	    }
	}
    SendClientMessageToAll(White,str);
    return 0;
}
/*
#define TeamAColor 00ebf3
#define TeamBColor e60000
*/
public OnFilterScriptExit()
{
    DOF2_Exit();
    return 1;
}
//==============================================================================
public OnPlayerCommandReceived(playerid, cmdtext[])
{
    if(InClass[playerid] == 1)return SendClientMessage(playerid,Red,"! לא ניתן לבצע פקודות במסך הבחירה");
    return 1;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	printf("[Command] %s performed a command: %s",GetName(playerid),cmdtext);
    if(InClass[playerid] == 1)return 0;
	for(new i = 0; i < Maxp; i++)
	{
	    if(IsPlayerConnected(i) && Admin[i] > 0 && AdminCanSeeCMD[i] == 1 && i != playerid)
	    {
	        SendFormatMessage(i,Gray,"{5fea5f}[RCM]{b9b9b9} %s sent a command: %s",GetName(playerid),cmdtext);
	    }
	}
    if (!success)return SendFormatMessage(playerid,White,"! [{1BFFFC}%s{ffffff}] הפקודה לא קיימת",cmdtext);
	return 1;
}
	CMD:crash(playerid,params[])
	{
		if(Admin[playerid] < 2 && !IsPlayerAdmin(playerid))return 0;
		new id;
		if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Crash [ID]");
		if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"שחקן לא מחובר");
		if(playerid == id)return SendClientMessage(playerid,Red,"! לא ניתן להשתמש בפקודה הזו על עצמך");
		GameTextForPlayer(id,"•₪¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/",1000,0);
		GameTextForPlayer(id,"•₪¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/",2000,1);
		GameTextForPlayer(id,"•₪¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/",3000,2);
		GameTextForPlayer(id,"•₪¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/",4000,3);
		GameTextForPlayer(id,"•₪¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/",5000,4);
		GameTextForPlayer(id,"•₪¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/",6000,5);
		GameTextForPlayer(id,"•₪¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/",7000,6);
		GameTextForPlayer(id,"•₪¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/",12000,6);
		format(str,sizeof(str),"~r~~h~you crashed ~w~%s",GetName(id));
		GameTextForPlayer(playerid,str,1500,3);
	    return 1;
	}
    CMD:ahelp(playerid,params[])
    {
        SendClientMessage(playerid,Lightblue,"======== > Admin Help < ========");
        SendClientMessage(playerid,Blue,"{00DADE}/ACommands - לכל פקודות האדמינים");
        SendClientMessage(playerid,Blue,"{00DADE}/RCommands - לכל פקודות הרקון");
        SendClientMessage(playerid,Blue,"{00DADE}/AKeys - אופציות מקשים לאדמינים");
		SendClientMessage(playerid,Blue,"{00DADE}/Admins - לרשימת האדמינים המחוברים");
		SendClientMessage(playerid,Blue,"{00DADE} *RCommands אדמינים ברמה 2 יכולים לבצע פקודות של*");
        SendClientMessage(playerid,Lightblue,"======== > Admin Help < ========");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        return 1;
    }
//==============================================================================
	CMD:fakes(playerid,params[])
	{
	    new name[MAX_PLAYER_NAME], msg[128];
	    new fakesCount = 0;
	    SendClientMessage(playerid, -1,"{979797}------ {53e7ee}רשימת הבדויים המחוברים {979797}------");
	    new IP[50];
	    for (new i = 0; i < Maxp; i++)
	    {
	        if (IsPlayerConnected(i) && FakeUser[i] == 1)
	        {
	            GetPlayerName(i, name, sizeof(name));
	            GetPlayerIp(i,IP,sizeof(IP));
	            format(msg, sizeof(msg), "-{40cbd1} %s {ffffff}/{40cbd1} %s",name,DOF2_GetString("RconOptions/IPList.ini",IP));
	            SendClientMessage(playerid, -1, msg);
	            fakesCount++;
	        }
	    }
	    if (fakesCount == 0)SendClientMessage(playerid, White, ".אין בדויים מחוברים");
		return 1;
	}
	CMD:rcons(playerid)
	{
	    new name[MAX_PLAYER_NAME], msg[128];
	    new rconCount = 0;
		SendClientMessage(playerid, -1,"{979797}------ {eddb2d}רשימת המחוברים לרקון {979797}------");
	    for (new i = 0; i < Maxp; i++)
	    {
	        if (IsPlayerConnected(i) && IsPlayerAdmin(i))
	        {
	            GetPlayerName(i, name, sizeof(name));
	            format(msg, sizeof(msg), "{eaba4b}- %s", name);
	            SendClientMessage(playerid, -1, msg);
	            rconCount++;
	        }
	    }
	    if (rconCount == 0)SendClientMessage(playerid, White, "אין שחקנים מחוברים לרקון");
		return 1;
	}
	CMD:amrams(playerid)
	{
	    new name[MAX_PLAYER_NAME], msg[128];
	    new amramscount = 0;
		SendClientMessage(playerid, -1,"{979797}------ {b2fb20}רשימת השחקנים במצב עמרם {979797}------");
	    for (new i = 0; i < Maxp; i++)
	    {
	        if (IsPlayerConnected(i) && AmramMode[i] == true)
	        {
	            GetPlayerName(i, name, sizeof(name));
	            format(msg, sizeof(msg), "{e4e417}- %s",name);
	            SendClientMessage(playerid, -1, msg);
	            amramscount++;
	        }
	    }
	    if (amramscount == 0)SendClientMessage(playerid, White, "אין עמרמים פעילים");
		return 1;
	}
	CMD:admins(playerid)
	{
	    new name[MAX_PLAYER_NAME], msg[128];
	    new adminCount = 0;
		SendClientMessage(playerid, -1,"{979797}------ {00ff00}רשימת האדמינים המחוברים {979797}------");
	    for (new i = 0; i < Maxp; i++)
	    {
	        if (IsPlayerConnected(i) && Admin[i] > 0)
	        {
	            GetPlayerName(i, name, sizeof(name));
	            format(msg, sizeof(msg), "{e4e417}- %s (level: %d)",name,Admin[i]);
	            SendClientMessage(playerid, -1, msg);
	            adminCount++;
	        }
	    }
	    if (adminCount == 0)SendClientMessage(playerid, White, "אין אדמינים מחוברים");
		return 1;
	}
	CMD:ad(playerid)return cmd_admins(playerid);
//==============================================================================
    CMD:credits(playerid,params[])
    {
        SendClientMessage(playerid,Lightblue,"======== > Credits < ========");
        SendClientMessage(playerid,AquaGreen,"• PreLoX :מתכנת המוד");
        SendClientMessage(playerid,AquaGreen,"• v3.0 :גרסת המוד");
        SendClientMessage(playerid,AquaGreen,"• [DOF2,zcmd,sscanf] :פלאגינים");
        SendClientMessage(playerid,AquaGreen,"• מי שמעתיק יקבל ביס משוקידוג");
        SendClientMessage(playerid,Lightblue,"======== > Credits < ========");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        return 1;
    }
    CMD:titanq(playerid,params[])
    {
		if(LoggedToTitan[playerid] == 0)return SendClientMessage(playerid,Red,"! Titan אתה לא מחובר למערכת קלאן");
		LoggedToTitan[playerid] = 0;
		SendClientMessage(playerid,TitanGold,"[TITAN]{cacaca} ! Titan התנתקת ממערכת קלאן");
		if(Team[playerid] == A)return SetPlayerColor(playerid,TeamAColor);
		if(Team[playerid] == B)return SetPlayerColor(playerid,TeamBColor);
		return 1;
	}
	CMD:titan(playerid,params[])
    {
        if(Area[playerid] == CW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! לא ניתן לבצע את הפקודה באמצע קלאן וואר");
        if(LoggedToTitan[playerid] == 1)return SendClientMessage(playerid,TitanGold,"[TITAN]{cacaca} /TitanQ להתנתקות השתמש ב .Titan אתה כבר מחובר למערכת");
		ShowPlayerDialog(playerid,Dialog_Titan ,DIALOG_STYLE_INPUT,"{daa520}Titan Clan System","{e3cc90}:אנא הכנס סיסמת מערכת על מנת להתחבר","התחבר","ביטול");
		return 1;
    }
    CMD:titangetpass(playerid,params[])
    {
		if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
		SendFormatMessage(playerid,TitanGold,"[TITAN]{cacaca} ! %s :הסיסמה הנוכחית למערכת קלאן טייטן היא",TitanCode);
		return 1;
	}
	CMD:titanpass(playerid,params[])
    {
		if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
		new newpass[128];
		if(sscanf(params,"s[128]",newpass))return SendClientMessage(playerid,TitanGold,"Usage:{ffffff} /TitanPass [New Password]");
		if(strlen(newpass) < 5 || strlen(newpass) > 20)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Red,"! הסיסמה חייבת להיות בין 5 ל 20 תווים");
		DOF2_SetString("RconOptions/Settings.ini","TitanCode",newpass);
		DOF2_SaveFile();
		PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
		TitanCode = newpass;
		SendClientMessage(playerid,TitanGold,"[TITAN]{cacaca} ! בהצלחה Titan שינית את הסיסמה למערכת קלאן");
		return 1;
   	}
    CMD:acommands(playerid,params[])
    {
        new page;
        if(sscanf(params,"n",page))return SendClientMessage(playerid,Gold,"Usage:{ffffff} /ACommands [1-5]");
        if(page > 5 || page < 1)return SendClientMessage(playerid,Gold,"Usage:{ffffff} /ACommands {ff0000}[1-5]");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        if(page == 1)
        {
            SendClientMessage(playerid,Gold,"============== [#1] פקודות אדמינים ==============");
            SendClientMessage(playerid,Yellow,"/Gw - להביא נשק לשחקן");
            SendClientMessage(playerid,Yellow,"/Say - לרשום הודעה כאדמין");
            SendClientMessage(playerid,Yellow,"/AKill - להרוג שחקן");
            SendClientMessage(playerid,Yellow,"/Get - לשגר שחקן אליך");
            SendClientMessage(playerid,Yellow,"/Goto - להשתגר אל שחקן");
            SendClientMessage(playerid,Yellow,"/Spec - לצפות בשחקן");
            SendClientMessage(playerid,Yellow,"/UnSpec - לצאת ממצב צפייה בשחקן");
            SendClientMessage(playerid,Yellow,"/Respawn - לבצע ריספאון לשחקן");
            SendClientMessage(playerid,Gold,"============== [#1] פקודות אדמינים ==============");
        }
        else if(page == 2)
        {
            SendClientMessage(playerid,Gold,"============== [#2] פקודות אדמינים ==============");
            SendClientMessage(playerid,Yellow,"/Freeze - לתת פריז לשחקן");
            SendClientMessage(playerid,Yellow,"/UnFreeze - להוריד פריז משחקן");
            SendClientMessage(playerid,Yellow,"/Disarm - לאפס נשקים לשחקן");
            SendClientMessage(playerid,Yellow,"/DisarmAll - לאפס נשקים לכולם");
			SendClientMessage(playerid,Yellow,"/Mute - לתת מיוט לשחקן");
            SendClientMessage(playerid,Yellow,"/UnMute - להוריד מיוט לשחקן");
			SendClientMessage(playerid,Yellow,"/FullAll - למלא חיים ומגן לכולם");
            SendClientMessage(playerid,Yellow,"/Drop - לזרוק שחקן לאוויר");
            SendClientMessage(playerid,Gold,"============== [#2] פקודות אדמינים ==============");
        }
        else if(page == 3)
        {
            SendClientMessage(playerid,Gold,"============== [#3] פקודות אדמינים ==============");
            SendClientMessage(playerid,Yellow,"/GiveJet - לתת ג'ט לשחקן");
            SendClientMessage(playerid,Yellow,"/Slap - לתת כאפה לשחקן");
            SendClientMessage(playerid,Yellow,"/SetSkin - לשנות סקין");
            SendClientMessage(playerid,Yellow,"/Chat - לנעול ולפתוח את הצ'אט");
            SendClientMessage(playerid,Yellow,"/CC - לנקות את הצ'אט");
            SendClientMessage(playerid,Yellow,"/GiveChat - לתת ראשות לשחקן לדבר בצ'אט נעול");
            SendClientMessage(playerid,Yellow,"/DelChat - להוריד לשחקן את האפשרות לדבר בצ'אט נעול");
            SendClientMessage(playerid,Yellow,"/Kick - לתת קיק לשחקן");
            SendClientMessage(playerid,Gold,"============== [#3] פקודות אדמינים ==============");
        }
        else if(page == 4)
        {
            SendClientMessage(playerid,Gold,"============== [#4] פקודות אדמינים ==============");
            SendClientMessage(playerid,Yellow,"/Flip - להפוך את הרכב");
            SendClientMessage(playerid,Yellow,"/RCars - לאפס רכבים בשרת");
			SendClientMessage(playerid,Yellow,"/GetCar - לשגר רכב");
            SendClientMessage(playerid,Yellow,"/DelCar - למחוק רכב");
            SendClientMessage(playerid,Yellow,"/LTC - לשגר אליך רכב מיוחד");
            SendClientMessage(playerid,Yellow,"/LTC2 - לשגר אליך רכב מיוחד 2");
            SendClientMessage(playerid,Yellow,"/Fix - לתקן את הרכב");
            SendClientMessage(playerid,Yellow,"/VGM - גוד מוד לרכב");
            SendClientMessage(playerid,Gold,"============== [#4] פקודות אדמינים ==============");
        }
        else if(page == 5)
        {
            SendClientMessage(playerid,Gold,"============== [#5] פקודות אדמינים ==============");
			SendClientMessage(playerid,Yellow,"/RPM - להפעיל ולכבות לוגים להודעות פרטיות");
			SendClientMessage(playerid,Yellow,"/RCM - להפעיל ולכבות לוגים לפקודות");
            SendClientMessage(playerid,Yellow,"/CleanTable - ניקוי טבלת הריגות");
            SendClientMessage(playerid,Yellow,"/CWHelp - פקודות מערכת הקלאן וואר");
            SendClientMessage(playerid,Yellow,"/MyTag - לשים תאג אישי עבורך");
            SendClientMessage(playerid,Yellow,"/SetTag | DelTag - לשים או למחוק תאג אישי עבור שחקן אחר");
            SendClientMessage(playerid,Yellow,"/Bomb - לשלוח פיצוץ לאחד השחקנים");
            SendClientMessage(playerid,Yellow,"/Act - להפעיל או לכבות פעילות בשרת");
			SendClientMessage(playerid,Gold,"============== [#5] פקודות אדמינים ==============");
        }
        return 1;
    }
    CMD:cwhelp(playerid,params[])
    {
		SendClientMessage(playerid,Yellow,"{a0a0a0}============ [{efaa2a}Clan War פקודות{a0a0a0}] ============");
		SendClientMessage(playerid,1,"{efe02a}/CW1 - בחירת הקבוצה הירוקה");
		SendClientMessage(playerid,1,"{efe02a}/CW2 - בחירת הקבוצה הכתומה");
		SendClientMessage(playerid,1,"{efe02a}/CWR - לשנות את מספר הראונדים בקלאן וואר");
		SendClientMessage(playerid,1,"{efe02a}/CWStart | /CWEnd - להתחיל או לסיים את הקלאן וואר בין הקבוצות");
		SendClientMessage(playerid,1,"{efe02a}/CWRp - לאפס את שחקני הקלאן וואר");
		SendClientMessage(playerid,1,"{efe02a}/RCW - לאפס את הראונד בקלאן וואר");
		SendClientMessage(playerid,1,"{efe02a}/CWCredits - קרדיטים למערכת הקלאן וואר");
        SendClientMessage(playerid,1,"{efe02a}/CWView - להכנס בתור צופה לקלאן וואר");
		SendClientMessage(playerid,Yellow,"{a0a0a0}============ [{efaa2a}Clan War פקודות{a0a0a0}] ============");
        return 1;
    }
    CMD:cw(playerid,params[])return cmd_cwhelp(playerid,params);
    CMD:cwcredits(playerid,params[])
    {
		SendClientMessage(playerid,Prp,"{a0a0a0}============== {efaa2a}ClanWar קרדיטים {a0a0a0}==============");
		SendClientMessage(playerid,Lightgreen,"{e4bf1a}PreLoX {d3d3d3}&{e4bf1a} SaiyajiN{d3d3d3} - מערכת הקלאן וואר נבנתה על ידי");
		SendClientMessage(playerid,Lightgreen,"{e4bf1a}SubjecT{d3d3d3} - שפן הנסיונות הראשי שלנו היה");
		SendClientMessage(playerid,Lightgreen,"{d3d3d3}! תהנו");
		SendClientMessage(playerid,Prp,"{a0a0a0}============== {efaa2a}ClanWar קרדיטים {a0a0a0}==============");
        return 1;
    }
//================================== CW COMMANDS ===============================
	CMD:cwview(playerid,params[])
	{
		if(CWOn == false) return SendClientMessage(playerid,Red,"! אין קלאן וואר פעיל");
		if(InCWTeam[playerid] == TOrange || InCWTeam[playerid] == TGreen)return SendClientMessage(playerid,Red,"אתה נמצא בקלאן וואר, אינך יכול לצפות בו.");
		Area[playerid] = CWVIEW;
		SpawnPlayerToCw(playerid);
		SendClientMessage(playerid,Green,"[Clan War System] - השתגרת לצפות בקלאן וואר");
		return 1;
	}
	CMD:cwr(playerid,params[])
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		new num;
		if(sscanf(params,"i",num))return SendClientMessage(playerid,Green,"Usage:{ffffff} /CWR [Rounds 5-15]");
		if(num < 5 || num > 15)return SendClientMessage(playerid,Green,"Usage:{ffffff} /CWR {ff0000}[Rounds 5-15]");
		if(num == CWMaxRounds)return SendClientMessage(playerid,Red,"! מספר הראונדים שבחרת זהה למספר הראונדים הנוכחי");
		CWMaxRounds = num;
		new playeridname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,playeridname,sizeof(playeridname));
		SendFormatMessageToAll(Yellow,"[Clan-War] ! %d -שינה את מספר הראונדים בקלאן וואר ל %s האדמין",num,playeridname);
		return 1;
	}
	CMD:cw1(playerid,params[])
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
	    if(CWOn == true)return SendClientMessage(playerid,Red,"! יש כבר קלאן וואר פעיל");
		new id1,id2,id3;
		if(sscanf(params,"uuu",id1,id2,id3))return SendClientMessage(playerid,Green,"Usage:{ffffff} /CW1 [Id1] [Id2] [Id3]");
		if(!IsPlayerConnected(id1) || !IsPlayerConnected(id2) || !IsPlayerConnected(id3))return SendClientMessage(playerid,Red,"! אחד מהשחקנים שבחרת אינו מחובר");
		InCWTeam[id1] = TGreen,InCWTeam[id2] = TGreen,InCWTeam[id3] = TGreen;
		CalculateTeamMembers(id1,id2,id3);
		TeamHasChosen[TGreen] = true;
		SendFormatMessageToAll(Yellow,"[Clan-War] בחר את שחקני הקבוצה הירוקה {44EE16}%s{ffff00} האדמין",GetName(playerid));
		SendFormatMessageToAll(Yellow,"[Clan-War] {44EE16}- %s {989898}/{44EE16} %s {989898}/{44EE16} %s",GetName(id1),GetName(id2),GetName(id3));
		if(TeamMembers == 1)GreenCount = 1;
		if(TeamMembers == 2)GreenCount = 2;
		if(TeamMembers == 3)GreenCount = 3;
  		OrangePlayer[id1][1] = false,OrangePlayer[id1][2] = false,OrangePlayer[id1][3] = false;
  		OrangePlayer[id2][1] = false,OrangePlayer[id2][2] = false,OrangePlayer[id2][3] = false;
  		OrangePlayer[id3][1] = false,OrangePlayer[id3][2] = false,OrangePlayer[id3][3] = false;
		GreenPlayer[id2][2] = true,GreenPlayer[id3][3] = true,GreenPlayer[id1][1] = true;
		SetPlayerColor(id1,CWGreenColor),SetPlayerColor(id2,CWGreenColor),SetPlayerColor(id3,CWGreenColor);
		SetPlayerTeam(id1,TGreen),SetPlayerTeam(id2,TGreen),SetPlayerTeam(id3,TGreen);
		for(new i = 0; i < Maxp; i++)
        {
            if(IsPlayerConnected(i) && InCWTeam[i] == TGreen  && AmramMode[i] == true)
            {
		        AmramMode[i] = false;
		        ResetPlayerWeapons(i);
		        GivePlayerWeapon(i,22,9000);
		        GivePlayerWeapon(i,28,9000);
		        GivePlayerWeapon(i,26,9000);
                format(Tag[i],25,"%s",PreTag[i]);
                ForcedToExitAmram[i] = true;
	        }
		}
		return 1;
	}
	CMD:cw2(playerid,params[])
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
	    if(CWOn == true)return SendClientMessage(playerid,Red,"! יש כבר קלאן וואר פעיל");
		new id1,id2,id3;
		if(sscanf(params,"uuu",id1,id2,id3))return SendClientMessage(playerid,Green,"Usage:{ffffff} /CW2 [Id1] [Id2] [Id3]");
		if(!IsPlayerConnected(id1) || !IsPlayerConnected(id2) || !IsPlayerConnected(id3))return SendClientMessage(playerid,Red,"! אחד מהשחקנים שבחרת אינו מחובר");
		InCWTeam[id1] = TOrange,InCWTeam[id2] = TOrange,InCWTeam[id3] = TOrange;
		CalculateTeamMembers(id1,id2,id3);
		TeamHasChosen[TOrange] = true;
		new playeridname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,playeridname,sizeof(playeridname));
		SendFormatMessageToAll(Yellow,"[Clan-War] בחר את שחקני הקבוצה הכתומה {FF9B00}%s{ffff00} האדמין",GetName(playerid));
		SendFormatMessageToAll(Yellow,"[Clan-War] {FF9B00}- %s {989898}/{FF9B00} %s {989898}/{FF9B00} %s",GetName(id1),GetName(id2),GetName(id3));
		if(TeamMembers == 1)OrangeCount = 1;
		if(TeamMembers == 2)OrangeCount = 2;
		if(TeamMembers == 3)OrangeCount = 3;
  		GreenPlayer[id1][1] = false,GreenPlayer[id1][2] = false,GreenPlayer[id1][3] = false;
  		GreenPlayer[id2][1] = false,GreenPlayer[id2][2] = false,GreenPlayer[id2][3] = false;
  		GreenPlayer[id3][1] = false,GreenPlayer[id3][2] = false,GreenPlayer[id3][3] = false;
		OrangePlayer[id2][2] = true,OrangePlayer[id3][3] = true,OrangePlayer[id1][1] = true;
		SetPlayerColor(id1,CWOrangeColor),SetPlayerColor(id2,CWOrangeColor),SetPlayerColor(id3,CWOrangeColor);
        SetPlayerTeam(id1,TOrange),SetPlayerTeam(id2,TOrange),SetPlayerTeam(id3,TOrange);
		for(new i = 0; i < Maxp; i++)
        {
            if(IsPlayerConnected(i) && InCWTeam[i] == TOrange  && AmramMode[i] == true)
            {
		        AmramMode[i] = false;
		        ResetPlayerWeapons(i);
		        GivePlayerWeapon(i,22,9000);
		        GivePlayerWeapon(i,28,9000);
		        GivePlayerWeapon(i,26,9000);
                format(Tag[i],25,"%s",PreTag[i]);
                ForcedToExitAmram[i] = true;
	        }
		}
		return 1;
	}
	CMD:cwrp(playerid,params[])
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		if(CWOn == true)return SendClientMessage(playerid,Red,"! לא ניתן לאפס את השחקנים כשיש קלאן וואר פעיל");
		for(new i; i < Maxp; i++)
		{
		    if(IsPlayerConnected(i) && InCWTeam[i] == TGreen || InCWTeam[i] == TOrange)
		    {
		        SetPlayerTeam(i,NO_TEAM);
				GreenPlayer[i][1] = false,GreenPlayer[i][2] = false,GreenPlayer[i][3] = false;
				OrangePlayer[i][1] = false,OrangePlayer[i][2] = false,OrangePlayer[i][3] = false;
		        InCWTeam[i] = None;
	         	if(Team[i] == A)
	       		{
					if(LoggedToTitan[i] == 0)
					{
	         			SetPlayerColor(i, TeamAColor);
	         		}else{
	                    SetPlayerColor(i, TitanGold);
					}
	         	}
	         	if(Team[i] == B)
	       		{
					if(LoggedToTitan[i] == 0)
					{
	         			SetPlayerColor(i, TeamBColor);
	         		}else{
	                    SetPlayerColor(i, TitanGold);
					}
	          	}
			}
			if(IsPlayerConnected(i) && ForcedToExitAmram[i] == true)
			{
				ForcedToExitAmram[i] = false;
				AmramMode[i] = true;
				SendClientMessage(i,Lightgreen,"{b0f217}[Amram Mode]{cacaca} המערכת זיהתה כי היית במצב עמרם מופעל לפני הקלאן וואר והחזירה אותך אוטומטית");
	            PlayerPlaySound(i,1057,0.0,0.0,0.0);
	            ResetPlayerWeapons(i);
	            GivePlayerWeapon(i,5,1);
	            PreSkin[i] = GetPlayerSkin(i);
				SetPlayerSkin(i,267);
				format(PreTag[i],25,"%s",DOF2_GetString(pFile(playerid),"Tag"));
				Tag[i] = "{b0f217}עמרם{ffffff}";
			}
		}
		TeamHasChosen[TGreen] = false;
		TeamHasChosen[TOrange] = false;
		new playeridname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,playeridname,sizeof(playeridname));
		SendFormatMessageToAll(Yellow,"[Clan-War] ! איפס את שחקני הקלאן וואר %s האדמין",playeridname);
		return 1;
	}
	CMD:cwstart(playerid,params[])
	{
	    if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		if(TeamHasChosen[TGreen] == false || TeamHasChosen[TOrange] == false)return SendClientMessage(playerid,Red,"יש לבחור שחקנים עבור 2 הקבוצות לפני התחלת הקלאן וואר");
		if(CWOn == true)return SendClientMessage(playerid,Red,"! יש כבר קלאן וואר פעיל");
		CWOn = true;
		for(new i = 0; i < Maxp; i++)
		{
			if(IsPlayerConnected(i) && ForcedToExitAmram[i] == true)
			{
				ForcedToExitAmram[i] = false;
				SetPlayerSkin(i,PreSkin[i]);
			}
		}
		StartRound();
		new playeridname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,playeridname,sizeof(playeridname));
		SendFormatMessageToAll(Yellow,"[Clan-War] ! התחיל את הקלאן וואר בין הקבוצות %s האדמין",playeridname);
		return 1;
	}
	CMD:cwend(playerid,params[])
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		if(CWOn == false)return SendClientMessage(playerid,Red,"! אין קלאן וואר פועל");
		CWEnd();
		new playeridname[MAX_PLAYER_NAME];
		GetPlayerName(playerid,playeridname,sizeof(playeridname));
		SendFormatMessageToAll(Yellow,"[Clan-War] ! עצר את הקלאן וואר %s האדמין",playeridname);
		return 1;
	}
	CMD:rcw(playerid,params[])
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		if(CWOn == false)return SendClientMessage(playerid,Red,"! אין קלאן וואר פעיל");
		SendFormatMessageToAll(Yellow,"[Clan-War] ! CW -התחיל מחדש את הראונד ב %s האדמין",GetName(playerid));
		for(new i; i < Maxp; i++)
		{
		    if(IsPlayerConnected(i) && InCWTeam[i] == TOrange || InCWTeam[i] == TGreen)
		    {
		        Area[i] = CW;
			}
		}
		StartRound();
		return 1;
	}
forward UnFreeze(i);
public UnFreeze(i)
{
	TogglePlayerControllable(i,1);
	return 1;
}
forward StartRound();
public StartRound()
{
	for(new i = 0; i < Maxp; i++)
	{
	    if(IsPlayerConnected(i) && InCWTeam[i] == TGreen || InCWTeam[i] == TOrange)
	    {
	        Area[i] = CW;
	        if(InCWTeam[i] == TGreen)
	        {
	            if(GreenPlayer[i][1] == true)SetPos(i,1137.2332,1335.9259,10.8203,180);
	            if(GreenPlayer[i][2] == true)SetPos(i,1117.2332,1335.9259,10.8203,180);
	            if(GreenPlayer[i][3] == true)SetPos(i,1157.2332,1335.9259,10.8203,180);
	        }
			else if(InCWTeam[i] == TOrange)
			{
			    if(OrangePlayer[i][1] == true)SetPos(i,1137.2332,1245.9259,10.8203,360);
			    if(OrangePlayer[i][2] == true)SetPos(i,1117.2332,1245.9259,10.8203,360);
			    if(OrangePlayer[i][3] == true)SetPos(i,1157.2358,1245.6803,10.8203,360);
			}
			SetPlayerHealth(i,100);
			SetPlayerArmour(i,100);
			SetPlayerInterior(i,0);
			SetPlayerVirtualWorld(i,101);
			ResetPlayerWeapons(i);
			TogglePlayerControllable(i,0);
			GivePlayerWeapon(i,22,9999),GivePlayerWeapon(i,26,9999),GivePlayerWeapon(i,28,9999);
			SetTimerEx("UnFreeze",5000,false,"%d",i);
		}
	}
	CDForVirtualWorld(101,5);
	GreenDeath = 0;
	OrangeDeath = 0;
}
stock CalculateTeamMembers(id1, id2, id3)
{
    if(id1 != id2 && id1 != id3 && id2 != id3)TeamMembers = 3;
   	if((id1 != id2 && id2 == id3) || (id1 == id3 && id2 != id3) || (id1 == id2 && id2 != id3))TeamMembers = 2;
    if(id1 == id2 && id2 == id3)TeamMembers = 1;
}
forward CWEnd();
public CWEnd()
{
	for(new i = 0; i < Maxp; i++)
	{
	    if(IsPlayerConnected(i) && Area[i] == CW || Area[i] == CWSPEC || Area[i] == CWVIEW)
	    {
	        SetPlayerVirtualWorld(i,0);
			Area[i] = Light;
			InCWTeam[i] = None;
			SetPlayerHealth(i,100);
			SetPlayerArmour(i,100);
			SetPlayerTeam(i,NO_TEAM);
			SpawnPlayer(i);
			GreenPlayer[i][1] = false,GreenPlayer[i][2] = false,GreenPlayer[i][3] = false;
			OrangePlayer[i][1] = false,OrangePlayer[i][2] = false,OrangePlayer[i][3] = false;
			if(LoggedToTitan[i] == 1)
			{
			    SetPlayerColor(i,TitanGold);
			}else{
				if(Team[i] == A)SetPlayerColor(i,TeamAColor);
				if(Team[i] == B)SetPlayerColor(i,TeamBColor);
			}
		}
	}
	GreenCount = 0;
	GreenDeath = 0;
	GreenScore = 0;
	OrangeCount = 0;
	OrangeDeath = 0;
	OrangeScore = 0;
	TeamHasChosen[TGreen] = false;
	TeamHasChosen[TOrange] = false;
	CWOn = false;
	return 1;
}
forward UnfreezePlayerAfterDelay(playerid);
public UnfreezePlayerAfterDelay(playerid)
{
    TogglePlayerControllable(playerid, 1); // הסרת הפריז מהשחקן
    return 1;
}
//==============================================================================
    CMD:rcommands(playerid,params[])
    {
        if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
        new page;
        if(sscanf(params,"n",page))return SendClientMessage(playerid,Green,"Usage:{Ffffff} /RCommands [1-2]");
        if(page < 1 || page > 2)return SendClientMessage(playerid,Green,"Usage:{Ffffff} /RCommands{ff0000} [1-2]");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		if(page == 1)
        {
            SendClientMessage(playerid,Gold,"============== [#1] פקודות לרקון ==============");
            SendClientMessage(playerid,Yellow,"/SetAdmin - לתת אדמין לשחקן");
            SendClientMessage(playerid,Yellow,"/DelAdmin - להוריד אדמין לשחקן");
            SendClientMessage(playerid,Yellow,"/RPanel - (פאנל רקון (לא כל הפקודות נמצאות שם");
            SendClientMessage(playerid,Yellow,"/FullEdit - לכבות ולהפעיל את האופציה למילוי חיים");
            //SendClientMessage(playerid,Yellow,"/AutoMessage - לכבות ולהפעיל הודעות אוטומטיות");
            SendClientMessage(playerid,Yellow,"/KillFull - מילוי חיים ומגן לאחר כל הריגה");
            SendClientMessage(playerid,Yellow,"/Ban - לתת באן לשחקן");
            SendClientMessage(playerid,Yellow,"/UnBan - להוריד באן משחקן");
            SendClientMessage(playerid,Yellow,"/Pec - להדליק או לכבות את האופציה לשחקנים להכנס לרכב");
            SendClientMessage(playerid,Gold,"============== [#1] פקודות לרקון ==============");
		}
        if(page == 2)
        {
            SendClientMessage(playerid,Gold,"============== [#2] פקודות לרקון ==============");
			SendClientMessage(playerid,Yellow,"/CdEdit - לערוך את מס השניות לספירה");
			SendClientMessage(playerid,Yellow,"/TitanPass - שינוי סיסמת מערכת הקלאן טייטן");
            SendClientMessage(playerid,Yellow,"/TitanGetPass - בדיקת הסיסמה הנוכחית למערכת הקלאן טייטן");
            SendClientMessage(playerid,Yellow,"/Crash - לתת קראש לשחקן");
			SendClientMessage(playerid,Gold,"============== [#2] פקודות לרקון ==============");
		}
        return 1;
    }
    CMD:help(playerid,params[])
    {
        SendClientMessage(playerid,Blue,"{00A6FF}==========[{00FFFF} Help {00A6FF}]==========");
        SendClientMessage(playerid,Aqua,"/Commands - פקודות לשחקן");
        SendClientMessage(playerid,Aqua,"/AHelp - פקודות לאדמינים");
        SendClientMessage(playerid,Aqua,"/Areas - איזורים");
        SendClientMessage(playerid,Aqua,"/Chathelp - אופציות דיבור בצ'אט");
        SendClientMessage(playerid,Aqua,"/Keys - אופציות למקשים");
        SendClientMessage(playerid,Aqua,"/ModeInfo - פרטי המוד");
        SendClientMessage(playerid,Aqua,"/Credits - קרדיטים");
        SendClientMessage(playerid,Blue,"{00A6FF}==========[{00FFFF} Help {00A6FF}]==========");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
    }
    CMD:chathelp(playerid,params[])
    {
        SendClientMessage(playerid,AquaGreen,"{b962de}==========[{a380f5} Chat Help {b962de}]==========");
        SendClientMessage(playerid,Gray,"{bcea21}@{d8ea21}TEXT - שליחת הודעה לקבוצה שאתה נמצא בה");
        SendClientMessage(playerid,Gray,"{bcea21}#{d8ea21}TEXT - שליחת הודעה אל העולם הוירטואלי שאתה נמצא בו");
        SendClientMessage(playerid,Gray,"{bcea21}${d8ea21}TEXT - צ'אט אדמינים");
        SendClientMessage(playerid,Gray,"{d8ea21}/PM - שליחת הודעה פרטית אל שחקן");
        SendClientMessage(playerid,AquaGreen,"{b962de}==========[{a380f5} Chat Help {b962de}]==========");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
    }
    CMD:keys(playerid,params[])
    {
        SendClientMessage(playerid,Yellow,"{00A6FF}==========[{00FFFF} Keys {00A6FF}]==========");
        SendClientMessage(playerid,Aqua,"Y Key - מילוי חיים ומגן");
        SendClientMessage(playerid,Aqua,"N Key - השתגרות חזרה לספאון");
        SendClientMessage(playerid,Yellow,"{00A6FF}==========[{00FFFF} Keys {00A6FF}]==========");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
    }
    CMD:akeys(playerid,params[])
    {
        SendClientMessage(playerid,Lightgreen,"{00A6FF}==========[{00FFFF} Keys {00A6FF}]==========");
        SendClientMessage(playerid,Gold,"Y Key - מילוי חיים ומגן ותיקון רכב");
        SendClientMessage(playerid,Gold,"N Key - השתגרות חזרה לספאון");
        SendClientMessage(playerid,Gold,"H Key - ניקוי צ'אט מילוי חיים ומגן לכולם וספירה");
        SendClientMessage(playerid,Gold,"Left Mouse Key - מהירות לרכב");
        SendClientMessage(playerid,Gold,"ALT GR/LCTRL/NUM0 Key - להקפיץ את הרכב");
        SendClientMessage(playerid,Gold,"Right Mouse Key (MAP) - לחיצה ימנית בעכבר בתוך מפת המשחק תשגר אותך אל הנקודה");
        SendClientMessage(playerid,Lightgreen,"{00A6FF}==========[{00FFFF} Keys {00A6FF}]==========");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
    }
    CMD:areas(playerid,params[])
    {
        SendClientMessage(playerid,Aqua,"========== Areas - איזורים ==========");
        SendClientMessage(playerid,AquaGreen,"/Light - איזור קלים");
        SendClientMessage(playerid,AquaGreen,"/Wars - איזור הוואר");
        SendClientMessage(playerid,AquaGreen,"/AP - איזור שדה התעופה");
        SendClientMessage(playerid,AquaGreen,"/WH - איזור המחסן");
        SendClientMessage(playerid,AquaGreen,"/BR - Br איזור ה");
        SendClientMessage(playerid,AquaGreen,"/GG - Gun Game איזור ה");
        /*SendClientMessage(playerid,AquaGreen,"/Heavy - איזור כבדים {ff0000}(deleted)");
        SendClientMessage(playerid,AquaGreen,"/Sniper - איזור סנייפרים {ff0000}(deleted)");
        SendClientMessage(playerid,AquaGreen,"/RPG - איזור טילים {ff0000}(deleted)");*/
        SendClientMessage(playerid,Aqua,"========== Areas - איזורים ==========");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
    }
    CMD:modeinfo(playerid,params[])
    {
        SendClientMessage(playerid,Aqua,"========== Mode Info ==========");
        SendClientMessage(playerid,AquaGreen,"! v3.0 - גרסת המוד");
        SendClientMessage(playerid,AquaGreen,"! CW בגרסה זו של המוד לא קיימת מערכת");
        SendClientMessage(playerid,AquaGreen,"! PreLoX - מתכנת המוד");
        SendClientMessage(playerid,Aqua,"========== Mode Info ==========");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
    }
    CMD:commands(playerid,params[])
    {
        new page;
        if(sscanf(params,"n",page))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Commands [1-4]");
        if(page > 4 || page < 1)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Commands {ff0000} [1-4]");
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        if(page == 1)
        {
            SendClientMessage(playerid,AquaGreen,"=========[ #1 פקודות לשחקן ]==========");
            SendClientMessage(playerid,Aqua,"/Spawn - להשתגר חזרה לספאון");
            SendClientMessage(playerid,Aqua,"/PM - לשלוח הודעה פרטית");
            SendClientMessage(playerid,Aqua,"/MySkin - לשנות את הסקין של השחקן");
			SendClientMessage(playerid,Aqua,"/SetWorld - לשנות עולם וירטואלי");
            SendClientMessage(playerid,Aqua,"/MyWorld - לבדוק את העולם הוירטואלי");
            SendClientMessage(playerid,Aqua,"/Admins - לבדוק אדמינים מחוברים");
            SendClientMessage(playerid,Aqua,"/Titan - התחברות למערכת הקלאן טייטן");
            SendClientMessage(playerid,Aqua,"/TitanQ - התנתקות ממערכת הקלאן טייטן");
            //SendClientMessage(playerid,Aqua,"/SaveSkin - לשמור את הסקין");
            //SendClientMessage(playerid,Aqua,"/DelSkin - למחוק את הסקין");
            SendClientMessage(playerid,AquaGreen,"=========[ #1 פקודות לשחקן ]==========");
        }
        if(page == 2)
        {
            SendClientMessage(playerid,AquaGreen,"=========[ #2 פקודות לשחקן ]==========");
            SendClientMessage(playerid,Aqua,"/Fullpower (/fp) - לחדש ריצה");
			SendClientMessage(playerid,Aqua,"/Kill - להתאבד");
			SendClientMessage(playerid,Aqua,"/Teams - להחליף קבוצה");
            SendClientMessage(playerid,Aqua,"/CLS - לנקות את הצ'אט לעצמך");
            SendClientMessage(playerid,Aqua,"/Jetp - לקבל ג'ט פק");
            SendClientMessage(playerid,Aqua,"/Fps - לבדוק את כמות הפריימים שלך");
            SendClientMessage(playerid,Aqua,"/HitSound - לכבות ולהפעיל את האופציה להיט סאונד");
            SendClientMessage(playerid,Aqua,"/TMP - לראות את כמות המוות וההריגות שלך מרגע כניסתך לשרת");
            SendClientMessage(playerid,AquaGreen,"=========[ #2 פקודות לשחקן ]==========");
        }
        if(page == 3)
        {
            SendClientMessage(playerid,AquaGreen,"=========[ #3 פקודות לשחקן ]==========");
            SendClientMessage(playerid,Aqua,"/Report - לדווח על שחקן");
            SendClientMessage(playerid,Aqua,"/Changepass - שינוי סיסמה למשתמש");
            SendClientMessage(playerid,Aqua,"/Showmypass - צפייה בסיסמה הנוכחית שלך");
            SendClientMessage(playerid,Aqua,"/Settings - הגדרות שחקן");
            SendClientMessage(playerid,Aqua,"/Fakes - רשימת השחקנים הבדויים המחוברים");
            SendClientMessage(playerid,Aqua,"/Rcons - רשימת השחקנים שמחוברים לרקון");
            SendClientMessage(playerid,Aqua,"/Time - לשנות שעה לעצמכם במשחק");
            SendClientMessage(playerid,Aqua,"/Weather - לשנות לעצמכם מזג אוויר במשחק");
            SendClientMessage(playerid,AquaGreen,"=========[ #3 פקודות לשחקן ]==========");
        }
        if(page == 4)
        {
            SendClientMessage(playerid,AquaGreen,"=========[ #4 פקודות לשחקן ]==========");
			SendClientMessage(playerid,Aqua,"/Amram - להכנס ולצאת ממצב עמרם");
			SendClientMessage(playerid,Aqua,"/Amrams - רשימת השחקנים במצב עמרם");
			SendClientMessage(playerid,Aqua,"/Radio - תחנות הרדיו");
			SendClientMessage(playerid,Aqua,"/MOff - לעצור את הרדיו");
			SendClientMessage(playerid,Aqua,"/Animlist - רשימת אנימציות");
			SendClientMessage(playerid,Aqua,"/ActJoin - להירשם לפעילות קיימת");
			SendClientMessage(playerid,Aqua,"/ActQ - לצאת מפעילות");
            SendClientMessage(playerid,AquaGreen,"=========[ #4 פקודות לשחקן ]==========");
        }
        return 1;
    }
/*
{ef2626}שים לב! שינוי הניק הזה הוא לא זמני\n{ef2626}.ומומלץ להשתמש בו רק אם ברצונך להתחבר בפעם הבאה אל הניק החדש\n{34e2c0}/Changenick{cacaca} - אם ברצונך לשנות לניק זמני שלא ישמר השתמש בפקודה\n\n{cacaca}:אנא הקלד ניק חדש עבור המשתמש שלך
*/
    stock ShowPlayerChangenickDialog(playerid)
    {
		ShowPlayerDialog(playerid,Dialog_Changenick,DIALOG_STYLE_INPUT,"{00ffc5}ChangeNick - שינוי ניק רשמי למשתמש","{ef2626}שים לב! שינוי הניק הזה הוא לא זמני\n{ef2626}.ומומלץ להשתמש בו רק אם ברצונך להתחבר בפעם הבאה אל הניק החדש\n{34e2c0}/Changenick{cacaca} - אם ברצונך לשנות לניק זמני שלא ישמר השתמש בפקודה\n\n{cacaca}:אנא הקלד ניק חדש עבור המשתמש שלך","אישור","ביטול");
        return 1;
    }
    stock ShowPlayerSettingsDialog(playerid)
    {
        format(str,sizeof(str),"{10e591}Hit Sound{c1c1c1} - צליל פגיעה\n{10e591}Change Password{c1c1c1} - שינוי סיסמה למשתמש\n{10e591}Show My Password{c1c1c1} - צפה בסיסמה הנוכחית\n{10e591}Your TMP{c1c1c1} - Kills: {92cab4}%d{c1c1c1} || Deaths: {92cab4}%d\n{10e591}Change Nickname{c1c1c1} - שינוי ניק רשמי למשתמש",TotalKills[playerid],TotalDeaths[playerid]);
        ShowPlayerDialog(playerid,Dialog_Settings,DIALOG_STYLE_LIST,"{00ffc5}Settings - הגדרות שחקן",str,"בחר","ביטול");
        return 1;
    }
	stock ShowPlayerHitsoundDialog(playerid)
	{
	    ShowPlayerDialog(playerid,Dialog_Hitsound,DIALOG_STYLE_LIST,"{00ffc5}Hit Sound - הגדרות שחקן","{00ff00}אפשר\n{ff0000}בטל","אישור","חזור");
		return 1;
	}
	stock ShowPlayerChangepassDialog(playerid)
	{
	    ShowPlayerDialog(playerid,Dialog_Changepass,DIALOG_STYLE_INPUT,"{00ffc5}Change Password - הגדרות שחקן","{cacaca}:אנא הקלד סיסמה חדשה למשתמש","אישור","חזור");
		return 1;
	}
	stock ShowPlayerShowpass2Dialog(playerid)
	{
        format(str,sizeof(str),"{c8c8c8}%s {edf32a}:הסיסמה הנוכחית שלך היא\n{edf32a}F8 מומלץ לצלם מסך בעזרת המקש",DOF2_GetString(pFile(playerid),"Password"));
		ShowPlayerDialog(playerid,Dialog_Showpass2,DIALOG_STYLE_MSGBOX,"{e5c741}Show My Password",str,"אישור","ביטול");
		return 1;
	}
    CMD:settings(playerid,params[])
    {
        ShowPlayerSettingsDialog(playerid);
        return 1;
    }
    CMD:s(playerid,params[])return cmd_settings(playerid,"");
	CMD:showmypass(playerid,params[])
	{
        format(str,sizeof(str),"{c8c8c8}%s {edf32a}:הסיסמה הנוכחית שלך היא\n{edf32a}F8 מומלץ לצלם מסך בעזרת המקש",DOF2_GetString(pFile(playerid),"Password"));
		ShowPlayerDialog(playerid,Dialog_Showpass,DIALOG_STYLE_MSGBOX,"{e5c741}Show My Password",str,"אישור","ביטול");
		return 1;
	}
	CMD:changepass(playerid, params[])
	{
	    new newpass[32];
	    if (sscanf(params, "s[32]", newpass))return SendClientMessage(playerid, Green, "Usage:{ffffff} /Changepass [New Password]");
	    if (strlen(newpass) < 3)return SendClientMessage(playerid, Red, "! הסיסמה החדשה חייבת להיות ארוכה יותר מ-3 תווים");
	    if (!strcmp(newpass, DOF2_GetString(pFile(playerid), "Password"), true))return SendClientMessage(playerid, Red, ".הסיסמה החדשה שהקלדת זהה לנוכחית");
	    DOF2_SetString(pFile(playerid), "Password", newpass);
	    DOF2_SaveFile();
	    SendClientMessage(playerid, Lightgreen, "! הסיסמה שלך שונתה בהצלחה");
	    return 1;
	}
    CMD:report(playerid,params[])
    {
        new admin_found = 0;
        for(new i = 0; i < Maxp; i++)
        {
            if(IsPlayerConnected(i) && Admin[i] > 0)
            {
                admin_found = 1;
                break;
            }
		}
		if(admin_found == 1)
		{
			new id,reason[128];
			if(sscanf(params,"is[128]",id,reason))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Report [ID] [Reason]");
			if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
			if(reportedonsomeone[playerid] == 1)return SendClientMessage(playerid,Red,"! אנא המתן לפחות 3 שניות עד הדיווח הבא");
			for(new a = 0; a < Maxp; a++)
			{
			    if(IsPlayerConnected(a) && Admin[a] > 0)
			    {
			        SendFormatMessage(a,Red,"[REPORT]{ce0000} %s reported %s / Reason: %s",GetName(playerid),GetName(id),reason);
	                PlayerPlaySound(a,1057,0.0,0.0,0.0);
				}
			}
			reportedonsomeone[playerid] = 1;
			SetTimerEx("reporteddelay", 3000, false, "d", playerid);
			SendClientMessage(playerid,Lightgreen,"! הדיווח נשלח לאדמינים");
		}else{
			SendClientMessage(playerid,Red,"! אין אדמינים מחוברים");
		}
		return 1;
    }
forward reporteddelay(playerid);
public reporteddelay(playerid)
{
	reportedonsomeone[playerid] = 0;
	return 1;
}
    CMD:hitsound(playerid,params[])
    {
        new choose;
        if(sscanf(params,"n",choose))return SendClientMessage(playerid,Green,"Usage:{ffffff} /HitSound [0/1]");
        if(choose < 0 || choose > 1)return SendClientMessage(playerid,Green,"Usage:{ffffff} /HitSound{ff0000} [0/1]");
        GetPlayerName(playerid,pname,sizeof(pname));
        if(choose == 1)
        {
            if(DOF2_GetInt(pFile(playerid),"HitSound") == 1)return SendClientMessage(playerid,Red,"! ההיט סאונד כבר מופעל אצלך");
            DOF2_SetInt(pFile(playerid),"HitSound",1);
            DOF2_SaveFile();
            HitSound[playerid] = 1;
			SendClientMessage(playerid,Yellow,"! הפעלת את ההיט סאונד");
        }
        if(choose == 0)
        {
            if(DOF2_GetInt(pFile(playerid),"HitSound") == 0)return SendClientMessage(playerid,Red,"! ההיט סאונד כבר מכובה אצלך");
            DOF2_SetInt(pFile(playerid),"HitSound",0);
            DOF2_SaveFile();
            HitSound[playerid] = 0;
			SendClientMessage(playerid,Yellow,"! כיבית את ההיט סאונד");
        }
        return 1;
    }
//============================ RCON COMMANDS ===================================
    CMD:killfull(playerid,params[])
    {
        if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
        new choose;
        if(sscanf(params,"n",choose))return SendClientMessage(playerid,Green,"Usage:{ffffff} /KillFull [0/1]");
        if(choose < 0 || choose > 1)return SendClientMessage(playerid,Green,"Usage:{ffffff} /KillFull{ff0000} [0/1]");
        GetPlayerName(playerid,pName,sizeof(pName));
        if(choose == 0)
        {
            if(KillFull == 0)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Red,"! האופציה למילוי חיים ומגן אחרי הריגה כבר מבוטלת");
            KillFull = 0;
            PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
            SendFormatMessageToAll(Yellow,"! ביטל את המילוי מגן וחיים אחרי הריגה %s האדמין",pName);
        }if(choose == 1)
        {
            if(KillFull == 1)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Red,"! האופציה למילוי חיים ומגן אחרי הריגה כבר דלוקה");
            KillFull = 1;
            PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
            SendFormatMessageToAll(Yellow,"! הדליק את המילוי חיים ומגן אחרי הריגה %s האדמין",pName);
        }
        return 1;
    }
//==============================================================================
    CMD:cdedit(playerid,params[])
    {
        if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
        new choose;
        if(sscanf(params,"n",choose))return SendClientMessage(playerid,Green,"Usage:{ffffff} /CdEdit [3-30]");
        if(choose < 3 || choose > 30)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Green,"Usage:{ffffff} /CdEdit {ff0000}[3-30]");
        if(DOF2_GetInt("RconOptions/Settings.ini","MaxCD") == choose)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Red,"! מספר השניות לפקודת הספירה כבר זהה");
        DOF2_SetInt("RconOptions/Settings.ini","MaxCD",choose);
        PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
        GetPlayerName(playerid,pname,sizeof(pname));
        SendFormatMessageToAll(Yellow,"%d שינה את מספר השניות המקסימלי לספירה ל %s האדמין",choose,pname);
        return 1;
    }
//==============================================================================
    CMD:pec(playerid,params[])
    {
        if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
        new choose;
        if(sscanf(params,"n",choose))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Pec [0/1]");
        if(choose < 0 || choose > 1)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Pec {ff0000}[0/1]");
		if(choose == 0 && DOF2_GetInt("RconOptions/Settings.ini","PlayerEnterCar") == 0)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Red,"! האופציה הזו כבר כבויה");
        if(choose == 1 && DOF2_GetInt("RconOptions/Settings.ini","PlayerEnterCar") == 1)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Red,"! האופציה הזו כבר דולקת");
		//if(DOF2_GetInt("RconOptions/Settings.ini","PlayerEnterCar") == choose)return SendClientMessage(playerid,Red,"! ");
        DOF2_SetInt("RconOptions/Settings.ini","PlayerEnterCar",choose);
        PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
		if(choose == 0)return SendFormatMessageToAll(Yellow,"! כיבה את האופציה לשחקנים להכנס לרכב %s האדמין",GetName(playerid));
        if(choose == 1)return SendFormatMessageToAll(Yellow,"! הדליק את האופציה לשחקנים להכנס לרכב %s האדמין",GetName(playerid));
		return 1;
    }
    CMD:setadmin(playerid,params[])
    {
        if(!IsPlayerAdmin(playerid))return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
        new id,level;
        if(sscanf(params,"ui",id,level))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Setadmin [ID] [1-2]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי לא מחובר");
		if(level < 1 || level > 2)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Setadmin [ID] {ff0000}[1-2]");
		if(level == 1 && Admin[id] == 1)return SendClientMessage(playerid,Red,"! השחקן שבחרת כבר אדמין ברמה 1");
		if(level == 2 && Admin[id] == 2)return SendClientMessage(playerid,Red,"! השחקן שבחרת כבר אדמין ברמה 2");
        Admin[id] = level;
        DOF2_SetInt(pFile(id),"Admin",level);
        DOF2_SaveFile();
        format(str,sizeof(str),"! %d העלה אותך לרמת אדמין %s האדמין",level,GetName(playerid));
        SendClientMessage(id,Lightgreen,str);
        format(str,sizeof(str),"! %d לרמת אדמין %s העלת את",level,GetName(id));
        SendClientMessage(playerid,Yellow,str);
        return 1;
    }
//==============================================================================
    CMD:deladmin(playerid,params[])
    {
        if(!IsPlayerAdmin(playerid))return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Deladmin [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי לא מחובר");
        if(Admin[id] == 0)return SendClientMessage(playerid,Red,"! השחקן שבחרת לא אדמין");
        Admin[id] = 0;
        DOF2_SetInt(pFile(id),"Admin",0);
        DOF2_SaveFile();
        format(str,sizeof(str),"! הוריד אותך מרמת אדמין %s האדמין",GetName(playerid));
        SendClientMessage(id,Red,str);
        format(str,sizeof(str),"! מרמת אדמין %s הורדת את",GetName(id));
        SendClientMessage(playerid,Yellow,str);
        return 1;
    }
//==============================================================================
    CMD:fulledit(playerid,params[])
    {
        if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
        new choose;
        if(sscanf(params,"n",choose))return SendClientMessage(playerid,Green,"Usage:{ffffff} /FullEdit [0/1]");
        if(choose < 0 || choose > 1)return SendClientMessage(playerid,Green,"Usage:{ffffff} /FullEdit{ff0000} [0/1]");
        GetPlayerName(playerid,pname,sizeof(pname));
        if(choose == 1)
        {
            if(DOF2_GetInt("RconOptions/Settings.ini","Full") == 1)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Red,"! האופציה למילוי חיים ומגן כבר פועלת");
            DOF2_SetInt("RconOptions/Settings.ini","Full",1);
			//4203 1149
			PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
            SendFormatMessageToAll(Yellow,"! הפעיל את אופציית מילוי החיים והמגן  %s האדמין",pname);
        }
        if(choose == 0)
        {
            if(DOF2_GetInt("RconOptions/Settings.ini","Full") == 0)return PlayerPlaySound(playerid,4203,0.0,0.0,0.0) && SendClientMessage(playerid,Red,"! האופציה למילוי החיים והמגן כבר כבויה");
            DOF2_SetInt("RconOptions/Settings.ini","Full",0);
            PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
			SendFormatMessageToAll(Yellow,"! כיבה את אופציית מילוי החיים והמגן %s האדמין",pname);
        }
        return 1;
    }
//==============================================================================
stock ShowPlayerTitansetpassDialog(playerid)
{
    ShowPlayerDialog(playerid,Dialog_Titansetpass,DIALOG_STYLE_INPUT,"{ffc900}Titan Change Pass - פאנל רקון","{dbdbdb}אנא הכנס סיסמה חדשה למערכת קלאן טייטן","אישור","חזור");
    return 1;
}
stock ShowPlayerRPanelDialog(playerid)
{
    ShowPlayerDialog(playerid, Dialog_RPanel, DIALOG_STYLE_LIST, "{ffc900}Rcon Panel - פאנל לרקון", "{ebe400}Full Edit{dbdbdb} - אופציה למילוי חיים ומגן\n{ebe400}KillFull{dbdbdb} - מילוי חיים ומגן לאחר הריגה\n{ebe400}Pec{dbdbdb} - אופציה לשחקנים להכנס לרכב\n{ebe400}CDEdit{dbdbdb} - שינוי מספר השניות המקסימלי לספירה\n{ebe400}Titan System{dbdbdb} - מערכת קלאן טייטן\n{ebe400}Text Hit{dbdbdb} - הפעל או כבה טקסט פגיעה", "אישור", "ביטול");
    return 1;
}
stock ShowPlayerFulleditDialog(playerid)
{
    ShowPlayerDialog(playerid,Dialog_Fulledit,DIALOG_STYLE_LIST,"{ffc900}Full Edit - פאנל רקון","{00ff00}אפשר\n{ff0000}בטל","אישור","חזור");
	return 1;
}
stock ShowPlayerKillfullDialog(playerid)
{
    ShowPlayerDialog(playerid,Dialog_Killfull,DIALOG_STYLE_LIST,"{ffc900}Killfull - פאנל רקון","{00ff00}אפשר\n{ff0000}בטל","אישור","חזור");
	return 1;
}
stock ShowPlayerPecDialog(playerid)
{
    ShowPlayerDialog(playerid,Dialog_Pec,DIALOG_STYLE_LIST,"{ffc900}Pec - פאנל רקון","{00ff00}אפשר\n{ff0000}בטל","אישור","חזור");
	return 1;
}
stock ShowPlayerCDeditDialog(playerid)
{
    ShowPlayerDialog(playerid,Dialog_Cdedit,DIALOG_STYLE_INPUT,"{ffc900}CDEdit - פאנל רקון","{dbdbdb}אנא הכנס מספר שניות מקסימלי לספירה\n{dbdbdb}מספר השניות חייב להיות בין 3 ל30","אישור","חזור");
	return 1;
}
stock ShowPlayerTitanpanelDialog(playerid)
{
	format(str,sizeof(str),"{ebe400}TitanPass{dbdbdb} - שינוי סיסמה למערכת קלאן טייטן\n{a2a2a2}%s{bdbdbd} :הסיסמה הנוכחית למערכת קלאן טייטן",TitanCode);
	ShowPlayerDialog(playerid,Dialog_Titanpanel,DIALOG_STYLE_LIST,"{ffc900}Titan System - פאנל רקון",str,"אישור","חזור");
	return 1;
}
stock ShowPlayerTexthitDialog(playerid)
{
	ShowPlayerDialog(playerid,Dialog_Texthit,DIALOG_STYLE_LIST,"{ffc900}Text Hit - טקסט פגיעה","{00ff00}אפשר\n{ff0000}בטל","אישור","חזור");
	return 1;
}
	CMD:rpanel(playerid,params[])
	{
	    if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
        //ShowPlayerDialog(playerid, Dialog_RPanel, DIALOG_STYLE_LIST, "{ffff00}Rcon Panel - פאנל לרקון", "Full Edit - אופציה למילוי חיים ומגן\nAutoMessage - הודעת מערכת אוטומטית\nPec - אופציה לשחקנים להכנס לרכב\nCDEdit - שינוי מספר השניות המקסימלי לספירה\nTitan System - מערכת קלאן טייטן", "אישור", "ביטול");
        ShowPlayerRPanelDialog(playerid);
		return 1;
	}
	CMD:teams(playerid)
	{
	    if(Area[playerid] == CW || Area[playerid] == CWVIEW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אין באפשרותך לבצע זאת באמצע");
        if(Area[playerid] == GG || Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"לא ניתן לבצע את הפקודה באיזור שאתה נמצא בו");
		ShowPlayerDialog(playerid, Dialog_Teams, DIALOG_STYLE_LIST, "{ffffff}! בחר את הקבוצה שלך", "{00ebf3}Team A{ffffff}\n{e60000}Team B{ffffff}", "אישור", "ביטול");
    	return 1;
	}
//==============================================================================
    CMD:ban(playerid,params[])
    {
        new id,reason[128];
        if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2)
		{
			SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
		}else if(sscanf(params,"us[128]",id,reason))
		{
        	SendClientMessage(playerid,Green,"Usage:{ffffff} /Ban [ID] [Reason]");
		}else if(playerid == id)
		{
            SendClientMessage(playerid,Red,"! אין אפשרות לתת באן לעצמך");
		}else if(!IsPlayerConnected(id))
		{
			SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
		}else{
			SendFormatMessageToAll(Red,"(%s) :סיבה %s נתן באן לשחקן %s האדמין",reason,GetName(id),GetName(playerid));
        	DOF2_CreateFile(bFile(id));
        	DOF2_SetString(bFile(id),"Reason",reason);
        	SetTimerEx("DelayBan", 150, false, "d", id);
		}
		return 1;
    }
//==============================================================================
	CMD:unban(playerid,params[])
	{
        new bannedname[MAX_PLAYER_NAME + 1];
		if(!IsPlayerAdmin(playerid) && Admin[playerid] < 2) return SendClientMessage(playerid,Red,"! פקודה זו לרקון בלבד");
		if(sscanf(params, "s[24]", bannedname))return SendClientMessage(playerid,Green,"Usage:{ffffff} /UnBan [Name]");
		if(!DOF2_FileExists(ubFile(bannedname))) return SendClientMessage(playerid,Red,"! לשחקן בחרת אין באן קיים");
		DOF2_RemoveFile(ubFile(bannedname));
		SendFormatMessageToAll(Red,"! את הבאן %s הוריד לשחקן %s האדמין",bannedname,GetName(playerid));
		return 1;
	}
//============================ ADMIN COMMANDS ==================================
    CMD:gw(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(Area[playerid] == CW || Area[playerid] == CWVIEW)return SendClientMessage(playerid,Red,"! CW אין באפשרותך לבצע זאת באמצע");
        if(Area[playerid] == GG || Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"לא ניתן לבצע את הפקודה באיזור שאתה נמצא בו");
		new id,weaponid,ammo;
        if(sscanf(params,"udn",id,weaponid,ammo)) return SendClientMessage(playerid,Green,"Usage:{ffffff} /GivePlayerWeapon [playerid] [Weapon ID] [Ammo]");
        if(!IsPlayerConnected(id))SendClientMessage(playerid, 0xFF0000AA, "! האיידי שבחרת לא מחובר");
        GivePlayerWeapon(id,weaponid,ammo);
        GetPlayerName(playerid,pname,sizeof(pname));
        GetPlayerName(id,iname,sizeof(iname));
        SendFormatMessage(id,Skygreen,"! %d עם כמות כדורים %d הביא לך את נשק %s האדמין",ammo,weaponid,pname);
        SendFormatMessage(playerid,Skygreen,"! %d עם כמות כדורים %d את הנשק %s הבאת לשחקן",ammo,weaponid,iname);
        return 1;
    }
//==============================================================================
	CMD:rcars(playerid)
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
    	new vehicleid;
    	for (vehicleid = 1; vehicleid <= MAX_VEHICLES; vehicleid++){if (IsVehicleStreamedIn(vehicleid, playerid)){DestroyVehicle(vehicleid);}}
    	SendFormatMessageToAll(Yellow,"! איפס את כל הרכבים במפה %s האדמין",GetName(playerid));
    	return 1;
	}
	CMD:sendmeto(playerid,params[])
	{
	    if(Admin[playerid] < 1)return 0;
	    new interior,Float:x,Float:y,Float:z;
	    if(sscanf(params,"ifff",interior,x,y,z))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Sendmeto [Interior] [x] [y] [z]");
		SetPlayerInterior(playerid,interior);
		SetPlayerPos(playerid,x,y,z);
		return 1;
	}
//==============================================================================
    CMD:getcar(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(Area[playerid] == CW || Area[playerid] == CWVIEW)return SendClientMessage(playerid,Red,"! CW אין באפשרותך לבצע זאת באמצע");
		if(Area[playerid] == War || Area[playerid] == WH || Area[playerid] == BR)return SendClientMessage(playerid,Red,"! אין באפשרותך לשגר רכב לאיזור הזה");
		new carid,color1,color2;
        if(sscanf(params,"nnn",carid,color1,color2))return SendClientMessage(playerid,Green,"Usage:{ffffff} /GetCar [Car ID] [Color1] [Color2]");
        if(carid < 400 || carid > 611)return SendClientMessage(playerid,Red,"! יש לבחור מספר בין 400 ל611 בלבד");
        new Float:x,Float:y,Float:z,Float:f;
        GetPlayerPos(playerid,x,y,z);
        z += 1.0;
        GetPlayerFacingAngle(playerid,f);
        new vehicle = CreateVehicle(carid,x + 2,y,z,f,color1,color2,60);
        PutPlayerInVehicle(playerid, vehicle, 0);
        return 1;
    }
//==============================================================================
    CMD:cleantable(playerid,params[])
    {
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו רק לאדמינים");
		for(new i;i<5;i++) SendDeathMessage(1000,1000,1000);
		SendFormatMessageToAll(Yellow,"! ניקה את טבלת ההריגות %s האדמין",GetName(playerid));
        return 1;
    }
//==============================================================================
    CMD:fix(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid, Red, "! אתה לא נמצא באף רכב");
		new vehicleid = GetPlayerVehicleID(playerid);
		SetVehicleHealth(vehicleid, 1000);
		RepairVehicle(vehicleid);
		SendClientMessage(playerid,Lightgreen,"! תיקנת את הרכב שלך");
        return 1;
    }
//==============================================================================
	CMD:vgm(playerid)
	{
	    if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
    	if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid, Red, "! אתה לא נמצא באף רכב");
    	new vehicleid = GetPlayerVehicleID(playerid);
    	if(VehicleGodMode[playerid] == 0)
    	{
        	VehicleGodMode[playerid] = 1;
     		SendClientMessage(playerid,Lightblue, "! הפעלת גוד מוד לרכב");
    		RepairVehicle(vehicleid);
			SetVehicleHealth(vehicleid,1000);
    	}
    	else
    	{
        	VehicleGodMode[playerid] = 0;
        	SendClientMessage(playerid,Lightblue, "! כיבית גוד מוד לרכב");
    	}
    	return 1;
	}
//==============================================================================
    CMD:flip(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendClientMessage(playerid,Red,"! ??? ???? ????? ???? ???");
        new Float:angle;
        GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
        SetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
        SendClientMessage(playerid,Lightgreen,"! הפכת את הרכב שלך");
        return 1;
    }
//==============================================================================
    CMD:delcar(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendClientMessage(playerid,Red,"! אתה לא נמצא ברכב");
        DestroyVehicle(GetPlayerVehicleID(playerid));
        SendClientMessage(playerid,Lightgreen,"! מחקת את הרכב שלך");
        return 1;
    }
//==============================================================================
    CMD:givemoney(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id,money;
        if(sscanf(params,"un",id,money))return SendClientMessage(playerid,Green,"Usage:{ffffff} /GiveMoney [ID] [Money]");
        GivePlayerMoney(id,money);
        GetPlayerName(id,iname,sizeof(iname));
        GetPlayerName(playerid,pname,sizeof(pname));
        SendFormatMessage(playerid,Aqua,"! [$%d] כסף בסכום %s הבאת לשחקן",money,iname);
        SendFormatMessage(id,AquaGreen,"! [$%d] העביר לך סכום כסף %s האדמין",money,pname);
        return 1;
    }
forward SendPMToAdmins(playerid, const targetname[], const message[]);
public SendPMToAdmins(playerid, const targetname[], const message[])
{
	for(new i = 0; i < Maxp; i++) // לולאה שעוברת על כל השחקנים
	{
		if(IsPlayerConnected(i) && Admin[i] > 0 && AdminCanSeePM[i] == 1 && i != playerid) // רק לאדמינים עם מעקב PM פעיל
		{
			new sendername[MAX_PLAYER_NAME], logmessage[256];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(logmessage, sizeof(logmessage), "{FFC600}[RPM]{bdbdbd} %s{9e9e9e} > {bdbdbd}%s{9e9e9e}: %s", sendername, targetname, message);
			SendClientMessage(i, -1, logmessage); // שולח את ההודעה לאדמינים
		}
	}
}
	CMD:rpm(playerid, params[])
	{
    	if(Admin[playerid] < 1)return SendClientMessage(playerid, Red, "! פקודה זו רק לאדמינים");
    	if(AdminCanSeePM[playerid] == 0)
    	{
        	AdminCanSeePM[playerid] = 1;
        	SendClientMessage(playerid, Gold, "! ReadPM - הפעלת את מערכת ה");
    	}else{
        	AdminCanSeePM[playerid] = 0;
        	SendClientMessage(playerid, Gold, "! ReadPM - כיבית את מערכת ה");
    	}
    	return 1;
	}
	CMD:rcm(playerid, params[])
	{
    	if(Admin[playerid] < 1)return SendClientMessage(playerid, Red, "! פקודה זו רק לאדמינים");
    	if(AdminCanSeeCMD[playerid] == 0)
    	{
        	AdminCanSeeCMD[playerid] = 1;
        	SendClientMessage(playerid, Gold, "{5fea5f}! ReadCMD - הפעלת את מערכת ה");
    	}else{
        	AdminCanSeeCMD[playerid] = 0;
        	SendClientMessage(playerid, Gold, "{5fea5f}! ReadCMD - כיבית את מערכת ה");
    	}
    	return 1;
	}
//==============================================================================
    CMD:say(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new msg[128];
        if(sscanf(params,"s[128]",msg))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Say [Message]");
        SendFormatMessageToAll(Lightgreen,"** Admin %s: %s",GetName(playerid),msg);
        return 1;
    }
//==============================================================================
    CMD:akill(playerid,params[])
    {
        new id;
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /AKill [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        //if(id == playerid)return SendClientMessage(playerid,Red,"! לא ניתן להשתמש בפקודה הזו על עצמך");
		SendFormatMessage(playerid,Yellow,"! %s הרגת את",GetName(id));
		SetPlayerHealth(id,0);
        return 1;
    }
//==============================================================================
    CMD:get(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Get [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        SendFormatMessage(id,Aqua,"! שיגר אותך אליו %s האדמין",GetName(playerid));
        SendFormatMessage(playerid,AquaGreen,"! אליך %s שיגרת את השחקן",GetName(id));
        SetPlayerInterior(id,GetPlayerInterior(playerid));
        SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid));
		new Float:x,Float:y,Float:z;
        GetPlayerPos(playerid,x,y,z);
        SetPlayerPos(id,x,y,z);
        return 1;
    }
//==============================================================================
    CMD:goto(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Goto [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        SendFormatMessage(id,Aqua,"! השתגר אליך %s האדמין",GetName(playerid));
        SendFormatMessage(playerid,AquaGreen,"! %s השתגרת אל השחקן",GetName(id));
        new Float:x,Float:y,Float:z;
        GetPlayerPos(id,x,y,z);
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)return SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
        SetPlayerPos(playerid,x,y,z);
        SetPlayerInterior(playerid,GetPlayerInterior(id));
        SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
        return 1;
    }
//==============================================================================
    CMD:spec(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Spec [ID]");
        if(id == playerid)return SendClientMessage(playerid,Red,"! לא ניתן לבצע את הפקודה הזו על עצמך");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        TogglePlayerSpectating(playerid,1);
        PlayerSpectatePlayer(playerid,id);
        SendClientMessage(playerid,Gray,"---------------------------------------------");
        SendFormatMessage(playerid,Yellow,"%s נכנסת למצב צפייה בשחקן",GetName(id));
        SendClientMessage(playerid,Yellow,"/UnSpec - על מנת לצאת ממצב צפייה השתמש בפקודה");
        SendClientMessage(playerid,Gray,"---------------------------------------------");
        InSpec[playerid] = 1;
        return 1;
    }
//==============================================================================
    CMD:unspec(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(InSpec[playerid] == 0)return SendClientMessage(playerid,Red,"! אתה לא במצב צפייה");
        TogglePlayerSpectating(playerid,0);
        SendClientMessage(playerid,Gray,"! יצאת ממצב צפייה");
        InSpec[playerid] = 0;
        return 1;
    }
//==============================================================================
//SetPlayerPos(playerid,1137.2332,1335.9259,10.8203) && SetPlayerFacingAngle(playerid,179.2149);//A
//SetPlayerPos(playerid,1137.2517,1235.1417,10.8203) && SetPlayerFacingAngle(playerid,359.0700);//B
	CMD:spawn(playerid,params[])
	{
	    if(Area[playerid] == CW || Area[playerid] == CWVIEW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אי אפשר לבצע את הפקודה הזאת במהלך");
		SendClientMessage(playerid,Yellow,"! השתגרת לספאון");
		if(Area[playerid] == Light)
		{
	    	if(IsPlayerInAnyVehicle(playerid))
	    	{
    			new vehicleid = GetPlayerVehicleID(playerid);
				if(Team[playerid] == A)
				{
  					SetVehiclePos(vehicleid, 1137.2332,1335.9259,10.8203);
    				SetPlayerPos(playerid,1137.2332,1335.9259,10.8203);
					PutPlayerInVehicle(playerid, vehicleid, 0);
					SetVehicleZAngle(vehicleid, 179.2149);
				}else{
					SetVehiclePos(vehicleid, 1137.2517,1235.1417,10.8203);
    				SetPlayerPos(playerid,1137.2517,1235.1417,10.8203);
					PutPlayerInVehicle(playerid, vehicleid, 0);
					SetVehicleZAngle(vehicleid, 359.0700);
				}
	    	}else{
				if(Team[playerid] == A)return SpawnPlayerToA(playerid);
				if(Team[playerid] == B)return SpawnPlayerToB(playerid);
			}
		}else if(Area[playerid] == AP)
		{
		    if(IsPlayerInAnyVehicle(playerid))
		    {
		        new vehicleid = GetPlayerVehicleID(playerid);
				if(Team[playerid] == A)
				{
				//A SPAWN
					SetVehiclePos(vehicleid, 1320.6469,1375.3042,10.8203);
    				SetPlayerPos(playerid,1320.6469,1375.3042,10.8203);
					PutPlayerInVehicle(playerid, vehicleid, 0);
					SetVehicleZAngle(vehicleid, 179.3954);
				}else{
				//B SPAWN
					SetVehiclePos(vehicleid, 1320.3190,1309.4552,10.8203);
    				SetPlayerPos(playerid,1320.3190,1309.4552,10.8203);
					PutPlayerInVehicle(playerid, vehicleid, 0);
					SetVehicleZAngle(vehicleid, 357.7778);
				}
		    }else{
				if(Team[playerid] == A)return SetPlayerPos(playerid,1320.6469,1375.3042,10.8203) && SetPlayerFacingAngle(playerid,179.3954);
                if(Team[playerid] == B)return SetPlayerPos(playerid,1320.3190,1309.4552,10.8203) && SetPlayerFacingAngle(playerid,357.7778);
			}
		}else if(Area[playerid] == WH)
		{
			if(Team[playerid] == A)return SetPlayerPos(playerid,1411.8306,-19.3712,1000.9240) && SetPlayerFacingAngle(playerid,90.8042);
   			if(Team[playerid] == B)return SetPlayerPos(playerid,1365.4437,-20.2236,1000.9219) && SetPlayerFacingAngle(playerid,269.0927);
		}else if(Area[playerid] == BR)
		{
  			//-1458.1985,995.3450,1024.8131,269.8115 a
  			//-1398.2206,994.9816,1024.0901,88.3741 b
			if(Team[playerid] == A)return SetPlayerPos(playerid,-1458.1985,995.3450,1024.8131) && SetPlayerFacingAngle(playerid,269.8115);
			if(Team[playerid] == B)return SetPlayerPos(playerid,-1398.2206,994.9816,1024.0901) && SetPlayerFacingAngle(playerid,88.3741);
		}
		else{
			SpawnPlayer(playerid);
		}
		return 1;
	}
//==============================================================================
	CMD:ltc(playerid,params[])
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(Area[playerid] == War || Area[playerid] == WH || Area[playerid] == BR || Area[playerid] == CW || Area[playerid] == CWVIEW)return SendClientMessage(playerid,Red,"! אין באפשרותך לשגר רכב לאיזור הזה");
		new Float:x,Float:y,Float:z,Float:f;
        GetPlayerPos(playerid,x,y,z);
        z += 1.0;
        GetPlayerFacingAngle(playerid,f);
        new vehicle = CreateVehicle(560,x + 2,y,z,f,15,15,60);
        PutPlayerInVehicle(playerid, vehicle, 0);
        ChangeVehiclePaintjob(vehicle, 0); //paintjob 1
		AddVehicleComponent(vehicle, 1010); //10x nitro
        AddVehicleComponent(vehicle, 1087); //hydraulic
        AddVehicleComponent(vehicle, 1029); //X FLOW Exahust
        AddVehicleComponent(vehicle, 1169); //Alien front bumper
        AddVehicleComponent(vehicle, 1141); //Alien rear bumper
        AddVehicleComponent(vehicle, 1032); //alien roof vent
        AddVehicleComponent(vehicle, 1138); //alien spoiler
        AddVehicleComponent(vehicle, 1026); //alien side skrits
        AddVehicleComponent(vehicle, 1027); //alien side skrits
        AddVehicleComponent(vehicle, 1080); //switch wheels
        SendClientMessage(playerid,Gold,"{fff300}! {ffbd00}LTC{fff300} שיגרת אליך את הרכב המיוחד");
	    return 1;
	}
	CMD:ltc2(playerid,params[])
	{
		if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(Area[playerid] == War || Area[playerid] == WH || Area[playerid] == BR || Area[playerid] == CW || Area[playerid] == CWVIEW)return SendClientMessage(playerid,Red,"! אין באפשרותך לשגר רכב לאיזור הזה");
		new Float:x,Float:y,Float:z,Float:f;
        GetPlayerPos(playerid,x,y,z);
        z += 1.0;
        GetPlayerFacingAngle(playerid,f);
        new vehicle = CreateVehicle(560,x + 2,y,z,f,15,15,60);
        PutPlayerInVehicle(playerid, vehicle, 0);
        ChangeVehiclePaintjob(vehicle, 2); //paintjob 1
		AddVehicleComponent(vehicle, 1010); //10x nitro
        AddVehicleComponent(vehicle, 1087); //hydraulic
        AddVehicleComponent(vehicle, 1029); //X FLOW Exahust
        AddVehicleComponent(vehicle, 1169); //Alien front bumper
        AddVehicleComponent(vehicle, 1141); //Alien rear bumper
        AddVehicleComponent(vehicle, 1032); //alien roof vent
        AddVehicleComponent(vehicle, 1138); //alien spoiler
        AddVehicleComponent(vehicle, 1026); //alien side skrits
        AddVehicleComponent(vehicle, 1027); //alien side skrits
        AddVehicleComponent(vehicle, 1080); //switch wheels
        SendClientMessage(playerid,Gold,"{fff300}! {ffbd00}LTC2{fff300} שיגרת אליך את הרכב המיוחד");
	    return 1;
	}
//==============================================================================
    CMD:respawn(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{Ffffff} /Respawn [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        cmd_spawn(id,"/spawn");
        format(str,sizeof(str),"! ביצע עבורך ריספאון %s האדמין",GetName(playerid));
        SendClientMessage(id,Skygreen,str);
        format(str,sizeof(str),"! ריספאון %s ביצעת עבור השחקן",GetName(id));
        SendClientMessage(playerid,Skygreen,str);
        return 1;
    }
//==============================================================================
    CMD:mute(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id,msg[128];
        if(sscanf(params,"us[128]",id,msg))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Mute [ID] [Reason]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        if(Mute[id] == 1)return SendClientMessage(playerid,Red,"! השחקן שבחרת נמצא כבר במיוט");
        Mute[id] = 1;
        SendFormatMessageToAll(Yellow,"! (Reason: {b8b8b8}%s{ffff00}) %s השתיק את %s האדמין",msg,GetName(id),GetName(playerid));
        return 1;
    }
//==============================================================================
    CMD:unmute(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /UnMute [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        if(Mute[id] == 0)return SendClientMessage(playerid,Red,"! השחקן שבחרת לא נמצא במיוט");
        Mute[id] = 0;
        SendFormatMessageToAll(Yellow,"! %s הוריד את המיוט לשחקן %s האדמין",GetName(id),GetName(playerid));
        return 1;
    }
//==============================================================================
    CMD:freeze(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Freeze [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        if(Freeze[id] == 1)return SendClientMessage(playerid,Red,"! השחקן שבחרת כבר נמצא בפריז");
        TogglePlayerControllable(id,0);
        Freeze[id] = 1;
        SendFormatMessageToAll(AquaGreen,"! %s שם פריז לשחקן %s האדמין",GetName(id),GetName(playerid));
        return 1;
    }
//==============================================================================
    CMD:unfreeze(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /UnFreeze [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        if(Freeze[id] == 0)return SendClientMessage(playerid,Red,"! השחקן שבחרת לא נמצא בפריז");
        TogglePlayerControllable(id,1);
        Freeze[id] = 0;
        SendFormatMessageToAll(AquaGreen,"! %s הוריד את הפריז לשחקן %s האדמין",GetName(id),GetName(playerid));
        return 1;
    }
//==============================================================================
    CMD:disarm(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Disarm [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        ResetPlayerWeapons(id);
        GetPlayerName(playerid,pname,sizeof(pname));
        GetPlayerName(id,iname,sizeof(iname));
        SendFormatMessage(playerid,Aqua,"! את כל הנשקים %s איפסת לשחקן",iname);
        SendFormatMessage(id,Aqua,"! איפס לך את כל הנשקים %s האדמין",pname);
        return 1;
    }
//==============================================================================
    CMD:fullall(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		SetPlayerHealthAll(100);
        SetPlayerArmourAll(100);
        GetPlayerName(playerid,pname,sizeof(pname));
        SendFormatMessageToAll(AquaGreen,"! מילא חיים ומגן לכולם %s האדמין",pname);
        return 1;
    }
//==============================================================================
    CMD:disarmall(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        for(new i; i < Maxp -1; i ++)return ResetPlayerWeapons(i);
        GetPlayerName(playerid,pname,sizeof(pname));
        SendFormatMessageToAll(Yellow,"! איפס נשקים לכולם %s האדמין",pname);
        return 1;
    }
//==============================================================================
    CMD:drop(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id,number;
        if(sscanf(params,"un",id,number))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Drop [ID] [1-1000]");
        if(number < 1 || number > 1000)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Drop [ID]{ff0000} [1-1000]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        if(IsPlayerAdmin(id))return SendClientMessage(playerid,Red,"לא ניתן לבצע פקודה וז על שחקן שמחובר לרקון");
		new Float:x,Float:y,Float:z;
        GetPlayerPos(id,x,y,z) && SetPlayerPos(id,x,y,z + number);
        SendFormatMessage(playerid,Lightgreen,"! %d לאוויר בגובה %s זרקת את השחקן",number,GetName(id));
        SendFormatMessage(id,Aqua,"! %s נזרקת לאוויר על ידי האדמין",GetName(playerid));
        return 1;
    }
//==============================================================================
    CMD:kick(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Kick [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
		if(IsPlayerAdmin(id))return SendClientMessage(playerid,Red,"לא ניתן לבצע פקודה וז על שחקן שמחובר לרקון");
		SendFormatMessageToAll(Red,"! מהשרת %s בעט את השחקן %s האדמין",GetName(id),GetName(playerid));
        //Kick(id);
        SetTimerEx("DelayBan", 150, false, "d", id);
        return 1;
    }
//==============================================================================
    CMD:tmp(playerid,params[])
    {
        new id;
        new kills = TotalKills[playerid];
        new deaths = TotalDeaths[playerid];
        if(sscanf(params, "u",id))return SendFormatMessage(playerid,Yellow,"{e4da67}Total Kills: {bdbdbd}%d{e4da67} || Total Deaths: {bdbdbd}%d{e4da67}",kills,deaths);
		if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! השחקן שבחרת לא מחובר");
		new idkills = TotalKills[id];
		new iddeaths = TotalDeaths[id];
		SendFormatMessage(playerid,Yellow,"{e4da67}'%s' Total Kills: {bdbdbd}%d{e4da67} || Total Deaths: {bdbdbd}%d{e4da67}",GetName(id),idkills,iddeaths);
        return 1;
    }
//==============================================================================
    CMD:changenick(playerid,params[])
    {
        new newname[24];
        if(sscanf(params,"s[24]",newname))return SendClientMessage(playerid,Green,"Usage:{ffffff} /ChangeNick [Nickname]");
    	if(strlen(newname) < 3)return SendClientMessage(playerid, Red, "! הניק שבחרת קצר מידי, המינימום הוא 3 תווים");
		for(new i = 0; i < strlen(newname); i++)
		{
			if( newname[i] == '!' || newname[i] == '@' || newname[i] == '#' || newname[i] == '$' ||
			newname[i] == '%' || newname[i] == '^' || newname[i] == '&' || newname[i] == '*' || newname[i] == '+' || newname[i] == '=' ||
			newname[i] == '{' || newname[i] == '}' || newname[i] == '\\' || newname[i] == '|' || newname[i] == ':' || newname[i] == ';' ||
			newname[i] == '"' || newname[i] == '\'' || newname[i] == '<' || newname[i] == '>' ||
			newname[i] == ',' || newname[i] == '?' || newname[i] == '/' || newname[i] == '`' || newname[i] == '~')
			{
				SendClientMessage(playerid, Red, "! הניק שבחרת מכיל תווים אסורים");
				return 1;
			}
		}
		for(new a; a < Maxp; a++)
		{
		    if(IsPlayerConnected(a) && Admin[a] == 1 || IsPlayerAdmin(a))
		    {
		        //SendFormatMessage(a,Yellow,"{009eff}[ChangeNick]{c6c6c6} %s{b3b3b3} changed his nick to {c6c6c6}%s",GetName(playerid),newname);
		        SendFormatMessage(a,Yellow,"{009eff}[Change Nick] {a5bdd7}%s{b3b3b3} שינה את הניק שלו ל {a5bdd7}%s{b3b3b3} השחקן",newname,GetName(playerid));
		    }
		}
		SetPlayerName(playerid, newname);
		format(str,sizeof(str),"%s",GetName(playerid));
		TextDrawSetString(Text:nametext[playerid],str);
		SendFormatMessage(playerid,Yellow,"! %s שינית את הניק שלך ל",newname);
		SendClientMessage(playerid,Yellow,"שים לב שהשינוי זמני עד יציאתך מהשרת");
  		return 1;
    }
//==============================================================================
    CMD:fps(playerid,params[])
    {
		new id;
		if(sscanf(params,"u",id))return SendFormatMessage(playerid,Yellow,"Your FPS: %d",GetPlayerFPS(playerid));
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! השחקן לא מחובר");
		SendFormatMessage(playerid,Yellow,"%s FPS: %d",GetName(id),GetPlayerFPS(id));
		return 1;
    }
	CMD:fp(playerid,params[])return cmd_fullpower(playerid,params);
	CMD:fullpower(playerid, params[])
	{
	    if(Area[playerid] == CW || Area[playerid] == CWVIEW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אין לבצע פקודה זאת באמצע");
	    GetPlayerPos(playerid, playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]);
	    SpawnPlayer(playerid);
	    SetTimerEx("ReturnToSavedPosition", 75, false, "i", playerid);
	    SendClientMessage(playerid,Lightgreen,"! מילאת את מאגרי האנרגיה שלך");
	    PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	    return 1;
	}
forward ReturnToSavedPosition(playerid);
public ReturnToSavedPosition(playerid)
{
    SetPlayerPos(playerid, playerPos[playerid][0], playerPos[playerid][1], playerPos[playerid][2]);
    return 1;
}
    CMD:posme(playerid,params[])
    {
		if(!IsPlayerAdmin(playerid))return 0;
		new nx,ny,nz;
		if(sscanf(params,"iii",nx,ny,nz))return SendClientMessage(playerid,Red,"/Posme [N] [N] [N]");
        SendClientMessage(playerid,Lightgreen,"מיקמת את עצמך בהצלחה");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid ,x,y,z);
		SetPlayerPos(playerid ,x+nx,y+ny,z+nz);
        return 1;
    }
//==============================================================================
	CMD:anim(playerid,params[])
	{
	    if(Admin[playerid] < 2)return 0;
		new lib[20],anim[20];
		if(sscanf(params,"s[20]s[20]",lib,anim))return SendClientMessage(playerid,-1,"/anim [lib] [anim]");
		ShowPlayerAnimTextDraw(playerid),InAnimation[playerid] = true;
		ApplyAnimation(playerid,lib,anim,4,1,1,1,1,0);
		return 1;
	}
	CMD:animlist(playerid,params[])
	{
	    SendClientMessage(playerid,Gray,"========== [Animations] ==========");
	    SendClientMessage(playerid,Aqua,"/Dance - לרקוד");
	    SendClientMessage(playerid,Aqua,"/Handsup - להרים ידיים");
	    SendClientMessage(playerid,Aqua,"/Crack - לשכב כמו נרקומן");
	    SendClientMessage(playerid,Aqua,"בקרוב עוד");
	    SendClientMessage(playerid,Gray,"========== [Animations] ==========");
	    return 1;
	}
	CMD:crack(playerid,params[])
	{
	    ShowPlayerAnimTextDraw(playerid),InAnimation[playerid] = true;
	    ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 1, 1, 1, 0);
	    return 1;
	}
	CMD:dance(playerid,params[])
	{
		new num;
		if(sscanf(params,"i",num))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Dance [1-4]");
		if(num < 1 || num > 4)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Dance {ff0000}[1-4]");
        ShowPlayerAnimTextDraw(playerid),InAnimation[playerid] = true;
		if(num == 1)SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		if(num == 2)SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		if(num == 3)SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		if(num == 4)ApplyAnimation(playerid,"GFUNK","Dance_B1",1.27,1,1,1,1,0);
		return 1;
	}
	CMD:handsup(playerid,params[])
	{
        ShowPlayerAnimTextDraw(playerid);
		InAnimation[playerid] = true;
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
		return 1;
	}
//==============================================================================
	CMD:time(playerid,params[])
	{
	    new hour,minutes = 0;
		if(sscanf(params,"ii",hour,minutes))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Time [0-23] [0-59]");
		if(hour < 0 || hour > 23 || minutes < 0 || minutes > 59)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Time {ff0000}[0-23] [0-59]");
		SetPlayerTime(playerid,hour,minutes);
		ghour[playerid] = hour;
		gminutes[playerid] = minutes;
  		SendFormatMessage(playerid,Gray,"! %02d:%02d שינית את השעה במשחק שלך ל",hour,minutes);
		return 1;
	}
	CMD:weather(playerid,params[])
	{
	    new weather;
	    if(sscanf(params,"i",weather))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Weather [0-20]");
	    if(weather < 0 || weather > 20)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Weather {ff0000}[0-20]");
		SetPlayerWeather(playerid,weather);
		SendFormatMessage(playerid,Gray,"! %d שינית את מזג האוויר במשחק שלך למספר",weather);
		return 1;
	}
 	CMD:amram(playerid,params[])
	{
	    if(InCWTeam[playerid] == TGreen || InCWTeam[playerid] == TOrange)return SendClientMessage(playerid,Red,"! לא ניתן להכנס למצב עמרם כשאתה נמצא בתוך קבוצת קלאן וואר");
        if(Area[playerid] == GG || Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"לא ניתן לבצע את הפקודה באיזור שאתה נמצא בו");
		if(AmramMode[playerid] == false)
	    {
			AmramMode[playerid] = true;
			SendFormatMessageToAll(Lightgreen,"{b0f217}[Amram Mode]{cacaca} נכנס למצב עמרם {b0f217}%s{cacaca} השחקן",GetName(playerid));
            PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid,5,1);
            PreSkin[playerid] = GetPlayerSkin(playerid);
			SetPlayerSkin(playerid,267);
			TogglePlayerControllable(playerid,1);
			format(PreTag[playerid],25,"%s",DOF2_GetString(pFile(playerid),"Tag"));
			Tag[playerid] = "{b0f217}עמרם{ffffff}";
	    }else{
    		SendFormatMessageToAll(Lightgreen,"{b0f217}[Amram Mode]{cacaca} יצא ממצב עמרם {ee4635}%s{cacaca} השחקן",GetName(playerid));
         	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	        AmramMode[playerid] = false;
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid,22,9000);
            GivePlayerWeapon(playerid,28,9000);
            GivePlayerWeapon(playerid,26,9000);
            SetPlayerSkin(playerid,PreSkin[playerid]);
            TogglePlayerControllable(playerid,1);
            format(Tag[playerid],25,"%s",PreTag[playerid]);
		}
	    return 1;
	}
    CMD:jetp(playerid,params[])
    {
    	if(Area[playerid] == CW || Area[playerid] == CWVIEW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אי אפשר לבצע את הפקודה הזאת במהלך");
        if(Area[playerid] == GG || Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"לא ניתן לבצע את הפקודה באיזור שאתה נמצא בו");
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        SendClientMessage(playerid,Yellow,"! קיבלת ג'ט פק");
        return 1;
    }
    CMD:jetpack(playerid,params[])return cmd_jetp(playerid,params);
    CMD:jet(playerid,params[])return cmd_jetp(playerid,params);
//==============================================================================
/*
	I Love Radio       https://ilm-stream11.radiohost.de/ilm_iloveradio_mp3-192
	Biggest Pop Hits       https://ilm.stream35.radiohost.de/ilm_ilovenewpop_mp3-192
	Music & Chill       https://ilm-stream11.radiohost.de/ilm_ilovemusicandchill_mp3-192
	Rock Radio       https://ilm-stream12.radiohost.de/ilm_iloveradiorock_mp3-192
	Hip Hop       https://ilm-stream12.radiohost.de/ilm_ilovehiphop_mp3-192
	Tomorrowland       https://ilm.stream35.radiohost.de/ilm_ilovethesun_mp3-192
	2000 + Throwbacks       https://ilm-stream11.radiohost.de/ilm_ilove2000throwbacks_mp3-192
	נושמים מזרחית       https://mzr.mediacast.co.il/mzradio

*/

/*
	{e8e81e}1#){c4c4c4} I Love Radio\n{e8e81e}2#){c4c4c4} Biggest Pop Hits\n{e8e81e}3#){c4c4c4} Music & Chill\n{e8e81e}4#){c4c4c4} Rock Radio\n{e8e81e}5#){c4c4c4} Hip Hop\n{e8e81e}6#){c4c4c4} Tomorrowland\n{e8e81e}7#){c4c4c4} 2000 Throwbacks\n{e8e81e}8#){c4c4c4} נושמים מזרחית
*/
//==============================================================================
	CMD:radio(playerid,params[])
	{
	    ShowPlayerDialog(playerid,Dialog_Radio,DIALOG_STYLE_LIST,"{e8c91e}Radio Stations - תחנות רדיו","{e8e81e}1#){c4c4c4} I Love Radio\n{e8e81e}2#){c4c4c4} Biggest Pop Hits\n{e8e81e}3#){c4c4c4} Music & Chill\n{e8e81e}4#){c4c4c4} Rock Radio\n{e8e81e}5#){c4c4c4} Hip Hop\n{e8e81e}6#){c4c4c4} Tomorrowland\n{e8e81e}7#){c4c4c4} 2000 Throwbacks\n{e8e81e}8#){c4c4c4} נושמים מזרחית","האזן","ביטול");
	    return 1;
	}
	CMD:music(playerid,params[])return cmd_radio(playerid,params);
	CMD:saudio(playerid,params[])
	{
		StopAudioStreamForPlayer(playerid);
	    return 1;
	}
	CMD:moff(playerid,params[])return cmd_saudio(playerid,params);
//==============================================================================
    CMD:givejet(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /GiveJet [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        GetPlayerName(playerid,pname,sizeof(pname));
        GetPlayerName(id,iname,sizeof(iname));
        SendFormatMessage(playerid,AquaGreen,"! ג'ט פק %s הבאת לשחקן",iname);
        SendFormatMessage(id,Aqua,"! הביא לך ג'ט פק %s האדמין",pname);
        SetPlayerSpecialAction(id,SPECIAL_ACTION_USEJETPACK);
        return 1;
    }
//==============================================================================
	CMD:bomb(playerid,params[])
	{
	    if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		new id;
		if(sscanf(params,"i",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Bomb [ID]");
		if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(id,x,y,z);
		CreateExplosion(x,y,z,11,1);
		SendFormatMessage(playerid,Yellow,".את הפנים %s פיצצת לשחקן",GetName(id));
		SendFormatMessage(id,Yellow,".פיצץ לך תפנים %s האדמין",GetName(playerid));
		return 1;
	}
//==============================================================================
    CMD:settag(playerid,params[])
    {
        if(!IsPlayerAdmin(playerid) && Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		new id,tag[25];
		if(sscanf(params,"ns[25]",id,tag))return SendClientMessage(playerid,Green,"Usage:{ffffff} /SetTag [ID] [Tag]");
		if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! השחקן שבחרת אינו מחובר");
		if(id != playerid && IsPlayerAdmin(id))return SendClientMessage(playerid,Red,"! לא ניתן לבצע פקודה זו על שחקן שמחובר לרקון");
		if(strlen(tag) < 3 || strlen(tag) > 25)return SendClientMessage(playerid,Red,"אורך התאג חייב להיות בין 3 ל25 תווים בלבד");
		DOF2_SetString(pFile(id),"Tag",tag);
		format(Tag[id], 25,"%s",DOF2_GetString(pFile(id),"Tag"));
		format(PreTag[id], 25,"%s",tag);
		DOF2_SaveFile();
		SendFormatMessage(playerid,Yellow,"{47e1a0}%s{b5e147} את התאג {47e1a0}%s{b5e147} שמת לשחקן",tag,GetName(id));
		SendFormatMessage(id,Yellow,"{b5e147}! {47e1a0}%s{b5e147} שם עבורך את התאג {47e1a0}%s{b5e147} האדמין",tag,GetName(playerid));
		return 1;
    }
    CMD:mytag(playerid,params[])
    {
    	if(!IsPlayerAdmin(playerid) && Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		new tag[25];
		if(sscanf(params,"s[25]",tag))return SendClientMessage(playerid,Green,"Usage:{ffffff} /MyTag [Tag]");
		if(strlen(tag) < 3 || strlen(tag) > 25)return SendClientMessage(playerid,Red,"אורך התאג חייב להיות בין 3 ל25 תווים בלבד");
		DOF2_SetString(pFile(playerid),"Tag",tag);
		format(Tag[playerid], 25,"%s",DOF2_GetString(pFile(playerid),"Tag"));
		format(PreTag[playerid], 25,"%s",tag);
		DOF2_SaveFile();
		SendFormatMessage(playerid,Yellow,"{b5e147}! {47e1a0}%s{b5e147} התאג האישי שלך שונה ל",tag);
		return 1;
    }
    CMD:deltag(playerid,params[])
    {
		if(!IsPlayerAdmin(playerid) && Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		new id;
		if(sscanf(params,"n",id))
		{
		    if(strlen(Tag[playerid]) < 3)return SendClientMessage(playerid,Red,"אין לך תאג אישי");
		    DOF2_SetString(pFile(playerid),"Tag","x");
		    format(Tag[playerid], 25,"%s",DOF2_GetString(pFile(playerid),"Tag"));
		    DOF2_SaveFile();
		    format(PreTag[playerid], 25,"%s",DOF2_GetString(pFile(playerid),"Tag"));
		    SendClientMessage(playerid,Yellow,"! מחקת את התאג האישי שלך");
		}else{
			if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! השחקן שבחרת אינו מחובר");
            if(id != playerid && IsPlayerAdmin(id))return SendClientMessage(playerid,Red,"! לא ניתן לבצע פקודה זו על שחקן שמחובר לרקון");
			if(strlen(Tag[id]) < 3)return SendClientMessage(playerid,Red,"! לשחקן שבחרת אין תאג אישי");
		    DOF2_SetString(pFile(id),"Tag","x");
      		format(Tag[id], 25,"%s",DOF2_GetString(pFile(id),"Tag"));
		    DOF2_SaveFile();
		    format(PreTag[id], 25,"%s",DOF2_GetString(pFile(id),"Tag"));
		    SendFormatMessage(id,Yellow,"מחק את התאג האישי שלך %s האדמין",GetName(playerid));
			SendFormatMessage(playerid,Yellow,"%s מחקת את התאג האישי של",GetName(id));
		}
		return 1;
    }
//==============================================================================
    CMD:slap(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Slap [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        new Float:Health;
        GetPlayerHealth(id,Health);
        SetPlayerHealth(id,Health - 20);
        GetPlayerName(playerid,pname,sizeof(pname));
        GetPlayerName(id,iname,sizeof(iname));
        SendFormatMessage(id,Aqua,"! הוריד לך סטירה %s האדמין",pname);
        SendFormatMessage(playerid,AquaGreen,"! סטירה %s נתת ל",iname);
        PlayerPlaySound(id, 1190, 0.0, 0.0, 0.0) && PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
        return 1;
    }
//==============================================================================
    CMD:setskin(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        new id,skin;
        if(sscanf(params,"un",id,skin))return SendClientMessage(playerid,Green,"Usage:{ffffff} /SetSkin [ID] [Skin]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        SetPlayerSkin(id,skin);
        GetPlayerName(playerid,pname,sizeof(pname));
        GetPlayerName(id,iname,sizeof(iname));
        SendFormatMessage(playerid,Aqua,"! %d את הסקין למספר %s שינית לשחקן",skin,iname);
        SendFormatMessage(id,AquaGreen,"! %d שינה לך את הסקין למספר %s האדמין",skin,pname);
        return 1;
    }
//==============================================================================
    CMD:cc(playerid,prams[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        for(new x; x < 100; x ++){SendClientMessageToAll(White," ");}
        GetPlayerName(playerid,pname,sizeof(pname));
        SendFormatMessageToAll(Aqua,"{00ffff}! ניקה את הצ'אט {ffffff}%s{00ffff} האדמין",pname);
        return 1;
    }
//==============================================================================
    CMD:chat(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        GetPlayerName(playerid,pname,sizeof(pname));
        if(ChatLock == 1){
			SendFormatMessageToAll(Lightblue,"{00DADE}! פתח את הצ'אט {ffffff}%s{00DADE} האדמין",pname),ChatLock = 0;
		}else{
			SendFormatMessageToAll(Lightblue,"{00DADE}! נעל את הצ'אט {ffffff}%s{00DADE} האדמין",pname),ChatLock = 1;
		}
        for(new i; i < Maxp; i++){ChatAccess[i] = 0;}
        return 1;
    }
//==============================================================================
    CMD:givechat(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(ChatLock == 0)return SendClientMessage(playerid,Red,"! הצ'אט לא נעול");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /GiveChat [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        if(Admin[id] > 0)return SendClientMessage(playerid,Red,"! השחקן שבחרת כבר אדמין ולכן יש לו גישה לצ'אט");
		if(ChatAccess[id] == 1)return SendClientMessage(playerid,Red,"! לשחקן שבחרת כבר יש גישה לדבר בצ'אט");
        SendFormatMessageToAll(Lightblue,"{00DADE}! לדבר בצ'אט {13F6E7}%s{00DADE} נתן גישה לשחקן {13F6E7}%s{00DADE} האדמין",GetName(id),GetName(playerid));
        ChatAccess[id] = 1;
        return 1;
    }
//==============================================================================
    CMD:delchat(playerid,params[])
    {
        if(Admin[playerid] == 0)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
        if(ChatLock == 0)return SendClientMessage(playerid,Red,"! הצ'אט לא נעול");
        new id;
        if(sscanf(params,"u",id))return SendClientMessage(playerid,Green,"Usage:{ffffff} /DelChat [ID]");
        if(!IsPlayerConnected(id))return SendClientMessage(playerid,Red,"! האיידי שבחרת לא מחובר");
        if(Admin[id] > 0)return SendClientMessage(playerid,Red,"! השחקן שבחרת כבר אדמין ולכן יש לו גישה לצ'אט");
		if(ChatAccess[id] == 0)return SendClientMessage(playerid,Red,"! לשחקן שבחרת אין גישה לדבר בצ'אט");
        SendFormatMessageToAll(Lightblue,"{00DADE}! את הגישה לדבר בצ'אט {13F6E7}%s{00DADE} מחק לשחקן {13F6E7}%s{00DADE} האדמין",GetName(id),GetName(playerid));
        ChatAccess[id] = 0;
        return 1;
    }
//==============================================================================
    forward DelayBan(id);
    public DelayBan(id)return Kick(id);
	CMD:text(playerid,params[])
	{
		new text[60];
		if(!sscanf(params,"s[60]",text))
		{
			format(str,sizeof(str),"%s",text);
			GameTextForPlayer(playerid,str,1000,3);
		}
	 	return 1;
	}
//================================== COMMANDS ==================================
    CMD:cd(playerid,params[])
    {
        if(Area[playerid] == GG || Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"לא ניתן לבצע את הפקודה באיזור שאתה נמצא בו");
        if(sscanf(params,"i",params[0])) return SendClientMessage(playerid,Green,"Usage:{FFFFFF} /CD [Number]");
		if(params[0] > DOF2_GetInt("RconOptions/Settings.ini","MaxCD"))return SendFormatMessage(playerid,Red,"! %d מספר השניות המקסימלי לספירה הוא",DOF2_GetInt("RconOptions/Settings.ini","MaxCD"));
        if(CDOn == 1) return SendClientMessage(playerid,Red,"! יש כבר ספירה פועלת");
        CDOn = 1;
        CountDown(params[0]);
        return 1;
    }
//==============================================================================
	CMD:pm(playerid, params[])
	{
	    new targetid, message[128];
	    if (sscanf(params, "us[128]", targetid, message))return SendClientMessage(playerid, Green, "Usage:{ffffff} /Pm [ID] [Message]");
	    if (!IsPlayerConnected(targetid))return SendClientMessage(playerid, 0xFF0000FF, "! האיידי שבחרת לא מחובר");
	    if (playerid == targetid)return SendClientMessage(playerid, 0xFF0000FF, "! אין אפשרות לשלוח הודעה לעצמך");
	    new targetname[MAX_PLAYER_NAME];
	    GetPlayerName(targetid, targetname, sizeof(targetname));
	    new sendername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    SendFormatMessage(targetid, Yellow, "[PM] from %s (%d): %s", sendername, playerid, message);
	    SendFormatMessage(playerid, Yellow, "{cfcf0c}[PM] to %s (%d): %s", GetName(targetid), targetid, message);
	    SendPMToAdmins(playerid, targetname, message);
	    targetRe[playerid] = targetid; // השחקן שהודעה נשלחה אליו נשמר אצל השולח
	    targetRe[targetid] = playerid; // השחקן השולח נשמר אצל השחקן המקבל
	    return 1;
	}
	CMD:re(playerid, params[])
	{
	    if (targetRe[playerid] == -1)return SendClientMessage(playerid, Red, ".לא שלחת לאף אחד הודעה");
	    new message[128];
	    if (sscanf(params, "s[128]", message))return SendClientMessage(playerid, Green, "Usage:{ffffff} /Replay [Text]");
		new targetid = targetRe[playerid];
		if(!IsPlayerConnected(targetid))return SendClientMessage(playerid,Red,"! השחקן אליו ניסית לשלוח הודעה אינו מחובר");
		new targetname[MAX_PLAYER_NAME];
	    GetPlayerName(targetid, targetname, sizeof(targetname));
	    new sendername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    SendFormatMessage(playerid, Yellow, "{cfcf0c}[PM] to %s (%d): %s", targetname, targetid, message);
	    SendFormatMessage(targetid, Yellow, "[PM] from %s (%d): %s", GetName(playerid), playerid, message);
	    targetRe[playerid] = targetid;
	    targetRe[targetid] = playerid;

	    return 1;
	}
//==============================================================================
    CMD:myskin(playerid,params[])
    {
        new skinid;
        if(sscanf(params,"n",skinid))return SendClientMessage(playerid,Green,"Usage:{ffffff} /MySkin [0-299]");
        if(skinid < 0 || skinid > 299)return SendClientMessage(playerid,Green,"Usage:{ffffff} /MySkin {ff0000}[0-299]");
        SetPlayerSkin(playerid,skinid);
		SavedSkin[playerid] = skinid;
		PreSkin[playerid] = skinid;
		format(str,sizeof(str),"! [%d] שינית לעצמך את הסקין למספר",skinid);
        SendClientMessage(playerid,Gold,str);
        return 1;
    }
    CMD:changeskin(playerid,params[])return cmd_myskin(playerid,params);
    CMD:cs(playerid,params[])return cmd_myskin(playerid,params);
//==============================================================================
    CMD:kill(playerid,params[])
    {
        if(Area[playerid] == CW || Area[playerid] == CWVIEW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אין לבצע פקודה זאת באמצע");
		SendClientMessage(playerid,Red,".התאבדת, וחבל כי יש דרכים טובות יותר להתמודד");
        SetPlayerHealth(playerid,0);
        return 1;
    }
//==============================================================================
    CMD:cls(playerid,params[])
    {
        for(new x; x < 100; x ++){SendClientMessage(playerid,White," ");}
        SendClientMessage(playerid,Skygreen,"! ניקית לעצמך את הצ'אט");
        return 1;
    }
//==============================================================================
    CMD:light(playerid,params[])
    {
        if(Area[playerid] == CW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אי אפשר לבצע את הפקודה הזאת במהלך");
        if(Area[playerid] == Light)return SendClientMessage(playerid,Red,"! אתה כבר נמצא באיזור הקלים");
		if(Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"! /ActQuit לא ניתן להשתגר באמצע פעילות, בשביל לצאת מהפעילות השתמש בפקודה");
		if(Area[playerid] == GG)TextDrawHideForPlayer(playerid,gungameleveltext[playerid]);
		Area[playerid] = Light;
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		SendClientMessage(playerid,Green,"! השתגרת אל איזור הקלים");
		SetPlayerArmour(playerid,100),SetPlayerHealth(playerid,100);
        ResetPlayerWeapons(playerid);
		if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
  		if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
   		if(IsPlayerInAnyVehicle(playerid))
    	{
  			new vehicleid = GetPlayerVehicleID(playerid);
			if(Team[playerid] == A)
			{
				SetVehiclePos(vehicleid, 1137.2332,1335.9259,10.8203);
				SetPlayerPos(playerid,1137.2332,1335.9259,10.8203);
				PutPlayerInVehicle(playerid, vehicleid, 0);
				SetVehicleZAngle(vehicleid, 179.2149);
			}else{
				SetVehiclePos(vehicleid, 1137.2517,1235.1417,10.8203);
				SetPlayerPos(playerid,1137.2517,1235.1417,10.8203);
				PutPlayerInVehicle(playerid, vehicleid, 0);
				SetVehicleZAngle(vehicleid, 359.0700);
			}
  		}else{
			if(Team[playerid] == A)return SpawnPlayerToA(playerid);
			if(Team[playerid] == B)return SpawnPlayerToB(playerid);
		}
        return 1;
    }
    CMD:qdmz(playerid,params[])return cmd_light(playerid,params);
    CMD:back(playerid,params[])return cmd_light(playerid,params);
    CMD:qdm(playerid,params[])return cmd_light(playerid,params);
//==============================================================================
    CMD:ap(playerid,params[])
    {
        if(Area[playerid] == CW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אי אפשר לבצע את הפקודה הזאת במהלך");
        if(Area[playerid] == AP)return SendClientMessage(playerid,Red,"! AP אתה כבר נמצא באיזור ה");
        if(Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"! /ActQuit לא ניתן להשתגר באמצע פעילות, בשביל לצאת מהפעילות השתמש בפקודה");
		if(Area[playerid] == GG)TextDrawHideForPlayer(playerid,gungameleveltext[playerid]);
		Area[playerid] = AP;
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerArmour(playerid,100),SetPlayerHealth(playerid,100);
		SendClientMessage(playerid,Green,"! AP השתגרת אל איזור ה");
		SendClientMessage(playerid,Green,"! /Light - על מנת לחזור לאיזור החניון הרגיל השתמש בפקודה");
        ResetPlayerWeapons(playerid);
		if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
  		if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		if(IsPlayerInAnyVehicle(playerid))
    	{
  			new vehicleid = GetPlayerVehicleID(playerid);
			if(Team[playerid] == A)
			{
				SetVehiclePos(vehicleid, 1320.6469,1375.3042,10.8203);
				SetPlayerPos(playerid,1320.6469,1375.3042,10.8203);
				PutPlayerInVehicle(playerid, vehicleid, 0);
				SetVehicleZAngle(vehicleid, 179.3954);
			}else{
				SetVehiclePos(vehicleid, 1320.3190,1309.4552,10.8203);
				SetPlayerPos(playerid,1320.3190,1309.4552,10.8203);
				PutPlayerInVehicle(playerid, vehicleid, 0);
				SetVehicleZAngle(vehicleid, 357.7778);
			}
  		}else{
			if(Team[playerid] == A)return SetPlayerPos(playerid,1320.6469,1375.3042,10.8203) && SetPlayerFacingAngle(playerid,179.3954);
			if(Team[playerid] == B)return SetPlayerPos(playerid,1320.3190,1309.4552,10.8203) && SetPlayerFacingAngle(playerid,357.7778);
		}
        return 1;
    }
	CMD:wh(playerid,params[])
	{
	    if(Area[playerid] == CW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אי אפשר לבצע את הפקודה הזאת במהלך");
        if(Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"! /ActQuit לא ניתן להשתגר באמצע פעילות, בשביל לצאת מהפעילות השתמש בפקודה");
		if(Area[playerid] == GG)TextDrawHideForPlayer(playerid,gungameleveltext[playerid]);
		new num;
		if(sscanf(params,"i",num))return SendClientMessage(playerid,Green,"Usage:{ffffff} /WH [1-50]");
		if(num < 1 || num > 50)return SendClientMessage(playerid,Green,"Usage:{ffffff} /WH {ff0000}[1-50]");
		SetPlayerInterior(playerid,1);
	    Area[playerid] = WH;
	    SetPlayerArmour(playerid,100),SetPlayerHealth(playerid,100);
	    SetPlayerVirtualWorld(playerid,num);
		SendFormatMessage(playerid,Green,"! {63FF82}[WH #%d]{25B801} - WH השתגרת אל איזור ה",num);
		SendClientMessage(playerid,Green,"! /Light - על מנת לחזור לאיזור החניון הרגיל השתמש בפקודה");
        ResetPlayerWeapons(playerid);
		if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
  		if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		if(Team[playerid] == A)
		{
		    //1411.8306,-19.3712,1000.9240,90.8042
		    SetPlayerPos(playerid,1411.8306,-19.3712,1000.9240) && SetPlayerFacingAngle(playerid,90.8042);
		}else{
		    //1365.4437,-20.2236,1000.9219,269.0927
		    SetPlayerPos(playerid,1365.4437,-20.2236,1000.9219) && SetPlayerFacingAngle(playerid,269.0927);
		}
	    return 1;
	}
	CMD:br(playerid,params[])
	{
	    if(Area[playerid] == CW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אי אפשר לבצע את הפקודה הזאת במהלך");
        if(Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"! /ActQuit לא ניתן להשתגר באמצע פעילות, בשביל לצאת מהפעילות השתמש בפקודה");
		if(Area[playerid] == GG)TextDrawHideForPlayer(playerid,gungameleveltext[playerid]);
		new brnum;
		if(sscanf(params,"i",brnum))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Br [1-50]");
		if(brnum < 1 || brnum > 50)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Br {ff0000}[1-50]");
		SetPlayerInterior(playerid,15);
	    Area[playerid] = BR;
	    SetPlayerVirtualWorld(playerid,brnum);
		SendFormatMessage(playerid,Green,"! {63FF82}[BR #%d]{25B801} - BR השתגרת אל איזור ה",brnum);
		SendClientMessage(playerid,Green,"! /Light - על מנת לחזור לאיזור החניון הרגיל השתמש בפקודה");
        ResetPlayerWeapons(playerid);
        SetPlayerArmour(playerid,100),SetPlayerHealth(playerid,100);
		if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
  		if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		if(Team[playerid] == A)
		{
		    //-1458.1985,995.3450,1024.8131,269.8115 a
		    //-1398.2206,994.9816,1024.0901,88.3741 b
		    SetPlayerPos(playerid,-1458.1985,995.3450,1024.8131) && SetPlayerFacingAngle(playerid,269.8115);
		}else{
		    //-1458.1985,995.3450,1024.8131,269.8115 a
		    //-1398.2206,994.9816,1024.0901,88.3741 b
		    SetPlayerPos(playerid,-1398.2206,994.9816,1024.0901) && SetPlayerFacingAngle(playerid,88.3741);
		}
	    return 1;
	}
//==============================================================================
/*    CMD:sniper(playerid,params[])
    {
        if(Area[playerid] == Sniper)return SendClientMessage(playerid,Red,"! אתה כבר נמצא באיזור הסנייפרים");
        SetPlayerVirtualWorld(playerid,0);
        Area[playerid] = Sniper;
        SetPlayerInterior(playerid,0);
		SetPlayerArmour(playerid,100);
        new sniperrand = random(sizeof(SniperSpawns));
        SetPlayerPos(playerid,SniperSpawns[sniperrand][0],SniperSpawns[sniperrand][1],SniperSpawns[sniperrand][2]);
        SetPlayerFacingAngle(playerid,SniperSpawns[sniperrand][3]);
        ResetPlayerWeapons(playerid);
        GivePlayerWeapon(playerid,34,9999);
        SendClientMessage(playerid,Green,"! השתגרת אל איזור הסנייפרים");
        return 1;
    }
//==============================================================================
    CMD:heavy(playerid,params[])
    {
        if(Area[playerid] == Heavy)return SendClientMessage(playerid,Red,"! אתה כבר נמצא באיזור הכבדים");
        SetPlayerVirtualWorld(playerid,0);
        SetPlayerInterior(playerid,0);
        ResetPlayerWeapons(playerid);
        new heavyrand = random(sizeof(HeavySpawns));
        Area[playerid] = Heavy;
        SendClientMessage(playerid,Green,"! השתגרת אל איזור הכבדים");
        SetPlayerPos(playerid,HeavySpawns[heavyrand][0],HeavySpawns[heavyrand][1],HeavySpawns[heavyrand][2]);
        SetPlayerFacingAngle(playerid,HeavySpawns[heavyrand][3]);
        GivePlayerWeapon(playerid,34,5000) && GivePlayerWeapon(playerid,24,5000);
        GivePlayerWeapon(playerid,27,5000) && GivePlayerWeapon(playerid,31,5000);
        SetPlayerHealth(playerid,100) && SetPlayerArmour(playerid,100);
        return 1;
    }
//==============================================================================
    CMD:rpg(playerid,params[])
    {
        if(Area[playerid] == RPG)return SendClientMessage(playerid,Red,"! אתה כבר נמצא באיזור הטילים");
        SetPlayerVirtualWorld(playerid,0);
        Area[playerid] = RPG;
        SetPlayerInterior(playerid,0);
        ResetPlayerWeapons(playerid);
        SetPlayerArmour(playerid,100);
        GivePlayerWeapon(playerid,35,9999);
        SendClientMessage(playerid,Green,"! השתגרת אל איזור הטילים");
        new rpgrand = random(sizeof(RPGSpawns));
        SetPlayerPos(playerid, RPGSpawns[rpgrand][0], RPGSpawns[rpgrand][1], RPGSpawns[rpgrand][2]);
        SetPlayerFacingAngle(playerid,RPGSpawns[rpgrand][3]);
        return 1;
    }*/
stock ShowPlayerActDialog(playerid)
{
    ShowPlayerDialog(playerid,Dialog_Acts,DIALOG_STYLE_LIST,"{69f247}Activities - פעילויות","{47ddf2}Gun Game{c6c6c6} - איזור הגאן גיים\n{47ddf2}War Activity{c6c6c6} - פעילות וואר\n{47ddf2}Kart Racing{c6c6c6} - פעילות מירוץ קארטינג","הפעל","ביטול");
	return 1;
}
public OnPlayerExitVehicle(playerid,vehicleid)
{
	if(Area[playerid] == KartAct)
	{
	    PlayersInAct[kart_act] --;
	    SendClientMessage(playerid,Gray,"יצאת מהרכב באמצע פעילות ולכן הפסדת במירוץ");
	    PlayerPlaySound(playerid,losesound,0,0,0);
        DestroyVehicle(GetPlayerVehicleID(playerid));
		Area[playerid] = Light;
		SetPlayerVirtualWorld(playerid,0);
		SpawnPlayer(playerid);
		if(KartPlayer[1] == playerid)KartPlayer[1] = -1;
		if(KartPlayer[2] == playerid)KartPlayer[2] = -1;
		if(KartPlayer[3] == playerid)KartPlayer[3] = -1;
		if(KartPlayer[4] == playerid)KartPlayer[4] = -1;
		DisablePlayerRaceCheckpoint(playerid);
		Checkpoints[playerid] = 0;
		if(PlayersInAct[kart_act] <= 1)
	    {
			OpenActivity = none;
			PlayersInAct[kart_act] = 0;
			ActIsRunning = false;
			for(new i; i<Maxp; i++)
			{
			    if(IsPlayerConnected(i) && Area[i] == KartAct)
			    {
			        DestroyVehicle(GetPlayerVehicleID(i));
			        PlayerPlaySound(i,winsound,0,0,0);
			        GameTextForPlayer(i,"~g~YOU WON THE KART RACING !",3000,3);
			        SendFormatMessageToAll(-1,"{48e832}[{ebf51b}Kart Activity{48e832}]{00ff00} ! ניצח את פעילות הקארטינג %s השחקן",GetName(i));
	                SetPlayerVirtualWorld(i,0);
	                SetPlayerInterior(i,0);
	                SetPlayerPos(i,1137.2332,1335.9259,10.8203);
					Area[i] = Light;
					Checkpoints[i] = 0;
					SpawnPlayer(i);
					DisablePlayerRaceCheckpoint(i);
					//DisableRemoteVehicleCollisions(i,false);
			        break;
			    }
			}
	    }
	}
	return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
    if(Area[playerid] == KartAct)
    {
        Checkpoints[playerid] ++;
	    if(Checkpoints[playerid] == 1)
		{
            SetPlayerRaceCheckpoint(playerid,2,-1311.0006,-141.0648,1049.4086,0,0,0,12); // checkpoint 2
			PlayerPlaySound(playerid,5205,0.0,0.0,0.0);
		}
	    if(Checkpoints[playerid] == 2)
		{
            SetPlayerRaceCheckpoint(playerid,2,-1433.2086,-282.8820,1050.5027,0,0,0,12);
            PlayerPlaySound(playerid,5205,0.0,0.0,0.0);
		}
	    if(Checkpoints[playerid] == 3)
		{
            SetPlayerRaceCheckpoint(playerid,2,-1405.5702,-154.6092,1043.1403,0,0,0,12);
            PlayerPlaySound(playerid,5205,0.0,0.0,0.0);
		}
	    if(Checkpoints[playerid] == 4)
		{
            SetPlayerRaceCheckpoint(playerid,2,-1366.4847,-281.8777,1044.5719,0,0,0,12);
            PlayerPlaySound(playerid,5205,0.0,0.0,0.0);
		}
	    if(Checkpoints[playerid] == 5)
		{
            SetPlayerRaceCheckpoint(playerid,2,-1311.0006,-141.0648,1049.4086,0,0,0,12);
            PlayerPlaySound(playerid,5205,0.0,0.0,0.0);
		}
	    if(Checkpoints[playerid] == 6)
		{
            SetPlayerRaceCheckpoint(playerid,2,-1433.2086,-282.8820,1050.5027,0,0,0,12);
            PlayerPlaySound(playerid,5205,0.0,0.0,0.0);
		}
	    if(Checkpoints[playerid] == 7)
		{
            SetPlayerRaceCheckpoint(playerid,1,-1405.5702,-154.6092,1043.1403,0,0,0,12);
            PlayerPlaySound(playerid,5205,0.0,0.0,0.0);
		}
	    if(Checkpoints[playerid] == 8)
		{
	        SendFormatMessageToAll(-1,"{48e832}[{ebf51b}Kart Activity{48e832}]{00ff00} ! ניצח את פעילות הקארטינג %s השחקן",GetName(playerid));
			GameTextForPlayer(playerid,"~g~YOU WON THE KART RACING !",3000,3);
			PlayerPlaySound(playerid,winsound,0,0,0);
			OpenActivity = none;
			ActIsRunning = false;
			PlayersInAct[kart_act] = 0;
			KartPlayer[1] = -1,KartPlayer[2] = -1,KartPlayer[3] = -1,KartPlayer[4] = -1;
			for(new i; i<Maxp; i++)
	        {
	            if(IsPlayerConnected(i) && Area[i] == KartAct)
	            {
	                DestroyVehicle(GetPlayerVehicleID(i));
	                SetPlayerVirtualWorld(i,0);
	                SetPlayerInterior(i,0);
	                SetPlayerPos(i,1137.2332,1335.9259,10.8203);
					Area[i] = Light;
					Checkpoints[i] = 0;
					SpawnPlayer(i);
					//DisableRemoteVehicleCollisions(i,false);
					DisablePlayerRaceCheckpoint(i);
					if(i != playerid)
					{
						PlayerPlaySound(i,losesound,0,0,0);
						GameTextForPlayer(i,"~r~YOU LOST THE KART RACING",3000,3);
						SendClientMessage(i,Gray,"הפסדת במירוץ הקארטינג וחזרת לאיזור הקלים");
					}
				}
	        }
	    }
	}
	return 1;
}
//==============================================================================
	CMD:act(playerid,params[])
	{
	    if(Admin[playerid] < 1)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
	    ShowPlayerActDialog(playerid);
	    return 1;
	}
	CMD:actstart(playerid,params[])
	{
		if(Admin[playerid] < 1)return SendClientMessage(playerid,Red,"! פקודה זו לאדמינים בלבד");
		if(OpenActivity == none || OpenActivity == gg_act)return SendClientMessage(playerid,Red,"! אף פעילות לא נפתחה להרשמה");
		if(PlayersInAct[war_act] < 1 && PlayersInAct[kart_act] < 1)return SendClientMessage(playerid,Red,"! לא נרשמו מספיק שחקנים לפעילות");
		if(ActIsRunning == true)return SendClientMessage(playerid,Red,"הפעילות כבר החלה");
		ActIsRunning = true;
		ActReg = close;
		if(OpenActivity == war_act)//פעילות וואר
		{
			for(new i;i<Maxp;i++)
			{
				if(IsPlayerConnected(i) && RegisteredToAct[i] == true)
				{
					RegisteredToAct[i] = false;
					Area[i] = WarAct;
					SetPlayerVirtualWorld(i,103);
					SetPlayerInterior(i,10);
					new wactrandom = random(sizeof(WarActSpawns));
					SetPos(i,WarActSpawns[wactrandom][0],WarActSpawns[wactrandom][1],WarActSpawns[wactrandom][2],WarActSpawns[wactrandom][3]);
					SetPlayerArmour(i,100),SetPlayerHealth(i,100);
					ResetPlayerWeapons(i);
					TogglePlayerControllable(i,0);
					SetTimerEx("UnFreeze",5000,false,"u",i);
					SetTimerEx("GiveRandomWeapons",5000,false,"u",i);
				}
			}
			CDForVirtualWorld(103,5);
			SendFormatMessageToAll(-1,"{48e832}[{e86f32}War Activity{48e832}]{00ff00} התחיל את פעילות הוואר %s האדמין",GetName(playerid));
		}
		if(OpenActivity == kart_act)
		{
		    SendFormatMessageToAll(-1,"{48e832}[{ebf51b}Kart Activity{48e832}]{00ff00} התחיל את מירוץ הקארטינג %s האדמין",GetName(playerid));
			for(new i;i<Maxp;i++)
			{
			    if(IsPlayerConnected(i) && RegisteredToAct[i] == true)
			    {
			        RegisteredToAct[i] = false;
			        SetPlayerVirtualWorld(i,104);
					SetPlayerInterior(i,7);
					SetPos(i,-1394.9991,-186.4924,1042.5122,185.5068);
					ResetPlayerWeapons(i);
			        SetPlayerArmour(i,100),SetPlayerHealth(i,100);
			        TogglePlayerControllable(i,0);
			        //DisableRemoteVehicleCollisions(i,true);
			        Checkpoints[i] = 0;
					BoostCooldown[i] = true;
					SetTimerEx("DisableBoostCooldown",5000,false,"u",i);
					SetTimerEx("UnFreeze",5000,false,"u",i);
					SendClientMessage(i,Lightblue,"[Activity Tip]{34d2b5} ! יהפוך את רכבכם במידה והתהפכתם N לחיצה שמאלית בעכבר תעניק לכם בוסט מהירות ולחיצה על המקש");
					Area[i] = KartAct;
					SetPlayerRaceCheckpoint(i,2,-1366.4847,-281.8777,1044.5719,0,0,0,12);
			    }
			}
  			Kart1 = CreateVehicle(571,-1403.9261,-187.2324,1042.5044,185.4957,1,1,false,0);
  			SetVehicleVirtualWorld(Kart1,104);
	    	LinkVehicleToInterior(Kart1,7);
	    	PutPlayerInVehicle(KartPlayer[1],Kart1,0);
			if(PlayersInAct[kart_act] == 2)
			{
			    Kart2 = CreateVehicle(571,-1400.9458,-187.0325,1042.5070,185.5014,1,1,false,0);
			    SetVehicleVirtualWorld(Kart2,104);
			    LinkVehicleToInterior(Kart2,7);
			    PutPlayerInVehicle(KartPlayer[2],Kart2,0);
			}
			if(PlayersInAct[kart_act] == 3)
			{
			    Kart2 = CreateVehicle(571,-1400.9458,-187.0325,1042.5070,185.5014,1,1,false,0);
			    LinkVehicleToInterior(Kart2,7);
			    Kart3 = CreateVehicle(571,-1397.9650,-186.8368,1042.5081,185.5051,1,1,false,0);
			    LinkVehicleToInterior(Kart3,7);
			    SetVehicleVirtualWorld(Kart2,104);
			    SetVehicleVirtualWorld(Kart3,104);
			    PutPlayerInVehicle(KartPlayer[2],Kart2,0);
			    PutPlayerInVehicle(KartPlayer[3],Kart3,0);
			}
			if(PlayersInAct[kart_act] == 4)
			{
			    Kart2 = CreateVehicle(571,-1400.9458,-187.0325,1042.5070,185.5014,1,1,false,0);
			    LinkVehicleToInterior(Kart2,7);
			    Kart3 = CreateVehicle(571,-1397.9650,-186.8368,1042.5081,185.5051,1,1,false,0);
			    LinkVehicleToInterior(Kart3,7);
			    Kart4 = CreateVehicle(571,-1394.9991,-186.4924,1042.5122,185.5068,1,1,false,0);
			    LinkVehicleToInterior(Kart4,7);
			    SetVehicleVirtualWorld(Kart2,104);
			    SetVehicleVirtualWorld(Kart3,104);
			    SetVehicleVirtualWorld(Kart4,104);
			    PutPlayerInVehicle(KartPlayer[2],Kart2,0);
			    PutPlayerInVehicle(KartPlayer[3],Kart3,0);
			    PutPlayerInVehicle(KartPlayer[4],Kart4,0);
			}
			CDForVirtualWorld(104,5);
		}
	    return 1;
	}
    CMD:as(playerid,params[])return cmd_actstart(playerid,"");
forward GiveRandomWeapons(i);
public GiveRandomWeapons(i)
{
    new randomIndex = random(sizeof(WarWeapons));
    new weaponid = WarWeapons[randomIndex];
    GivePlayerWeapon(i, weaponid, 5000);
    return 1;
}
	CMD:actq(playerid,params[])
	{
	    if(Area[playerid] != WarAct && Area[playerid] != KartAct)return SendClientMessage(playerid,Red,"! אתה לא נמצא באף פעילות");
		if(Area[playerid] == WarAct)
		{
		    PlayersInAct[war_act] --;
			Area[playerid] = Light;
			ResetPlayerWeapons(playerid);
			SetPlayerHealth(playerid,100),SetPlayerArmour(playerid,100);
			SetPlayerInterior(playerid,0),SetPlayerVirtualWorld(playerid,0);
			SpawnPlayer(playerid);
			SendClientMessage(playerid,Gray,"! יצאת מהפעילות וחזרת לאיזור הקלים");
			PlayerPlaySound(playerid,errorsound,0,0,0);
			if(PlayersInAct[war_act] <= 1)
			{
				for(new i;i<Maxp;i++)
				{
				    if(IsPlayerConnected(i) && Area[i] == WarAct)
				    {
				        GameTextForPlayer(i,"~g~YOU WON THE WAR ACTIVITY !",3000,3);
				        PlayerPlaySound(i,winsound,0,0,0);
				        SendFormatMessageToAll(-1,"{48e832}[{e86f32}War Activity{48e832}] ! ניצח את פעילות הוואר %s השחקן",GetName(i));
				        Area[i] = Light;
				        SpawnPlayer(i);
				        SetPlayerVirtualWorld(i,0);
				        break;
				    }
				}
				OpenActivity = none;
				PlayersInAct[war_act] = 0;
				ActIsRunning = false;
			}
		}
		if(Area[playerid] == KartAct)
		{
		    PlayersInAct[kart_act] --;
		    SendClientMessage(playerid,Gray,"! יצאת מהפעילות וחזרת לאיזור הקלים");
		    PlayerPlaySound(playerid,errorsound,0,0,0);
	        DestroyVehicle(GetPlayerVehicleID(playerid));
			Area[playerid] = Light;
			SetPlayerVirtualWorld(playerid,0);
			SpawnPlayer(playerid);
			if(KartPlayer[1] == playerid)KartPlayer[1] = -1;
			if(KartPlayer[2] == playerid)KartPlayer[2] = -1;
			if(KartPlayer[3] == playerid)KartPlayer[3] = -1;
			if(KartPlayer[4] == playerid)KartPlayer[4] = -1;
			DisablePlayerRaceCheckpoint(playerid);
			Checkpoints[playerid] = 0;
			if(PlayersInAct[kart_act] <= 1)
		    {
				OpenActivity = none;
				PlayersInAct[kart_act] = 0;
				ActIsRunning = false;
				for(new i; i<Maxp; i++)
				{
				    if(IsPlayerConnected(i) && Area[i] == KartAct)
				    {
				        DestroyVehicle(GetPlayerVehicleID(i));
				        PlayerPlaySound(i,winsound,0,0,0);
				        GameTextForPlayer(i,"~g~YOU WON THE KART RACING !",3000,3);
				        SendFormatMessageToAll(-1,"{48e832}[{ebf51b}Kart Activity{48e832}]{00ff00} ! ניצח את פעילות הקארטינג %s השחקן",GetName(i));
		                SetPlayerVirtualWorld(i,0);
		                SetPlayerInterior(i,0);
		                SetPlayerPos(i,1137.2332,1335.9259,10.8203);
						Area[i] = Light;
						Checkpoints[i] = 0;
						SpawnPlayer(i);
						DisablePlayerRaceCheckpoint(i);
						//DisableRemoteVehicleCollisions(i,false);
				        break;
				    }
				}
		    }
		}
		return 1;
	}
	CMD:actjoin(playerid,params[])
	{
	    if(OpenActivity == none || OpenActivity == gg_act)return SendClientMessage(playerid,Red,"! אין אף פעילות פתוחה להרשמה");
		if(RegisteredToAct[playerid] == true)return SendClientMessage(playerid,Red,"כבר נרשמת לפעילות");
		if(ActReg == close)return SendClientMessage(playerid,Red,"הפעילות כבר החלה");
		if(OpenActivity == war_act)
		{
		    RegisteredToAct[playerid] = true;
		    PlayersInAct[war_act] ++;
			SendFormatMessageToAll(-1,"{48e832}[{e86f32}War Activity{48e832}] ! (%d/10) נרשם אל פעילות הוואר {e86f32}%s{48e832} השחקן",PlayersInAct[war_act],GetName(playerid));
		}
		if(OpenActivity == kart_act)
		{
			if(PlayersInAct[kart_act] == 4)return SendClientMessage(playerid,Red,"! כל המקומות בפעילות נתפסו");
            RegisteredToAct[playerid] = true;
			PlayersInAct[kart_act] ++;
			KartPlayer[PlayersInAct[kart_act]] = playerid;
			SendFormatMessageToAll(-1,"{48e832}[{ebf51b}Kart Activity{48e832}] ! (%d/4) נרשם אל פעילות מירוץ הקארטינג {ebf51b}%s{48e832} השחקן",PlayersInAct[kart_act],GetName(playerid));
		}
		return 1;
	}
	CMD:ac(playerid,params[])return cmd_actjoin(playerid,"");
	CMD:gg(playerid,params[])
	{
	    if(OpenActivity != gg_act)return SendClientMessage(playerid,Red,"! איזור הגאן גיים סגור");
		if(AmramMode[playerid] == true)return SendClientMessage(playerid,Red,"! לא ניתן להכנס אל איזור הגאן גיים כשמצב עמרם מופעל");
		if(Area[playerid] == GG)return SendClientMessage(playerid,Red,"! אתה כבר נמצא באיזור הגאן גיים");
		Area[playerid] = GG;
		SendFormatMessageToAll(-1,"{55e044}[Gun Game] ! הצטרף אל איזור הגאן גיים %s השחקן",GetName(playerid));
		ResetPlayerWeapons(playerid);
		SetPlayerHealth(playerid,100);
		SetPlayerArmour(playerid,0);
		new ggrand = random(sizeof(GGSpawns));
		SetPos(playerid,GGSpawns[ggrand][0],GGSpawns[ggrand][1],GGSpawns[ggrand][2],GGSpawns[ggrand][3]);
		GGLevel[playerid] = 1;
		GGDeath[playerid] = 0;
		GivePlayerWeapon(playerid,level1weapon,9999);
		format(str,sizeof(str),"GUNGAME LEVEL: %d/10",GGLevel[playerid]);
		TextDrawSetString(gungameleveltext[playerid],str);
		TextDrawShowForPlayer(playerid,gungameleveltext[playerid]);
		return 1;
	}
	CMD:gungame(playerid,params[])return cmd_gg(playerid,"");
//==============================================================================
   	CMD:wars(playerid,params[])
    {
        if(Area[playerid] == CW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אי אפשר לבצע את הפקודה הזאת במהלך");
        if(Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"! /ActQuit לא ניתן להשתגר באמצע פעילות, בשביל לצאת מהפעילות השתמש בפקודה");
		if(Area[playerid] == GG)TextDrawHideForPlayer(playerid,gungameleveltext[playerid]);
		new war;
		if(sscanf(params,"i",war))return SendClientMessage(playerid,Green,"Usage:{ffffff} /Wars [1-50]");
        if(war < 1 || war > 50)return SendClientMessage(playerid,Green,"Usage:{ffffff} /Wars {ff0000}[1-50]");
		Area[playerid] = War;
		SetPlayerVirtualWorld(playerid,war);
        SetPlayerInterior(playerid,16);
        SetPlayerArmour(playerid,100),SetPlayerHealth(playerid,100);
        new warrand = random(sizeof(WarSpawns));
        SetPlayerPos(playerid,WarSpawns[warrand][0],WarSpawns[warrand][1],WarSpawns[warrand][2]);
        SetPlayerFacingAngle(playerid,WarSpawns[warrand][3]);
        ResetPlayerWeapons(playerid);
		if(AmramMode[playerid] == false)GivePlayerWeapon(playerid,26,9999) && GivePlayerWeapon(playerid,22,9999) && GivePlayerWeapon(playerid,28,9999);
  		if(AmramMode[playerid] == true)GivePlayerWeapon(playerid,5,1);
		format(str,sizeof(str),"! {63FF82}[Wars #%d]{25B801} - השתגרת אל הוואר",war);
        SendClientMessage(playerid,Green,str);
        SendClientMessage(playerid,Green,"! /Light - על מנת לחזור לאיזור החניון הרגיל השתמש בפקודה");
        return 1;
    }
    CMD:war(playerid,params[])return cmd_wars(playerid,params);
stock SpawnPlayerToWar(playerid)
{
    new warrand = random(sizeof(WarSpawns));
	SetPlayerPos(playerid,WarSpawns[warrand][0],WarSpawns[warrand][1],WarSpawns[warrand][2]);
 	SetPlayerFacingAngle(playerid,WarSpawns[warrand][3]);
 	return 1;
}
//==============================================================================
    CMD:setworld(playerid,params[])
    {
        if(Area[playerid] == CW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אי אפשר לבצע את הפקודה הזאת במהלך");
        if(Area[playerid] == GG || Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"לא ניתן לבצע את הפקודה באיזור שאתה נמצא בו");
		new world;
		if(sscanf(params,"n",world))return SendClientMessage(playerid,Green,"Usage:{ffffff} /SetWorld [0-100]");
        if(world < 0 || world > 100)return SendClientMessage(playerid,Green,"Usage:{ffffff} /SetWorld {ff0000}[0-100]");
        SetPlayerVirtualWorld(playerid,world);
        format(str,sizeof(str),"! (#%d) שינית את מס העולם הוירטואלי שלך ל",world);
        SendClientMessage(playerid,Skyblue,str);
        return 1;
    }
    CMD:myvw(playerid,params[])return cmd_setworld(playerid,params);
//==============================================================================
    CMD:myworld(playerid,params[])
    {
        format(str,sizeof(str),"! (#%d) העולם הוירטואלי שאתה נמצא בו כעת הוא",GetPlayerVirtualWorld(playerid));
        SendClientMessage(playerid,Skygreen,str);
        return 1;
    }
//================================== COMMANDS ==================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(Admin[playerid] == 0 && DOF2_GetInt("RconOptions/Settings.ini","PlayerEnterCar") == 0)
    {
        SendClientMessage(playerid,Red,"! אין באפשרותך להכנס לרכבים כי האופציה לשחקנים כבויה");
        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerid,x,y,z);
        SetPlayerPos(playerid,x,y,z);
    }
    return 1;
}
//==============================================================================
public OnPlayerRequestSpawn(playerid)
{
	if(LoggedIn[playerid] == false)return 0;
    InClass[playerid] = 0;
    SetPlayerArmour(playerid,100);
    SetPlayerHealth(playerid,100);
    SetPlayerVirtualWorld(playerid,0);
	SavedSkin[playerid] = GetPlayerSkin(playerid);
	PreSkin[playerid] = GetPlayerSkin(playerid);
    return 1;
}
public OnPlayerCommandText(playerid,cmdtext[])
{
	if(LoggedIn[playerid] == false || InClass[playerid] == 1)return 0;
	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
    SetPos(playerid,1498.1403,2773.4592,10.8203,268.8430);
    SetPlayerVirtualWorld(playerid,102);
    SetPlayerCameraPos(playerid,1505.1403,2773.4592,12.0203);
    SetPlayerCameraLookAt(playerid, 1498.1403,2773.4592,10.8203);
    InClass[playerid] = 1;
    
    if(classid == 0 || classid == 1 || classid == 2 || classid == 3 || classid == 4 || classid == 5 || classid == 6)
    {
        GameTextForPlayer(playerid,"~w~~h~Team: -~b~~h~~h~~h~A~w~~h~-",1500,3);
        SetPlayerColor(playerid,TeamAColor);
        Team[playerid] = A;
        //SetPlayerTeam(playerid,A);
    }
    if(classid == 7 || classid == 8 || classid == 9 || classid == 10 || classid == 11 || classid == 12 || classid == 13)
    {
        GameTextForPlayer(playerid,"~w~~h~Team: -~r~~h~B~w~~h~-",1500,3);
        SetPlayerColor(playerid,TeamBColor);
        Team[playerid] = B;
        //SetPlayerTeam(playerid,B);
    }
    return 1;
}
forward CDOffTimer();
public CDOffTimer()return CDOn = 0;
//==============================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
//========================== [G] Stop Animation ================================
	if(PRESSED(KEY_SECONDARY_ATTACK) && InAnimation[playerid] == true)
	{
	    InAnimation[playerid] = false;
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
		ClearAnimations(playerid,0);
		TextDrawHideForPlayer(playerid,stopanimation);
		TextDrawHideForPlayer(playerid,enteranimlist);
	}
//================================ [Y] Full HP Armor ===========================
    if(PRESSED(KEY_YES))
    {
        if(Area[playerid] == CW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אין באפשרותך למלא חיים ומגן באמצע");
		if(Area[playerid] == GG || Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"! לא ניתן לבצע זאת באיזור שאתה נמצא בו");
		if(DOF2_GetInt("RconOptions/Settings.ini","Full") == 0)return SendClientMessage(playerid,Red,"! האופציה למילוי חיים ומגן כבויה");
        if(Admin[playerid] > 0 && IsPlayerInAnyVehicle(playerid))
  		{
			new vehicleid = GetPlayerVehicleID(playerid);
			SetVehicleHealth(vehicleid, 1000);
			RepairVehicle(vehicleid);
			new Float:Health,Float:Armour;
        	if(GetPlayerHealth(playerid,Health) == 100 && GetPlayerArmour(playerid,Armour) == 100)return SendClientMessage(playerid,Red,"!  החיים והמגן שלך כבר מלאים");
        	SetPlayerHealth(playerid,100.0);
        	SetPlayerArmour(playerid,100.0);
        	SendClientMessage(playerid,Lightgreen,"! מילאת לעצמך את החיים המגן ותיקנת את הרכב");
		}else{
			new Float:Health,Float:Armour;
        	if(GetPlayerHealth(playerid,Health) == 100 && GetPlayerArmour(playerid,Armour) == 100)return SendClientMessage(playerid,Red,"!  החיים והמגן שלך כבר מלאים");
        	SetPlayerHealth(playerid,100.0);
        	SetPlayerArmour(playerid,100.0);
        	SendClientMessage(playerid,Lightgreen,"! מילאת לעצמך חיים ומגן");
		}
	}
//=================================== [N] Spawn ================================
    if(PRESSED(KEY_NO))
    {
        if(Area[playerid] == CW || Area[playerid] == CWVIEW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אין באפשרותך לבצע זאת באמצע");
        if(Area[playerid] == GG || Area[playerid] == WarAct)return SendClientMessage(playerid,Red,"! לא ניתן לבצע זאת באיזור שאתה נמצא בו");
		if(Area[playerid] == KartAct)
		{
  			new Float:angle;
        	GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
        	SetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
			PlayerPlaySound(playerid,17001,0,0,0);
		}else{
			cmd_spawn(playerid,"/spawn");
		}
	}
//============================== [H] CD + Full For All =========================
	if(Admin[playerid] > 0 && PRESSED(KEY_CTRL_BACK) && !IsPlayerInAnyVehicle(playerid))
	{
	    if(Area[playerid] == CW || Area[playerid] == CWVIEW || Area[playerid] == CWSPEC)return SendClientMessage(playerid,Red,"! CW אין באפשרותך למלא חיים ומגן באמצע");
        if(Area[playerid] == GG || Area[playerid] == WarAct || Area[playerid] == KartAct)return SendClientMessage(playerid,Red,"! לא ניתן לבצע זאת באיזור שאתה נמצא בו");
		if(CDOn == 1)return SendClientMessage(playerid,Red,"! קיימת כבר ספירה פועלת");
		new playerVW = GetPlayerVirtualWorld(playerid); // קבלת העולם הווירטואלי של השחקן
		CDOn = 1;
		SetTimer("CDOffTimer",5000,false);
		for(new i = 0; i < Maxp; i++)
    	{
        	if(IsPlayerConnected(i) && GetPlayerVirtualWorld(i) == playerVW && Area[playerid] == Area[i]) // בדיקה אם השחקן מחובר ונמצא באותו עולם וירטואלי
        	{
            	SetPlayerHealth(i, 100);
            	SetPlayerArmour(i, 100);
				CDForVirtualWorld(playerVW,5);
		    	for(new x = 0; x < 100; x++)
		    	{
		        	SendClientMessage(i,White," ");
		    	}
		    	SendFormatMessage(i,Gold, "{57e9eb}! ניקה את הצ'אט מילא את כולם והתחיל ספירה {e8c544}%s{57e9eb} האדמין", GetName(playerid));
			}
    	}
	}
//================================ [CTRL] Car Jump =============================
    if(Admin[playerid] > 0 && PRESSED(KEY_ACTION) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
		if(Area[playerid] == KartAct)return 0;
        if(GetPlayerVehicleID(playerid) == 425 || GetPlayerVehicleID(playerid) == 520 || GetPlayerVehicleID(playerid) == 432)return 0;
        new Float:x,Float:y,Float:z;
        GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z);
        SetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z + 0.3);
    }
//================================ [+] Car Fix =================================
    if(Admin[playerid] > 0 && PRESSED(KEY_LOOK_BEHIND) && IsPlayerInAnyVehicle(playerid))
    {
  		if(Area[playerid] == KartAct)return 0;
        SetVehicleHealth(GetPlayerVehicleID(playerid),1000.0);
        PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
        SendClientMessage(playerid,Lightgreen,"! תיקנת את הרכב");
        RepairVehicle(GetPlayerVehicleID(playerid));
    }
//============================= [MOUSE_FIRE] Car Speed =========================
    if((PRESSED(KEY_FIRE) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
    {
        if(Area[playerid] == KartAct)
        {
            if(BoostCooldown[playerid] == true)return GameTextForPlayer(playerid,"~r~BOOST COLDOWN",500,3);
            PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
			new Float:Pos[3];
	        GetVehicleVelocity(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
	        SetVehicleVelocity(GetPlayerVehicleID(playerid), Pos[0] * 1.5, Pos[1] * 1.5, Pos[2] * 1.5);
			BoostCooldown[playerid] = true;
			GameTextForPlayer(playerid,"~p~+ BOOST +",500,3);
			SetTimerEx("DisableBoostCooldown",2000,false,"u",playerid);
		}else{
            if(Admin[playerid] < 1)return 0;
        	if(GetPlayerVehicleID(playerid) == 425 || GetPlayerVehicleID(playerid) == 520 || GetPlayerVehicleID(playerid) == 432)return 0;
	        new Float:Pos[3];
	        GetVehicleVelocity(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
	        SetVehicleVelocity(GetPlayerVehicleID(playerid), Pos[0] * 1.7, Pos[1] * 1.7, Pos[2] * 1.7);
		}
	}
    return 1;
}
forward DisableBoostCooldown(playerid);
public DisableBoostCooldown(playerid)
{
	BoostCooldown[playerid] = false;
	return 1;
}
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == Dialog_Acts)
	{
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0: //GG Activity//
				{
				    if(OpenActivity == none)//במידה ואין אף פעילות פתוחה
			    	{
				        OpenActivity = gg_act;
						GameTextForAll("~b~] ~g~~h~ACTIVITY: ~w~/GUNGAME ~b~]",3000,3);
                        PlaySoundForAll(1149);
						SendClientMessageToAll(-1,"{b9b9b9}<========= [{32e846}GunGame - גאן גיים{b9b9b9}] =========>");
						SendFormatMessageToAll(-1,"{dcdcdc}! {32e846}GunGame{dcdcdc} פתח את איזור ה {32e846}%s{dcdcdc} האדמין",GetName(playerid));
						SendClientMessageToAll(-1,"{dcdcdc}! {32e846}/GG{dcdcdc} - להצטרפות אנא השתמשו בפקודה");
						SendClientMessageToAll(-1,"{dcdcdc}! בהצלחה לכל המשתתפים");
						SendClientMessageToAll(-1,"{b9b9b9}<========= [{32e846}GunGame - גאן גיים{b9b9b9}] =========>");
				    }else if(OpenActivity == gg_act)//במידה ויש פעילות פתוחה וזה הגאן גיים
				    {
						OpenActivity = none;
						ActIsRunning = false;
						PlaySoundForAll(errorsound);
						SendFormatMessageToAll(Yellow,"! סגר את איזור הגאן גיים %s האדמין",GetName(playerid));
						for(new i;i<Maxp;i++)
						{
							if(IsPlayerConnected(i) && Area[i] == GG)
							{
								GGLevel[i] = 0;
								GGDeath[i] = 0;
								Area[i] = Light;
								TextDrawHideForPlayer(i,gungameleveltext[i]);
								SetPlayerVirtualWorld(i,0);
								if(GetPlayerState(i) != PLAYER_STATE_WASTED)SpawnPlayer(i);
							}
						}
					}else{
						SendClientMessage(playerid,Red,"! יש כבר פעילות קיימת");
						PlayerPlaySound(playerid,errorsound,0,0,0);
						ShowPlayerActDialog(playerid);
					}
				}
				case 1: //War Activity//
				{
				    if(OpenActivity == none)
				    {
				        OpenActivity = war_act;
				        ActReg = open;
				        PlayersInAct[war_act] = 0;
						GameTextForAll("~b~] ~g~~h~ACTIVITY: ~w~/actjoin ~b~]",3000,3);
                        PlaySoundForAll(1149);
						SendClientMessageToAll(-1,"{b9b9b9}<========= [{e86f32}War Activity - פעילות וואר{b9b9b9}] =========>");
						SendFormatMessageToAll(-1,"{dcdcdc}! {e86f32}War Activity{dcdcdc} פתח את פעילות הוואר {e86f32}%s{dcdcdc} האדמין",GetName(playerid));
						SendClientMessageToAll(-1,"{dcdcdc}! {e86f32}/ActJoin{dcdcdc} - להצטרפות אנא השתמשו בפקודה");
						SendClientMessageToAll(-1,"{dcdcdc}! בהצלחה לכל המשתתפים");
						SendClientMessageToAll(-1,"{b9b9b9}<========= [{e86f32}War Activity - פעילות וואר{b9b9b9}] =========>");
						SendClientMessage(playerid,Yellow,"/ActStart על מנת להתחיל את הפעילות לאחר שנרשמו השתמש בפקודה");
				    }else if(OpenActivity == war_act)
				    {
				        OpenActivity = none;
				        ActReg = close;
				        PlaySoundForAll(errorsound);
				        PlayersInAct[war_act] = 0;
				        ActIsRunning = false;
				        SendFormatMessageToAll(-1,"{e86f32}[War Activity]{b9b9b9} ! סגר את פעילות הוואר {e86f32}%s{b9b9b9} האדמין",GetName(playerid));
				        for(new i;i<Maxp;i++)
				        {
				            if(IsPlayerConnected(i))
				            {
				                if(RegisteredToAct[i] == true)RegisteredToAct[i] = false;
				                if(Area[i] == WarAct)
				                {
									Area[i] = Light;
									ResetPlayerWeapons(i);
									SetPlayerVirtualWorld(i,0);
									SpawnPlayer(i);
				                }
				            }
				        }
				    }else{
						SendClientMessage(playerid,Red,"! יש כבר פעילות קיימת");
						PlayerPlaySound(playerid,errorsound,0,0,0);
						ShowPlayerActDialog(playerid);
					}
				}
				case 2:
				{
				    if(OpenActivity == none)
				    {
				        OpenActivity = kart_act;
				        ActReg = open;
				        PlayersInAct[kart_act] = 0;
						GameTextForAll("~b~] ~g~~h~ACTIVITY: ~w~/actjoin ~b~]",3000,3);
                        PlaySoundForAll(1149);
						SendClientMessageToAll(-1,"{b9b9b9}<========= [{ebf51b}Kart Activity - פעילות וואר{b9b9b9}] =========>");
						SendFormatMessageToAll(-1,"{dcdcdc}! {ebf51b}Kart Activity{dcdcdc} פתח את פעילות מירוץ הקארטינג {ebf51b}%s{dcdcdc} האדמין",GetName(playerid));
						SendClientMessageToAll(-1,"{dcdcdc}! {ebf51b}/ActJoin{dcdcdc} - להצטרפות אנא השתמשו בפקודה");
						SendClientMessageToAll(-1,"{dcdcdc}! בהצלחה לכל המשתתפים");
						SendClientMessageToAll(-1,"{b9b9b9}<========= [{ebf51b}Kart Activity - פעילות וואר{b9b9b9}] =========>");
                        SendClientMessage(playerid,Yellow,"/ActStart על מנת להתחיל את הפעילות לאחר שנרשמו השתמש בפקודה");
					}else if(OpenActivity == kart_act)
				    {
				        OpenActivity = none;
				        ActReg = close;
				        PlaySoundForAll(errorsound);
				        PlayersInAct[kart_act] = 0;
				        ActIsRunning = false;
				        SendFormatMessageToAll(-1,"{ebf51b}[Kart Activity]{b9b9b9} ! סגר את פעילות מירוץ הקארטינג {ebf51b}%s{b9b9b9} האדמין",GetName(playerid));
				        for(new i;i<Maxp;i++)
				        {
				            if(IsPlayerConnected(i))
				            {
				                if(RegisteredToAct[i] == true)RegisteredToAct[i] = false;
				                if(Area[i] == KartAct)
				                {
				                    //DisableRemoteVehicleCollisions(i,false);
				                    DisablePlayerRaceCheckpoint(i);
				                    DestroyVehicle(GetPlayerVehicleID(i));
				                    SetPlayerVirtualWorld(i,0);
									Area[i] = Light;
									ResetPlayerWeapons(i);
									SpawnPlayer(i);
				                }
				            }
				        }
				    }else{
						SendClientMessage(playerid,Red,"! יש כבר פעילות קיימת");
						PlayerPlaySound(playerid,errorsound,0,0,0);
						ShowPlayerActDialog(playerid);
					}
				}
	        }
	    }
	}
	if(dialogid == Dialog_Radio)
	{
	    if(!response)return 0;
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0:PlayAudioStreamForPlayer(playerid,"https://ilm-stream11.radiohost.de/ilm_iloveradio_mp3-192") && SendClientMessage(playerid,Gray,"/MOff על מנת להפסיק להאזין השתמש בפקודה");
                case 1:PlayAudioStreamForPlayer(playerid,"https://ilm.stream35.radiohost.de/ilm_ilovenewpop_mp3-192") && SendClientMessage(playerid,Gray,"/MOff על מנת להפסיק להאזין השתמש בפקודה");
                case 2:PlayAudioStreamForPlayer(playerid,"https://ilm-stream11.radiohost.de/ilm_ilovemusicandchill_mp3-192") && SendClientMessage(playerid,Gray,"/MOff על מנת להפסיק להאזין השתמש בפקודה");
                case 3:PlayAudioStreamForPlayer(playerid,"https://ilm-stream12.radiohost.de/ilm_iloveradiorock_mp3-192") && SendClientMessage(playerid,Gray,"/MOff על מנת להפסיק להאזין השתמש בפקודה");
                case 4:PlayAudioStreamForPlayer(playerid,"https://ilm-stream12.radiohost.de/ilm_ilovehiphop_mp3-192") && SendClientMessage(playerid,Gray,"/MOff על מנת להפסיק להאזין השתמש בפקודה");
                case 5:PlayAudioStreamForPlayer(playerid,"https://ilm.stream35.radiohost.de/ilm_ilovethesun_mp3-192") && SendClientMessage(playerid,Gray,"/MOff על מנת להפסיק להאזין השתמש בפקודה");
                case 6:PlayAudioStreamForPlayer(playerid,"https://ilm-stream11.radiohost.de/ilm_ilove2000throwbacks_mp3-192") && SendClientMessage(playerid,Gray,"/MOff על מנת להפסיק להאזין השתמש בפקודה");
                case 7:PlayAudioStreamForPlayer(playerid,"https://mzr.mediacast.co.il/mzradio") && SendClientMessage(playerid,Gray,"/MOff על מנת להפסיק להאזין השתמש בפקודה");
			}
	    }
	}
	if(dialogid == Dialog_Showpass2)
	{
	    if(!response || response)return ShowPlayerSettingsDialog(playerid);
	}
	if(dialogid == Dialog_Changepass)
	{
	    if(!response)return ShowPlayerSettingsDialog(playerid);
	    if(response)
	    {
	        cmd_changepass(playerid,inputtext);
	        ShowPlayerChangepassDialog(playerid);
	    }
	}
	if(dialogid == Dialog_Texthit)
	{
		if(!response)return ShowPlayerRPanelDialog(playerid);
		if(response)
		{
		    switch(listitem)
		    {
		        case 0: // הפעל
		        {
		            if(TextHit == 1)
		            {
		                ShowPlayerTexthitDialog(playerid);
						SendClientMessage(playerid,Red,"! טקסט פגיעה כבר מופעל");
						PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
		            }else{
				        DOF2_SetInt("RconOptions/Settings.ini","TextHit",1);
				        DOF2_SaveFile();
						TextHit = 1;
						PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
						SendFormatMessageToAll(Yellow,"! הפעיל טקסט פגיעה בשרת %s האדמין",GetName(playerid));
                        ShowPlayerRPanelDialog(playerid);
					}
				}
				case 1:// כבה
				{
				    if(TextHit == 0)
				    {
		                ShowPlayerTexthitDialog(playerid);
						SendClientMessage(playerid,Red,"! טקסט פגיעה כבר כבוי");
						PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
				    }else{
				        DOF2_SetInt("RconOptions/Settings.ini","TextHit",0);
				        DOF2_SaveFile();
						TextHit = 0;
						PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
						SendFormatMessageToAll(Yellow,"! כיבה טקסט פגיעה בשרת %s האדמין",GetName(playerid));
                        ShowPlayerRPanelDialog(playerid);
					}
				}
		    }
		}
	}
	if(dialogid == Dialog_Hitsound)
	{
	    if(!response)return ShowPlayerSettingsDialog(playerid);
		if(response)
		{
			switch(listitem)
		    {
		        case 0:
		        {
					if(HitSound[playerid] == 1)
					{
					    PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
					    ShowPlayerHitsoundDialog(playerid);
					    SendClientMessage(playerid,Red,"! צליל פגיעה כבר מופעל אצלך");
					}else{
						cmd_hitsound(playerid,"1");
						ShowPlayerHitsoundDialog(playerid);
						PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
					}
		        }
		        case 1:
				{
					if(HitSound[playerid] == 0)
					{
					    PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
					    ShowPlayerHitsoundDialog(playerid);
					    SendClientMessage(playerid,Red,"! צליל פגיעה כבר כבוי אצלך");
					}else{
						cmd_hitsound(playerid,"0");
						ShowPlayerHitsoundDialog(playerid);
						PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
					}
				}
		    }
	    }
	}
	if(dialogid == Dialog_Settings)
	{
	    if(response)
	    {
			switch(listitem)
			{
			    case 0: //Hit Sound
			    {
					ShowPlayerHitsoundDialog(playerid);
					PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
			    }
			    case 1:
				{
				    ShowPlayerChangepassDialog(playerid);
				    PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
				case 2:
				{
				    ShowPlayerShowpass2Dialog(playerid);
				    PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
				case 3:
				{
					ShowPlayerSettingsDialog(playerid);
					PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
				}
				case 4:
				{
				    ShowPlayerChangenickDialog(playerid);
				    PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}

			}
		}
	}
	if(dialogid == Dialog_Login)
	{
	    if(!response)
	    {
	        PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
		    ShowPlayerLoginDialog(playerid);
		    SendClientMessage(playerid,Red,"/Quit אתה מחוייב להתחבר מחדש למשתמש לפני שתוכל להמשיך לשחק, אם ברצונך לצאת השתמש בפקודה");
	    }else{
	        if(strcmp(inputtext,DOF2_GetString(pFile(playerid),"Password"),false) || strlen(inputtext) < 3)
			{
                PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
				ShowPlayerLoginDialog(playerid);
				SendClientMessage(playerid,Red,"! הסיסמה שהקלדת שגויה");
			}else{
				Admin[playerid] = DOF2_GetInt(pFile(playerid),"Admin");
				if(Admin[playerid] > 0)ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{00ff00}! ברוכים הבאים","{ffff00}.התחברת אוטומטית למערכת האדמינים\n{ffff00}/AHelp - השתמש בפקודה על מנת לקבל עזרה","אישור","ביטול");
				LoggedIn[playerid] = true;
				DOF2_SetString(pFile(playerid),"IP",GetIp(playerid));
				DOF2_SetString("RconOptions/IPList.ini", GetIp(playerid), GetName(playerid));
				DOF2_SaveFile();
				HitSound[playerid] = DOF2_GetInt(pFile(playerid),"HitSound");
				SendFormatMessageToAll(Lightgreen,"** %s has joined the server !",GetName(playerid));
				SendClientMessage(playerid,Lightgreen,"! התחברת למשתמש והאייפי החדש שלך נשמר");
                PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
			}
		}
	}
	if(dialogid == Dialog_Register)
	{
		if(!response)
		{
		    PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
		    ShowPlayerRegisterDialog(playerid);
		    SendClientMessage(playerid,Red,"/Quit אתה מחוייב להרשם לפני שתתחיל לשחק, אם ברצונך לצאת הקלד");
		}else{
			if(strlen(inputtext) < 3)
			{
			    PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
			    ShowPlayerRegisterDialog(playerid);
			    SendClientMessage(playerid,Red,".הסיסמה חייבת להיות ארוכה יותר מ3 תווים לפחות");
			}else{
                DOF2_CreateFile(pFile(playerid));
                DOF2_SetString(pFile(playerid),"Nickname", GetName(playerid));
                DOF2_SetString(pFile(playerid),"Password", inputtext);
		        DOF2_SetInt(pFile(playerid),"Admin", 0);
		        DOF2_SetInt(pFile(playerid),"HitSound", 1);
		        DOF2_SetString(pFile(playerid),"IP",GetIp(playerid));
		        DOF2_SetString(pFile(playerid),"Tag","x");
		        new PlusOne = 1 + DOF2_GetInt("RconOptions/Settings.ini","RegisteredPlayers");
		        DOF2_SetInt("RconOptions/Settings.ini","RegisteredPlayers",PlusOne);
		        DOF2_SaveFile();
		        SendFormatMessageToAll(Lightgreen,"** %s has {00d900}registered {00ff00}to the server !",GetName(playerid));
		        LoggedIn[playerid] = true;
				PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		        SendClientMessage(playerid,Lightgreen,".על מנת לחקור את המוד במלואו /Help נרשמת בהצלחה לשרת, מומלץ להשתמש בפקודה");
				if(FakeUser[playerid] != 1)
				{
	  				DOF2_SetString("RconOptions/IPList.ini", GetIp(playerid), GetName(playerid));
					DOF2_SaveFile();
				}
			}
		}
	}
	if (dialogid == Dialog_Titansetpass)
	{
		if(!response)return ShowPlayerTitanpanelDialog(playerid);
		if(response)
		{
  			cmd_titanpass(playerid,inputtext);
   			ShowPlayerTitanpanelDialog(playerid);
   			//PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
		}
	    return 1;
	}
	if (dialogid == Dialog_Cdedit)
	{
		if(!response)return ShowPlayerRPanelDialog(playerid);
		if(response)
		{
  			cmd_cdedit(playerid,inputtext);
   			ShowPlayerCDeditDialog(playerid);
   			//PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
		}
		return 1;
	}
	if (dialogid == Dialog_Titanpanel)
	{
		if(!response)return ShowPlayerRPanelDialog(playerid);
		switch(listitem)
		{
			case 0:
			{
			    ShowPlayerTitansetpassDialog(playerid);
			    PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
			}
			case 1:
			{
				ShowPlayerTitanpanelDialog(playerid);
			}
		}
		return 1;
	}
	if(dialogid == Dialog_Fulledit)
	{
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0:
	            {
	                cmd_fulledit(playerid,"1");
	                ShowPlayerFulleditDialog(playerid);
	                //PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
	            }
	            case 1:
	            {
	                cmd_fulledit(playerid,"0");
	                ShowPlayerFulleditDialog(playerid);
	                //PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
	            }
	        }
	    }else{
	        ShowPlayerRPanelDialog(playerid);
		}
	}
	if(dialogid == Dialog_Killfull)
	{
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0:
	            {
	                cmd_killfull(playerid,"1");
	                ShowPlayerKillfullDialog(playerid);
	                //PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
	            }
	            case 1:
	            {
	                cmd_killfull(playerid,"0");
	                ShowPlayerKillfullDialog(playerid);
	                //PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
	            }
	        }
	    }else{
	        ShowPlayerRPanelDialog(playerid);
		}
	}
	if(dialogid == Dialog_Pec)
	{
	    if(response)
	    {
	        switch(listitem)
	        {
	            case 0:
	            {
	                cmd_pec(playerid,"1");
	                ShowPlayerPecDialog(playerid);
	                //PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
	            }
	            case 1:
	            {
	                cmd_pec(playerid,"0");
	                ShowPlayerPecDialog(playerid);
	                //PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
	            }
	        }
	    }else{
	        ShowPlayerRPanelDialog(playerid);
		}
	}
    if(dialogid == Dialog_RPanel)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
					//ShowPlayerDialog(playerid,Dialog_Fulledit,DIALOG_STYLE_LIST,"Full Edit - פאנל רקון","{ffff00}אפשר\n{ff0000}בטל","אישור","חזור");
                    ShowPlayerFulleditDialog(playerid);
                    PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
                case 1:
                {
                    //ShowPlayerDialog(playerid,Dialog_Automessage,DIALOG_STYLE_LIST,"AutoMessage - פאנל רקון","{ffff00}אפשר\n{ff0000}בטל","אישור","חזור");
                    ShowPlayerKillfullDialog(playerid);
                    PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
                case 2:
                {
                    //ShowPlayerDialog(playerid,Dialog_Pec,DIALOG_STYLE_LIST,"Pec - פאנל רקון","{ffff00}אפשר\n{ff0000}בטל","אישור","חזור");
					ShowPlayerPecDialog(playerid);
					PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
                case 3:
                {
                    //ShowPlayerDialog(playerid,Dialog_Cdedit,DIALOG_STYLE_INPUT,"CDEdit - פאנל רקון","אנא הכנס מספר שניות לספירה\nמספר השניות חייב להיות בין 3 ל15","אישור","חזור");
					ShowPlayerCDeditDialog(playerid);
					PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
                case 4:
                {
                	//format(str,sizeof(str),"TitanPass - שינוי סיסמה למערכת קלאן טייטן\n%s :הסיסמה הנוכחית למערכת קלאן טייטן",TitanCode);
                    //ShowPlayerDialog(playerid,Dialog_Titanpanel,DIALOG_STYLE_LIST,"Titan System - פאנל רקון",str,"אישור","חזור");
                    ShowPlayerTitanpanelDialog(playerid);
                    PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
				case 5:
				{
                    ShowPlayerTexthitDialog(playerid);
                    PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
           	}
        }
    }
    if(dialogid == Dialog_Teams)
    {
        if(response) // ????? ?? ????? ??? ?? "Select"
        {
            switch(listitem)
            {
                case 0:
                {
               		//SetPlayerTeam(playerid,1); // A
                	SendClientMessage(playerid,0xFF0000FF, "{ffffff}! {00ebf3}A {ffffff}עברת לקבוצה");
    				if(LoggedToTitan[playerid] != 1)SetPlayerColor(playerid,TeamAColor);
    				Team[playerid] = A;
    				//SetPlayerTeam(playerid,A);
    				PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
                    if(Area[playerid] == 1)
                    {
						if(IsPlayerInAnyVehicle(playerid))
						{
					    	new vehicleid = GetPlayerVehicleID(playerid);
 							SetVehiclePos(vehicleid, 1137.2332,1335.9259,10.8203);
    						SetPlayerPos(playerid,1137.2332,1335.9259,10.8203);
							PutPlayerInVehicle(playerid, vehicleid, 0);
							SetVehicleZAngle(vehicleid, 179.2149);
						}else{
                        	SetPlayerPos(playerid,1137.2332,1335.9259,10.8203) && SetPlayerFacingAngle(playerid,179.2149);
						}
					}else if(Area[playerid] == AP)
					{
						//1320.6469,1375.3042,10.8203,179.3954 A SPAWN
						//1320.3190,1309.4552,10.8203,357.7778 B SPAWN
						if(IsPlayerInAnyVehicle(playerid))
						{
					    	new vehicleid = GetPlayerVehicleID(playerid);
 							SetVehiclePos(vehicleid, 1320.6469,1375.3042,10.8203);
    						SetPlayerPos(playerid,1320.6469,1375.3042,10.8203);
							PutPlayerInVehicle(playerid, vehicleid, 0);
							SetVehicleZAngle(vehicleid, 179.3954);
						}else{
                        	SetPlayerPos(playerid,1320.6469,1375.3042,10.8203) && SetPlayerFacingAngle(playerid,179.3954);
						}
					}else if(Area[playerid] == WH)return SetPlayerPos(playerid,1411.8306,-19.3712,1000.9240) && SetPlayerFacingAngle(playerid,90.8042);
					else if(Area[playerid] == BR)return SetPlayerPos(playerid,-1458.1985,995.3450,1024.8131) && SetPlayerFacingAngle(playerid,269.8115);
		//-1458.1985,995.3450,1024.8131,269.8115 a
		//-1398.2206,994.9816,1024.0901,88.3741 b
					else{
						SpawnPlayer(playerid);
					}
                }
//==============================================================================
                case 1:
                {
                    //SetPlayerTeam(playerid,2); // B
                    SendClientMessage(playerid,0x0080FFFF, "{ffffff}! {e60000}B {ffffff}עברת לקבוצה");
                    if(LoggedToTitan[playerid] != 1)SetPlayerColor(playerid,TeamBColor);
        			Team[playerid] = B;
        			//SetPlayerTeam(playerid,B);
        			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
					if(Area[playerid] == 1)
					{
						if(IsPlayerInAnyVehicle(playerid))
						{
					    	new vehicleid = GetPlayerVehicleID(playerid);
							SetVehiclePos(vehicleid, 1137.2517,1235.1417,10.8203);
    						SetPlayerPos(playerid,1137.2517,1235.1417,10.8203);
							PutPlayerInVehicle(playerid, vehicleid, 0);
							SetVehicleZAngle(vehicleid, 359.0700);
						}else{
                        	SetPlayerPos(playerid,1137.2517,1235.1417,10.8203) && SetPlayerFacingAngle(playerid,359.0700);
						}
					}else if(Area[playerid] == AP)
					{
						//1320.6469,1375.3042,10.8203,179.3954 A SPAWN
						//1320.3190,1309.4552,10.8203,357.7778 B SPAWN
						if(IsPlayerInAnyVehicle(playerid))
						{
					    	new vehicleid = GetPlayerVehicleID(playerid);
 							SetVehiclePos(vehicleid, 1320.3190,1309.4552,10.8203);
    						SetPlayerPos(playerid,1320.3190,1309.4552,10.8203);
							PutPlayerInVehicle(playerid, vehicleid, 0);
							SetVehicleZAngle(vehicleid, 357.7778);
						}else{
                        	SetPlayerPos(playerid,1320.3190,1309.4552,10.8203) && SetPlayerFacingAngle(playerid,357.7778);
						}
					}else if(Area[playerid] == WH)return SetPlayerPos(playerid,1365.4437,-20.2236,1000.9219) && SetPlayerFacingAngle(playerid,269.0927);
					else if(Area[playerid] == BR)return SetPlayerPos(playerid,-1398.2206,994.9816,1024.0901) && SetPlayerFacingAngle(playerid,88.3741);
					//-1458.1985,995.3450,1024.8131,269.8115 a
					//-1398.2206,994.9816,1024.0901,88.3741 b
					else{
						SpawnPlayer(playerid);
					}
                }
            }
        }
        return 1;
    }
	//daa520
	if (dialogid == Dialog_Titan)
	{
		if(!response)return 0;
		if(strlen(inputtext) != strlen(TitanCode))
		{
		    ShowPlayerDialog(playerid,Dialog_Titan ,DIALOG_STYLE_INPUT,"{daa520}Titan Clan System",":אנא הכנס סיסמת מערכת","התחבר","ביטול");
		    SendClientMessage(playerid,Red,"! הסיסמה שהקלדת שגויה");
		}else{
		    SendFormatMessageToAll(TitanGold,"[TITAN]{cacaca} ! Titan התחבר אל מערכת קלאן %s השחקן",GetName(playerid));
			LoggedToTitan[playerid] = 1;
			SetPlayerColor(playerid,TitanGold);
		}
		return 1;
	}
	if(dialogid == Dialog_Changenick)
	{
	    if(!response)return ShowPlayerSettingsDialog(playerid);
	    if(strlen(inputtext) < 3 || strlen(inputtext) > MAX_PLAYER_NAME)
	    {
	    	ShowPlayerChangenickDialog(playerid);
	    	PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
			SendClientMessage(playerid, Red, "! הניק שבחרת קצר או ארוך מידי");
			return 1;
	    }
	    if(strcmp(inputtext,oldname[playerid],false) == 0)
	    {
	    	ShowPlayerChangenickDialog(playerid);
	    	PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
			SendClientMessage(playerid, Red, "! הניק שבחרת זהה לניק הנוכחי שלך");
			return 1;
	    }
	    format(str,sizeof(str),"%s.ini",inputtext);
	    if(DOF2_FileExists(str))
	    {
	    	ShowPlayerChangenickDialog(playerid);
	    	PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
			SendFormatMessage(playerid, Red, "! %s כבר קיים שחקן העונה לשם",inputtext);
			return 1;
	    }
		for(new i = 0; i < strlen(inputtext); i++)
		{
			if( inputtext[i] == '!' || inputtext[i] == '@' || inputtext[i] == '#' || inputtext[i] == '$' ||
			inputtext[i] == '%' || inputtext[i] == '^' || inputtext[i] == '&' || inputtext[i] == '*' || inputtext[i] == '+' || inputtext[i] == '=' ||
			inputtext[i] == '{' || inputtext[i] == '}' || inputtext[i] == '\\' || inputtext[i] == '|' || inputtext[i] == ':' || inputtext[i] == ';' ||
			inputtext[i] == '"' || inputtext[i] == '\'' || inputtext[i] == '<' || inputtext[i] == '>' ||
			inputtext[i] == ',' || inputtext[i] == '?' || inputtext[i] == '/' || inputtext[i] == '`' || inputtext[i] == '~')
			{
			    ShowPlayerChangenickDialog(playerid);
			    PlayerPlaySound(playerid,4203,0.0,0.0,0.0);
				SendClientMessage(playerid, Red, "! הניק שבחרת מכיל תווים אסורים");
                return 1;
			}
		}
		SendFormatMessageToAll(Yellow,"! %s שינה את הניק במשתמש שלו ל %s השחקן",inputtext,oldname[playerid]);
		new pfile[50];
		format(pfile,MAX_PLAYER_NAME,"%s.ini",oldname[playerid]);
		DOF2_SetString(pfile,"Nickname",inputtext);
		format(str,sizeof(str),"%s.ini",inputtext);
		DOF2_RenameFile(pfile,str);
		DOF2_SetString("RconOptions/IPList.ini",GetIp(playerid),inputtext);
		DOF2_SaveFile();
  		format(oldname[playerid],MAX_PLAYER_NAME,"%s",inputtext);
		SendFormatMessage(playerid,Lightgreen,".אנא התחבר מחדש עם הניק שבחרת ! %s שינית את הניק בשחקן הנוכחי שלך ל",inputtext);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
  		SetPlayerName(playerid,inputtext);
		SetTimerEx("DelayBan",250,false,"u",playerid);
	}
    return 1;
}
//==============================================================================
public CountDown(cd)
{
    format(str,sizeof(str),"~b~~h~%d",cd);
    GameTextForAll(str,1000,3);
    for(new i; i < Maxp; i++)
    PlayerPlaySound(i,1056,0.0,0.0,0.0);
    CDOn = 1;
    if(cd > 0)
    {
        cd--,SetTimerEx("CountDown",1000,0,"%d",cd);
    }else{
        format(str,sizeof(str),"~b~~h~~h~]~g~~h~ Go ~b~~h~~h~]");
        GameTextForAll(str,1000,3);
        for(new i; i < Maxp; i++)
        PlayerPlaySound(i,1057,0.0,0.0,0.0);
        CDOn = 0;
    }
    return 1;
}
forward CDForVirtualWorld(world,cd);
public CDForVirtualWorld(world,cd)
{
    format(str, sizeof(str), "~b~%d", cd);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && GetPlayerVirtualWorld(i) == world)
        {
            GameTextForPlayer(i, str, 1000, 3);
            PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
        }
    }
    if (cd > 0)
    {
        cd--;
        SetTimerEx("CDForVirtualWorld", 1000, 0, "ii", world, cd);
    }else{
        format(str, sizeof(str), "~w~] ~g~~h~Go ~w~]");
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && GetPlayerVirtualWorld(i) == world)
            {
                GameTextForPlayer(i, str, 1000, 3);
                PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
            }
        }
    }
    return 1;
}
//-------------- Stokcs ------------------
stock PlaySoundForAll(soundid)
{
	for(new i;i<Maxp;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        PlayerPlaySound(i,soundid,0,0,0);
	    }
	}
	return 1;
}
stock GivePlayerLightWeapons(playerid)
{
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,26,9999);
	GivePlayerWeapon(playerid,22,9999);
	GivePlayerWeapon(playerid,28,9999);
	return 1;
}
stock SpawnPlayerToB(playerid)
{
    SetPlayerPos(playerid,1137.2517,1235.1417,10.8203) && SetPlayerFacingAngle(playerid,359.0700);
	return 1;
}
stock SpawnPlayerToA(playerid)
{
    SetPlayerPos(playerid,1137.2332,1335.9259,10.8203) && SetPlayerFacingAngle(playerid,179.2149);
	return 1;
}
stock SetPos(playerid,Float:X,Float:Y,Float:Z,Float:F)
{
    SetPlayerPos(playerid,X,Y,Z);
    SetPlayerFacingAngle(playerid,F);
    return 1;
}
stock GetName(playerid)
{
    GetPlayerName(playerid,pName,sizeof(pName));
    return pName;
}
stock fFile(playerid)
{
    new filename[30];
    format(filename,128,"FakeUsers/%s.ini",GetName(playerid));
    return filename;
}
stock pFile(playerid)
{
    new filename[30];
    format(filename,128,"%s.ini",oldname[playerid]);
    return filename;
}
stock ubFile(bannedname[])
{
	new filename[50];
	format(filename,128,"Bans/%s.ini",bannedname);
	return filename;
}
stock bFile(id)
{
    new filename[50];
    format(filename,128,"Bans/%s.ini",GetName(id));
    return filename;
}
stock SpawnPlayerToCw(playerid){
	SetPlayerVirtualWorld(playerid,101);
	new cwrand = random(sizeof(CwViewersSpawns));
	SetPlayerPos(playerid,CwViewersSpawns[cwrand][0],CwViewersSpawns[cwrand][1],CwViewersSpawns[cwrand][2]);
	SetPlayerFacingAngle(playerid,CwViewersSpawns[cwrand][3]);
	ResetPlayerWeapons(playerid);
	return 1;
}
stock SpawnPlayerToSpecCw(playerid){
	SetPlayerVirtualWorld(playerid,101);
	new cwrand = random(sizeof(CwSpecSpawns));
	SetPlayerPos(playerid,CwSpecSpawns[cwrand][0],CwSpecSpawns[cwrand][1],CwSpecSpawns[cwrand][2]);
	SetPlayerFacingAngle(playerid,CwSpecSpawns[cwrand][3]);
	ResetPlayerWeapons(playerid);
	return 1;
}
stock GetIp(playerid)
{
    new ip[50];
    GetPlayerIp(playerid,ip,sizeof(ip));
    return ip;
}
stock GetPlayerFPS(playerid)
{
    SetPVarInt(playerid, "DrunkL", GetPlayerDrunkLevel(playerid));
    if(GetPVarInt(playerid, "DrunkL") < 100)
    {
        SetPlayerDrunkLevel(playerid, 2000);
        SetPVarInt(playerid, "LDrunkL", GetPlayerDrunkLevel(playerid));
        return 0;
    }

    if(GetPVarInt(playerid, "LDrunkL") != GetPVarInt(playerid, "DrunkL"))
    {
        new fps = (GetPVarInt(playerid, "LDrunkL") - GetPVarInt(playerid, "DrunkL"));
        if(fps > 0 && fps < 256)
        {
            SetPVarInt(playerid, "FPS", fps);
        }
        else
        {
            SetPVarInt(playerid, "FPS", 0);
        }

        SetPVarInt(playerid, "LDrunkL", GetPVarInt(playerid, "DrunkL"));
        return GetPVarInt(playerid, "FPS");
    }
    return GetPVarInt(playerid, "FPS");
}
