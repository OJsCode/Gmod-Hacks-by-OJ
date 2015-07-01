// Bp bot 4/25/14 <3
local BP = BP or {};

local hook = hook or {};
local player = player or {};
local team = team or {}; 
local surface = surface;
local file = file;
local render = render;
local cam = cam;
local http = http;
local package = package;
local chat = chat;
local timer = timer;
local string = string;
local vgui = vgui;
local table = table;
local ents = ents;
local gui = gui;
local debug = debug;
local math = math;
local util = util;
local input = input;
local net = net;
local jit = jit;
local MsgC = MsgC;
local engine = engine;
local gameevent = gameevent;
local bit = bit;
local GAMEMODE = GAMEMODE;
local tostring = tostring;
local SortedPairs = SortedPairs;
local aimtarget;
local tonumber = tonumber;
local IsValid = IsValid;
local LocalPlayer = LocalPlayer;
local rawset = rawset;
local Lerp = Lerp;
local RunConsoleCommand = RunConsoleCommand;
local pairs = pairs;
local ipairs = ipairs;
local Angle = Angle;
local print = print;
local next = next; 
local type = type;
local MsgN = MsgN;
local IsFirstTimePredicted = IsFirstTimePredicted;
local Material = Material;
local CreateMaterial = CreateMaterial;
local Msg = Msg; 
local GetConVar = GetConVar;
local RunString = RunString;
local ScrW = ScrW;
local CurTime = CurTime;
local ScrH = ScrH;
local Entity = Entity;
local pcall = pcall;
local Format = Format;
local Color = Color;
local _G = _G;
local Vector = Vector;
local tobool = tobool;
local FindMetaTable = FindMetaTable;
local require = require;
local __eq = __eq;
local __tostring = __tostring;
local __gc = __mul;
local __index = __index;
local __concat = __concat;
local __newindex = __newindex;
local __add = __add;
local __sub = __sub;
local __div  = __div;
local __call = __call;
local __pow = __pow;
local __unm = __unm;
local __lt = __lt;
local __le = __le;
local __mode = __mode;
local __metatable = __metatable;
local MOVETYPE_OBSERVER = MOVETYPE_OBSERVER;
local TEAM_SPECTATOR = TEAM_SPECTATOR;
local KEY_UP, KEY_DOWN, KEY_RIGHT, KEY_LEFT, KEY_INSERT, KEY_F = KEY_UP, KEY_DOWN, KEY_RIGHT, KEY_LEFT, KEY_INSERT, KEY_F;
local MASK_SHOT, CONTENTS_WINDOW = MASK_SHOT, CONTENTS_WINDOW; 

BP['ANG'] = FindMetaTable'Angle';
BP['CMD'] = FindMetaTable'CUserCmd';
BP['VEC'] = FindMetaTable'Vector';
BP['ENT'] = FindMetaTable'Entity';
BP['ply'] = FindMetaTable'Player';
BP['WEP'] = FindMetaTable'Weapon';
BP['MetaVM'] = FindMetaTable'VMatrix';

for i = 0, 1 do 
	print('--------------Credits:-----------------')
	print('	Ari: AA,AAA,Fixmovement help         |')
	print(' cDriza:                              |')
	print('                                      ')
	print('                                      ')
	print('                                      ')
	print('                                      ')
	print('                                      ')
	print('                                      ')
	print('                                      ')
	print('                                      ')
	print('--------------------------------------')
end	

local me = LocalPlayer();

function BP.Message( col, txt )
	chat['AddText']( Color( 200, 50, 50, 255 ),  '[ BP Bot ]: ', col, txt .. '\n' );
	surface['PlaySound']('Resource/warning.wav');
end

bSendPacket = true;

local g = table.Copy(_G);

local e, err = pcall( function() g['require']('dickwrap') end );
g['require']('bsendpacket');
g['require']('pspeed');

if ( err ) then
	dickwrap = {};
	dickwrap.Predict = function( ucmd, ang )
		return ang;
	end
end

local aiming;

function render.Capture()
	return 'deze nutz'
end	

function render.CapturePixels()
	return 'deze nutz'
end

surface.CreateFont('BP', {
        font = 'Console',
        size = 13,
        weight = 900,
        shadow = true,
        antialias = false,
});
 
surface.CreateFont('BP2', {
        font = 'Console',
        size = 13,
        weight = 900,
        shadow = false,
        antialias = false,
});
 
