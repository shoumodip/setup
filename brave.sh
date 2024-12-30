#!/bin/sh

OS=${OS:-linux}
LINK=${LINK:-$HOME/.local/bin/brave}
BASE=${BASE:-$HOME/.local/share/brave}

mkdir -p "$BASE"
mkdir -p "$(dirname "$LINK")"

confirm() {
    read -p ". Proceed? (y/n) " choice
    [ "$choice" = "" ] || [ "$choice" = "y" ] || [ "$choice" = "Y" ]
}

if [ "$1" = "clean" ]; then
    ACTUAL="brave-$(realpath "$LINK" | sed "s|$BASE/brave-||;s|/.*||")"
    OTHERS=$(ls "$BASE" | grep "brave-")

    for other in $OTHERS; do
        if [ ! "$other" = "$ACTUAL" ]; then
            printf "Outdated installation '$other' will be removed"
            if confirm; then
                rm -rf "$BASE/$other"
            fi
        fi
    done

    exit
fi

URL=$(curl -s "https://api.github.com/repos/brave/brave-browser/releases/latest" \
    | grep "browser_download_url.*$OS-amd64.*zip" \
    | head -n 1 \
    | cut -d ":" -f 2,3 \
    | tr -d ' "')

NEW_VERSION=$(echo $URL | sed "s|.*/v||;s|/.*||")

if [ -f "$LINK" ]; then
    OLD_VERSION=$(realpath "$LINK" | sed "s|$BASE/brave-||;s|/.*||")
    if [ "$OLD_VERSION" = "$NEW_VERSION" ]; then
        echo "Brave is already up to date!"
        exit
    fi

    printf "Brave will be updated ($OLD_VERSION -> $NEW_VERSION)"
else
    printf "Brave will be installed"
fi

if confirm; then
    DIR="brave-$NEW_VERSION"
    ZIP="brave-browser-$NEW_VERSION-$OS-amd64.zip"

    cd "$BASE"
    mkdir "$DIR" && cd "$DIR"
    curl -LO "$URL"
    unzip "$ZIP" && rm "$ZIP"
    cd ..
    [ -f "$LINK" ] && unlink "$LINK"
    ln -sf "$BASE/$DIR/brave-browser" "$LINK"
fi

echo "Brave $NEW_VERSION installed successfully!"
