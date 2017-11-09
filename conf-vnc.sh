#!/bin/bash
# brand new ubuntu instance on aws
# 2017-11-08
# P Campbell
#
# new instance setup part 2
# configure VNC
#
# 

# check if vnc is installed
dpkg -S vnc4server >/dev/null 2>&1
if [[ $? -ne 0 ]] ;  then
   you must run the conf-install.sh first
   exit 5
fi

read -p  "Enter a password for VNC, remember it" pass

prog=$(which vncpasswd)

expect <<EOPASS
spawn $prog
expect "Password: "
send "$pass\r"
expect "Verify: "
send "$pass\r"
expect eof
exit
EOPASS

# pmc maybe don't need this:
vncserver;vncserver -kill :1

cat <<EOXSTARTUP >> .vnc/xstartup
#!/bin/sh

# Uncomment the following two lines for normal desktop:
unset SESSION_MANAGER
exec /etc/X11/xinit/xinitrc

# gnome session workaround
# http://broderick-tech.com/vncxstartup-files-ubuntu-14-04/
#export XKL_XMODMAP_DISABLE=1
#unset SESSION_MANAGER
#unset DBUS_SESSION_BUS_ADDRESS

#gnome-panel &
#gnome-settings-daemon &
#metacity &
#nautilus &
#gnome-terminal &

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &


EOXSTARTUP