local options = {
        ['Aimbot'] = {
                {
                        {'Aimbot', 20, 20, 350, 240, 120},
                        {'Enabled', 'Checkbox', false, 0},
                        {'Autofire', 'Checkbox', false, 0},
						{'pSilent', 'Checkbox', false, 0},
						{'FOV', 'Slider', 0, 100, 150},
                },
                {
                        {"Target", 20, 280, 350, 180, 120},
                        {"Target Friends", 'Checkbox', false, 0},
						{"Target Team", 'Checkbox', false, 0},
                },
                {
                        {"Accuracy", 380, 20, 350, 190, 120},
                        {"NoSpread", 'Checkbox', false, 0},
                },
                {
                        {"Anti-Aim", 380, 230, 350, 230, 140},
                        {"Enabled", 'Checkbox', false, 0},
						{"Spinbot", 'Checkbox', false, 0},
						{"FakeLag", 'Checkbox', false, 0},
                        {"Max Y", "Slider", 50, 500, 150},
                        {"Min Y", "Slider", 0, 500, 150},
                        {"Min X", "Slider", 50, 500, 150},
                        {"Max X", "Slider", 20, 500, 150},
						{"Speed", "Slider", 20, 100, 150},
						{"Thirdperson D.", "Slider", 20, 100, 150},
						{"Anti-Aim Type", "Slider", 0, 100, 150},
						
                },
        },
        ["Visuals"] = {
                {
                        {"ESP", 20, 20, 350, 240, 220},
                        {"2D Box", "Checkbox", false, 54},
                        {"Name", "Checkbox", false, 54},
                        {"Health", "Checkbox", false, 54},
						{"Healthbar", "Checkbox", false, 54},
                        {"Wep", "Checkbox", false, 54},
						{"Rank", "Checkbox", false, 54},
                        {"Chams", "Checkbox", false, 54},
                },
                {
                        {"Misc.", 380, 20, 350, 190, 220},
                        {"Thirdperson", "Checkbox", false, 54},
						{"BunnyHop", "Checkbox", false, 54},
						{"Crosshair", "Checkbox", false, 54},
                },
        },
        ["Colors"] = {
                {
                        {"Box - Team", 20, 20, 250, 175, 130},
                        {"R", "Slider", 255, 255, 88},
                        {"G", "Slider", 255, 255, 88},
                        {"B", "Slider", 0, 255, 88},
                },
                {
                        {"Box - Enemy", 20, 205, 250, 175, 130},
                        {"R", "Slider", 180, 255, 88},
                        {"G", "Slider", 120, 255, 88},
                        {"B", "Slider", 0, 255, 88},
                },
                {
                        {"Visible R", "Slider", 0, 255, 88},
                        {"Visible G", "Slider", 255, 255, 88},
                        {"Visible B", "Slider", 0, 255, 88},
                        {"Not Visible R", "Slider", 0, 255, 88},
                        {"Not Visible G", "Slider", 0, 255, 88},
                        {"Not Visible B", "Slider", 255, 255, 88},
                },
               
                {
                        {"Visible R", "Slider", 255, 255, 88},
                        {"Visible G", "Slider", 0, 255, 88},
                        {"Visible B", "Slider", 0, 255, 88},
                        {"Not Visible R", "Slider", 180, 255, 88},
                        {"Not Visible G", "Slider", 120, 255, 88},
                        {"Not Visible B", "Slider", 0, 255, 88},
                },
        },
};
 
local order = {
        'Aimbot',
        'Visuals',
        'Colors'
};
 
local function updatevar( men, sub, lookup, new )
        for aa,aaa in next, options[men] do
                for key, val in next, aaa do
                        if(aaa[1][1] != sub) then continue; end
                        if(val[1] == lookup) then
                                val[3] = new;
                        end
                end
        end
end
 
local function loadconfig()
        if(!file.Exists('settings.txt', 'DATA')) then return; end
        local tab = util.JSONToTable( file.Read('settings.txt', 'DATA') );
        local cursub;
        for k,v in next, tab do
            if(!options[k]) then continue; end
                for men, subtab in next, v do
                        for key, val in next, subtab do
                                if(key == 1) then cursub = val[1]; continue; end
                                updatevar(k, cursub, val[1], val[3]);
                        end
                end
        end
end
 
local function gBool(men, sub, lookup)
        if(!options[men]) then return; end
        for aa,aaa in next, options[men] do
                for key, val in next, aaa do
                        if(aaa[1][1] != sub) then continue; end
                        if(val[1] == lookup) then
                                return val[3];
                        end
                end
        end
end
 
local function gOption(men, sub, lookup)
        if(!options[men]) then return ''; end
        for aa,aaa in next, options[men] do
                for key, val in next, aaa do
                        if(aaa[1][1] != sub) then continue; end
                        if(val[1] == lookup) then
                                return val[3];
                        end
                end
        end
        return '';
end
 
local function gInt(men, sub, lookup)
        if(!options[men]) then return 0; end
        for aa,aaa in next, options[men] do
                for key, val in next, aaa do
                        if(aaa[1][1] != sub) then continue; end
                        if(val[1] == lookup) then
                                return val[3];
                        end
                end
        end
        return 0;
end

local curtime = 0;

local function ProperCurTime()
	if !( IsFirstTimePredicted() ) then return; end
		curtime = CurTime();
end

local function Move()
	ProperCurTime();
end	

local function CanFire()
	local wep = BP['ply']['GetActiveWeapon']( me );
	if !BP['ENT']['IsValid']( wep ) then return false; end
	return wep:GetNextPrimaryFire() < curtime;
end

local fa = BP.ENT.EyeAngles(me);

local function Bunnyhop(ucmd)
if (!gBool('Visuals', 'Misc.', 'BunnyHop')) or me:IsTyping() then return; end
    if ( BP['CMD']['KeyDown']( ucmd, 2 ) && !BP['ENT']['IsOnGround']( me ) && BP['ply']['Alive']( me ) ) then	
		 BP['CMD']['RemoveKey']( ucmd, 2 );
	end	
end

local function FixMovement(ucmd, aa)
	local ang = Vector(BP.CMD.GetForwardMove(ucmd), BP.CMD.GetSideMove(ucmd), 0)
	local ang = BP.ANG.Forward((BP.VEC.Angle(BP.VEC.GetNormal(ang)) + (BP.CMD.GetViewAngles(ucmd) - Angle(0, fa.y, 0)))) * BP.VEC.Length(ang)
	BP.CMD.SetForwardMove(ucmd, ang.x);
	BP.CMD.SetSideMove(ucmd, ( aa && ang.y * -1 || ang.y));
end

local cones = {	
	["weapon_smg1"] 	= Vector( -0.04362, -0.04362, -0.04362 ),
	["weapon_ar2"] 		= Vector( -0.02618, -0.02618, 0.02618 ),
	["weapon_shotgun"] 	= Vector( -0.08716, -0.08716, -0.08716 ),
	["weapon_pistol"]	= Vector( -0.01, -0.01, -0.01 ),
};

