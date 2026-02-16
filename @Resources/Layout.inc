;================================================================
;Backgrounds
;================================================================

[BgMain]
Meter=Shape
Shape=Rectangle 5,5,544,110 | Fill Color 0,0,0,0 | StrokeWidth 0
MouseOverAction=[!ShowMeterGroup Details] [!MoveMeter 277 370 MeterAlert] [!Redraw]
MouseLeaveAction=[!HideMeter MeterDetailsCurrentHour] [!HideMeterGroup Details] [!HideMeter MeterDetailsRiskIcon] [!MoveMeter 277 120 MeterAlert] [!Redraw]
UpdateDivider=-1

[BgNow]
Meter=Shape
Group=Colored
Shape=Rectangle 5,5,90,110 | Fill Color [MeasureWindowsColor] | StrokeWidth 0
MouseOverAction=[!SetVariable MouseOverDay 0] [!ShowMeter MeterDetailsCurrentHour] [!UpdateMeasureGroup LuaSetDetails] [!Redraw]
DynamicVariables=1
UpdateDivider=-1

[BgDay1]
Meter=Shape
Shape=Rectangle 95,5,90,110 | Fill Color 0,0,0,#BgAlpha# | StrokeWidth 0
MouseOverAction=[!SetVariable MouseOverDay 1] [!HideMeter MeterDetailsCurrentHour] [!UpdateMeasureGroup LuaSetDetails] [!Redraw]
UpdateDivider=-1

[BgDay2]
Meter=Shape
Shape=Rectangle 185,5,91,110 | Fill Color 0,0,0,#BgAlpha# | StrokeWidth 0
MouseOverAction=[!SetVariable MouseOverDay 2] [!HideMeter MeterDetailsCurrentHour] [!UpdateMeasureGroup LuaSetDetails] [!Redraw]
UpdateDivider=-1

[BgDay3]
Meter=Shape
Shape=Rectangle 276,5,91,110 | Fill Color 0,0,0,#BgAlpha# | StrokeWidth 0
MouseOverAction=[!SetVariable MouseOverDay 3] [!HideMeter MeterDetailsCurrentHour] [!UpdateMeasureGroup LuaSetDetails] [!Redraw]
UpdateDivider=-1

[BgDay4]
Meter=Shape
Shape=Rectangle 367,5,91,110 | Fill Color 0,0,0,#BgAlpha# | StrokeWidth 0
MouseOverAction=[!SetVariable MouseOverDay 4] [!HideMeter MeterDetailsCurrentHour] [!UpdateMeasureGroup LuaSetDetails] [!Redraw]
UpdateDivider=-1

[BgDay5]
Meter=Shape
Shape=Rectangle 458,5,91,110 | Fill Color 0,0,0,#BgAlpha# | StrokeWidth 0
MouseOverAction=[!SetVariable MouseOverDay 5] [!HideMeter MeterDetailsCurrentHour] [!UpdateMeasureGroup LuaSetDetails] [!Redraw]
UpdateDivider=-1

[BgDaysLines]
Meter=Shape
Group=Colored
Shape=Rectangle 185,5,1,110 | Fill RadialGradient LineGradient | StrokeWidth 0
Shape2=Rectangle 276,5,1,110 | Fill RadialGradient LineGradient | StrokeWidth 0
Shape3=Rectangle 367,5,1,110 | Fill RadialGradient LineGradient | StrokeWidth 0
Shape4=Rectangle 458,5,1,110 | Fill RadialGradient LineGradient | StrokeWidth 0
LineGradient=0,0 | [MeasureWindowsColor] ; 0.0 | [MeasureWindowsColor],25 ; 1.0
DynamicVariables=1
UpdateDivider=-1

;-------------------------

[BgDetails]
Meter=Shape
Group=Details
Padding=5,5,5,5
Shape=Rectangle 0,115,544,245 | Fill Color 0,0,0,#BgAlpha# | StrokeWidth 0
;Hours separator
Shape2=Rectangle 210,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape3=Rectangle 238,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape4=Rectangle 266,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape5=Rectangle 294,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape6=Rectangle 322,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape7=Rectangle 350,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape8=Rectangle 378,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape9=Rectangle 406,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape10=Rectangle 434,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape11=Rectangle 462,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape12=Rectangle 490,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
Shape13=Rectangle 518,120,14,219 | Fill LinearGradient GradientHours | StrokeWidth 0
;Graph X & Y
Shape14=Rectangle 196,339,336,1 | Fill LinearGradient GradientX | StrokeWidth 0
Shape15=Rectangle 195,120,1,220 | Fill LinearGradient GradientY | StrokeWidth 0
;Gradients
GradientHours=90 | 0,0,0,0 ; 0.0 | 0,0,0,50 ; 0.5 | 0,0,0,0 ; 1.0
GradientX=180 | 255,255,255,255 ; 0.0 | 130,130,130,130 ; 0.8 | 20,20,20,50 ; 1.0
GradientY=90 | 255,255,255,255 ; 0.0 | 130,130,130,130 ; 0.8 | 20,20,20,50 ; 1.0
Hidden=1
UpdateDivider=-1

