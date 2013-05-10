#!/usr/bin/env bash

TMP="$(dirname $(mktemp --dry-run 2>/dev/null || echo "/var/tmp/tmp_dir"))/php-build"

download_phpcsfixer() {
    local phpcsfixer_url="$1"

    if [ -z "$phpcsfixer_url" ]; then
        phpcsfixer_url="http://cs.sensiolabs.org/get/php-cs-fixer.phar"
    fi

    echo "php-cs-fixer" "Downloading from $phpcsfixer_url" >&3

    if [ ! -f "$TMP/packages/php-cs-fixer.phar" ]; then
        wget -P "$TMP/packages" $phpcsfixer_url
    fi
}

copy_phpcsfixer_phar() {
    cp "$TMP/packages/php-cs-fixer.phar" "$PREFIX/bin/php-cs-fixer.phar"
}

install_phpcsfixer() {
    download_phpcsfixer
    copy_phpcsfixer_phar

    echo "php-cs-fixer" "Installing executable in $PREFIX/bin/php-cs-fixer" >&3
    
    mv "$PREFIX/bin/php-cs-fixer.phar" "$PREFIX/bin/php-cs-fixer"

    chmod a+x "$PREFIX/bin/php-cs-fixer"
}

install_phpcsfixer