#!/bin/bash

# Install Nginx
sudo apt-get update
sudo apt-get install -y nginx

# Get host name 
HOSTNAME=$(hostname -f)

# Generate index.html
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IP Address Display</title>
</head>
<body>
    <h1>IP Address Information</h1>
    <p><strong>Hostname:</strong> <span id="hostname">Loading...</span></p>
    <p><strong>Public IP Address:</strong> <span id="public-ip">Fetching...</span></p>
    <p><strong>Private IP Address:</strong> <span id="private-ip">Fetching...</span></p>

    <script>
        // Get the hostname
        const hostnameElement = document.getElementById('hostname');
        hostnameElement.textContent = window.location.hostname;

        // Fetch the public IP address
        const publicIpElement = document.getElementById('public-ip');
        fetch('https://api64.ipify.org?format=json')
            .then(response => response.json())
            .then(data => {
                publicIpElement.textContent = data.ip;
            })
            .catch(error => {
                console.error('Error fetching public IP:', error);
                publicIpElement.textContent = 'Failed to fetch';
            });

        // Attempt to retrieve private IP address using WebRTC
        const privateIpElement = document.getElementById('private-ip');
        privateIpElement.textContent = 'Fetching...';

        const pc = new RTCPeerConnection({ iceServers: [] });
        pc.createDataChannel('');
        pc.createOffer()
            .then(offer => pc.setLocalDescription(offer))
            .catch(error => console.error('Error getting private IP:', error));

        pc.onicecandidate = event => {
            if (event.candidate) {
                const privateIp = event.candidate.candidate.split(' ')[4];
                privateIpElement.textContent = privateIp;
                pc.onicecandidate = null;
                pc.close();
            }
        };
    </script>
</body>
</html>
EOF

# Restart Nginx
sudo systemctl restart nginx