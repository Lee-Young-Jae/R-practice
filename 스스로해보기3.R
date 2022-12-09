# TLS의 자료실에 있는 “2015년 초미세먼지.xlsx”에 대하여 다음 과제를 수행하시오.

# 1. 파일에는 3개의 시트(1분기, 2분기, 3분기)가 있다. 각각의 시트를 읽어 각각 mise1, mise2, mise3에 저장하는 코드를 작성
mise1 <- read_excel("2015년 초미세먼지.xlsx", sheet = 1)
mise2 <- read_excel("2015년 초미세먼지.xlsx", sheet = 2)
mise3 <- read_excel("2015년 초미세먼지.xlsx", sheet = 3)

# rbind를 이용하여 mise1, mise2, mise3를 합쳐 mise라는 데이터 프레임을 만들고, mise의 구조를 확인
mise <- rbind(mise1, mise2, mise3)

# 3. 데이터프레임 mise의 구조(str) 출력
str(mise)

# 4. 무작정따라하기-3 을 참고하여 변수 AREA 중에서 광역시도를 추출하여 새로운 변수 Sido를 추가하고 head 출력
# mise$Sido <- substr(mise$AREA, 1, 2)
mise$Sido <- word(mise$AREA)


head(mise)

# AREA가 서울인 데이터만 추출하여 seoul에 저장하고 Point의 빈도표 구하기
seoul <- subset(mise, AREA == "서울")
table(seoul$Point)

# 서울의 PM10과 PM25의 평균 구하기 (결측값 제외)
mean(seoul$PM10, na.rm = TRUE)
mean(seoul$PM25, na.rm = TRUE)

# 서울의 PM10의 월별 평균 구하기 (결측값 제외)
round(tapply(seoul$PM10, seoul$Month, mean, na.rm = TRUE), 2)

# Sido가 경기, 강원, 제주인 데이터만 추출하여 three에 저장하고 Sido의 빈도표 구하기
three <- subset(mise, Sido %in% c("경기", "강원", "제주"))
table(three$Sido)

# 데이터 three에 대하여 Sido 별 PM10의 평균 구하기
round(tapply(three$PM10, three$Sido, mean, na.rm = TRUE), 2)

# 데이터 three에 대하여 월별 PM10의 평균 구하기
round(tapply(three$PM10, three$Month, mean, na.rm = TRUE), 2)

# 강의자료실에 있는 “도로교통공단_시군구별 월별 교통사고 통계_20211231.xlsx”에 대하여 다음 과제를 수행하시오.
# 11. 파일을 읽고 head 출력
accident <- read_excel("도로교통공단_시군구별 월별 교통사고 통계_20211231.xlsx")
head(accident)

# 12. 4개의 변수 ‘사고건수’, ‘사망자수’, ‘중상자수’, ‘경상자수’의 요약통계량
summary(accident[, 4:7])

# 13. 사고건수가 380건 이상인 데이터만 추출하여 출력
accident[accident$사고건수 >= 380, ]

# 14. 월별 사고건수의 평균 구하기
round(tapply(accident$사고건수, accident$발생월, mean), 2)

# 15. 1, 2, 3, 4월의 데이터만 추출하여 변수 data2에 저장하고 빈도수 출력
data2 <- subset(accident, 발생월 %in% c(1, 2, 3, 4))
table(data2$발생월)

# 변수 data2의 월별 사고건수의 평균 구하기
round(tapply(data2$사고건수, data2$발생월, mean), 2)

# 17. 시군구가 충주시, 제천시, 청주시인 3도시만 추출하여 변수 cb에 저장하고 구조 출력
cb <- subset(accident, 시군구 %in% c("충주시", "제천시", "청주시"))

# 18. 세 도시 충주시, 제천시, 청주시의 사고건수의 평균 출력
round(tapply(cb$사고건수, cb$시군구, mean), 2)
