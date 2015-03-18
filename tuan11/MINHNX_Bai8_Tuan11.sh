#!/bin/bash

echo "Tim va xoa file duoi 1M"
 path=`pwd`
 du -a $path/ | awk '$1 < 1024' | awk -F / '{print $NF}' >> danhsach.txt

 dlt=`cat danhsach.txt`
 rm -rf $dlt

echo "Ket thuc"
