function Initialize()
	oIconX = tonumber(SELF:GetOption('IconX'))
	oIconY = tonumber(SELF:GetOption('IconY'))
	
	msCloudCover = SKIN:GetMeasure('MeasureNowCloudCover')
	msPrecip = SKIN:GetMeasure('MeasureNowPrecip')
	msPrecipType = SKIN:GetMeasure('MeasureNowPrecipType')
	msMoonPhase = SKIN:GetMeasure('MeasureMoonPhase')
	msSunrise = SKIN:GetMeasure('MeasureDay0SunriseEpoch')
	msSunset = SKIN:GetMeasure('MeasureDay0SunsetEpoch')
	
	mtCloud = SKIN:GetMeter('MeterNowIconCloud')
	mtLightning = SKIN:GetMeter('MeterNowIconLightning')
	mtPrecip = SKIN:GetMeter('MeterNowIconPrecip')
end

function Update()
	local vCloudCover = tonumber(msCloudCover:GetStringValue())
	local vPrecip = tonumber(msPrecip:GetStringValue())
	local vPrecipType = msPrecipType:GetStringValue()
	local vMoonPhase = Round(tonumber(msMoonPhase:GetStringValue())*20)*5
	
	-- Stars backgRound and Moon/Sun
	if vCloudCover > 95 then
		SKIN:Bang('!HideMeter', 'MeterNowIconSunMoon')
		SKIN:Bang('!HideMeter', 'MeterNowIconNightStars')
	else
		if IsDayTime(msSunrise:GetStringValue(), msSunset:GetStringValue()) then
			SKIN:Bang('!HideMeter', 'MeterNowIconNightStars')
			SKIN:Bang('!SetOption', 'MeterNowIconSunMoon', 'ImageName', 'sun.png')
		else
			SKIN:Bang('!SetOption', 'MeterNowIconSunMoon', 'ImageName', 'moon-'..vMoonPhase..'.png')
			SKIN:Bang('!SetOption', 'MeterNowIconNightStars', 'ImageName', 'stars-'..tostring(100-math.floor(vCloudCover/25)*25)..'.png')
			SKIN:Bang('!UpdateMeter', 'MeterNowIconNightStars')
			SKIN:Bang('!ShowMeter', 'MeterNowIconNightStars')
		end
		SKIN:Bang('!UpdateMeter', 'MeterNowIconSunMoon')
		SKIN:Bang('!ShowMeter', 'MeterNowIconSunMoon')
	end
	
	-- Cloud
	if vCloudCover < 5 then
		SKIN:Bang('!HideMeter', 'MeterNowIconCloud')
	else
		SKIN:Bang('!ShowMeter', 'MeterNowIconCloud')
	end

	-- Precipitations (quantity mm)
	if vPrecip > 0 then
		if IsNull(vPrecipType) then
			vPrecipType = "rain"
		end
		SKIN:Bang('!SetOption', 'MeterNowIconPrecip', 'ImageName', vPrecipType..'-'..math.min(100, (math.ceil(vPrecip/3)*25))..'.png')
		SKIN:Bang('!UpdateMeter', 'MeterNowIconPrecip')
		SKIN:Bang('!ShowMeter', 'MeterNowIconPrecip')
	else
		SKIN:Bang('!HideMeter', 'MeterNowIconPrecip')
	end
	
	-- Resize icons
	if vCloudCover >= 5 and vCloudCover <= 95 then
		local vIconSize = Round(60-40*(100-(vCloudCover-5)*100/90)/100)
		local vIconX = Round(oIconX+((60-vIconSize)/2))
		local vIconY = Round(oIconY+((60-vIconSize)/2))
		
		mtCloud:SetW(vIconSize)
		mtCloud:SetH(vIconSize)
		mtCloud:SetX(vIconX)
		mtCloud:SetY(vIconY)
		
		mtLightning:SetW(vIconSize)
		mtLightning:SetH(vIconSize)
		mtLightning:SetX(vIconX)
		mtLightning:SetY(vIconY)
		
		mtPrecip:SetW(vIconSize)
		mtPrecip:SetH(vIconSize)
		mtPrecip:SetX(vIconX)
		mtPrecip:SetY(vIconY)
	elseif vCloudCover > 95 then
		mtCloud:SetW(60)
		mtCloud:SetH(60)
		mtCloud:SetX(oIconX)
		mtCloud:SetY(oIconY)
		
		mtLightning:SetW(60)
		mtLightning:SetH(60)
		mtLightning:SetX(oIconX)
		mtLightning:SetY(oIconY)
		
		mtPrecip:SetW(60)
		mtPrecip:SetH(60)
		mtPrecip:SetX(oIconX)
		mtPrecip:SetY(oIconY)
	end
end

function Round(num)
	return math.floor(tonumber(num+0.5))
end

function IsNull(var)
	return var == null or var=="null" or var == nil or #var == 0
end

function IsDayTime(sunrise, sunset)
	local currentEpoch = os.time()
	if (currentEpoch > tonumber(sunrise) and currentEpoch < tonumber(sunset)) then
		return true
	else
		return false
	end
end
