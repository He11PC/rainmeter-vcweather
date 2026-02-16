function Initialize()
	-- Skin variables
	sMonitorOrientation = tonumber(SKIN:GetVariable('MonitorOrientation'))

	-- Measures
	msNowDetails = SKIN:GetMeasure('MeasureNowDetails')
	msDay0Details = SKIN:GetMeasure('MeasureDay0Details')
	msDay1Details = SKIN:GetMeasure('MeasureDay1Details')
	msDay2Details = SKIN:GetMeasure('MeasureDay2Details')
	msDay3Details = SKIN:GetMeasure('MeasureDay3Details')
	msDay4Details = SKIN:GetMeasure('MeasureDay4Details')
	msDay5Details = SKIN:GetMeasure('MeasureDay5Details')
end

function Update()
	local vDay = tonumber(SKIN:GetVariable('MouseOverDay'))
	
	-- Load RAW Data
	local vDetailsNow
	local vDetailsDay
	
	if vDay == 0 then
		vDetailsNow = msNowDetails:GetStringValue()
		vDetailsDay = msDay0Details:GetStringValue()
	elseif vDay == 1 then
		vDetailsDay = msDay1Details:GetStringValue()
	elseif vDay == 2 then
		vDetailsDay = msDay2Details:GetStringValue()
	elseif vDay == 3 then
		vDetailsDay = msDay3Details:GetStringValue()
	elseif vDay == 4 then
		vDetailsDay = msDay4Details:GetStringValue()
	elseif vDay == 5 then
		vDetailsDay = msDay5Details:GetStringValue()
	end
	
	-- Feels like
	local vFeelsLikeMin = tostring(Round(vDetailsDay:match("\"feelslikemin\":(.-),"))).."[\\x00B0]"
	local vFeelsLikeMax = tostring(Round(vDetailsDay:match("\"feelslikemax\":(.-),"))).."[\\x00B0]"
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsFeelsLikeTxt1', 'Text', tostring(Round(vDetailsNow:match("\"feelslike\":(.-),"))).."[\\x00B0]")
		SKIN:Bang('!SetOption', 'MeterDetailsFeelsLikeTxt2', 'Text', vFeelsLikeMin.."[\\x0020]/[\\x0020]"..vFeelsLikeMax)
	else
		SKIN:Bang('!SetOption', 'MeterDetailsFeelsLikeTxt1', 'Text', vFeelsLikeMin)
		SKIN:Bang('!SetOption', 'MeterDetailsFeelsLikeTxt2', 'Text', vFeelsLikeMax)
	end
	
	-- Sunrise/Sunset
	SKIN:Bang('!SetOption', 'MeterDetailsSunriseTxt', 'Text', string.sub(vDetailsDay:match("\"sunrise\":\"(.-)\""),1,5))
	SKIN:Bang('!SetOption', 'MeterDetailsSunsetIcon', 'Text', GetMoonIcon(vDetailsDay:match("\"moonphase\":(.-),")))
	SKIN:Bang('!SetOption', 'MeterDetailsSunsetTxt', 'Text', string.sub(vDetailsDay:match("\"sunset\":\"(.-)\""),1,5))
	
	-- Cloud Cover
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsCloudCoverTxt', 'Text', Compact(vDetailsNow:match("\"cloudcover\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsCloudCoverTxt', 'Text', Compact(vDetailsDay:match("\"cloudcover\":(.-),")))
	end
	
	-- Visibility
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsVisibilityTxt', 'Text', Compact(vDetailsNow:match("\"visibility\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsVisibilityTxt', 'Text', Compact(vDetailsDay:match("\"visibility\":(.-),")))
	end
	
	-- UV Index
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsUvTxt', 'Text', Compact(vDetailsNow:match("\"uvindex\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsUvTxt', 'Text', Compact(vDetailsDay:match("\"uvindex\":(.-),")))
	end
	
	-- Solar energy
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsSolarEnergyTxt', 'Text', Compact(vDetailsNow:match("\"solarradiation\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsSolarEnergyTxt', 'Text', Compact(vDetailsDay:match("\"solarradiation\":(.-),")))
	end
	
	-- Humidity
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsHumidityTxt', 'Text', Compact(vDetailsNow:match("\"humidity\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsHumidityTxt', 'Text', Compact(vDetailsDay:match("\"humidity\":(.-),")))
	end
	
	-- Dew point
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsDewTxt', 'Text', Compact(vDetailsNow:match("\"dew\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsDewTxt', 'Text', Compact(vDetailsDay:match("\"dew\":(.-),")))
	end
	
	-- Precipitations probability
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsPrecipProbTxt', 'Text', Compact(vDetailsNow:match("\"precipprob\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsPrecipProbTxt', 'Text', Compact(vDetailsDay:match("\"precipprob\":(.-),")))
	end
	
	-- Precipitations quantity
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsPrecipQtyTxt', 'Text', Compact(vDetailsNow:match("\"precip\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsPrecipQtyTxt', 'Text', Compact(vDetailsDay:match("\"precip\":(.-),")))
	end
	
	-- Wind speed
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsWindTxt', 'Text', Compact(vDetailsNow:match("\"windspeed\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsWindTxt', 'Text', Compact(vDetailsDay:match("\"windspeed\":(.-),")))
	end
	
	-- Wind direction
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeasureWindDirArrowRotation', 'Formula', GetWindDirAngle(vDetailsNow:match("\"winddir\":(.-),")))
		SKIN:Bang('!SetOption', 'MeterDetailsWindDirTxt', 'Text', GetWindDirTxt(vDetailsNow:match("\"winddir\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeasureWindDirArrowRotation', 'Formula', GetWindDirAngle(vDetailsDay:match("\"winddir\":(.-),")))
		SKIN:Bang('!SetOption', 'MeterDetailsWindDirTxt', 'Text', GetWindDirTxt(vDetailsDay:match("\"winddir\":(.-),")))
	end
	SKIN:Bang('!UpdateMeasure', 'MeasureWindDirArrowRotation')
	
	-- Gust speed
	local vGustSpeedNow
	local vGustSpeedDay = vDetailsDay:match("\"windgust\":(.-),")
	
	if vDay == 0 then
		vGustSpeedNow = vDetailsNow:match("\"windgust\":(.-),")
	end
	
	if IsNull(vGustSpeedNow) then
		vGustSpeedNow = vGustSpeedDay
	end
	
	SKIN:Bang('!SetOption', 'MeterDetailsGustTxt', 'Text', Compact(vGustSpeedNow))
	
	-- Severe risk
	if tonumber(vGustSpeedNow) > 70 or tonumber(vGustSpeedDay) > 70 or tonumber(vDetailsDay:match("\"severerisk\":(.-),")) > 70 then
		SKIN:Bang('!ShowMeter', 'MeterDetailsRiskIcon')
	else
		SKIN:Bang('!HideMeter', 'MeterDetailsRiskIcon')
	end
	
	-- Pressure
	if vDay == 0 then
		SKIN:Bang('!SetOption', 'MeterDetailsPressureTxt', 'Text', Compact(vDetailsNow:match("\"pressure\":(.-),")))
	else
		SKIN:Bang('!SetOption', 'MeterDetailsPressureTxt', 'Text', Compact(vDetailsDay:match("\"pressure\":(.-),")))
	end
	
	-- Update Meters
	SKIN:Bang('!UpdateMeterGroup', 'DetailsData')
