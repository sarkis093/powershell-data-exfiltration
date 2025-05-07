# PowerShell Data Exfiltration Simulations

This repository contains scripts written in PowerShell and Python designed to simulate data exfiltration scenarios in corporate networks. They can be used by cybersecurity professionals, offensive security analysts, and Red Team teams in controlled environments to demonstrate risks and validate defensive controls.

---

## Contents

- `exfiltrate-to-webhook.ps1`  
  Simulates data exfiltration via a manually crafted HTTP `POST` request to the external service [webhook.site](https://webhook.site). The connection is made on port 80 (no TLS), useful for observing unencrypted outbound traffic behavior.

- `exfiltrate-to-python.ps1`  
  Establishes a direct TCP connection to a custom Python server on port 443. Provides full control over the sent and received content, ideal for lab simulations.

- `exfil_listener.py`  
  A simple Python script that acts as a listener server to receive data sent from the PowerShell script. It listens on port 443 and responds after receiving the message.

---

## Purpose

The scripts aim to simulate **data exfiltration channels** for:

- Assessing network security controls (firewall, proxy, DLP)
- Testing visibility and response in solutions like EDR, NDR, and SIEM
- Demonstrating risks in corporate environments with permissive network policies
- Training Blue Team and analyzing anomalous traffic

---

## Requirements

- **PowerShell** (Windows)
- **Python 3.x** (for the listener server)
- Internet access (for use with Webhook.site)

---

## Disclaimer

> **This project is strictly educational and should only be used in controlled test environments with explicit permission. Misuse of this code in production environments or without authorization is illegal and unethical.**

---

## How to Use

### Version with Webhook.site (HTTP)

1. **Access Webhook.site:**
   - Go to [https://webhook.site](https://webhook.site).
   - Once the page loads, you will see a unique URL generated for you automatically. The URL will look like this: `https://webhook.site/<unique-id>`. This is the URL of your **custom endpoint**, where the exfiltrated data will be sent.

2. **Copy the Webhook URL:**
   - In the main panel on the Webhook.site homepage, you'll see your unique URL. Simply copy this URL (usually displayed in a field titled “Your unique URL”).

3. **Replace the endpoint in the PowerShell script:**
   - Open the `exfiltrate-to-webhook.ps1` file in your text editor or PowerShell.
   - Inside the script, locate the following variables:
     ```powershell
     $webhookUrl = 'webhook.site'
     $port = 80  # Default HTTP port

     $endpoint = 'unique URL'
     ```
   - Replace the value of `$endpoint` with the unique URL you copied in step 2, so it looks like this:
     ```powershell
     $endpoint = '<unique-id>'
     ```
     The `<unique-id>` is the part at the end of the URL provided by Webhook.site (e.g., if your URL is `https://webhook.site/abc123`, you should replace `unique URL` with `abc123`).

4. **Run the PowerShell script:**
   - Now that the script is configured with your custom URL, run the script in a PowerShell terminal. Use the following command:
     ```powershell
     .\exfiltrate-to-webhook.ps1
     ```
   - The script will make an HTTP `POST` request to Webhook.site, sending the simulated exfiltrated data.

5. **Check the reception in Webhook.site:**
   - After running the script, go back to the Webhook.site page.
   - In the site's interface, you'll see the HTTP requests that were sent to your endpoint, with details about the exfiltrated data. Webhook.site will also show the request headers and the content sent (just like a real exfiltration payload).

**Important Tips:**
- Webhook.site can be used to observe how the network responds to unencrypted HTTP traffic (no TLS), which is useful for security testing purposes.
- There’s no need to set up extra servers or infrastructure to start testing, as Webhook.site provides everything automatically.