local sprd = BP.ENT.FireBullets;

local nullcone = Vector() * -1;

function BP.ENT.FireBullets(nigger, data)
	if (nigger != me) then return sprd(nigger, data); end
	local Spread = data.Spread * -1;
	local w = BP.ply.GetActiveWeapon(me);
	if (!w || !BP.ENT.IsValid(w)) then return sprd(nigger, data); end
	local class = BP.ENT.GetClass(w);
	if (cones[class] == Spread) then return sprd(nigger, data); end
	if (Spread == nullcone) then return sprd(nigger, data); end
	cones[class] = Spread;
	return sprd(nigger, data);
end

local function PredictSpread(ucmd, ang)
	local w = BP.ply.GetActiveWeapon(me);
	if (!w || !BP.ENT.IsValid(w)) then return ang; end
	local class = BP.ENT.GetClass(w);
	if (!cones[class]) then return ang; end
	return BP.VEC.Angle(dickwrap.Predict(ucmd, BP.ANG.Forward(ang), cones[class]));
end

local function AAA( pPlayer )
local ang = BP['ENT']['EyeAngles'](pPlayer);
	if ang['p'] == 90 then
		BP['ENT']['SetPoseParameter'](pPlayer, 'aim_pitch', -90 );
	elseif ang['p'] == -90 then
		BP['ENT']['SetPoseParameter'](pPlayer, 'aim_pitch', 90 );
	elseif ang['p'] == -541 then
		BP['ENT']['SetPoseParameter'](pPlayer, 'Fake_Sideways', 541 );
	elseif ang['p'] == -271 then	
		BP['ENT']['SetPoseParameter'](pPlayer, 'ugh', 271 );
	elseif ang['p'] == -181 then
		BP['ENT']['SetPoseParameter'](pPlayer, 'fuk', 181 );
	elseif ang['y'] == -180 then	
		BP['ENT']['SetPoseParameter'](pPlayer, 'fukngr', 180 );
	elseif ang['y'] == -620 then
		BP['ENT']['SetPoseParameter'](pPlayer, 'psfsdce', -620 );	
	end
	if ang.p > 89 then
		BP['ENT']['SetPoseParameter'](pPlayer, "aim_pitch", 270);
	elseif ang.p < -89 then
		BP['ENT']['SetPoseParameter'](pPlayer, "aim_pitch", 90);
	end

	if ang.y >= 0 and ang.y <= 180 then
		BP['ENT']['SetPoseParameter'](pPlayer, "aim_yaw", ang.y + 360);
	end

	BP['ENT']['SetPoseParameter'](pPlayer, "aim_yaw", ang.y - (ang.y / 360) * 360);

	if ang.y  < -180 then
		BP['ENT']['SetPoseParameter'](pPlayer, "aim_yaw", ang.y  + 360);
	elseif ang.y  > 180 then
		BP['ENT']['SetPoseParameter'](pPlayer, "aim_yaw", ang.y  - 360);
	end
end

local function Transform(pos, matrix)
	local matA, matB, matC = matrix[1], matrix[2], matrix[3]
	local x = Vector(matA[1], matA[2], matA[3])
	local y = Vector(matB[1], matB[2], matB[3])
	local z = Vector(matC[1], matC[2], matC[3])
	return Vector( BP['VEC']['Dot'](pos, x) + matA[4], BP['VEC']['Dot'](pos, y) + matB[4], BP['VEC']['Dot'](pos, z) + matC[4] )
end

local function Aimpos(ply)
		local Index = string.find(BP['ENT']['GetModel'](ply), "combine") and 1 or 0
		local Bone = BP['ENT']['GetHitBoxBone'](ply, Index, 0);
		if !BP['ENT']['GetBonePosition'](ply, Bone) then return; end
		local _Matrix = BP['ENT']['GetBoneMatrix'](ply,Bone);
		if !_Matrix then return; end
		_Matrix = BP['MetaVM']['ToTable'](_Matrix);
		local min, max = BP['ENT']['GetHitBoxBounds'](ply, Index, 0);
		return (Transform(min, _Matrix) + Transform(max, _Matrix)) * .5
end

 local function GetAimbotPosition( target )
    for i = 1, target:GetHixBoxCount(0) do
        local hitboxPos = Aimpos(target, i)
        if ( IsVisible(hitbox) ) then
            return hitboxPos
        end
    end
end


local function Valid(ent)
	if (!ent || !BP.ENT.IsValid(ent) || ent == me || BP['ply']['InVehicle']( ent ) || BP.ENT.Health(ent) < 1 || BP.ENT.IsDormant(ent) || BP.ply.Team(ent) == 1002 || (!gBool("Aimbot", "Target", "Target Team") && (BP.ply.Team(ent) == BP.ply.Team(me))) || (!gBool("Aimbot", "Target", "Target Friends") && BP.ply.GetFriendStatus(ent) == "friend") ) then return false; end
	local tr = {
		mask = 1174421507,
		endpos = Aimpos( ent ),
		start = BP['ply']['GetShootPos'](me),
		filter = {me, ent},
	};
	return (util.TraceLine(tr).Fraction == 1);
end

local function GetTarget()
	aimtarget = nil;
	local tblPlayers = player.GetAll();
	local iMaxPlayers = #player.GetAll();
	for i = 0, iMaxPlayers do
	local pPlayer = tblPlayers[i];
		local pEnt = pPlayer;
		if (!Valid(pEnt)) then continue; end
		aimtarget = pEnt;
	end
end

local function pSpeed()
	if input.IsKeyDown(KEY_V) then
		SetSpeed(10)
	else
		SetSpeed(0)
	end
end
local bDelay_AA = 0;

