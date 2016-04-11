ROOT="/home/network"
ROOT_EXCLUDE="--exclude=/dev --exclude=/proc --exclude=/sys --exclude=/temp --exclude=/run --exlucde=/mnt --exlcude=/media --exlude=/backup2.tgz --exclude=/lost+find"
DESTIN="/home/network/backupDest/"
BACKUP="backup.tgz"
CREATE="/dev /proc /sys /temp /run /mnt /media /lost+found "

if [ "$USER" != "root" ]; then
    echo "You are not the root user"
    echo "To use backup please use: sudo backup"
    exit
fi

clear

echo "************************************************"
echo "********* Backup Menu **************************"
echo "************************************************"

OPTIONS="BACKUP RESTORE DESTINATION EXIT"
LIST="1)BACKUP 2)RESTORE 3)DESTINATION 4)EXIT"

select opt in $OPTIONS; do
if [ "$opt" = "EXIT" ]; then
    echo "GOODBYE!"
    sleep 3
    clear
    exit

elif [ "$opt" = "BACKUP" ]; then
    echo "BACKING UP FILES..."
    sleep 2
    tar cvpfz $DESTIN/backup.`date +%d%m%y_%k:%M`.tgz $ROOT $ROOT_EXCLUDE_DIRS
    echo "BACKUP COMPLETE"
    sleep 2
    exit

elif [ "$opt" = "RESTORE" ]; then
    echo "RESTORING FILES..."
    sleep 2
    echo $BACKUP
    tar xvpfz $DESTIN/$BACKUP -C /
    sleep 2
    if [[ -e "/proc" ]]; then
            echo "$CREATE already exists! "
    else
            mkdir $CREATE
            echo "$CREATE are created! "
    fi
    echo "RESTORE COMPLETE..."
    exit
elif [ "$opt" = "DESTINATION" ]; then
    echo "CURRENT DESTINATION: $DEST_DIR/backup.`date +%d/%m/%y_%k:%M`.tgz "
    echo "TO CHANGE ENTER THE NEW DESTINATION..."
    echo "TO LEAVE IT AS IS JUST PRESS ENTER..."
    read NEW_DESTIN

    #IF GREATER THEN 0 ASSIGN NEW DESTINATION
    if [ ${#NEW_DESTIN} -gt 0 ]; then
            DESTIN = "$NEW_DESTIN"
    fi
    clear
    echo $BANNER1
    echo $BANNER2
    echo $BANNER3
    echo $LIST


else
    clear
    echo "BAD INPUT!"
    echo "ENTER 1 , 2, 3 or 4.."
    echo $LIST


fi
done
