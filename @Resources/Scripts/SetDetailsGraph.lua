function Initialize()
	-- Skin variables
	sColorTempVeryLow = SKIN:GetVariable('ColorTempVeryLow')
	sColorTempLow = SKIN:GetVariable('ColorTempLow')
	sColorTempAverage = SKIN:GetVariable('ColorTempAverage')
	sColorTempWarm = SKIN:GetVariable('ColorTempWarm')
	sColorTempVeryWarm = SKIN:GetVariable('ColorTempVeryWarm')
	
	sBelowIsTempVeryLow = tonumber(SKIN:GetVariable('BelowIsTempVeryLow'))
	sBelowIsTempLow = tonumber(SKIN:GetVariable('BelowIsTempLow'))
	sBelowIsTempAverage = tonumber(SKIN:GetVariable('BelowIsTempAverage'))
	sBelowIsTempWarm = tonumber(SKIN:GetVariable('BelowIsTempWarm'))

	-- Option variables
	oMinTempGraphPosition = tonumber(SELF:GetOption('MinTempGraphPosition'))
	oMaxTempGraphPosition = tonumber(SELF:GetOption('MaxTempGraphPosition'))
	oMinCloudCoverGraphPosition = tonumber(SELF:GetOption('MinCloudCoverGraphPosition'))
	oMaxCloudCoverGraphPosition = tonumber(SELF:GetOption('MaxCloudCoverGraphPosition'))
	oMinPrecipProbGraphPosition = tonumber(SELF:GetOption('MinPrecipProbGraphPosition'))
	oMaxPrecipProbGraphPosition = tonumber(SELF:GetOption('MaxPrecipProbGraphPosition'))
	
	-- Measures
	msHour = SKIN:GetMeasure('MeasureCurrentHour')
	
	msDay0Details = SKIN:GetMeasure('MeasureDay0Details')
	msDay0Hours = SKIN:GetMeasure('MeasureDay0Hours')
	msDay1Hours = SKIN:GetMeasure('MeasureDay1Hours')
	msDay2Hours = SKIN:GetMeasure('MeasureDay2Hours')
	msDay3Hours = SKIN:GetMeasure('MeasureDay3Hours')
	msDay4Hours = SKIN:GetMeasure('MeasureDay4Hours')
	msDay5Hours = SKIN:GetMeasure('MeasureDay5Hours')
	
	msDay1TempMin = SKIN:GetMeasure('MeasureDay1TempMin')
	msDay1TempMax = SKIN:GetMeasure('MeasureDay1TempMax')
	msDay2TempMin = SKIN:GetMeasure('MeasureDay2TempMin')
	msDay2TempMax = SKIN:GetMeasure('MeasureDay2TempMax')
	msDay3TempMin = SKIN:GetMeasure('MeasureDay3TempMin')
	msDay3TempMax = SKIN:GetMeasure('MeasureDay3TempMax')
	msDay4TempMin = SKIN:GetMeasure('MeasureDay4TempMin')
	msDay4TempMax = SKIN:GetMeasure('MeasureDay4TempMax')
	msDay5TempMin = SKIN:GetMeasure('MeasureDay5TempMin')
	msDay5TempMax = SKIN:GetMeasure('MeasureDay5TempMax')
end