local function Antiaim(ucmd)
	if (!gBool("Aimbot", "Anti-Aim", "Enabled") || BP.CMD.KeyDown(ucmd, 1) || aiming || !me:Alive()) then return; end
	local aam = gInt("Aimbot", "Anti-Aim", "Anti-Aim Type");
	if (aam == 0) then // normal
		local aang = Angle(gInt("Aimbot", "Anti-Aim", "Min X"), gInt("Aimbot", "Anti-Aim", "Min Y"), 0);
		BP.CMD.SetViewAngles(ucmd, aang);
		//BP.CMD.SetButtons(ucmd, bit.bor(ucmd.GetButtons(ucmd), KEY_LCONTROL));
		FixMovement(ucmd);
	elseif(aam == 1) then // jitter
		local aang = Angle(math.random(gInt("Aimbot", "Anti-Aim", "Min X"), gInt("Aimbot", "Anti-Aim", "Max X")), math.random(gInt("Aimbot", "Anti-Aim", "Min Y"), gInt("Aimbot", "Anti-Aim", "Max Y")), 0);
		BP.CMD.SetViewAngles(ucmd, aang);
		//BP.CMD.SetButtons(ucmd, bit.bor(ucmd.GetButtons(ucmd), KEY_LCONTROL));
		FixMovement(ucmd);
	elseif(aam == 2) then // sideways follow
		local aang = Angle(gInt("Aimbot", "Anti-Aim", "Min X"), math.NormalizeAngle(fa.y + 90), 0);
		BP.CMD.SetViewAngles(ucmd, aang);
		//BP.CMD.SetButtons(ucmd, bit.bor(ucmd.GetButtons(ucmd), KEY_LCONTROL));
		FixMovement(ucmd);
	else if (aam == 3 ) then //fake sideways  
			bDelay_AA = bDelay_AA + 1
			if (bDelay_AA < 3) then
				bSendPacket = false;
				fa.p = -541
				fa.y = -620
				fa.r = fa.r
			else 
				fa.p = 541
				fa.y = 720
				fa.r = fa.r
			end
		BP.CMD.SetViewAngles(ucmd, aang);	
	//BP.CMD.SetButtons(ucmd, bit.bor(ucmd.GetButtons(ucmd), KEY_LCONTROL));
	FixMovement(ucmd);
		end
	end
end

local function Aimbot(ucmd)
	fa = fa + Angle(BP.CMD.GetMouseY(ucmd) * .023, BP.CMD.GetMouseX(ucmd) * -.023, 0);
	fa.p = math.Clamp(fa.p, -89, 89);
	fa.x = math.NormalizeAngle(fa.x);
	fa.y = math.NormalizeAngle(fa.y);
	GetTarget();
  if input['IsKeyDown']( KEY_F ) && !me:IsTyping() then
  if ucmd:CommandNumber() == 0 then return end
	if (aimtarget) then
	  AAA(aimtarget)
			aiming = true;
				local predictedShootPos = me:GetShootPos() + ( me:GetVelocity() * (engine.TickInterval()*2) )
				local pos = BP.VEC.Angle(Aimpos(aimtarget) - predictedShootPos);
				if (gBool("Aimbot", "Accuracy", "NoSpread")) then
					pos = PredictSpread(ucmd, pos);
				end
				pos.x = math.NormalizeAngle(pos.x);
				pos.y = math.NormalizeAngle(pos.y);
				BP.CMD.SetViewAngles(ucmd, pos);
				if (gBool("Aimbot", "Aimbot", "Autofire") && CanFire() && aiming) then
					BP.CMD.SetButtons(ucmd, bit.bor(ucmd.GetButtons(ucmd), 1));
				end
				FixMovement(ucmd);
				return;
		end
	end
	aiming = false;
	if( (gBool("Aimbot", "Anti-Aim", "Enabled") || gBool("Aimbot", "Anti-Aim", "Spinbot")) && !BP.CMD.KeyDown(ucmd, 1) ) then return; end
	if (gBool("Aimbot", "Accuracy", "NoSpread") && BP.CMD.KeyDown(ucmd, 1)) then
		local hey = PredictSpread(ucmd, fa);
		hey.x = math.NormalizeAngle(hey.x);
		hey.y = math.NormalizeAngle(hey.y);
		BP.CMD.SetViewAngles(ucmd, hey);
		return
	end
	BP.CMD.SetViewAngles(ucmd, fa);
end

local function Spinbot(ucmd)
	if (!gBool("Aimbot", "Anti-Aim", "Spinbot") || gBool("Aimbot", "Anti-Aim", "Enabled") || BP.CMD.KeyDown(ucmd, 1)) then return; end
	BP.CMD.SetViewAngles(ucmd, Angle(fa.x, BP.CMD.GetViewAngles(ucmd).y + gInt("Aimbot", "Anti-Aim", "Speed"), 0));
	FixMovement(ucmd);
end

local queue = 0;
local function FakeLag(ucmd)
if !gBool("Aimbot", "Anti-Aim", "FakeLag") then return end 
if ucmd:CommandNumber() == 0 then return end
queue = queue + 1
	if queue >= 0 then
		if queue < 15 then
			bSendPacket = false
		else
			bSendPacket = true
		end
	else
		bSendPacket = true
	end
	if queue >= 15 then
		queue = 0
	end
end

