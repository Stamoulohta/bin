#! /usr/bin/env sh

usage() {

    echo "Please provide one valid .po and one valid .pot file."
    exit 1
}

validate() {

    if [ $# -ne 2 ]; then
        usage
    fi

    po="$1"
    pot="$2"

    echo "$po" | grep -Eq ".po$"
    ret=$?
    echo "$pot" | grep -Eq ".pot$"
    let "ret += $?"

    if [ $ret -ne 0 ]; then
        usage
    fi

    if [ ! -e "$po" ] || [ ! -e "$pot" ]; then
        usage
    fi

    action "$po" "$pot"
}

action () {

    po="$1"
    pot="$2"
    id_i=0
    i=0

    while read line; do
        let "i += 1"

        if [ -z "$line" ]; then # Don't bother with empty lines
            continue
        fi

        echo "$line" | grep -Eq "^msgid\s"
        if [ $? -eq 0 ] && [ $(echo "$line" | grep -c "/") -eq 0 ]; then
            msgid="$line"
            id_i=$i
            continue
        fi

        echo "$line" | grep -Eq "^msgstr\s"
        if [ $? -eq 0 ]; then
            msgstr="$line"
            let "id_i += 1"
            if [ $id_i -eq $i ]; then
                pot_i=$(sed -n "/$msgid/=" "$pot")
                if [ $(echo "$pot_i" | wc -w) -ne 1 ]; then # More than one match
                    continue
                fi
                let "pot_i += 1" # move index from msgid to msgstr
                sed -i "${pot_i}c ${msgstr}" "$pot"
            fi
        fi

    done < "$po"
}

validate $@
