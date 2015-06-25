//DHAK2 Recode and not skidded
//Author: OJDaJuiceMan

/*	Credits:
	me for lots of codens
	Cdriza: Menu
	Ari: Prediction fix
	Razor: Silent Aim
*/

local hook = hook or {};
local player = player or {};
local team = team or {}; 
local surface = surface or {};
local file = file or {};
local render = render or {};
local cam = cam or {};
local http = http or {};
local package = package or {};
local chat = chat or {};
local timer = timer or {};
local string = string or {};
local vgui = vgui or {};
local table = table or {};
local ents = ents or {};
local gui = gui or {};
local debug = debug or {};
local math = math or {};
local util = util or {};
local input = input or {};
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
local jit = jit;
local debug = debug;
local util = util;

function debug.getinfo()
	return { 
		what = "C",
		source = "[C]",
		source_src = "[C]",
		linedefined = -1,
		currentline = -1,
		lastlinedefined = -1,
		short_src = "[C]"
	};
end

	function jit.util.funcinfo()
	   return nil;
	end   
	
	function jit.attach()
		return nil;
	end	

	function jit.util.funcbc()
		return nil;
	end	
	
	function jit.util.funck()
		return nil;
	end

	function jit.util.funcuvname()
		return nil;
	end

	function jit.util.ircalladdr()
		return nil;
	end	
	
	function jit.util.traceexitstub()
		return nil;
	end

	function jit.util.traceinfo()
		return nil;
	end

	function jit.util.traceir()
		return nil;
	end

	function jit.util.tracek()
		return nil;
	end	
	
	function jit.util.tracemc()
		return nil;
	end	
	
	function jit.util.tracesnap()
		return nil;
	end	

	function debug.getupvalue()
		return nil;
	end

	function debug.upvalueid()
		return nil;
	end

	function debug.upvaluejoin()
		return nil;
	end
	
	function debug.getmetatable()
		return nil;
	end	
	
	function debug.getfenv()
		return nil;
	end

local me = LocalPlayer();

surface.CreateFont("nigger", {
	font = "Arial",
	size = 50,

} )

surface.CreateFont("nigger2", {
	font = "Arial",
	size = 20
} )

local DHAK = DHAK or {};

local vars = {};

vars["Aimbot"] = false
vars["NoSpread"] = false
vars["Autoshoot"] = false
vars["IgnoreTeam"] = false
vars["IgnoreFriends"] = false
vars["FOV"] = 180
vars["bhop"] = false
vars["ESP"] = false
vars["AntiAim"] = false
vars["ThirdPerson"] = false
vars["AA"] = false
vars["Crosshair"] = false
vars["FakeLag"] = false
vars["silent"] = true

local ang;

local change = false;

local fa = Angle()

local exc = me:EyeAngles();

local aiming;

local fakeang = Angle();

local fucktac = {
	['Soap drop nigga'] = {
		'https://www.youtube.com/watch?v=gwdPoqPQeeg'
	};
};

function hook.GetTable() //not using hook.add but i like to fuck with people if they pull my hook table
	return fucktac;
end	
 
local curtime = 0;

local function ProperCurTime()
        if(!IsFirstTimePredicted()) then return; end
        curtime = CurTime();
end

local function Move()
	ProperCurTime();
end	

local function CanFire()
    local w = me:GetActiveWeapon();
    if(!w || !w:IsValid()) then return true; end
    return( curtime >= w:GetNextPrimaryFire() );
end

local function Aimpos(target)
    targetBone = target:GetHitBoxBone(0, 0); 
	if !targetBone then return; end
    local min, max = target:GetHitBoxBounds(0, 0);
    return ( target:GetBonePosition( targetBone ) + ( (min + max) / 2 ) );
end

local function AAA(ent)
	local pitch = ent:EyeAngles().p
	local yaw = ent:EyeAngles().y

	if pitch > 89 then
		pitch = -89
	elseif pitch < -89 then
		pitch = 89
	end
	
	if yaw >= 180 then
		yaw = -180
	elseif yaw <= -180 then
		yaw = 180
	end
	
	ent:SetPoseParameter("aim_pitch", pitch);
	ent:SetPoseParameter("aim_yaw", yaw);
	ent:InvalidateBoneCache();
end

