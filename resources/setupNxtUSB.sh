#!/bin/sh

# Do all the steps required to set up USB support for NXT on Linux.
# Feel free to modify this file.
#
# This file is run without !
#
# Syntax:
# ./setupNxtUSB.sh
#
#
# This is required to correctly resolve ${USER}.  It runs 
# when required, which should cache the password properly.

# One location to change the group, if you would like
LEGO_GROUP=legonxt

# Try to become root on a harmless command
echo "Trying to become root"
if (  ls / >> /dev/null ); then
    echo Could become root successfully
else
    echo ERROR: Could NOT become root successfully
    exit 0;
fi


# Create the right group
if (  addgroup ${LEGO_GROUP} ); then
    echo Group ${LEGO_GROUP} created;
else
    echo ERROR: Group ${LEGO_GROUP} could NOT be created;
    exit 0;
fi


# Add your username to the group
if (  adduser ${USER} ${LEGO_GROUP} ); then
    echo User ${USER} added to group ${LEGO_GROUP}
else
    echo ERROR: User ${USER} could NOT be added to group ${LEGO_GROUP}
    exit 0;
fi



# Specify the /dev/legonxt-* device
RULES_FILE=$(mktemp)
cat <<EOF > ${RULES_FILE}
SUBSYSTEM=="usb_device", ACTION=="add", SYSFS{idVendor}=="0694",
SYSFS{idProduct}=="0002", SYMLINK+="legonxt-%k", GROUP="${LEGO_GROUP}", MODE="0660", RUN+="/etc/udev/legonxt.sh"

EOF
if (  mv ${RULES_FILE} /etc/udev/rules.d/45-legonxt.rules ); then
    echo File /etc/udev/rules.d/45-legonxt.rules written
else
    echo ERROR: File /etc/udev/rules.d/45-legonxt.rules could NOT be written
    rm ${RULES_FILE}
    exit 0;
fi



# Now set up the script that sets the permissions
SHELL_FILE=$(mktemp)
cat <<EOF > ${SHELL_FILE}
#!/bin/bash
#
GROUP=${LEGO_GROUP}

if [ "\${ACTION}" = "add" ] && [ -f "\${DEVICE}" ]
then
    chmod o-rwx "\${DEVICE}"
    chgrp "\${GROUP}" "\${DEVICE}"
    chmod g+rw "\${DEVICE}"
fi

EOF
chmod a+x ${SHELL_FILE}
if ( mv ${SHELL_FILE} /etc/udev/legonxt.sh ); then
    echo File /etc/udev/legonxt.sh written
else
    echo ERROR: File /etc/udev/legonxt.sh could NOT be written
    rm ${SHELL_FILE}
    exit 0;
fi

echo "Complete success!"

