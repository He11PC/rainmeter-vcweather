function Initialize()
	msDay1Epoch = SKIN:GetMeasure("MeasureDay1Date")
	msDay2Epoch = SKIN:GetMeasure("MeasureDay2Date")
	msDay3Epoch = SKIN:GetMeasure("MeasureDay3Date")
	msDay4Epoch = SKIN:GetMeasure("MeasureDay4Date")
	msDay5Epoch = SKIN:GetMeasure("MeasureDay5Date")
end

function Update()
	SKIN:Bang('!SetOption', 'MeterDay1Title', 'Text', GetDay(msDay1Epoch:GetStringValue()))
	SKIN:Bang('!SetOption', 'MeterDay2Title', 'Text', GetDay(msDay2Epoch:GetStringValue()))
	SKIN:Bang('!SetOption', 'MeterDay3Title', 'Text', GetDay(msDay3Epoch:GetStringValue()))
	SKIN:Bang('!SetOption', 'MeterDay4Title', 'Text', GetDay(msDay4Epoch:GetStringValue()))
	SKIN:Bang('!SetOption', 'MeterDay5Title', 'Text', GetDay(msDay5Epoch:GetStringValue()))
	
	SKIN:Bang('!UpdateMeterGroup', 'MainTitles')
end

function GetDay(epoch)
	local days = {"Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"}
	return days[os.date('%w', tonumber(epoch))+1]
end
