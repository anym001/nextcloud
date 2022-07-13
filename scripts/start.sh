if [ -z "${MEMORY_LIMIT}" ]; then
    echo memory_limit="1024M" > /usr/local/etc/php/conf.d/z-memory-limit.ini
else
    echo "memory_limit=${MEMORY_LIMIT}" > /usr/local/etc/php/conf.d/z-memory-limit.ini
fi

# Start webserver, php, whatever,... add this here
