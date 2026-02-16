function Initialize()
	oDay = SELF:GetOption('Day')
	oIconX = tonumber(SELF:GetOption('IconX'))
	oIconY = tonumber(SELF:GetOption('IconY'))

	msCloudCover = SKIN:GetMeasure('MeasureDay'..oDay..'CloudCover')
	msPrecip = SKIN:GetMeasure('MeasureDay'..oDay..'PrecipCover')
	msPrecipType = SKIN:GetMeasure('MeasureDay'..oDay..'PrecipType')
	
	mtCloud = SKIN:GetMeter('MeterDay'..oDay..'IconCloud')
	mtLightning = SKIN:GetMeter('MeterDay'..oDay..'IconLightning')
	mtPrecip = SKIN:GetMeter('MeterDay'..oDay..'IconPrecip')
end

function Update()
	local vCloudCover = tonumber(msCloudCover:GetStringValue())
	local vPrecip = tonumber(msPrecip:GetStringValue())
	local vPrecipType = msPrecipType:GetStringValue()
	
	-- Sun
	if vCloudCover > 95 then
		SKIN:Bang('!HideMeter', 'MeterDay'..oDay..'IconSun')
	else
		SKIN:Bang('!ShowMeter', 'MeterDay'..oDay..'IconSun')
	end
	
	-- Cloud
	if vCloudCover < 5 then
		SKIN:Bang('!HideMeter', 'MeterDay'..oDay..'IconCloud')
	else
		SKIN:Bang('!ShowMeter', 'MeterDay'..oDay..'IconCloud')
	end

	-- Precipitations (% day)
	if vPrecip > 5 then
		if IsNull(vPrecipType) then
			vPrecipType = "rain"
		end
		SKIN:Bang('!SetOption', 'MeterDay'..oDay..'IconPrecip', 'ImageName', vPrecipType..'-'..(math.ceil(vPrecip/25)*25)..'.png')
		SKIN:Bang('!UpdateMeter', 'MeterDay'..oDay..'IconPrecip')
		SKIN:Bang('!ShowMeter', 'MeterDay'..oDay..'IconPrecip')
	else
		SKIN:Bang('!HideMeter', 'MeterDay'..oDay..'IconPrecip')
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