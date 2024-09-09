#!/bin/sh

#  ci_post_clone.sh
#  Treehouse
#
#  Created by ParkJunHyuk on 9/9/24.
#

# Config.xcconfig 파일 생성
echo "환경변수 참조 Config.xcconfig file 생성시작"
# Secrets 경로 지정
cat <<EOF > "/Volumes/workspace/repository/Treehouse/Treehouse/Global/Resources/Config.xcconfig"

BASE_URL = $(BASE_URL)
ACCESS_TOKEN_KEY = $(ACCESS_TOKEN_KEY)
REFRESH_TOKEN_KEY = $(REFRESH_TOKEN_KEY)
LOGIN_KEY = $(LOGIN_KEY)
WEB_FRONT_URL = $(WEB_FRONT_URL)

echo "환경변수 참조 Secrets.xcconfig file 생성완료"
