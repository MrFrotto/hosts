#!/bin/bash

verifica_ip() {
    local host="$1"
    local ip_asteptat="$2"
    local dns_server="$3"

    rezolvat_ip=$(
        nslookup "$host" "$dns_server" 2>/dev/null |
        awk '/^Address: / {print $2}' |
        tail -n 1
    )

    if [ "$rezolvat_ip" = "$ip_asteptat" ]; then
        echo "OK: $host -> $ip_asteptat"
        return 0
    else
        echo "EROARE: $host rezolvat la $rezolvat_ip, asteptat $ip_asteptat"
        return 1
    fi
}

if [ $# -ne 3 ]; then
    echo "Utilizare: $0 <host> <ip> <server_dns>"
    exit 1
fi

verifica_ip "$1" "$2" "$3"
exit $?

