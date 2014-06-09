#!/bin/bash
if [ `pcp_pool_status  1 localhost 9898 root test |sed '/backend_status1/,/desc/ !d' |grep value |cut -d' ' -f2` -eq 3 ]
then
        echo offline
        pcp_attach_node  1 localhost 9898 root test 1
fi

if [ `pcp_pool_status  1 localhost 9898 root test |sed '/backend_status0/,/desc/ !d' |grep value |cut -d' ' -f2` -eq 3 ]
then
        echo offline
        pcp_attach_node  1 localhost 9898 root test 0
fi