local function Valid(ent)
	if (!ent || !ent:IsValid() || ent == me || ent:InVehicle() || ent:Health() < 1 || ent:IsDormant() || ent:Team() == 1002 ) then return false; end
	local tr = {};
		tr.mask = 1174421507
		tr.endpos = Aimpos( ent ) 
		tr.start = me:GetShootPos() 
		tr.filter = {me, ent}
	return (util.TraceLine(tr).Fraction == 1);
end

local function GetNigs()
	aimtarget = nil;
	local tblPlayers = player.GetAll();
	local iMaxPlayers = #player.GetAll();
	for i = 0, iMaxPlayers do
	local pPlayer = tblPlayers[i];
		local pNig = pPlayer;
		if (!Valid(pNig)) then continue; end
		aimtarget = pNig;
	end
end

local function bhoop(ucmd)
if !vars["BunnyHop"] then return; end
    if ( ucmd:KeyDown( 2 ) && !me:IsOnGround() && me:Alive() ) then	
		ucmd:RemoveKey( 2 );
	end	
end	

local function aimboot(ucmd)
	exc = exc + Angle(ucmd:GetMouseY() * .023, ucmd:GetMouseX() * -.023, 0);
	exc.p = math.Clamp(exc.p, -89, 89);
	exc.x = math.NormalizeAngle(exc.x);
	exc.y = math.NormalizeAngle(exc.y);
    GetNigs();
        if (input.IsKeyDown(KEY_F) && aimtarget ) then
		aiming = true;
			AAA(aimtarget);
				local lapPred = me:GetShootPos() + ( me:GetVelocity() * (engine.TickInterval()*2) );
                local pos = (Aimpos(aimtarget) - lapPred):Angle();
				pos.x = math.NormalizeAngle(pos.x);
				pos.y = math.NormalizeAngle(pos.y)
                ucmd:SetViewAngles(pos);
				if vars["Autoshoot"] && CanFire() then	
					ucmd:SetButtons(bit.bor(ucmd:GetButtons(), 1));
				end
			return;				
		end
	aiming = false;
end

local function ESP( ent )
if !vars["ESP"] then return; end
	local pos = ent:GetPos();
	local pos2 = pos + Vector(0, 0, 70);
	local pos = pos:ToScreen();
	local pos2 = pos2:ToScreen();
	local h = pos.y - pos2.y;
	local w = h / 2;
	local col = Color(0,0,0);
	surface.SetDrawColor(col);
	surface.DrawOutlinedRect(pos.x - w / 1.5, pos.y - h, w, h);
	surface.DrawOutlinedRect(pos.x - w / 1.5 + 1.5, pos.y - h + 1.5, w - 2.5, h - 2.5);
	local ocol = Color( 0, 255, 0 );
	surface.SetDrawColor(ocol);
	surface.DrawOutlinedRect(pos.x - w / 1.5 - .5, pos.y - h - .5, w + 1.5, h + 1.5);
	surface.DrawOutlinedRect(pos.x - w / 1.5 + .5, pos.y - h + .5, w - 1.5, h - 1.5);
	local bgcol = Color(0, 0, 0);
	surface.SetDrawColor(bgcol);
	surface.DrawRect(pos.x - (w/2) - 7, pos.y - h - 1, 5, h + 2);
	local hp = ent:Health();
	local col1 = Color(0,255,0);
	surface.SetDrawColor((100 - hp) * 2.55, hp * 2.55, 0);
	local hp = hp * h / 100;
	local diff = h - hp;
	surface.DrawRect(pos.x - (w / 2) - 6, pos.y - h + diff, 3, hp);
	local hh = 0;
	local col1 = Color(0,200,0);
	draw.SimpleText(ent:Name(), "BudgetLabel", pos.x + (w/2) + 5, pos.y - h + 3 + hh, col1, 0, 1);
end

local function DrawCrosshair()
if !vars["Crosshair"] then return; end
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

local function ESPhook()
	local tblPlayers = player.GetAll();
	local iMaxPlayers = #player.GetAll();
	if vars["ESP"] then 
	for i = 0, iMaxPlayers do
	local pPlayer = tblPlayers[i];
	if (!pPlayer || !pPlayer:IsValid() || pPlayer == me || pPlayer:Health(pPlayer) < 1) then continue; end
			ESP(pPlayer);
		end
	end
	DrawCrosshair();
end

local function ShouldDrawLocalPlayer()
	return(vars["thirdperson"]);
end

local function calcview(ply, pos, angle, fov)

	local view = {
		angles = exc,
		origin = vars["thirdperson"] and pos - exc:Forward() * 100 or pos;
	};

	return view;
