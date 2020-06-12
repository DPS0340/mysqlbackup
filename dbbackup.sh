#!/bin/bash

# 오픈소스 파이썬 스크립트를 이지호가 포크 후 2019년 1월에 수정하였음
# 그 후 2020년 6월에 bash 스크립트로 컨버전하였다

# github 레포지토리
# 원본: https://github.com/tecrahul/python-mysql-backup
# 포크: https://github.com/DPS0340/mysqlbackup/tree/bash-script

# 스크립트 파일의 디렉토리 저장
script_dir=$(cd $(dirname "$0"); pwd)

echo "Checking Variables..."
echo ""
echo "DB_HOST=$DB_HOST"
echo "DB_USER=$DB_USER"
echo "DB_USER_PASSWORD=$DB_USER_PASSWORD"
echo "DB_NAME=$DB_NAME"
echo ""


# DB_USER_PASSWORD는 공백도 가능해야하므로 체크하지 않음
if [ -z "$DB_HOST" ] || [ -z "$DB_USER" ] || [ -z "$DB_NAME" ]
then
echo "At least one of variables(DB_HOST, DB_USER, DB_NAME) is unset.";
echo "Please retry after export some environment variables."
exit 1
fi

echo "directory of script file: $script_dir"