local function ESP( ent )
	local pos = BP.ENT.GetPos(ent);
	local pos2 = pos + Vector(0, 0, 70);
	local pos = BP.VEC.ToScreen(pos);
	local pos2 = BP.VEC.ToScreen(pos2);
	local h = pos.y - pos2.y;
	local w = h / 2;
	local col = Color(0,0,0);
	if(gBool("Visuals", "ESP", "2D Box")) then
		surface.SetDrawColor(col);
		surface.DrawOutlinedRect(pos.x - w / 1.5, pos.y - h, w, h);
		surface.DrawOutlinedRect(pos.x - w / 1.5 + 1.5, pos.y - h + 1.5, w - 2.5, h - 2.5);
		local ocol = Color( 0, 255, 0 );
		surface.SetDrawColor(ocol);
		surface.DrawOutlinedRect(pos.x - w / 1.5 - .5, pos.y - h - .5, w + 1.5, h + 1.5);
		surface.DrawOutlinedRect(pos.x - w / 1.5 + .5, pos.y - h + .5, w - 1.5, h - 1.5);
	end
	if(gBool("Visuals", "ESP", "Healthbar")) then
		local bgcol = Color(0, 0, 0);
		surface.SetDrawColor(bgcol);
		surface.DrawRect(pos.x - (w/2) - 7, pos.y - h - 1, 5, h + 2);
		local hp = BP.ENT.Health(ent);
		local col1 = Color(0,255,0);
		surface.SetDrawColor((100 - hp) * 2.55, hp * 2.55, 0);
		local hp = hp * h / 100;
		local diff = h - hp;
		surface.DrawRect(pos.x - (w / 2) - 6, pos.y - h + diff, 3, hp);
	end
	local hh = 0;
	if(gBool("Visuals", "ESP", "Name")) then
		local col1 = Color(0,200,0);
			draw.SimpleText(BP.ply.Name(ent), "BudgetLabel", pos.x + (w/2) + 5, pos.y - h + 3 + hh, col1, 0, 1);
			//hh = hh + 10;
	end
	if(gBool("Visuals", "ESP", "Health")) then
		hh = hh + 10;
		local col1 = Color((100 - BP.ENT.Health(ent)) * 2.55, BP.ENT.Health(ent) * 2.55, 0);
			draw.SimpleText("H:"..BP.ENT.Health(ent), "BudgetLabel", pos.x, pos.y - 2, col1, 1, 0);
	end
	if(gBool("Visuals", "ESP", "Distance")) then
		local col = Color(255,210,255);
			draw.SimpleText("D:"..math.ceil(BP.VEC.Distance(BP.ENT.GetPos(ent), BP.ENT.GetPos(me))), "BudgetLabel", pos.x, pos.y - 2 + hh, col, 1, 0);
		hh = hh + 10;
	end
	if(gBool("Visuals", "ESP", "Rank")) then
		local col = Color(170,0,170);
			draw.SimpleText( "R:"..BP.ply.GetUserGroup( ent ), "BudgetLabel", pos.x, pos.y - 2 + hh, col, 1, 0 );
			hh = hh + 10;
	end
	if(gBool("Visuals", "ESP", "Wep")) then
		local col = Color(170,0,170);
			draw.SimpleText( "W:"..BP.ENT.GetClass( BP.ply.GetActiveWeapon( ent ) ), "BudgetLabel", pos.x, pos.y - 2 + hh, col, 1, 0 );
	end
end

local function DrawCrosshair()
	if(!gBool("Visuals", "Misc.", "Crosshair")) then return; end
	surface['SetDrawColor']( Color( 0, 255, 0 ) );
    local x = ScrW() / 2;
    local y = ScrH() / 2;
    local i = 0;
    for i = 0, 1 do
        surface['DrawLine']( x + 9 + i, y, x, y );
        surface['DrawLine']( x - 9 - i, y, x, y );
        surface['DrawLine']( x, y + 9 + i, x, y );
        surface['DrawLine']( x, y - 9 - i, x, y );
	end
end

local function DrawOverlay()
	local tblPlayers = player.GetAll();
	local iMaxPlayers = #player.GetAll();
	for i = 0, iMaxPlayers do
	local pPlayer = tblPlayers[i];
		if (!pPlayer || !BP.ENT.IsValid(pPlayer) || pPlayer == me || BP.ENT.Health(pPlayer) < 1) then continue; end
		ESP(pPlayer);
	end
	DrawCrosshair();
end

local function CalcView(p, o, a, f)
	local view = {}
	view.origin = (gBool("Visuals", "Misc.", "Thirdperson") && o - (BP.ANG.Forward(fa) * (gInt("Aimbot", "Anti-Aim", "Thirdperson D.") * 10)) || o);
	view.angles = fa;
	view.fov = f;
	return view;
end

local mat = CreateMaterial("", "VertexLitGeneric", {
	["$basetexture"] = "models/debug/debugwhite", 
	["$model"] = 1, 
	["$ignorez"] = 1,
});

local mat2 = CreateMaterial(" ", "VertexLitGeneric", {
	["$basetexture"] = "models/debug/debugwhite", 
	["$model"] = 1, 
	["$ignorez"] = 0,
});

local function RenderScreenspaceEffects()
	if(!gBool("Visuals", "ESP", "Chams")) then return; end
	local tblPlayers = player.GetAll();
	local iMaxPlayers = #player.GetAll();
	for i = 0, iMaxPlayers do
	local pPlayer = tblPlayers[i];
		if (!pPlayer || !BP.ENT.IsValid(pPlayer) || pPlayer == me || BP.ENT.Health(pPlayer) < 1 || BP.ply.Team(pPlayer) == 1002) then continue; end
		local col = team.GetColor(BP.ply.Team(pPlayer));
		cam.Start3D();
			render.MaterialOverride(mat);
			render.SetColorModulation(col.b / 255, col.r / 255, col.g / 255);
			BP.ENT.DrawModel(pPlayer);
			render.MaterialOverride(mat2);
			render.SetColorModulation(col.r / 255, col.g / 255, col.b / 255);
			BP.ENT.DrawModel(pPlayer);
			render.SetColorModulation(1, 1, 1);
		cam.End3D();
	end
