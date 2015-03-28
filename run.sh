#!/bin/bash
if [ "$1" ] && [ "$2" ]
then
  WERCKER_GRAILS_VERSION=$1
  WERCKER_GRAILS_OPTIONS=$2
fi

if [ "$WERCKER_GRAILS_VERSION" ]
then
    case "$WERCKER_GRAILS_VERSION" in
        "2.5.0" )
            GRAILS_HOME=/lib/grails-$WERCKER_GRAILS_VERSION;;
        
        * )
            echo "unknown version:$WERCKER_GRAILS_VERSION"
    esac
    case "$(uname -s)" in
        "Darwin" )
            ;;# export JAVA_HOME=$(dirname $(readlink $(which javac)));;
        "Linux" )
            export JAVA_HOME=/usr/lib/jvm/java-8-oracle;;
        * )
         echo "unknown system: $(uname -s)"
         exit 0
    esac
    export PATH="$PATH:$JAVA_HOME/bin"
    export PATH="$PATH:$GRAILS_HOME/bin"
    echo "--- RUN WITH GRAILS $WERCKER_GRAILS_VERSION ----"
    $GRAILS_HOME/bin/grails $WERCKER_GRAILS_OPTIONS
else
    echo "version:<not set>"
fi
