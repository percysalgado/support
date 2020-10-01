#!/bin/bash
# Copyright 2014-2020 Carlos Salgado
# http://macadmins.pro
#
# Format [mm][dd]HH]MM[yy]
date 
echo
echo
cat << "EOF"
 __  __                 _       _           _             
|  \/  | __ _  ___     / \   __| |_ __ ___ (_)_ __  ___  
| |\/| |/ _` |/ __|   / _ \ / _` | '_ ` _ \| | '_ \/ __|     
| |  | | (_| | (__   / ___ \ (_| | | | | | | | | | \__ \  
|_|  |_|\__,_|\___| /_/   \_\__,_|_| |_| |_|_|_| |_|___/ 
                                                                            

Para soporte contacta a macadmin@macadmins.pro


CLIENTE: KERNEL HUAMANI

***************************************************
*          Informacion de tu equipo               *
***************************************************
EOF

/bin/echo Modelo de hardware : $(curl -s https://support-sp.apple.com/sp/product?cc=$( ioreg -l | grep IOPlatformSerialNumber | awk '{print $4}' | sed 's|"||g' | cut -b9-13 ) | sed "s@.*<configCode>\(.*\)</configCode>.*@\1@")
/bin/echo "CPU                : $(sysctl machdep.cpu.brand_string | sed "s/.*: \(.*\)/\1/g")"
/bin/echo "RAM                : $(($(sysctl hw.memsize|awk '{print $2}')/1024/1024/1024))GB"
/bin/echo "Serial Number      : $(ioreg -rd1 -c IOPlatformExpertDevice | awk -F'"' '/IOPlatformSerialNumber/{print $4}')"
/bin/echo "Bateria (ciclos)   : $(ioreg -l | grep CycleCount |  awk '{print $5}' | head -2 | tail -1) ciclos"
/bin/echo "***************************************************"
/bin/echo
/bin/echo
echo
echo SEGURO QUE DESEA REALIZAR UNA NUEVA INSTALACION DE MAC OS? 
echo 
echo ENTER PARA CONTINUAR ...... CTL-C PARA CANCELAR
read

diskutil partitionDisk disk0 GPT APFS macOS R
diskutil partitionDisk disk1 GPT APFS macOS R

echo -n "w46t59[RV\tF3@Y1UK}x6Nx" | hdiutil attach -stdinpass /Volumes/ker/autoinstall.10.15.7.02.dmg -noverify

/Volumes/install/run


echo Listo ...
echo
echo by Mac Admin ;) 