end

local function ShouldDrawLocalPlayer()
	return(gBool("Visuals", "Misc.", "Thirdperson"));
end

local function saveconfig()
    file.Write("settings.txt", util.TableToJSON(options));
end
 
local mousedown;
local candoslider;
local drawlast;
 
local visible = {};
 
for k,v in next, order do
        visible[v] = false;
end
 
local function DrawBackground(w, h)
        surface.SetDrawColor(255, 255, 255);
        surface.DrawRect(0, 0, w, h);
       
        local curcol = Color(182, 0, 0);
       
        for i = 0, 30 do
                surface.SetDrawColor(curcol);
                curcol.r = curcol.r - 1;
                surface.DrawLine(0, i, w, i);
        end
       
        surface.SetDrawColor(curcol);
       
        surface.SetFont("BP");
       
        local tw, th = surface.GetTextSize("Booty Priide Bot");
       
        surface.SetTextPos(5, 15 - th / 2);
       
        surface.SetTextColor(255, 255, 255);
       
        surface.DrawText("Booty Priide Bot");
       
        surface.DrawRect(0, 31, 5, h - 31);
        surface.DrawRect(0, h - 5, w, h);
        surface.DrawRect(w - 5, 31, 5, h);
end
 
local function MouseInArea(minx, miny, maxx, maxy)
        local mousex, mousey = gui.MousePos();
        return(mousex < maxx && mousex > minx && mousey < maxy && mousey > miny);
end
 
local function DrawOptions(self, w, h)
        local mx, my = self:GetPos();
       
        local sizeper = (w - 10) / #order;
       
        local maxx = 0;
       
        for k,v in next, order do
                local bMouse = MouseInArea(mx + 5 + maxx, my + 31, mx + 5 + maxx + sizeper, my + 31 + 30);
                if(visible[v]) then
                        local curcol = Color(0, 0, 0);
                        for i = 0, 30 do
                                surface.SetDrawColor(curcol);
                                curcol.r, curcol.g, curcol.b = curcol.r + 3, curcol.g + 3, curcol.b + 3;
                                surface.DrawLine( 5 + maxx, 31 + i, 5 + maxx + sizeper, 31 + i);
                        end
                elseif(bMouse) then
                        local curcol = Color(124, 124, 124);
                        for i = 0, 30 do
                                surface.SetDrawColor(curcol);
                                curcol.r, curcol.g, curcol.b = curcol.r - 1.7, curcol.g - 1.7, curcol.b - 1.7;
                                surface.DrawLine( 5 + maxx, 31 + i, 5 + maxx + sizeper, 31 + i);
                        end
                else
                        local curcol = Color(51, 51, 51);
                        for i = 0, 30 do
                                surface.SetDrawColor(curcol);
                                curcol.r, curcol.g, curcol.b = curcol.r - 1.7, curcol.g - 1.7, curcol.b - 1.7;
                                surface.DrawLine( 5 + maxx, 31 + i, 5 + maxx + sizeper, 31 + i);
                        end
                end
                if(bMouse && input.IsMouseDown(MOUSE_LEFT) && !mousedown && !visible[v]) then
                        local nb = visible[v];
                        for key,val in next, visible do
                                visible[key] = false;
                        end
                        visible[v] = !nb;
                end
                surface.SetFont("BP2");
                surface.SetTextColor(255, 255, 255);
                local tw, th = surface.GetTextSize(v);
                surface.SetTextPos( 5 + maxx + sizeper / 2 - tw / 2, 31 + 15 - th / 2 );
                surface.DrawText(v);
                maxx = maxx + sizeper;
        end
end
 
local function DrawCheckbox(self, w, h, var, maxy, posx, posy, dist)
        surface.SetFont("BP2");
        surface.SetTextColor(0, 0, 0);
        surface.SetTextPos( 5 + posx + 15 + 5, 61 + posy + maxy );
        local tw, th = surface.GetTextSize(var[1]);
        surface.DrawText(var[1]);
       
        surface.SetDrawColor(163, 163, 163);
       
        surface.DrawOutlinedRect( 5 + posx + 15 + 5 + dist + var[4], 61 + posy + maxy + 2, 14, 14);
       
        local mx, my = self:GetPos();
       
        local bMouse = MouseInArea(mx + 5 + posx + 15 + 5, my + 61 + posy + maxy, mx + 5 + posx + 15 + 5 + dist + 14 + var[4], my + 61 + posy + maxy + 16);
       
        if(bMouse) then
                surface.DrawRect( 5 + posx + 15 + 5 + dist + 2 + var[4], 61 + posy + maxy + 4, 10, 10);
        end
       
        if(var[3]) then
                surface.SetDrawColor(184, 0, 0);
                surface.DrawRect( 5 + posx + 15 + 5 + dist + 2 + var[4], 61 + posy + maxy + 4, 10, 10);
                surface.SetDrawColor(93, 0, 0);
                surface.DrawOutlinedRect( 5 + posx + 15 + 5 + dist + 2 + var[4], 61 + posy + maxy + 4, 10, 10);
        end
       
        if(bMouse && input.IsMouseDown(MOUSE_LEFT) && !mousedown && !drawlast) then
                var[3] = !var[3];
        end
end
 
