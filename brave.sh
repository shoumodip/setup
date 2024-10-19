#!/bin/sh

OS=linux
BASE=$HOME/Software

confirm() {
    read -p ". Proceed? (y/n) " choice
    [ "$choice" = "" ] || [ "$choice" = "y" ] || [ "$choice" = "Y" ]
}

if [ "$1" = "clean" ]; then
    ACTUAL="brave-$(realpath $BASE/brave | sed "s|$BASE/brave-||")"
    OTHERS=$(ls $BASE | grep "brave-")

    for other in $OTHERS; do
        if [ ! "$other" = "$ACTUAL" ]; then
            printf "Outdated installation '$other' will be removed"
            if confirm; then
                rm -rf $BASE/$other
            fi
        fi
    done

    exit
fi

URL=$(curl -s https://api.github.com/repos/brave/brave-browser/releases/latest \
    | grep "browser_download_url.*$OS-amd64.*zip" \
    | head -n 1 \
    | cut -d ":" -f 2,3 \
    | tr -d '"')

NEW_VERSION=$(echo $URL | sed "s|.*/v||;s|/.*||")

if [ -d $BASE/brave ]; then
    OLD_VERSION=$(realpath $BASE/brave | sed "s|$BASE/brave-||")
    if [ "$OLD_VERSION" = "$NEW_VERSION" ]; then
        echo "Brave is already up to date!"
        exit
    fi

    printf "Brave will be updated ($OLD_VERSION -> $NEW_VERSION)"
else
    printf "Brave will be installed"
fi

if confirm; then
    DIR=brave-$NEW_VERSION
    ZIP="brave-browser-$NEW_VERSION-$OS-amd64.zip"

    cd $BASE
    mkdir $DIR && cd $DIR
    curl -LO $URL
    unzip $ZIP && rm $ZIP
    cd ..
    unlink brave
    ln -sf $BASE/$DIR brave
fi

echo "Brave $NEW_VERSION installed successfully!"
