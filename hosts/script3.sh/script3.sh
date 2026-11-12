#!/bin/bash

cat /etc/hosts | while read -r ip host rest
do
    [ -z "$ip" ] && continue
    [[ "$ip" =~ ^# ]] && continue
    [ -z "$host" ] && continue

    ns_ip=$(nslookup -type=A "$host" 8.8.8.8 2>/dev/null | \
            awk '/^Address: / {print $2}' | tail -n 1)
    # Dacă nslookup a returnat un IP diferit
    if  [ -n "$ns_ip" ]&&[ "$ns_ip" != "$ip" ]; then
        echo "Bogus IP for $host in /etc/hosts! "
    fi
done
