#!/bin/bash
WORK_DIR=$HOME/.brightness_conf
BIN_XRANDR=$(which xrandr)

if [ ! -d $WORK_DIR ]; then
    $(mkdir -p $WORK_DIR)
fi

error="Please, set:\n"

if [ -z $1 ]; then
    get_mons=$(xrandr -q | grep ' connected')
    error="$error TARGET[monitor name].\n To get monitor name, you can use:\n\t xrandr -q | grep ' connected'
_________________________________________________________________________________________________
Your monitors are:
The first word are the name, like 'HDMI-1', 'eDP-1', etc.\n
$get_mons
-------------------------------------------------------------------------------------------------\n\n"
else
    mon_target_name=$1
fi

if [ -z $2 ]; then
    error="$error ACTION[up|down] default=up"
else
    if [[ $2 == 'up' || $2 == 'down' ]]; then
        doit=$2
        has_error='yes'
    else
        echo -e "\nPlease, to ACTION use 'up' or 'down' \nSetting as 'up'\n"
        doit='up'
        has_error='yes'
    fi    
fi

if [[ -z $1 || -z $2 ]]; then
    echo -e "$error"
    exit
fi

mon_target_file_conf="$WORK_DIR/mon_${mon_target_name}_conf.txt"

if [ ! -f $mon_target_file_conf ]; then
    $(touch $mon_target_file_conf)
    $(echo '9' > $mon_target_file_conf)
fi

mon_target_with_paramns="$BIN_XRANDR --output $mon_target_name --brightness"
left=0

mon_target_val=$(cat $mon_target_file_conf) #Value of mon_target_file_conf

if [[ $doit == 'up' ]]; then

    if [ $mon_target_val -eq 0 ]; then
        left=1
        do_operation=0
    else
        do_operation=$((mon_target_val+1))
    fi
    
    # do_operation=$((mon_target_val+1))    #Val after sum

    if [ $do_operation -gt 9 ]; then
        left=1
        do_operation=0
    fi
fi

if [[ $doit == 'down' ]]; then

    if [ $mon_target_val -le 1 ]; then
        if [ $mon_target_val -eq 1 ]; then
            left=0
            do_operation=0
        else
            left=0
            do_operation=9
        fi
    else
        do_operation=$((mon_target_val-1))    #Val after sum
    fi

    # do_operation=$((mon_target_val-1))    #Val after sum

    if [ $do_operation -le 0 ]; then
        left=0
        do_operation=1
    fi
fi

if [[ $doit != 'up' ]] && [[ $doit != 'down' ]]; then
    $mon_target_with_paramns 1.0
fi

$(echo $do_operation > $mon_target_file_conf)

after_operation=$do_operation
run_tis="$mon_target_with_paramns $left.$after_operation"

$run_tis                                        #Finaly Run

echo -e "\nWas executed [$doit]: \n$run_tis\n"  #Show Run code
