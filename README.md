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

1. Go to [webhook.site](https://webhook.site) and copy your unique endpoint.
2. Edit the `exfiltrate-to-webhook.ps1` script and replace the endpoint in the request header.
3. Run the script in PowerShell:
   ```powershell
   .\exfiltrate-to-webhook.ps1

