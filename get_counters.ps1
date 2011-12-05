$outputFilename = (Get-Date -format yyyy_MM_dd_HH_mm_ss) + ".csv"


$counters = 	"\Processor(_Total)\% Processor Time",
		"\Process(w3wp*)\% Processor Time",
		"\Process(w3wp*)\Private Bytes",
		"\Process(w3wp*)\Virtual Bytes",
		"\Process(w3wp*)\Handle Count",
		"\.NET CLR Exceptions(w3wp*)\# of Excepts Thrown",
		"\.NET CLR Exceptions(w3wp*)\# of Excepts Thrown / sec",
		"\ASP.NET\Application Restarts",
		"\ASP.NET\Requests Rejected",
		"\ASP.NET\Requests Queued",
		"\ASP.NET\Worker Process Restarts",
		"\ASP.NET\Worker Processes Running",
		"\Memory\Available MBytes",
		"\Web Service(*)\Current Connections",
		"\ASP.NET Apps v4.0.30319(*)\Cache API Hit Ratio",
		"\ASP.NET Apps v4.0.30319(*)\Output Cache Hit Ratio",
		"\ASP.NET Apps v4.0.30319(*)\Requests/Sec",
		"\ASP.NET Apps v4.0.30319(*)\Viewstate MAC Validation Failure"

$rawData = $counters | Get-Counter

$data = $rawData.CounterSamples | Select-Object TimeStamp, Path, Instance, CookedValue, CounterType

$csvData = $data | ConvertTo-Csv -NoTypeInformation

$csvData | Out-File $outputFilename