local function DrawSlider(self, w, h, var, maxy, posx, posy, dist)
        local curnum = var[3];
        local max = var[4];
        local size = var[5];
        surface.SetFont("BP2");
        surface.SetTextColor(0, 0, 0);
        surface.SetTextPos( 5 + posx + 15 + 5, 61 + posy + maxy );
        surface.DrawText(var[1]);
       
        local tw, th = surface.GetTextSize(var[1]);
       
        surface.SetDrawColor(163, 163, 163);
       
        surface.DrawRect( 5 + posx + 15 + 5 + dist, 61 + posy + maxy + 9, size, 2);
       
        local ww = math.ceil(curnum * size / max);
       
        surface.SetDrawColor(184, 0, 0);
       
        surface.DrawRect( 3 + posx + 15 + 5 + dist + ww, 61 + posy + maxy + 9 - 5, 4, 12);
       
        surface.SetDrawColor(93, 0, 0);
       
        local tw, th = surface.GetTextSize(curnum..".00");
       
        surface.DrawOutlinedRect( 3 + posx + 15 + 5 + dist + ww, 61 + posy + maxy + 4, 4, 12);
       
        surface.SetTextPos( 5 + posx + 15 + 5 + dist + (size / 2) - tw / 2, 61 + posy + maxy + 16);
       
        surface.DrawText(curnum..".00");
       
        local mx, my = self:GetPos();
       
        local bMouse = MouseInArea(5 + posx + 15 + 5 + dist + mx, 61 + posy + maxy + 9 - 5 + my, 5 + posx + 15 + 5 + dist + mx + size, 61 + posy + maxy + 9 - 5 + my + 12);
       
        if(bMouse && input.IsMouseDown(MOUSE_LEFT) && !drawlast && !candoslider) then
                local mw, mh = gui.MousePos();
       
                local new = math.ceil( ((mw - (mx + posx + 25 + dist - size)) - (size + 1)) / (size - 2) * max);
                var[3] = new;
        end
end
 
local notyetselected;
 
local function DrawSelect(self, w, h, var, maxy, posx, posy, dist)
 
        local size = var[5];
        local curopt = var[3];
       
        surface.SetFont("BP2");
        surface.SetTextColor(0, 0, 0);
        surface.SetTextPos( 5 + posx + 15 + 5, 61 + posy + maxy );
        local tw, th = surface.GetTextSize(var[1]);
        surface.DrawText(var[1]);
       
        surface.SetDrawColor(163, 163, 163);
       
        surface.DrawOutlinedRect( 25 + posx + dist, 61 + posy + maxy, size, 16);
       
        local mx, my = self:GetPos();
       
        local bMouse = MouseInArea( mx + 25 + posx + dist, my + 61 + posy + maxy, mx + 25 + posx + dist + size, my + 61 + posy + maxy + 16)
       
        local check = dist..posy..posx..w..h..maxy;
       
        if(bMouse || notyetselected == check) then
               
                surface.DrawRect(25 + posx + dist + 2, 61 + posy + maxy + 2, size - 4, 12);
               
        end
       
        local tw, th = surface.GetTextSize(curopt);
       
        surface.SetTextPos( 25 + posx + dist + 5, 61 + posy + maxy + 6 - th / 2 + 2);
       
        surface.DrawText(curopt);
       
        if(bMouse && input.IsMouseDown(MOUSE_LEFT) && !drawlast && !mousedown || notyetselected == check) then
                notyetselected = check;
                drawlast = function()
                        local maxy2 = 16;
                        for k,v in next, var[4] do
                                surface.SetDrawColor(163, 163, 163);
                                surface.DrawRect( 25 + posx + dist, 61 + posy + maxy + maxy2, size, 16);
                                local bMouse2 = MouseInArea( mx + 25 + posx + dist, my + 61 + posy + maxy + maxy2, mx + 25 + posx + dist + size, my + 61 + posy + maxy + 16 + maxy2)
                                if(bMouse2) then
                                        surface.SetDrawColor(200, 200, 200);
                                        surface.DrawRect( 25 + posx + dist, 61 + posy + maxy + maxy2, size, 16);
                                end
                                local tw, th = surface.GetTextSize(v);
                                surface.SetTextPos( 25 + posx + dist + 5, 61 + posy + maxy + 6 - th / 2 + 2 + maxy2);
                                surface.DrawText(v);
                                maxy2 = maxy2 + 16;
                                if(bMouse2 && input.IsMouseDown(MOUSE_LEFT) && !mousedown) then
                                        var[3] = v;
                                        notyetselected = nil;
                                        drawlast = nil;
                                        return;
                                end
                        end
                        local bbMouse = MouseInArea( mx + 25 + posx + dist, my + 61 + posy + maxy, mx + 25 + posx + dist + size, my + 61 + posy + maxy + maxy2);
                        if(!bbMouse && input.IsMouseDown(MOUSE_LEFT) && !mousedown) then
                                 notyetselected = nil;
                                 drawlast = nil;
                                 return;
                        end
                end
        end
       
       
end
 
local function DrawSubSub(self, w, h, k, var)
        local opt, posx, posy, sizex, sizey, dist = var[1][1], var[1][2], var[1][3], var[1][4], var[1][5], var[1][6];
       
        surface.SetDrawColor(163, 163, 163);
       
        local startpos = 61 + posy;
       
        surface.SetTextColor(0, 0, 0);
       
        surface.SetFont("BP2");
       
        local tw, th = surface.GetTextSize(opt);
       
        surface.DrawLine( 5 + posx, startpos, 5 + posx + 15, startpos);
       
        surface.SetTextPos( 5 + posx + 15 + 5, startpos - th / 2 );
       
        surface.DrawLine( 5 + posx + 15 + 5 + tw + 5, startpos, 5 + posx + sizex, startpos);
       
        surface.DrawLine( 5 + posx, startpos, 5 + posx, startpos + sizey);
       
        surface.DrawLine(5 + posx, startpos + sizey, 5 + posx + sizex, startpos + sizey );
       
        surface.DrawLine( 5 + posx + sizex, startpos, 5 + posx + sizex, startpos + sizey);
       
        surface.DrawText(opt);
       
        local maxy = 15;
       
        for k,v in next, var do
                if(k == 1) then continue; end
                if(v[2] == "Checkbox") then
                        DrawCheckbox(self, w, h, v, maxy, posx, posy, dist);
                elseif(v[2] == "Slider") then
                        DrawSlider(self, w, h, v, maxy, posx, posy, dist);
                elseif(v[2] == "Selection") then
                        DrawSelect(self, w, h, v, maxy, posx, posy, dist);
                end
                maxy = maxy + 25;
        end
