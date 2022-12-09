# 1. 세 문자열 “I”, “love”, “R”을 paste()함수를 이용하여 다음 결과가 나오는 코드 작성

paste("I", "love", "R", sep = "-")

#  paste() 함수를 이용하여 다음의 결과가 나오는 코드 작성

# [1] "X.1" "X.2" "X.3" "X.4" "X.5" "X.6" "X.7" "X.8" "X.9" "X.10"
# [11] "X.11" "X.12" "X.13" "X.14" "X.15" "X.16" "X.17" "X.18" "X.19" "X.20"
# [21] "X.21" "X.22" "X.23" "X.24" "X.25" "X.26" "X.27" "X.28" "X.29" "X.30"

paste("X", 1:30, sep = ".")

#  msg <- "KokUk UniVersity NaTuraL SciEnce"의 모든 문자를 소문자로 변환하여 출력하는 코드 작성
msg <- "KokUk UniVersity NaTuraL SciEnce"
tolower(msg)

# 다음은 최근 4회의 하계 올림픽이 개최된 정보가 저장된 데이터프레임이다. 
# 데이터프레임 olympic을 생성하는 코드

olympic <- data.frame(no = c(32, 31, 30, 29), date = c(20210723, 20160805, 20120727, 20080808), 
                      place = c("동경", "리우데자네이루", "런던", "베이징"))
View(olympic)

# 변수 date에서 year, month, day를 각각 추출하여 olympic의 변수로 추가
olympic$year <- substr(olympic$date, 1, 4)
olympic$month <- substr(olympic$date, 5, 6)
olympic$day <- substr(olympic$date, 7, 8)
View(olympic)

# mtcars 데이터셋 불러오기
data(mtcars)

#  데이터프레임 mtcars의 행이름(rownames)을 변수 model에 저장 그리고 mtcars의 행이름(nownames)은 NULL 지정
myCars <- mtcars

myCars$model <- rownames(myCars)
rownames(myCars) <- NULL

View(myCars)

# model에 대문자 "S"를 포함하고 있는 행만 검색하고 출력
index <- grep("S", model)
myCars[index, ]

# 8. 대소문자 구별없이 “S” 또는 “s”를 포함하고 있는 행을 검색하고 출력
index <- grep("S|s", model, ignore.case = T)
myCars[index, ]

# 9 숫자로 끝나는 행을 검색하고 출력
myCars[grep("[0-9]$", myCars$model, ignore.case = T), ]

# 10. 대문자 “H”로 시작하는 행을 검색하고 출력
myCars[grep("^H", myCars$model, ignore.case = T), ]

# 11. 현재의 폴더 (디렉토리) 출력
getwd()

# 현재 디렉토리의 파일 이름을 검색하여 출력
list.files()

# 현재 디렉토리에서 엑셀 파일만 검색하여 출력
list.files(pattern = ".xlsx")

# “2015년 초미세먼지.xlsx”에 대하여 다음 과제를 수행하시오.
# 파일에는 3개의 시트(1분기, 2분기, 3분기)가 있다. 각각의 시트를 읽은 후 하나로 합쳐 하나의 변수 mise에 저장하고 데이터프레임 mise의 구조 출력
library(readxl)
mise1 <- read_excel("2015년 초미세먼지.xlsx", sheet = 1)
mise2 <- read_excel("2015년 초미세먼지.xlsx", sheet = 2)
mise3 <- read_excel("2015년 초미세먼지.xlsx", sheet = 3)

mise <- rbind(mise1, mise2, mise3)
str(mise)

# 15. AREA가 서울인 데이터만 추출하여 seoul에 저장하고 Point의 빈도표 구하기
seoul <- mise[mise$AREA == "서울", ]

table(seoul$Point)

# 16. 서울에는 25개의 구가 있다. 위 데이터 seoul에서 25개의 구 데이터만 추출하고자 한다.

# Point가 구로 끝나는 데이터만 추출
gu <- seoul[grepl("구$", seoul$Point), ]
table(gu$Point)

# gu에서 각 구별 PM10의 평균 구하기 (결측치 제거)
guMean <- aggregate(gu$PM10, by = list(gu$Point), FUN = mean, na.rm = TRUE)
colnames(guMean) <- c("Point", "PM10")
guMean

# 소숫점 1자리까지
guMean$PM10 <- round(guMean$PM10, 1)
View(guMean)

# aggregate 대신 tapply 사용
guMean <- round(tapply(gu$PM10, gu$Point, mean, na.rm = TRUE), 1)
guMean





