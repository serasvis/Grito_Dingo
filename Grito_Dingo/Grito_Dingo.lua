--[[

fun addon thing

]]--

frame_scale=0.5
frame_x=0
frame_y=350
syncing=true
audio=true
threshold=12
local last_triggered=0
local frame = CreateFrame( "FRAME" )
frame:SetPoint("CENTER",frame_x,frame_y)
frame:SetSize(1024,1024)
frame:SetFrameStrata("tooltip")
frame:SetScale(frame_scale)
local text1=frame:CreateFontString(nil,"OVERLAY","GameFontNormal")
text1:SetFont("Interface\\AddOns\\Grito_Dingo\\TACOM___.ttf", 45)
text1:SetPoint("CENTER",0,-190)
text1:SetText("")
text1:SetTextColor(107/255,177/255,77/255,1)
local text2=frame:CreateFontString(nil,"OVERLAY","GameFontNormal")
text2:SetFont("Interface\\AddOns\\Grito_Dingo\\aAvocadoTaco.ttf", 30)
text2:SetPoint("CENTER",0,-240)
text2:SetText("")
text2:SetTextColor(227/255,127/255,27/255,1)
local mb_index = 0
local ci_index = 1
local show_frame = 1
local start_time = 0
local total_time = 11.2
local mband1 = frame:CreateTexture()
local mband2 = frame:CreateTexture()
local mband3 = frame:CreateTexture()
mband1:SetAllPoints(frame)
mband2:SetAllPoints(frame)
mband3:SetAllPoints(frame)
local cnftti1 = frame:CreateTexture()
local cnftti2 = frame:CreateTexture()
local cnftti3 = frame:CreateTexture()
cnftti1:SetAllPoints(frame)
cnftti2:SetAllPoints(frame)
cnftti3:SetAllPoints(frame)
mband1:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
cnftti1:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
if mb_index==47 then mb_index=0 else mb_index=mb_index+1 end
if ci_index==299 then ci_index=1 else ci_index=ci_index+1 end
mband2:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
cnftti2:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
frame:Hide()
local t_onload = 0
local t_this_lvl = 0

local function updateFrame()
	frame:SetScale(frame_scale)
	frame:SetPoint("CENTER",frame_x,frame_y)
end

local function playSound()
	if audio then
		PlaySoundFile("Interface\\Addons\\Grito_Dingo\\grito_mexicano.ogg", "Master")
	end
end

local function display_GIF()
	if GetTime()-start_time>=total_time then
		mb_index=0
		ci_index=1
		show_frame=1
		mband1:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
		cnftti1:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
		if mb_index==47 then mb_index=0 else mb_index=mb_index+1 end
		if ci_index==299 then ci_index=1 else ci_index=ci_index+1 end
		mband2:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
		cnftti2:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
		frame:Hide()
	else
		if show_frame==1 then
			mband1:Show()
			cnftti1:Show()
			show_frame=2
			C_Timer.After(0.008, function()
				mband3:Hide()
				cnftti3:Hide()
				if mb_index==47 then mb_index=0 else mb_index=mb_index+1 end
				if ci_index==299 then ci_index=1 else ci_index=ci_index+1 end
				mband3:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
				cnftti3:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
				C_Timer.After(0.008, display_GIF)
			end)
		elseif show_frame==2 then
			mband2:Show()
			cnftti2:Show()
			show_frame=3
			C_Timer.After(0.008, function()
				mband1:Hide()
				cnftti1:Hide()
				if mb_index==47 then mb_index=0 else mb_index=mb_index+1 end
				if ci_index==299 then ci_index=1 else ci_index=ci_index+1 end
				mband1:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
				cnftti1:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
				C_Timer.After(0.008, display_GIF)
			end)
		else
			mband3:Show()
			cnftti3:Show()
			show_frame=1
			C_Timer.After(0.008, function()
				mband2:Hide()
				cnftti2:Hide()
				if mb_index==47 then mb_index=0 else mb_index=mb_index+1 end
				if ci_index==299 then ci_index=1 else ci_index=ci_index+1 end
				mband2:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
				cnftti2:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
				C_Timer.After(0.008, display_GIF)
			end)
		end
	end
end

function secondsToDays(inputSeconds)
	local fdays = math.floor(inputSeconds/86400)
	local fhours = math.floor((bit.mod(inputSeconds,86400))/3600)
	local fminutes = math.floor(bit.mod((bit.mod(inputSeconds,86400)),3600)/60)
	local fseconds = math.floor(bit.mod(bit.mod((bit.mod(inputSeconds,86400)),3600),60))
 	if fdays > 0 then
		return fdays.."d "..fhours.."h "..fminutes.."m "..fseconds.."s"
	elseif fhours > 0 then
		return fhours.."h "..fminutes.."m "..fseconds.."s"
	else
 		return fminutes.."m "..fseconds.."s"
	end
end

function onOrOff(b)
	if b then
		return "on"
	else
		return "off"
	end
end

local function findClassColor ( name )
	for i=1,GetNumGuildMembers() do
		local ncheck,_,_,_,_,_,_,_,_,_,class = GetGuildRosterInfo(i)
		if string.sub(ncheck, 1, string.len(name))==name then
			local _,_,_,hex = GetClassColor(class)
			return "|c"..hex
		end
	end
	return "|cff6bb14d"
end

