import socket

# Define the IP and port to listen on
host = '0.0.0.0'  # Listen on all network interfaces
port = 443  # The same port used in the PowerShell script

# Create a TCP/IP socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the address and port
server_socket.bind((host, port))

# Start listening for connections
server_socket.listen(5)
print(f"Server listening on port {port}...")

while True:
    # Accept a connection
    client_socket, client_address = server_socket.accept()
    print(f"Connection received from {client_address}")

    try:
        # Receive data from the client
        data = client_socket.recv(1024)
        if data:
            print(f"Data received: {data.decode('ascii')}")
            
            # Send a response to the client
            response = "Message received successfully!"
            client_socket.sendall(response.encode('ascii'))
        else:
            print("No data received.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        # Close the connection with the client
        client_socket.close()
        print(f"Connection with {client_address} closed.")