[BgDetailsColoredLines]
Meter=Shape
Group=Details | Colored
Padding=5,5,5,5
Shape=Rectangle 196,135,336,1 | Fill LinearGradient GradientPercents | StrokeWidth 0
Shape2=Rectangle 196,186,336,1 | Fill LinearGradient GradientPercents | StrokeWidth 0
Shape3=Rectangle 196,237,336,1 | Fill LinearGradient GradientPercents | StrokeWidth 0
Shape4=Rectangle 196,288,336,1 | Fill LinearGradient GradientPercents | StrokeWidth 0
Shape5=Rectangle 153,120,1,235 | Fill RadialGradient GradientSeparator | StrokeWidth 0
GradientPercents=180 | [MeasureWindowsColor],25 ; 0.0 | [MeasureWindowsColor],125 ; 0.25 | [MeasureWindowsColor],125 ; 0.75 | [MeasureWindowsColor],25 ; 1.0
GradientSeparator=0,0 | [MeasureWindowsColor] ; 0.0 | [MeasureWindowsColor],25 ; 1.0
DynamicVariables=1
Hidden=1
UpdateDivider=-1

;================================================================
;Texts
;================================================================

[BgDetailsHour3]
Meter=String
Group=Details
X=250
Y=347
FontFace=Calibri
FontColor=200,200,200,200
FontSize=10
StringAlign=Center
AntiAlias=1
Text=03
Hidden=1
UpdateDivider=-1

[BgDetailsHour6]
Meter=String
Group=Details
X=292
Y=347
FontFace=Calibri
FontColor=200,200,200,200
FontSize=10
StringAlign=Center
AntiAlias=1
Text=06
Hidden=1
UpdateDivider=-1

[BgDetailsHour9]
Meter=String
Group=Details
X=334
Y=347
FontFace=Calibri
FontColor=200,200,200,200
FontSize=10
StringAlign=Center
AntiAlias=1
Text=09
Hidden=1
UpdateDivider=-1

[BgDetailsHour12]
Meter=String
Group=Details
X=376
Y=347
FontFace=Calibri
FontColor=200,200,200,200
FontSize=10
StringAlign=Center
AntiAlias=1
Text=12
Hidden=1
UpdateDivider=-1

[BgDetailsHour15]
Meter=String
Group=Details
X=418
Y=347
FontFace=Calibri
FontColor=200,200,200,200
FontSize=10
StringAlign=Center
AntiAlias=1
Text=15
Hidden=1
UpdateDivider=-1

[BgDetailsHour18]
Meter=String
Group=Details
X=460
Y=347
FontFace=Calibri
FontColor=200,200,200,200
FontSize=10
StringAlign=Center
AntiAlias=1
Text=18
Hidden=1
UpdateDivider=-1

[BgDetailsHour21]
Meter=String
Group=Details
X=502
Y=347
FontFace=Calibri
FontColor=200,200,200,200
FontSize=10
StringAlign=Center
AntiAlias=1
Text=21
Hidden=1
UpdateDivider=-1

;-------------------------

[BgDetailsPercent25]
Meter=String
Group=Details
X=193
Y=287
FontFace=Calibri
FontColor=200,200,200,150
FontSize=8
StringAlign=Right
AntiAlias=1
Text=25%
Hidden=1
UpdateDivider=-1

[BgDetailsPercent50]
Meter=String
Group=Details
X=193
Y=236
FontFace=Calibri
FontColor=200,200,200,150
FontSize=8
StringAlign=Right
AntiAlias=1
Text=50%
Hidden=1
UpdateDivider=-1

[BgDetailsPercent75]
Meter=String
Group=Details
X=193
Y=185
FontFace=Calibri
FontColor=200,200,200,150
FontSize=8
StringAlign=Right
AntiAlias=1
Text=75%
Hidden=1
UpdateDivider=-1

[BgDetailsPercent100]
Meter=String
Group=Details
X=193
Y=134
FontFace=Calibri
FontColor=200,200,200,150
FontSize=8
StringAlign=Right
AntiAlias=1
Text=100%
Hidden=1
UpdateDivider=-1