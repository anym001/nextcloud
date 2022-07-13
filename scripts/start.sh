if [ -z "${MEMORY_LIMIT}" ]; 
then
    MEMORY_LIMIT="1024M"
else
    echo memory_limit=${MEMORY_LIMIT} > /usr/local/etc/php/conf.d/z-memory-limit.ini
fi