function Update()
	local vDay = tonumber(SKIN:GetVariable('MouseOverDay'))
	
	-- Load Data
	local vHours
	local vTempMin
	local vTempMax
	
	if vDay == 0 then
		vHours = msDay0Hours:GetStringValue()
		local vDetailsDay = msDay0Details:GetStringValue()
		vTempMin = tonumber(vDetailsDay:match("\"tempmin\":(.-),"))
		vTempMax = tonumber(vDetailsDay:match("\"tempmax\":(.-),"))		
	elseif vDay == 1 then
		vHours = msDay1Hours:GetStringValue()
		vTempMin = msDay1TempMin:GetValue()
		vTempMax = msDay1TempMax:GetValue()
	elseif vDay == 2 then
		vHours = msDay2Hours:GetStringValue()
		vTempMin = msDay2TempMin:GetValue()
		vTempMax = msDay2TempMax:GetValue()
	elseif vDay == 3 then
		vHours = msDay3Hours:GetStringValue()
		vTempMin = msDay3TempMin:GetValue()
		vTempMax = msDay3TempMax:GetValue()
	elseif vDay == 4 then
		vHours = msDay4Hours:GetStringValue()
		vTempMin = msDay4TempMin:GetValue()
		vTempMax = msDay4TempMax:GetValue()
	elseif vDay == 5 then
		vHours = msDay5Hours:GetStringValue()
		vTempMin = msDay5TempMin:GetValue()
		vTempMax = msDay5TempMax:GetValue()
	end
	
	vTempMin = Round(vTempMin)
	vTempMax = Round(vTempMax)
	
	-- Parse hours
	local vHourData
	local vTemp
	local vTempColor
	local vTempGraphPosition
	local vCloudCover
	local vPrecip
	
	for hour = 0,23,1
	do
		vHourData = vHours:match("\{\"datetime\":\""..AddZeros(tostring(hour),2)..":00:00\"(.-)\}")
		
		-- Get RAW values
		vTemp = Round(tonumber(vHourData:match("\"temp\":(.-),")))
		vCloudCover = tonumber(vHourData:match("\"cloudcover\":(.-),"))
		vPrecip = tonumber(vHourData:match("\"precipprob\":(.-),"))		
		
		-- Temperature
		SKIN:Bang('!SetOption', 'MeterHour'..hour..'Temp', 'Text', vTemp)
		SKIN:Bang('!SetOption', 'MeasureHour'..hour..'TempColor', 'String', GetTempColor(vTemp))
		vTempGraphPosition = GetTempGraphPosition(vTemp, vTempMin, vTempMax)
		SKIN:Bang('!SetOption', 'MeasureHour'..hour..'TempGraphPosition', 'Formula', vTempGraphPosition)
		SKIN:Bang('!SetOption', 'MeasureHour'..hour..'TempTxtPosition', 'Formula', GetTempTxtPosition(vTempGraphPosition))
		
		-- Cloud cover
		SKIN:Bang('!SetOption', 'MeasureHour'..hour..'CloudCoverGraphPosition', 'Formula', GetCloudCoverGraphPosition(vCloudCover))
		
		-- Precipitation probability
		SKIN:Bang('!SetOption', 'MeasureHour'..hour..'PrecipProbGraphPosition', 'Formula', GetPrecipProbGraphPosition(vPrecip))
		
		-- Icon
		if math.fmod(hour,3) == 0 then
			SKIN:Bang('!SetOption', 'MeterDetailsHour'..hour..'Icon', 'Text', GetIcon(vHourData:match("\"icon\":\"(.-)\",")))
		end
		
		-- Update skin
		SKIN:Bang('!UpdateMeasureGroup', 'Graph')
		SKIN:Bang('!UpdateMeterGroup', 'Graph')
	end
end

function Round(num)
	return math.floor(tonumber(num+0.5))
end

function AddZeros(txt, length)
   return string.rep('0', length-#txt)..txt
end

function GetTempColor(temp)
	if temp <= sBelowIsTempVeryLow then
		return sColorTempVeryLow
	elseif temp <= sBelowIsTempLow then
		return sColorTempLow
	elseif temp <= sBelowIsTempAverage then
		return sColorTempAverage
	elseif temp <= sBelowIsTempWarm then
		return sColorTempWarm
	else
		return sColorTempVeryWarm
	end
end

function GetIcon(icon)
	if icon == "snow" then
		return "[\\xf01b]"
	elseif icon == "snow-showers-day" then
		return "[\\xf00a]"
	elseif icon == "snow-showers-night" then
		return "[\\xf02a]"
	elseif icon == "thunder-rain" then
		return "[\\xf01d]"
	elseif icon == "thunder-showers-day" then
		return "[\\xf00e]"
	elseif icon == "thunder-showers-night" then
		return "[\\xf02c]"
	elseif icon == "rain" then
		return "[\\xf01a]"
	elseif icon == "showers-day" then
		return "[\\xf009]"
	elseif icon == "showers-night" then
		return "[\\xf029]"
	elseif icon == "fog" then
		return "[\\xf014]"
	elseif icon == "wind" then
		return "[\\xf050]"
	elseif icon == "cloudy" then
		return "[\\xf041]"
	elseif icon == "partly-cloudy-day" then
		return "[\\xf002]"
	elseif icon == "partly-cloudy-night" then
		return "[\\xf086]"
	elseif icon == "clear-day" then
		return "[\\xf00d]"
	else -- "clear-night"
		return "[\\xf02e]"
	end
end

function GetTempGraphPosition(temp, tempMin, tempMax)
	return oMinTempGraphPosition+Round((oMaxTempGraphPosition-oMinTempGraphPosition)*((temp-tempMin)/(tempMax-tempMin)))
end

function GetTempTxtPosition(graphPosition)
	return graphPosition - 10
end

function GetCloudCoverGraphPosition(cover)
	return oMinCloudCoverGraphPosition+Round((oMaxCloudCoverGraphPosition-oMinCloudCoverGraphPosition)*(cover/100))
end

function GetPrecipProbGraphPosition(precip)
	return oMinPrecipProbGraphPosition+Round((oMaxPrecipProbGraphPosition-oMinPrecipProbGraphPosition)*(precip/100))
end
