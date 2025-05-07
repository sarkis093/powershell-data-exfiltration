<#
Manually Building the HTTP Request.
Does not support port 443 (HTTPS)
#>

$webhookUrl = 'webhook.site'
$port = 80  # Default HTTP port

# Define the data to be sent
$data = '{"username": "administrator", "password": "admin@123"}'

$endpoint = ''

# Create the raw HTTP request
$headers = @"
POST /$($endpoint) HTTP/1.1
Host: webhook.site
Content-Type: application/json
Content-Length: $($data.Length)

$data
"@

# Create the TCP client and connect to the server
$client = New-Object Net.Sockets.TcpClient($webhookUrl, $port)

# Get the stream to send data
$stream = $client.GetStream()

# Convert the request to bytes and send it
$bytes = [Text.Encoding]::ASCII.GetBytes($headers)
$stream.Write($bytes, 0, $bytes.Length)

# Read the response from the server
$responseBuffer = New-Object byte[] 1024
$bytesRead = $stream.Read($responseBuffer, 0, $responseBuffer.Length)
$response = [Text.Encoding]::ASCII.GetString($responseBuffer, 0, $bytesRead)

# Display the response
Write-Host "Server response: $response"

# Close the connection
$stream.Close()
$client.Close()
