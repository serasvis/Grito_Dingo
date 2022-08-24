--[[

fun addon thing

]]--

frame_scale=0.5
frame_x=0
frame_y=350
syncing=true
threshold=12
last_triggered=0
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
text2:SetTextColor(177/255,127/255,77/255,1)
local mb_index = 0
local ci_index = 1
local current_frame = 0
local total_frames = 624
local mband1 = frame:CreateTexture()
local mband2 = frame:CreateTexture()
mband1:SetAllPoints(frame)
mband2:SetAllPoints(frame)
local cnftti1 = frame:CreateTexture()
local cnftti2 = frame:CreateTexture()
cnftti1:SetAllPoints(frame)
cnftti2:SetAllPoints(frame)
frame:Hide()
local t_onload = 0
local t_this_lvl = 0

local function updateFrame()
	frame:SetScale(frame_scale)
	frame:SetPoint("CENTER",frame_x,frame_y)
end

local function display_GIF()
	if current_frame==total_frames then
		mb_index=0
		ci_index=1
		current_frame=0
		frame:Hide()
	else
		if mb_index==48 then mb_index=0 end
		if ci_index==300 then ci_index=1 end
		if mband1:IsShown() then
			mband2:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
			cnftti2:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
			mband2:Show()
			cnftti2:Show()
			C_Timer.After(0, function()
				mband1:Hide()
				cnftti1:Hide()
			end)
		else
			mband1:SetTexture("Interface\\AddOns\\Grito_Dingo\\MBAND\\file-"..mb_index..".tga")
			cnftti1:SetTexture("Interface\\AddOns\\Grito_Dingo\\CNFTTI\\file-"..ci_index..".tga")
			mband1:Show()
			cnftti1:Show()
			C_Timer.After(0, function()
				mband2:Hide()
				cnftti2:Hide()
			end)
		end
		mb_index=mb_index+1
		ci_index=ci_index+1
		current_frame=current_frame+1
		C_Timer.After(0.014, display_GIF)
	end
end

function secondsToDays(inputSeconds)
 fdays = math.floor(inputSeconds/86400)
 fhours = math.floor((bit.mod(inputSeconds,86400))/3600)
 fminutes = math.floor(bit.mod((bit.mod(inputSeconds,86400)),3600)/60)
 fseconds = math.floor(bit.mod(bit.mod((bit.mod(inputSeconds,86400)),3600),60))
 return fdays.."d "..fhours.."h "..fminutes.."m "..fseconds.."s"
end

SLASH_GRITO1 = "/grito";	
SlashCmdList["GRITO"] = function(msg)

	if msg=="test" then
		frame:Show()
		PlaySoundFile("Interface\\Addons\\Grito_Dingo\\grito_mexicano.ogg", "master")
		display_GIF()
		text1:SetText("¡This is a test!")
		text2:SetText("You've been level "..UnitLevel("player").." for "..secondsToDays(t_this_lvl+(GetTime()-t_onload)) )
		
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

	elseif msg=="sync off" then
		syncing=false

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
		threshold=12
		updateFrame()
		print("default settings restored")

	else
		print(" /grito Usage:")
		print("Test Event:")
		print(" /grito test - trigger test event")
		print("Frame Scale (Default 0.69):")
		print(" /grito scale [num] - set frame scale to [num]")
		print("Frame Position (Default x=0,y=275):")
		print(" /grito x [num] - change x axis to [num] pixels from center")
		print(" /grito y [num] - change y axis")
		print("Syncing (Default ON):")
		print(" /grito sync on - toggle on amigo broadcasts triggering the event")
		print(" /grito sync off - toggle it off >:(")
		print("Threshold (Default 12):")
		print(" /grito threshold [num] - wait a minimum of [num] seconds before allowing broadcasts to retrigger the event. note: your own level ups are not blocked but do restart this timer")
		print("Restore Default Settings:")
		print(" /grito default - revert changes to the default settings referenced above")
	end
end

local function EventHandler( self, event, ... )
	
	local arg1,arg2,arg3,arg4 = ...
	local t = GetTime()

	if event == "PLAYER_LEVEL_UP" then
		last_triggered=t
		frame:Show()
		PlaySoundFile("Interface\\Addons\\Grito_Dingo\\grito_ranchero.ogg", "master")
		if not current_frame==0 then
			current_frame=0
		else
			display_GIF()
		end
		local t_to_level = secondsToDays(t_this_lvl+(t-t_onload))
		t_this_lvl=0
		t_onload=t
		text1:SetText("¡You've just reached level "..arg1.."!")
		text2:SetText("You were level ".. arg1-1 .." for "..t_to_level)
		SendAddonMessage("GRITO_BROADCAST", "name="..UnitName("player")..", level="..arg1..", time="..t_to_level, "GUILD")
		SendChatMessage("¡I just reached level "..arg1..", amigos!", "GUILD")
	end

	if event == "CHAT_MSG_ADDON" and arg1=="GRITO_BROADCAST" and syncing and t-last_triggered > threshold then
		local broadcast = {}
		for k, v in string.gmatch( arg2, "(%w+)=(%w+)" ) do
			broadcast[k] = v
		end
		last_triggered=t
		frame:Show()
		PlaySoundFile("Interface\\Addons\\Grito_Dingo\\grito_ranchero.ogg", "master")
		display_GIF()
		text1:SetText("¡"..broadcast.name.." just reached level "..broadcast.level.."!")
		text2:SetText("They were level ".. tonumber(broadcast.level)-1 .." for "..broadcast.time)
	end

	if event == "ADDON_LOADED" and arg1=="Grito_Dingo" then
		if not frame_scale then
			frame_scale=0.69
		end
		if not frame_x then
			frame_x=0
		end
		if not frame_y then
			frame_y=275
		end
		updateFrame()
		if not syncing then
			syncing=true
		end
		if not threshold then
			threshold=12
		end
		if not last_triggered then
			last_triggered=0
		end
		RequestTimePlayed()
	end

	if event == "TIME_PLAYED_MSG" then
		t_this_lvl = arg2
		t_onload = GetTime()
	end
end

frame:RegisterEvent( "PLAYER_LEVEL_UP" )
frame:RegisterEvent( "CHAT_MSG_ADDON" ) --Send addon msg with SendAddonMessage(prefix, msg, type, target)
frame:RegisterEvent( "ADDON_LOADED" )
frame:RegisterEvent( "TIME_PLAYED_MSG" )
frame:SetScript( "OnEvent", EventHandler )