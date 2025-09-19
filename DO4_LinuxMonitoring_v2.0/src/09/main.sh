#!/bin/bash

output="/var/www/html/metrics.html"
#output="./metrics.html"

metrics() {
    {
        echo "# HELP cpu_usage CPU usage in percentage"
        echo "# TYPE cpu_usage gauge"
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
        echo "cpu_usage ${cpu_usage}"

        echo "# HELP memory_total Total memory in MB"
        echo "# TYPE memory_total gauge"
        memory_total=$(free -m | awk '/^Mem:/{print $2}')
        echo "memory_total ${memory_total}"

        echo "# HELP memory_used Used memory in MB"
        echo "# TYPE memory_used gauge"
        memory_used=$(free -m | awk '/^Mem:/{print $3}')
        echo "memory_used ${memory_used}"

        echo "# HELP memory_free Free memory in MB"
        echo "# TYPE memory_free gauge"
        memory_free=$(free -m | awk '/^Mem:/{print $4}')
        echo "memory_free ${memory_free}"

        echo "# HELP disk_total Total disk space in KB"
        echo "# TYPE disk_total gauge"
        disk_total=$(df / | awk 'NR==2 {print $2}')
        echo "disk_total ${disk_total}"

        echo "# HELP disk_used Used disk space in KB"
        echo "# TYPE disk_used gauge"
        disk_used=$(df / | awk 'NR==2 {print $3}')
        echo "disk_used ${disk_used}"

        echo "# HELP disk_free Free disk space in KB"
        echo "# TYPE disk_free gauge"
        disk_free=$(df / | awk 'NR==2 {print $4}')
        echo "disk_free ${disk_free}"

    } > "$output"
}

while true; do
  metrics
  sleep 3
done


