# smb verbindungs-problem

[SMB-HOWTO8](https://www.tldp.org/HOWTO/SMB-HOWTO-8.html)
 
auf remote vm (78.94.81.228):

```
sudo apt-get install smbclient
```

local connect to samba service:
```
smbclient //127.0.0.1/volker --user=volker volker
```
funzt

### test auf 78.94.81.228 über EXT_SYN_2

```
26.07.19|4:07:09  smart  $ sudo nmap -sT -p 139,445 78.94.81.228

Starting Nmap 7.01 ( https://nmap.org ) at 2019-07-26 16:07 CEST
Nmap scan report for b2b-78-94-81-228.unitymedia.biz (78.94.81.228)
Host is up (0.031s latency).
PORT    STATE    SERVICE
139/tcp filtered netbios-ssn
445/tcp filtered microsoft-ds

Nmap done: 1 IP address (1 host up) scanned in 1.42 seconds
```

--> Verbindung kann nicht aufgebaut werden.
AKA "Du kommst hier net rein!"...

### test auf 78.94.81.228 über mobilfunk

```
26.07.19|4:04:36  smart  $ sudo nmap -sT -p 139,445 78.94.81.228

Starting Nmap 7.01 ( https://nmap.org ) at 2019-07-26 16:04 CEST
Nmap scan report for b2b-78-94-81-228.unitymedia.biz (78.94.81.228)
Host is up (0.070s latency).
PORT    STATE SERVICE
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds

Nmap done: 1 IP address (1 host up) scanned in 0.23 seconds
```
--> Verbindung kann aufgebaut werden über dir url `cifs://volker:volker@78.94.81.228/volker`


## Performance

|Was|Zeit / LAN | Zeit / WLAN|
|---|---|---|
|Präsi (19MB) speichern |0|50s|
|Präsi (19MB) lokal öffnen & remote speichern |0|50s|
|Präsi (19MB) kopieren von share zu mir|0|13s|
|Präsi (19MB) kopieren vom mir auf share|0|20s|



