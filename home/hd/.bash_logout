removehistorydups() {
    tmpfile=$(mktemp)
    tac $HISTFILE | cat -n | sort -uk2 | sort -nk1 | cut -f2- | tac > $tmpfile
    cat $tmpfile > $HISTFILE
    rm $tmpfile
}

removehistorydups