end

function Round(num)
	return math.floor(tonumber(num+0.5))
end

function Compact(num)
	return tostring(tonumber(num))
end

function IsNull(var)
	return var == null or var=="null" or var == nil or #var == 0
end

function GetMoonIcon(phase)
	phase = Round(tonumber(phase)/(1/28))*(1/28)
	if phase == (1/28) then
		return "[\\xf095]"
	elseif phase == (1/28*2) then
		return "[\\xf096]"
	elseif phase == (1/28*3) then
		return "[\\xf097]"
	elseif phase == (1/28*4) then
		return "[\\xf098]"
	elseif phase == (1/28*5) then
		return "[\\xf099]"
	elseif phase == (1/28*6) then
		return "[\\xf09a]"
	elseif phase == (1/28*7) then
		return "[\\xf09b]"
	elseif phase == (1/28*8) then
		return "[\\xf09c]"
	elseif phase == (1/28*9) then
		return "[\\xf09d]"
	elseif phase == (1/28*10) then
		return "[\\xf09e]"
	elseif phase == (1/28*11) then
		return "[\\xf09f]"
	elseif phase == (1/28*12) then
		return "[\\xf0a0]"
	elseif phase == (1/28*13) then
		return "[\\xf0a1]"
	elseif phase == (1/28*14) then
		return "[\\xf0a2]"
	elseif phase == (1/28*15) then
		return "[\\xf0a3]"
	elseif phase == (1/28*16) then
		return "[\\xf0a4]"
	elseif phase == (1/28*17) then
		return "[\\xf0a5]"
	elseif phase == (1/28*18) then
		return "[\\xf0a6]"
	elseif phase == (1/28*19) then
		return "[\\xf0a7]"
	elseif phase == (1/28*20) then
		return "[\\xf0a8]"
	elseif phase == (1/28*21) then
		return "[\\xf0a9]"
	elseif phase == (1/28*22) then
		return "[\\xf0aa]"
	elseif phase == (1/28*23) then
		return "[\\xf0ab]"
	elseif phase == (1/28*24) then
		return "[\\xf0ac]"
	elseif phase == (1/28*25) then
		return "[\\xf0ad]"
	elseif phase == (1/28*26) then
		return "[\\xf0ae]"
	elseif phase == (1/28*27) then
		return "[\\xf0af]"
	elseif phase == 1 then
		return "[\\xf0b0]"
	else
		return "[\\xf095]"
	end
end

function GetWindDirAngle(degree)
	return Round(tonumber(degree)-sMonitorOrientation)
end

function GetWindDirTxt(degree)
	local vRoundDegree = Round(tonumber(degree)/45)*45
	if vRoundDegree == 0 then
		return "N"
	elseif vRoundDegree == 45 then
		return "NE"
	elseif vRoundDegree == 90 then
		return "E"
	elseif vRoundDegree == 135 then
		return "SE"
	elseif vRoundDegree == 180 then
		return "S"
	elseif vRoundDegree == 225 then
		return "SO"
	elseif vRoundDegree == 270 then
		return "O"
	elseif vRoundDegree == 315 then
		return "NO"
	else
		return "N"
	end
end