#!/bin/bash

RSA_KEY=~/.ssh/id_vagrant_rsa
SSH_CONFIG=~/.ssh/config
PUB_KEY_CWD=id_vagrant_rsa.pub

Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
EndColor='\033[0m'         # No color

# Function provides RSA key delivery for current directory
# Function generate the RSA key special for Vagrant Guest - Nginx VM  if RSA key does not exist.
# Operation is ommited if RSA key exist.
# Then present RSA key is copied to current directory
function rsa_keygen () {
    if ! test -f "${RSA_KEY}"; then
        ssh-keygen -b 2048 -f ${RSA_KEY} -t rsa -q -N ""
	echo -e "${Red}[1]${EndColor} Key ${Yellow}${RSA_KEY}${EndColor} has been created."
    fi
    
    cp ${RSA_KEY}.pub .
    echo -e "${Red}[2]${EndColor} Public Key ${Yellow}${RSA_KEY}.pub${EndColor} copied to directory ${Yellow}$(pwd)${EndColor}."
}

function clear_rsa () {
	rm -f ${RSA_KEY}
	rm -f ${RSA_KEY}.pub
	rm -f ./${PUB_KEY_CWD}
	echo -e "${Red}[1]${EndColor} Following files has been removed:
- ${Yellow}${RSA_KEY}${EndColor}
- ${Yellow}${RSA_KEY}.pub${EndColor}
- ${Yellow}$(pwd)/${PUB_KEY_CWD}${EndColor}"
}

# Funtion append data described below to SSH config file.
# If data written below exists in file, whole operation is ommited.
function append_ssh_config () {
    if test -f "${SSH_CONFIG}" ; then
	if [[ $(grep nginx-tutorial ${SSH_CONFIG} | wc -l) -eq 0 ]] ; then
echo -e "${Red}[3]${EndColor} The following content has been copied to file ${Yellow}${SSH_CONFIG}${EndColor}\n# https://github.com/piechota1989/nginx-tutorial #nginx-tutorial 
Host nginx-vagrant         
  HostName 192.168.56.56   
  User vagrant             
  IdentityFile ${RSA_KEY}  

# https://github.com/piechota1989/nginx-tutorial #nginx-tutorial
Host nginx-root            
  HostName 192.168.56.56   
  User root                
  IdentityFile ${RSA_KEY}"

		
echo -e "# https://github.com/piechota1989/nginx-tutorial #nginx-tutorial 
Host nginx-vagrant         
  HostName 192.168.56.56   
  User vagrant             
  IdentityFile ${RSA_KEY}  

# https://github.com/piechota1989/nginx-tutorial #nginx-tutorial
Host nginx-root            
  HostName 192.168.56.56   
  User root                
  IdentityFile ${RSA_KEY}  
" >> ${SSH_CONFIG}
	fi
    fi
}

function clear_ssh_config () {
    sed -e '/#nginx-tutorial/, +5d' -i ${SSH_CONFIG}
    echo -e "${Red}[2]${EndColor} File ${Yellow}${SSH_CONFIG}${EndColor} has been cleared form data inserted by current script"
}

if [ "$1" == "init" ] ; then
    rsa_keygen
    append_ssh_config
elif [ "$1" == "clear" ] ; then
    clear_rsa
    clear_ssh_config
else
    echo -e "Use synax ${Green}./install.sh${EndColor} ${Yellow}[OPTION]${EndColor}. Available options:
${Yellow}clear${EndColor} - remove RSA key and clear SSH config in user directory
${Yellow}init${EndColor} - generate RSA key and append SSH settings into SSH config file"
fi
