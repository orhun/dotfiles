#!/usr/bin/env bash
# witch - watches a process by running top continuously

PID=$(pidof $1 | awk '{print $1}')
if [[ $PID ]]; then
    echo "==> SYS:" `uname -a`
    echo "==> CPU:" `awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | cut -c 2-`
    echo "==> MEM:" `awk '/MemTotal/ {print $2 " kB"}' /proc/meminfo`
    echo "    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND"
    while :
    do
        top -b -p $PID -n 1 | tail -1
	    sleep 0.1
    done
else
    echo "==> ERROR: No process to watch."
fi
