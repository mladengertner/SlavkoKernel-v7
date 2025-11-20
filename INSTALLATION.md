# Installation Guide

## Prerequisites
- Windows 10/11 or Linux
- PowerShell 5.1+
- Ollama (for AI model support)
- 8GB RAM minimum

## Step-by-Step Installation

### 1. Clone Repository
\\\ash
git clone https://github.com/username/slavkokernel.git
cd slavkokernel
\\\

### 2. Run Installation Script
\\\powershell
.\install.ps1
\\\

### 3. Configure Environment
\\\ash
cp .env.example .env
# Edit .env with your settings
\\\

### 4. Start Services
\\\powershell
.\start.ps1
\\\

## Verification
Visit http://localhost:8080 to verify installation.