end

local menuopen = false
local insert2 = false
function ShowMenu()
	local Menu = vgui.Create("DFrame")
	Menu:SetSize(450,550)
	Menu:Center()
	Menu:MakePopup()
	Menu:SetDraggable(true)
	Menu:ShowCloseButton(false)
	Menu:SetTitle("")
	Menu.Paint = function(self)
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color( 150, 150, 150 ) )
		draw.RoundedBox(0, 0, 0, self:GetWide(), 80, Color(255,192,203))
		draw.SimpleText("DHAK 2", "nigger", 90, 17, Color(255,255,255))
	end

	local AimSheet = vgui.Create("DPropertySheet", Menu)
	AimSheet:SetSize( Menu:GetWide(), 155)
	AimSheet:SetPos( 0, 83 )
	AimSheet.Paint = function(self)
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(255,192,203))
		draw.RoundedBox(0, 0, 0, self:GetWide(), 31, Color(255,120,239))
		draw.SimpleText("Aimbot", "nigger2", 450 / 2 - 30, 6, Color(255,255,255))
	end

	local VisualSheet = vgui.Create("DPropertySheet", Menu)
	VisualSheet:SetSize( Menu:GetWide(), 155)
	VisualSheet:SetPos( 0, 83 * 3 - 8 )
	VisualSheet.Paint = function(self)
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(255,192,203))
		draw.RoundedBox(0, 0, 0, self:GetWide(), 31, Color(255,120,239))
		draw.SimpleText("Visuals", "nigger2", 450 / 2 - 30, 6, Color(255,255,255))
	end

	local MiscSheet = vgui.Create("DPropertySheet", Menu)
	MiscSheet:SetSize( Menu:GetWide(), 155)
	MiscSheet:SetPos( 0, 83 * 5  - 16)
	MiscSheet.Paint = function(self)
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(255,192,203))
		draw.RoundedBox(0, 0, 0, self:GetWide(), 31, Color(255,120,239))
		draw.SimpleText("Misc", "nigger2", 450 / 2 - 26, 6, Color(255,255,255))
	end

	local aimSpread = vgui.Create("DCheckBoxLabel", AimSheet)
	aimSpread:SetPos( 5, 52 )
	aimSpread:SetValue(vars["NoSpread"])
	aimSpread:SetText("Nospread")
	aimSpread:SetDark(1)
	aimSpread:SizeToContents()
	aimSpread.OnChange = function(self)
		vars["NoSpread"] = tobool(self:GetChecked())
	end

	local aimAutoshoot = vgui.Create("DCheckBoxLabel", AimSheet)
	aimAutoshoot:SetPos( 5, 69 )
	aimAutoshoot:SetValue(vars["Autoshoot"])
	aimAutoshoot:SetText("Autoshoot")
	aimAutoshoot:SetDark(1)
	aimAutoshoot:SizeToContents()
	aimAutoshoot.OnChange = function(self)
		vars["Autoshoot"] = tobool(self:GetChecked())
	end

	local aimTeam = vgui.Create("DCheckBoxLabel", AimSheet)
	aimTeam:SetPos(122, 35)
	aimTeam:SetValue(vars["IgnoreTeam"])
	aimTeam:SetText("Ignore Team")
	aimTeam:SetDark(1)
	aimTeam:SizeToContents()
	aimTeam.OnChange = function(self)
		vars["IgnoreTeam"] = tobool(self:GetChecked())
	end

	local aimFriends = vgui.Create("DCheckBoxLabel", AimSheet)
	aimFriends:SetPos(122, 35 + 17)
	aimFriends:SetValue(vars["IgnoreFriends"])
	aimFriends:SetText("Ignore Friends")
	aimFriends:SetDark(1)
	aimFriends:SizeToContents()
	aimFriends.OnChange = function(self)
		vars["IgnoreFriends"] = tobool(self:GetChecked())
	end

	local aimSilent = vgui.Create("DCheckBoxLabel", AimSheet)
	aimSilent:SetPos(122, 35 + 17 + 17)
	aimSilent:SetValue(vars["silent"])
	aimSilent:SetText("SilentAim")
	aimSilent:SetDark(1)
	aimSilent:SizeToContents()
	aimSilent.OnChange = function(self)
		vars["silent"] = tobool(self:GetChecked())
	end

	local aimFOV = vgui.Create("DNumSlider", AimSheet)
	aimFOV:SetMin(5)
	aimFOV:SetMax(180)
	aimFOV:SetDecimals(1)
	aimFOV:SetText("Aim FOV")
	aimFOV:SetValue(vars["Aimbot_fov"])
	aimFOV:SetSize(200, 15)
	aimFOV:SetPos( 240, 35 )
	aimFOV:SetDark(1)
	aimFOV.OnValueChanged = function(self)
		vars["Aimbot_fov"] = tonumber(self:GetValue())
	end

	local visualUser = vgui.Create("DCheckBoxLabel", VisualSheet)
	visualUser:SetPos( 5, 35 )
	visualUser:SetValue(vars["ESP"])
	visualUser:SetText("ESP")
	visualUser:SetDark(1)
	visualUser:SizeToContents()
	visualUser.OnChange = function(self)
		vars["ESP"] = tobool(self:GetChecked())
	end
	
	local visualCrosshair = vgui.Create("DCheckBoxLabel", VisualSheet)
	visualCrosshair:SetPos( 5, 35 + 17 )
	visualCrosshair:SetValue(vars["Crosshair"])
	visualCrosshair:SetText("Crosshair")
	visualCrosshair:SetDark(1)
	visualCrosshair:SizeToContents()
	visualCrosshair.OnChange = function(self)
		vars["Crosshair"] = tobool(self:GetChecked())
	end

	local miscBhop = vgui.Create("DCheckBoxLabel", MiscSheet)
	miscBhop:SetPos( 5, 35 )
	miscBhop:SetValue(vars["BunnyHop"])
	miscBhop:SetText("pBhoop")
	miscBhop:SetDark(1)
	miscBhop:SizeToContents()
	miscBhop.OnChange = function(self)
		vars["BunnyHop"] = tobool(self:GetChecked())
	end

	local miscAntiAim = vgui.Create("DCheckBoxLabel", MiscSheet)
	miscAntiAim:SetPos( 95, 35 + 17 + 17  )
	miscAntiAim:SetValue(vars["AA"])
	miscAntiAim:SetText("AA")
	miscAntiAim:SetDark(1)
	miscAntiAim:SizeToContents()
	miscAntiAim.OnChange = function(self)
		vars["AA"] = tobool(self:GetChecked())
	end
	
	local miscAntiAim = vgui.Create("DCheckBoxLabel", MiscSheet)
	miscAntiAim:SetPos( 95, 35  )
	miscAntiAim:SetValue(vars["FakeLag"])
	miscAntiAim:SetText("FakeLag")
	miscAntiAim:SetDark(1)
	miscAntiAim:SizeToContents()
	miscAntiAim.OnChange = function(self)
		vars["FakeLag"] = tobool(self:GetChecked())
	end

	local miscThirdPerson = vgui.Create("DCheckBoxLabel", MiscSheet)
	miscThirdPerson:SetPos( 95, 35 + 17  )
	miscThirdPerson:SetValue(vars["ThirdPerson"])
	miscThirdPerson:SetText("ThirdPerson")
	miscThirdPerson:SetDark(1)
	miscThirdPerson:SizeToContents()
	miscThirdPerson.OnChange = function(self)
		vars["ThirdPerson"] = tobool(self:GetChecked())
	end

	function Menu:Think()
		if input.IsKeyDown(KEY_INSERT) and !insert2 then
			menuopen = false
			Menu:Close()
		end
	end

end

local insert = false

local function OpenMenu()
	if ( input.IsKeyDown(KEY_INSERT) and !menuopen and !insert ) then
		menuopen = true
		insert = true
		ShowMenu()
	elseif ( !input.IsKeyDown(KEY_INSERT) and !menuopen ) then
		insert = false
	end
	if ( input.IsKeyDown(KEY_INSERT) and insert and menuopen ) then
		insert2 = true
	else
		insert2 = false
	end
end

local function hookMove()
	Move();
end	

local function hookCreateMove(ucmd)
	bhoop(ucmd);
	aimboot(ucmd);
end

local function hookHUDPaint()
	ESPhook();
end

local function hookThink()
	OpenMenu();
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

Add('Move', hookMove);
Add('CreateMove', hookCreateMove);
Add('HUDPaint', hookHUDPaint);
Add('Think', hookThink);
Add('ShouldDrawLocalPlayer', ShouldDrawLocalPlayer);
Add('CalcView', calcview);
