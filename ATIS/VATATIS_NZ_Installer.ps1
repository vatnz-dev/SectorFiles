$url = "https://s3-ap-southeast-2.amazonaws.com/atis-voice-files-nz/vatatis_files"
$output = "$PSScriptRoot"
$start_time = Get-Date

Write-Output "$url/AtisFiles.txt"

$wc = New-Object System.Net.WebClient
$wc.DownloadFile("$url/AtisFiles.txt", "$output/AtisFiles.txt")


$atis_file = Get-Content "$output/AtisFiles.txt"

$atis_file | foreach {
	$data = $_ -split ':'
	if($data[0] -eq "RECORD"){
		Write-Output "Downloading $($data[2])"
		$wc.DownloadFile($url+ '/' +$data[2], $output+ '/' +$data[2])
	}
}


Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Write-Host "Press any key to continue ..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")



