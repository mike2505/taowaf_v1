#!/bin/bash
# TaoWaf V1
# Coded by: Dimitri Zhorzholiani


# Declaring Colors

Color_Off='\033[0m'

Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'

BBlack='\033[1;30m'
BRed='\033[1;31m'
BGreen='\033[1;32m'
BYellow='\033[1;33m'
BBlue='\033[1;34m'
BPurple='\033[1;35m'
BCyan='\033[1;36m'
BWhite='\033[1;37m'

UBlack='\033[4;30m'
URed='\033[4;31m'
UGreen='\033[4;32m'
UYellow='\033[4;33m'
UBlue='\033[4;34m'
UPurple='\033[4;35m'
UCyan='\033[4;36m'
UWhite='\033[4;37m'

echo -e "${Yellow}[*] ${Green}Checking if iptables is installed."
if [ -x "$(command -v apt)" ]; then
	# iptables Configuration
	echo -e "${Yellow}[*] ${URed}Debian${Green} based Distro detected."
	if [ "$(dpkg -l | awk '/iptables-persistent/ {print }'|wc -l)" -ge 1 ]; then
		echo -e "${Yellow}[*] ${BRed}iptables is not installed."
		echo -e "${Yellow}[*] ${Green}Updating the package source cache"
		sudo apt update -y &> /dev/null
		echo -e "${Yellow}[*] ${Green}Installing the Persistent Firewall Package"
		sudo apt install iptables-persistent -y &> /dev/null
	fi
	echo -e "${Yellow}[*] ${Green}Starting iptables"
	sudo systemctl start netfilter-persistent &> /dev/null

	echo "KmZpbHRlcgojIFNldHRpbmcgdXAgYSAiZGVueSBhbGwtYWNjZXB0IGFsbCIgcG9saWN5CiMgQWxsb3cgYWxsIG91dGdvaW5nLCBidXQgZGVueS9kcm9wIGFsbCBpbmNvbWluZyBhbmQgZm9yd2FyZGluZyB0cmFmZmljCjpJTlBVVCBEUk9QIFswOjBdCjpGT1JXQVJEIERST1AgWzA6MF0KOk9VVFBVVCBBQ0NFUFQgWzA6MF0KCiMgQ3VzdG9tIHBlci1wcm90b2NvbCBjaGFpbnMKIyBEZWZpbmluZyBjdXN0b20gcnVsZXMgZm9yIFVEUCBwcm90b2NvbC4KOlVEUCAtIFswOjBdCiMgRGVmaW5pbmcgY3VzdG9tIHJ1bGVzIGZvciBUQ1AgcHJvdG9jb2wuCjpUQ1AgLSBbMDowXQojIERlZmluaW5nIGN1c3RvbSBydWxlcyBmb3IgSUNNUCBwcm90b2NvbC4KOklDTVAgLSBbMDowXQoKIyBBY2NlcHQgU1NIIFVEUCB0cmFmZmljCi1BIFRDUCAtcCB1ZHAgLS1kcG9ydCAyMiAtaiBBQ0NFUFQKIyBBY2NlcHQgU1NIIFRDUCB0cmFmZmljCi1BIFRDUCAtcCB0Y3AgLS1kcG9ydCAyMiAtaiBBQ0NFUFQKCiMgQWNjZXB0YWJsZSBJQ01QIHRyYWZmaWMKCiMgQm9pbGVycGxhdGUgYWNjZXB0YW5jZSBwb2xpY3kKIyBBbGxvd2luZyBwYWNrZXRzIGJhc2VkIG9uIHRoZSBDT05OVFJBQ0sgY29ubmVjdGlvbiBzdGF0ZXMgb2YgRVNUQUJMSVNIRUQgYW5kIFJFTEFURUQKLUEgSU5QVVQgLW0gY29ubnRyYWNrIC0tY3RzdGF0ZSBFU1RBQkxJU0hFRCxSRUxBVEVEIC1qIEFDQ0VQVAojIEFsbG93aW5nIHBhY2tldHMgdGhyb3VnaCB0aGUgbG9vcGJhY2sgaW50ZXJmYWNlLCB3aGljaCBpcyB1c2VkIGZvciBsb2NhbCBjb25uZWN0aW9ucwotQSBJTlBVVCAtaSBsbyAtaiBBQ0NFUFQKCiMgUGFja2V0cyB0aGF0IGRvIG5vdCBtYXRjaCBhbnkgcnVsZXMgaW4gdGhlIHByb3RvY29sLXNwZWNpZmljIHNob3VsZCBiZSBkcm9wcGVkLgotQSBJTlBVVCAtbSBjb25udHJhY2sgLS1jdHN0YXRlIElOVkFMSUQgLWogRFJPUAojIEFsbG93aW5nIG5ldyBwcm90b2NvbC1zcGVjaWZpYyBjaGFpbnMgdG8gcHJvY2VzcyBwYWNrZXRzIGZvciBVRFAgdGhhdCBoYXZlIGEgTkVXIGNvbm50cmFjayBzdGF0ZS4KLUEgSU5QVVQgLXAgdWRwIC1tIGNvbm50cmFjayAtLWN0c3RhdGUgTkVXIC1qIFVEUAojIEFsbG93aW5nIG5ldyBwcm90b2NvbC1zcGVjaWZpYyBjaGFpbnMgdG8gcHJvY2VzcyBwYWNrZXRzIGZvciBUQ1AgdGhhdCBoYXZlIGEgTkVXIGNvbm50cmFjayBzdGF0ZS4KLUEgSU5QVVQgLXAgdGNwIC0tc3luIC1tIGNvbm50cmFjayAtLWN0c3RhdGUgTkVXIC1qIFRDUAojIEFsbG93aW5nIG5ldyBwcm90b2NvbC1zcGVjaWZpYyBjaGFpbnMgdG8gcHJvY2VzcyBwYWNrZXRzIGZvciBJQ01QIHRoYXQgaGF2ZSBhIE5FVyBjb25udHJhY2sgc3RhdGUuCi1BIElOUFVUIC1wIGljbXAgLW0gY29ubnRyYWNrIC0tY3RzdGF0ZSBORVcgLWogSUNNUAoKIyBSZWplY3QgYW55dGhpbmcgYXQgdGhpcyBwb2ludC4gQW5kIHByaW50IG91dCByZWplY3Rpb24gbWVzc2FnZSB3aXRoIGl0cyBzcGVjaWZpYyBwcm90b2NvbC4KIyBJc3N1aW5nIGFuIElDTVAgInBvcnQgdW5yZWFjaGFibGUiIG1lc3NhZ2UgdG8gYW55IG5ldyBpbmNvbWluZyBVRFAgcGFja2V0cywgcmVqZWN0aW5nIHRoZW0uCi1BIElOUFVUIC1wIHVkcCAtaiBSRUpFQ1QgLS1yZWplY3Qtd2l0aCBpY21wLXBvcnQtdW5yZWFjaGFibGUKIyBJc3N1aW5nIGEgInRjcC1yZXNldCIgbWVzc2FnZSB0byBhbnkgbmV3IGluY29taW5nIFRDUCBwYWNrZXRzLCByZWplY3RpbmcgdGhlbS4KLUEgSU5QVVQgLXAgdGNwIC1qIFJFSkVDVCAtLXJlamVjdC13aXRoIHRjcC1yZXNldAojIElzc3VpbmcgYW4gImljbXAtcHJvdG8tdW5yZWFjaGFibGUiIG1lc3NhZ2UgdG8gYW55IG5ldyBpbmNvbWluZyBUQ1AgcGFja2V0cywgZHJvcHBpbmcgYWxsIG90aGVyIGluY29taW5nIHBhY2tldHMuCi1BIElOUFVUIC1qIFJFSkVDVCAtLXJlamVjdC13aXRoIGljbXAtcHJvdG8tdW5yZWFjaGFibGUKCiMgQ29tbWl0IHRoZSBjaGFuZ2VzCkNPTU1JVAoKKnJhdwojIEFsbG93aW5nIHBhY2tldHMgaW4gdGhlIFBSRVJPVVRJTkcgY2hhaW4KOlBSRVJPVVRJTkcgQUNDRVBUIFswOjBdCiMgQWxsb3dzIHBhY2tldHMgaW4gdGhlIE9VVFBVVCBjaGFpbiwgd2hpY2ggaXMgdXNlZCBmb3IgbG9jYWxseSBnZW5lcmF0ZWQgcGFja2V0cwo6T1VUUFVUIEFDQ0VQVCBbMDowXQojIENvbW1pdHMgdGhlIGNoYW5nZXMgdG8gdGhlIGtlcm5lbApDT01NSVQKIyBOQVQgdGFibGUgaXMgdXNlZCB0byBhbHRlciBwYWNrZXRzIGFzIHRoZXkgYXJlIHJvdXRlZCB0aHJvdWdoIHRoZSBzeXN0ZW0KKm5hdAo6UFJFUk9VVElORyBBQ0NFUFQgWzA6MF0KIyBBbGxvd2luZyBwYWNrZXRzIGluIHRoZSBJTlBVVCBjaGFpbnMgZm9yIE5BVAo6SU5QVVQgQUNDRVBUIFswOjBdCiMgQWxsb3dpbmcgcGFja2V0cyBpbiB0aGUgT1VUUFVUIGNoYWlucyBmb3IgTkFUCjpPVVRQVVQgQUNDRVBUIFswOjBdCiMgQWxsb3dpbmcgcGFja2V0cyBpbiB0aGUgUE9TVFJPVVRJTkcgY2hhaW5zIGZvciBOQVQKOlBPU1RST1VUSU5HIEFDQ0VQVCBbMDowXQojIENvbW1pdHMgdGhlIGNoYW5nZXMgdG8gdGhlIGtlcm5lbApDT01NSVQKCipzZWN1cml0eQojIEFsbG93aW5nIHBhY2tldHMgaW4gdGhlIElOUFVUIGNoYWlucyBmb3Igc2VjdXJpdHkKOklOUFVUIEFDQ0VQVCBbMDowXQojIEFsbG93aW5nIHBhY2tldHMgaW4gdGhlIEZPUldBUkQgY2hhaW5zIGZvciBzZWN1cml0eQo6Rk9SV0FSRCBBQ0NFUFQgWzA6MF0KIyBBbGxvd2luZyBwYWNrZXRzIGluIHRoZSBPVVRQVVQgY2hhaW5zIGZvciBzZWN1cml0eQo6T1VUUFVUIEFDQ0VQVCBbMDowXQojIENvbW1pdHMgdGhlIGNoYW5nZXMgdG8gdGhlIGtlcm5lbApDT01NSVQKCiptYW5nbGUKIyBBbGxvd2luZyBwYWNrZXRzIGluIHRoZSBQUkVST1VUSU5HIGNoYWlucyBmb3IgbWFuZ2xlCjpQUkVST1VUSU5HIEFDQ0VQVCBbMDowXQojIEFsbG93aW5nIHBhY2tldHMgaW4gdGhlIElOUFVUIGNoYWlucyBmb3IgbWFuZ2xlCjpJTlBVVCBBQ0NFUFQgWzA6MF0KIyBBbGxvd2luZyBwYWNrZXRzIGluIHRoZSBGT1JXQVJEIGNoYWlucyBmb3IgbWFuZ2xlCjpGT1JXQVJEIEFDQ0VQVCBbMDowXQojIEFsbG93aW5nIHBhY2tldHMgaW4gdGhlIE9VVFBVVCBjaGFpbnMgZm9yIG1hbmdsZQo6T1VUUFVUIEFDQ0VQVCBbMDowXQojIEFsbG93aW5nIHBhY2tldHMgaW4gdGhlIFBPU1RST1VUSU5HIGNoYWlucyBmb3IgbWFuZ2xlCjpQT1NUUk9VVElORyBBQ0NFUFQgWzA6MF0KIyBDb21taXRzIHRoZSBjaGFuZ2VzIHRvIHRoZSBrZXJuZWwKQ09NTUlU" | base64 --decode > /etc/iptables/rules.v4
	sudo iptables-restore -t /etc/iptables/rules.v4 &> /dev/null
	echo "KmZpbHRlcgo6SU5QVVQgRFJPUCBbMDowXQo6Rk9SV0FSRCBEUk9QIFswOjBdCjpPVVRQVVQgRFJPUCBbMDowXQpDT01NSVQ=" | base64 --decode > /etc/iptables/rules.v6
	sudo ip6tables-restore -t /etc/iptables/rules.v6 &> /dev/null

	sudo service netfilter-persistent reload &> /dev/null
	sudo service netfilter-persistent save &> /dev/null
	
	echo -e "${Yellow}[*] ${Green}Configuring iptables"
	sudo iptables -A TCP -p tcp --dport 80 -j ACCEPT
	sudo iptables -A TCP -p tcp --dport 443 -j ACCEPT
	sudo service netfilter-persistent save &> /dev/null

	echo -e "${Yellow}[*] ${Green}Enter ip to allow connection seperated with space (if none press Enter)"
	read ips
	if ! [ -z "$var" ]; then
		for ip in ips
		do
			sudo iptables -A TCP -s $ip -j ACCEPT
		done
	fi

	sudo service netfilter-persistent save &> /dev/null
	echo -e "${Yellow}[*] ${Green}iptables configured succesfully"
	
	# SSH Configuration
	echo -e "${Yellow}[*] ${Green}Configuring SSH"
	echo -e "${Yellow}[*] ${Green}Enter default port for SSH (E.g 2223)"
	read ssh_port
	sed -i 's/#Port 22/Port ${ssh_port}/g' /etc/ssh/sshd_config
	sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
	sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
	sudo service ssh restart &> /dev/null

	echo -e "${Yellow}[*] ${Green}SSH port changed to ${ssh_port}"
	echo -e "${Yellow}[*] ${Green}SSH configured succesfully"
	echo -e "${Yellow}[*] ${Green}Waf Started Succesfully"
fi

# Live Security need to be done >
