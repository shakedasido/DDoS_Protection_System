# DDoS Protection System

This project consists of a shell script designed to protect a Linux server from various types of Distributed Denial of Service attacks (Extensions for Windows below) The script utilizes `iptables` and `ip6tables` to provide mitigation against different attack vectors including SYN Flood, ICMP Flood, Invalid Packets, Fragmented ICMP Packets, and IPv6 ICMP Floods.

## System:

- [Linux](Linux Installation and Usage)
- [Windows (using MSYS2)](Windows Installation)

## Contents

- `victim_script.sh`: The main script used to implement DDoS protection.
- `attacker_scripts.txt`: A text file containing various attacker scripts used for testing the victim script.
- `README.md`: This file.
- `.gitignore`: A configuration file.
- `LICENSE`: MIT License


## Linux Installation and Usage

### Prerequisites

- Linux-based operating system (We suggest that you use VM)
- `iptables` and `ip6tables` utilities
- `hping3` for attack simulations

### Steps

1. **Download the Script**

   Save `ddos_protection.sh` to your local directory.

2. **Make the Script Executable**

   ```bash
   chmod +x ddos_protection.sh
   ```

3. **Run the Script**

   Execute the script with superuser privileges:

   ```bash
   sudo ./ddos_protection.sh
   ```

4. **Testing the Protection**

   Use the attacker scripts provided in `attacker_scripts.txt` in another Linux-based VM to simulate DDoS attacks. Follow the instructions below for each attack type.

## Attacker Scripts

The `attacker_scripts.txt` file contains several scripts to test the DDoS protection script. 

### 1. SYN Flood Attack

### 2. ICMP Flood Attack

### 3. Invalid Packet Attack

### 4. Fragmented ICMP Packet Attack

### 5. IPv6 ICMP Flood Attack


## Windows Installation

To use the DDoS protection script on Windows, follow these steps using MSYS2 (We suggest that you use Windows-Based VM):

1. **Install MSYS2**

   Install MSYS2 from [MSYS2's website](https://www.msys2.org/) or via `winget`:

   ```bash
   winget install msys2
   ```

2. **Set Up MSYS2 Environment**

   Open MSYS2 terminal and update the package database:

   ```bash
   pacman -Syu
   ```

   Then, install `bash` and other necessary packages:

   ```bash
   pacman -S bash coreutils iptables
   ```

3. **Download the Script**

   Save `ddos_protection.sh` to your MSYS2 environment.

4. **Make the Script Executable**

   In MSYS2 terminal, change the permissions of the script:

   ```bash
   chmod +x ddos_protection.sh
   ```

5. **Run the Script**

   Execute the script:

   ```bash
   ./ddos_protection.sh
   ```

   Note: Ensure that `iptables` is properly configured and supported in your MSYS2 environment.

6. **Testing the Protection**

   Use the attacker scripts provided in `attacker_scripts.txt` to test the DDoS protection script.

## Contributing

If you have suggestions for improvements or additional features, feel free to open an issue or submit a pull request.

## Authors

- Shaked Asido
- Eli Ben-Aharon

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
