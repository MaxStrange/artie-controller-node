export PS1='\h:\w\$ '
umask 022

# Color ls command
export LS_OPTIONS='--color=auto'
eval `dircolors`
alias ls='ls $LS_OPTIONS'

# Keep dmesg from spouting stuff at us all the time
dmesg -n 1