end
 
local function DrawSub(self, w, h)
        for k, v in next, visible do
                if(!v) then continue; end
                for _, var in next, options[k] do
                        DrawSubSub(self, w, h, k, var);
                end
        end
end
 
local function DrawSaveButton(self, w, h)
        local curcol = Color(235, 235, 235);
        local mx, my = self:GetPos();
        local bMouse = MouseInArea(mx + 30, my + h - 50, mx + 30 + 200, my + h - 50 + 30);
        if(bMouse) then
                curcol = Color(200, 200, 200);
        end
        for i = 0, 30 do
                surface.SetDrawColor(curcol);
                surface.DrawLine( 30, h - 50 + i, 30 + 200, h - 50 + i );
                for k,v in next, curcol do
                        curcol[k] = curcol[k] - 2;
                end
        end
        surface.SetFont("BP2");
        surface.SetTextColor(0, 0, 0);
        local tw, th = surface.GetTextSize("Save Configuration");
        surface.SetTextPos( 30 + 100 - tw / 2, h - 50 + 15 - th / 2 );
        surface.DrawText("Save Configuration");
        if(bMouse && input.IsMouseDown(MOUSE_LEFT)) then
                saveconfig();
        end
end
 
local function DrawLoadButton(self, w, h)
        local curcol = Color(235, 235, 235);
        local mx, my = self:GetPos();
        local bMouse = MouseInArea(mx + 250, my + h - 50, mx + 250 + 200, my + h - 50 + 30);
        if(bMouse) then
                curcol = Color(200, 200, 200);
        end
        for i = 0, 30 do
                surface.SetDrawColor(curcol);
                surface.DrawLine( 250, h - 50 + i, 250 + 200, h - 50 + i );
                for k,v in next, curcol do
                        curcol[k] = curcol[k] - 2;
                end
        end
        surface.SetFont("BP2");
        surface.SetTextColor(0, 0, 0);
        local tw, th = surface.GetTextSize("Load Configuration");
        surface.SetTextPos( 250 + 100 - tw / 2, h - 50 + 15 - th / 2 );
        surface.DrawText("Load Configuration");
        if(bMouse && input.IsMouseDown(MOUSE_LEFT)) then
            loadconfig();
        end
end
 
loadconfig();
 
local insertdown2, insertdown, menuopen;
 
local function menu()
        local frame = vgui.Create("DFrame");
        frame:SetSize(800, 600);
        frame:Center();
        frame:SetTitle("");
        frame:MakePopup();
        frame:ShowCloseButton(false);
       
        frame.Paint = function(self, w, h)
                if(candoslider && !mousedown && !drawlast && !input.IsMouseDown(MOUSE_LEFT)) then
                        candoslider = false;
                end
                DrawBackground(w, h);
                DrawOptions(self, w, h);
                DrawSub(self, w, h);
                DrawSaveButton(self, w, h);
                DrawLoadButton(self, w, h);
                if(drawlast) then
                        drawlast();
                        candoslider = true;
                end
                mousedown = input.IsMouseDown(MOUSE_LEFT);
        end
       
        frame.Think = function()
                if (input.IsKeyDown(KEY_INSERT) && !insertdown2) then
                        frame:Remove();
                        menuopen = false;
                        candoslider = false;
                        drawlast = nil;
                end
        end
end

local function Think()
        if (input.IsKeyDown(KEY_INSERT) && !menuopen && !insertdown) then
                menuopen = true;
                insertdown = true;
                menu();
        elseif (!input.IsKeyDown(KEY_INSERT) && !menuopen) then
                insertdown = false;
        end
        if (input.IsKeyDown(KEY_INSERT) && insertdown && menuopen) then
                insertdown2 = true;
        else
                insertdown2 = false;
        end
end 

local function hookCreateMove( ucmd )  
	Bunnyhop(ucmd);
	Aimbot(ucmd);
	Spinbot(ucmd);
	Antiaim(ucmd);
	FakeLag(ucmd);
	pSpeed();
end

local hooks = {};

local null = function() end

local function detour(typ)
	hooks[typ] = {};

	local ofunc = GAMEMODE[typ] || null;

	GAMEMODE[typ] = function(self, ...)

		ofunc(self, ...);

		for k,v in next, hooks[typ] do
			local ret1, ret2, ret3, ret4 = v(...);
			if(ret1) then return ret1, ret2, ret3, ret4; end
		end

	end
end

local function Add(typ, func)
	if(!hooks[typ]) then
		detour(typ);
	end
	hooks[typ][ #hooks[typ] + 1 ] = func;
end

hook.Add('Move', Move);
hook.Add('HUDPaint', DrawOverlay);
hook.Add('CalcView', CalcView);
hook.Add('RenderScreenspaceEffects', RenderScreenspaceEffects);
hook.Add('ShouldDrawLocalPlayer', ShouldDrawLocalPlayer);
hook.Add('CreateMove', hookCreateMove);
hook.Add('Think', Think);

BP['Message']( Color( 0, 255, 0 ), 'BP Bot 2.5 Initialized!' );
