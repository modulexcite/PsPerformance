$tempFileName = "ConsolidatedData.txt"

if(Test-Path $tempFileName) {
	Remove-Item $tempFileName
}

. .\Invoke-SqlCmd2.ps1

$data  = Get-ChildItem -Filter *.csv |  
		ForEach { 
			Get-Content -Path $_.FullName | 
			Select-Object -Skip 1 |
				ForEach {
					$_ -Replace '"'
				}
		} |
		Set-Content $tempFileName

$file = Get-Item $tempFileName

$query = @"
BULK INSERT PerfMon.dbo.CounterSamples FROM '$file' WITH (FIRSTROW = 1, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')
"@

Invoke-Sqlcmd2 -ServerInstance "(local)" -Database PerfMon -Query $query

Remove-Item $file