SLASH_GRITO1 = "/grito";	
SlashCmdList["GRITO"] = function(msg)

	if msg=="test" then
		start_time=GetTime()
		frame:Show()
		playSound()
		display_GIF()
		text1:SetText("¡This is a test!")
		text2:SetText("You've been level "..UnitLevel("player").." for "..secondsToDays(t_this_lvl+(GetTime()-t_onload)) )
		text1:SetWidth(text1:GetStringWidth())
		text2:SetWidth(text2:GetStringWidth())
		
	elseif string.sub(msg,1,6)=="scale " then
		local num = tonumber(string.sub(msg,7,-1))
		if num and type(num)=="number" then
			frame_scale = num
			print("scale set to "..num)
			updateFrame()
		else
			print("¡scale input invalid!")
		end

	elseif string.sub(msg,1,2)=="x " then
		local num = tonumber(string.sub(msg,3,-1))
		if num and type(num)=="number" then
			frame_x = num
			print("x set to "..num)
			updateFrame()
		else
			print("¡x input invalid!")
		end

	elseif string.sub(msg,1,2)=="y " then
		local num = tonumber(string.sub(msg,3,-1))
		if num and type(num)=="number" then
			frame_y = num
			print("y set to "..num)
			updateFrame()
		else
			print("¡y input invalid!")
		end		

	elseif msg=="sync on" then
		syncing=true
		print("syncing turned on")

	elseif msg=="sync off" then
		syncing=false
		print("syncing turned off")

	elseif msg=="audio on" then
		audio=true
		print("audio turned on")

	elseif msg=="audio off" then
		audio=false
		print("audio turned off")

	elseif string.sub(msg,1,10)=="threshold " then
		local num = tonumber(string.sub(msg,11,-1))
		if num and type(num)=="number" and math.floor(num)==num then
			threshold=num
			print("threshold set to "..num)
		else
			print("¡threshold input invalid!")
		end

	elseif msg=="default" then
		frame_scale=0.5
		frame_x=0
		frame_y=350
		syncing=true
		audio=true
		threshold=12
		updateFrame()
		print("default settings restored")

	else
		print(" /grito Usage:")
		print(" /grito test - trigger test event")
		print(" /grito scale [num] - (default 0.5; current "..frame_scale..") set frame scale to [num]")
		print(" /grito x [num] - (default x=0; current "..frame_x..") change x axis to [num] pixels from center")
		print(" /grito y [num] - (default y=350; current "..frame_y..") change y axis")
		print(" /grito sync on - (default on; current "..onOrOff(syncing)..") toggle on amigo broadcasts triggering the event")
		print(" /grito sync off - toggle it off >:(")
		print(" /grito audio on - (default on; current "..onOrOff(audio)..") toggle on the mariachi music audio clip")
		print(" /grito audio off - toggle it off >:(")
		print(" /grito threshold [num] - (default 12; current "..threshold..") wait a minimum of [num] seconds before allowing broadcasts to retrigger the event. note: your own level ups are not blocked but do restart this timer")
		print(" /grito default - revert changes to the default settings referenced above")
	end
end

local function EventHandler( self, event, ... )
	
	local arg1,arg2,arg3,arg4 = ...
	local t = GetTime()

	if event == "PLAYER_LEVEL_UP" then
		last_triggered=t
		start_time=t
		local t_to_level = secondsToDays(t_this_lvl+(t-t_onload))
		t_this_lvl=0
		t_onload=t
		text1:SetText("¡You've just reached level "..arg1.."!")
		text2:SetText("You were level ".. arg1-1 .." for "..t_to_level)
		text1:SetWidth(text1:GetStringWidth())
		text2:SetWidth(text2:GetStringWidth())
		frame:Show()
		playSound()
		display_GIF()
		SendChatMessage("¡I just reached level "..arg1..", amigos! Tiempo necesario: "..t_to_level, "GUILD")
		C_ChatInfo.SendAddonMessage("GRITO_BROADCAST", "name="..UnitName("player")..", level="..arg1..", time="..t_to_level, "GUILD")
	end

	if event == "CHAT_MSG_ADDON" and arg1=="GRITO_BROADCAST" and syncing and t-last_triggered > threshold then
		local broadcast = {}
		for k, v in string.gmatch( arg2, "(%w+)=(%w+)" ) do
			broadcast[k] = v
		end
		if broadcast.name~=UnitName("player") then
			last_triggered=t
			start_time=t
			text1:SetText("¡"..findClassColor(broadcast.name)..broadcast.name.."|r just reached level "..broadcast.level.."!")
			text2:SetText("They were level ".. tonumber(broadcast.level)-1 .." for "..broadcast.time)
			text1:SetWidth(text1:GetStringWidth())
			text2:SetWidth(text2:GetStringWidth())
			frame:Show()
			playSound()
			display_GIF()
		end
	end

	if event == "ADDON_LOADED" and arg1=="Grito_Dingo" then
		if not frame_scale then
			frame_scale=0.5
			frame_x=0
			frame_y=350
			syncing=true
			audio=true
			threshold=12
		end
		updateFrame()
		C_ChatInfo.RegisterAddonMessagePrefix("GRITO_BROADCAST")
		RequestTimePlayed()
	end

	if event == "TIME_PLAYED_MSG" then
		t_this_lvl = arg2
		t_onload = GetTime()
	end
end

frame:RegisterEvent( "PLAYER_LEVEL_UP" )
frame:RegisterEvent( "CHAT_MSG_ADDON" )
frame:RegisterEvent( "ADDON_LOADED" )
frame:RegisterEvent( "TIME_PLAYED_MSG" )
frame:SetScript( "OnEvent", EventHandler )
