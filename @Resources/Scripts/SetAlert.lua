function Initialize()
	msAlert = SKIN:GetMeasure("MeasureAlert")
end

function Update()
	local vAlert = msAlert:GetStringValue()
	
	if IsNull(vAlert) then
		SKIN:Bang('!HideMeter', 'MeterAlert')
	else		
		SKIN:Bang('!SetOption', 'MeterAlert', 'Text', ConvertDate(vAlert:match("\"onset\":\"(.-)\",")).." - "..ConvertDate(vAlert:match("\"ends\":\"(.-)\",")).." | "..vAlert:match("\"event\":\"(.-)\","))
		SKIN:Bang('!UpdateMeter', 'MeterAlert')
		SKIN:Bang('!ShowMeter', 'MeterAlert')
	end
end

function IsNull(var)
	return var == null or var=="null" or var == nil or #var == 0
end

function ConvertDate(date)
	return (date:gsub('(%d+)-(%d+)-(%d+)T(%d+:%d+):%d+','%3/%2/%1 %4'))
end