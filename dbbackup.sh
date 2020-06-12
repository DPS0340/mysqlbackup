#!/bin/bash

# 리눅스/유닉스 환경에서의 mysql 백업 스크립트
# cron과 연동하는 것을 전제로 설계되었음

# Rahul Kumar의 오픈소스 파이썬 스크립트를 이지호가 포크 후 2019년 1월에 수정하였음 - 주로 매개변수 설정 관련
# 그 후 2020년 6월에 bash 스크립트로 컨버전하였다 - 유닉스기초 3차과제 발표 코드 용도로 작성

# github 레포지토리
# 원본(Rahul Kumar): https://github.com/tecrahul/python-mysql-backup
# 포크(jiho lee): https://github.com/DPS0340/mysqlbackup

# 스크립트 파일의 디렉토리 저장
script_dir=$(cd $(dirname "$0"); pwd)
backup_path="$script_dir/backup"

# 현재 시간을 포매팅하여 저장
# 백업 폴더 이름으로 사용됨
now=$(date +'%Y%m%d-%H%M%S')

# 백업 폴더 경로 작성
today_backup_path="$backup_path/$now"

# 환경 변수 상태 출력
echo "Checking Variables..."
echo ""
echo "DB_HOST=$DB_HOST"
echo "DB_USER=$DB_USER"
# 비밀번호는 출력하지 않음
echo "DB_USER_PASSWORD=*****"
echo "DB_NAME=$DB_NAME"
echo "directory of script file: $script_dir"
echo "backup folder: $backup_path"
echo ""

# 변수들이 설정되어있는지 체크
# DB_USER_PASSWORD는 공백도 가능해야하므로 체크하지 않음
if [ -z "$DB_HOST" ] || [ -z "$DB_USER" ] || [ -z "$DB_NAME" ]
then
# 오류 메시지 출력
echo "At least one of variables(DB_HOST, DB_USER, DB_NAME) is unset.";
echo "Please retry after export some environment variables."
# 프로그램 종료
exit 1
fi

# 백업 폴더가 없다면 새로 생성
mkdir -p $today_backup_path

# 백업, 압축 커맨드 작성
backup_command="mysqldump -h $DB_HOST -u $DB_USER -p '$DB_USER_PASSWORD' $DB_NAME > $today_backup_path/db.sql"
gzipcmd = "gzip $today_backup_path/db.sql"

# 커맨드 출력
echo "$backup_command"
echo "$gzipcmd"

# 커맨드 실행
eval backup_command
eval gzip

echo "done!"
