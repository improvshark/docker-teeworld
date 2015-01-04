HOSTPORT=8303
CONTAINERPORT=8303/udp
HOSTPORTTWO=8304
CONTAINERPORTTWO=8304

USERNAME=improvshark
NAME=tworld
DIRECTORY=tworld

function install_game {

    if [ !  -d $DIRECTORY ]; then
        mkdir $DIRECTORY
        cd $DIRECTORY
        curl -s https://downloads.teeworlds.com/teeworlds-0.6.3-linux_x86_64.tar.gz | tar -vxz
        cd ..
    fi
}

function launch_local {
  tworld/teeworlds-0.6.3-linux_x86_64/teeworlds_srv -f ./server.cfg
}

function launch {
    docker rm $NAME
    docker run  --name $NAME -d -p $HOSTPORT:$CONTAINERPORT -p $HOSTPORTTWO:$CONTAINERPORTTWO $USERNAME/$NAME
}

function build {
    docker build -t improvshark/$NAME .
}








case $1 in


    ''|'-h'|'help')
        echo "usage:  srv.sh <option>"
        echo "  update"
        echo "  download"
        echo "  build"
        echo "  launch"
    ;;

    'download') echo "downloading localy!"
        install_game
    ;;
    'build')
        echo "building!"
        build
    ;;
    'start'|'launch')
        echo "launching!"
        launch
    ;;
    'startLocal'|'launchLocal'|'local')
    echo "launching localy!"
    launch_local
    ;; 
    'clean')
        rm -rf ./$DIRECTORY
    ;;

esac
