# # 초미세먼지 데이터 : ‘2015년 초미세먼지.xlsx’를 다운받아 사용

# 1. 데이터 불러오기
library(readxl)


# 현재 디렉토리(폴더)가 어디인지 확인
getwd()

# 첫번째 시트 읽기
mese1 <- read_excel("2015년 초미세먼지.xlsx", sheet = 1)
# 두번째 시트 읽기
mese2 <- read_excel("2015년 초미세먼지.xlsx", sheet = 2)

# mese1의 구조 확인
str(mese1)

# mese2의 구조 확인
str(mese2)

# 두 데이터를 rbind를 이용하여 합치기 (위/ 아래로, 케이스 추가), 총 1,361,486개의 데이터
mise <- rbind(mese1, mese2)
str(mise)

# 데이터 mise의 앞부분 확인
head(mise)

# 데이터 mise의 뒷부분 확인
tail(mise)

# 측정 시군구 (AREA) 의 빈도표
table(mise$AREA)

# 패키지 stringr 로드 (필요시 설치)
library(stringr)

# AREA의 첫 단어는 광역시도를 뜻함. 광역시도를 추출하여 Sido에 저장
mise$Sido <- word(mise$AREA)
tail(mise)

# Sido의 빈도표
table(mise$Sido)

# 충북 데이터만 추출
cb <- subset(mise, Sido == "충북")
head(cb)

# 충북의 측정시군구(AREA) 빈도표
table(cb$AREA)

# 미세먼지 (PM10) 와 초미세먼지 (PM25)의 기술통계량
summary(cb[,c("PM10", "PM25")])

# 충북의 PM10의 전체 평균 (결측값 제외)
mean(cb$PM25, na.rm=TRUE) # 빈칸 제외하는 옶션 na.rm=TRUE

# 충북의 월별 PM의 평균 구하기
group_mean <- round(tapply(cb$PM10, cb$Month, mean, na.rm=TRUE), 2)
print(group_mean)

# 충북의 시군구별 PM의 평균 구하기
group_mean <- round(tapply(cb$PM10, cb$AREA, mean, na.rm=TRUE), 2)
print(group_mean)

# 서울, 부산 데이터만 추출하여 two에 저장/빈도표 보기
# 논리연산자 or(|) 사용
two <- subset(mise, Sido == "서울" | Sido == "부산")
table(two$Sido)

# 서울, 부산 두 도시의 미세먼지(PM10)의 평균 (6개월간)
group_mean <- round(tapply(two$PM10, two$Sido, mean, na.rm=TRUE), 2)
print(group_mean)

# 6개 광역시 데이터만 추출
# 도시수가 많아 or 보다는 %in% 연산자 사용
wide <- subset(mise, Sido %in% c("인천", "광주", "부산", "울산", "대구", "대전"))
table(wide$Sido)

# 6개 광역시의 미세먼지 평균
group_mean <- round(tapply(wide$PM10, wide$Sido, mean, na.rm=TRUE), 2)
print(group_mean)