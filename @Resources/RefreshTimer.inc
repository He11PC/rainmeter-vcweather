[MeasureMinutes]
Measure=Time
Format=%M
IfCondition=(MeasureMinutes%10=1)
IfTrueAction=[!CommandMeasure MeasureWeather Update] [!DisableMeasure MeasureMinutes]