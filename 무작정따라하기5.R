# 범주형 자료의 분석 - 빈도표, 막대그래프

# mtcars 데이터셋을 불러온다.
data(mtcars)

myCars <- mtcars

# 데이터 mycars의 앞부분 보기
head(myCars)

# 변수 cyl의 빈도표 구하고 출력
tbl <- table(myCars$cyl)
tbl

# 가로합 구하기
addmargins(tbl)

# barplot 그리기 col = gold, border = red
barplot(tbl, col = "gold", border = "red")

# 상대도수 구하고 출력
prop_tbl <- prop.table(tbl)
prop_tbl

# 상대도수 막대그래프
barplot(prop_tbl, col = "gold", border = "red")

# 연속형 자료의 분석 - 기초통계량, 도수분포표, 히스토그램

# 변수 mpg의 통계량
summary(myCars$mpg)

# 변수 mpg, hp, wt의 통계량 (index 번호로)
summary(myCars[, c(1, 4, 6)])

# 계급 구간 정하기
bins <- seq(10, 35, 5) # 10부터 35까지 5씩 증가하는 수열
# 각 계급별 도수 구하기
table(cut(myCars$mpg, breaks=bins))

# 히스토그램 그리기 col=gold border=red
hist(myCars$mpg, breaks=bins, col="gold", border="red")

# 연속형 자료의 그룹별 평균 (통계량), 그룹별 평균을 높이로 하는 막대그래프
result <- tapply(myCars$mpg, myCars$cyl, mean)
names(result) <- paste0(names(result), "개")
result <- round(result, 2)
result

# 평균을 높이로 하는 막대그래프
barplot(result)

# 실린더와 오토/메뉴얼에 대한 mpg의 평균
tapply(myCars$mpg, list(myCars$cyl, myCars$am), mean)

# doBy 패키지를 이용한 그룹별 분석
install.packages("doBy")
library(doBy)

summaryBy(mpg ~ cyl, data=myCars, FUN=mean)

# 실린더 개수와 오토/메뉴얼 교차표 
table(myCars$cyl, myCars$am)
# summaryBy 이용
summaryBy(mpg ~ cyl + am, data=myCars, FUN=mean)

# 엑셀 파일 분석- 설문 데이터 "K팀 대학 생활 만족도 설문(응답).xlsx"

library(readxl)
data <- read_xlsx("K팀 대학 생활 만족도 설문(응답).xlsx")
str(data)

# 성별 빈도표
table(data$Q1)

# 성별 빈도표 + 가로합
addmargins(table(data$Q1))

# 학년별 상대도수 + 가로합
addmargins(round(prop.table(table(data$Q2)), 3))

# 성별, 학년별 분포
crosstab <- table(data$Q1, data$Q2)
crosstab

# 가로합, 세로합 보기
addmargins(crosstab)

# 성별 만족도 교차표
result <- table(data$Q1, data$Q6)
addmargins(result)

# 학년별 만족도 교차표
result2 <- table(data$Q2, data$Q6)
addmargins(result2)

# 수직 누적 막대그래프 그리기 col= green blue gold  legend = rownames(result2)
barplot(result2, col=c("green", "blue", "gold"), legend=rownames(result2))

# 결과를 리스트로 Q4, Q9
lapply(data[, c("Q4", "Q9")], mean)

# 결과를 벡터로
result <- sapply(data[, c("Q4", "Q9")], mean)
round(result, 2)

# 미세먼지 데이터 준비하기 "2015년 초미세먼지.xlsx" sheet 1, 2, 3
mise1 <- read_xlsx("2015년 초미세먼지.xlsx", sheet=1)
mise2 <- read_xlsx("2015년 초미세먼지.xlsx", sheet=2)
mise3 <- read_xlsx("2015년 초미세먼지.xlsx", sheet=3)

# 3개의 데이터를 하나로 합치기
mise <- rbind(mise1, mise2, mise3)
mise$Sido <- word(mise$AREA)

# 서울 데이터만 추출
seoul <- subset(mise, Sido=="서울")

# Sido, Month, PM10, PM25 변수만 추출
seoul <- seoul[c("Sido", "Month", "PM10", "PM25")]
head(seoul)

# 3번째(PM10), 4번째(PM25) 평균
lapply(seoul[, c(3, 4)], mean)

# 결측치 제거 후 계산
lapply(seoul[, c(3, 4)], mean, na.rm=TRUE)

# 서울 데이터에서 PM10만
seoulPM10 <- seoul[c("Sido", "Month", "PM10")]

# NA가 있는지 확인
any(is.na(seoulPM10)) # true

seoulPM10 <- na.omit(seoulPM10) # 결측치가 있는 행 제거

result <- round(tapply(seoulPM10$PM10, seoulPM10$Month, mean), 2)
print(result) # 월별 PM10의 평균

# 광역시만 따로 추출
city <- c("인천", "대전", "대구", "광주", "부산", "울산", "세종")
wide <- subset(mise, Sido %in% city)
table(wide$Sido)

# wide2 Sido PM25, Month
wide2 <- wide[c("Sido", "Month", "PM25")]
head(wide2)

# 결측치 제거
newwide <- na.omit(wide2)
table(newwide$Sido)

# 광역시별 PM25 평균 구하기
result <- round(tapply(newwide$PM25, newwide$Sido, mean), 2)
print(result)

# 광역시에서 월별 PM10 평균 구하기
# result <- round(tapply(newwide$PM25, list(newwide$Sido, newwide$Month), mean), 2)
# print(result)

# with 사용 - 광역시에서 월별 PM10 평균 구하기
result <- with(newwide, tapply(PM25, list(Sido, Month), mean))
round(result, 2)

# dplyr 패키지
install.packages("dplyr")
library(dplyr)

newcyl <- select(mtcars,  mpg, cyl)
head(newcyl)

# 위 코드와 동일 %>% 연산자 사용 %>%는 파이프 연산자
mtcars %>%
  select(mpg, cyl) %>%
  head()

newcyl1 <- select(mtcars, mpg, cyl)
newcyl2 <- mutate(newcyl1, mPc=mpg/cyl) # mpg/cyl 변수 추가
newcyl3 <- filter(newcyl2, mPc>3) # mPc>20인 행만 추출
head(newcyl3)

# 위 코드와 동일 %>% 연산자 사용
mtcars %>%
  select(mpg, cyl) %>%
  mutate(mPc=mpg/cyl) %>%
  filter(mPc>3) %>%
  head()


newcyl1 <- select(mtcars, mpg, cyl)
newcyl2 <- mutate(newcyl1, mPc=mpg/cyl) # mpg/cyl 변수 추가
newcyl3 <- filter(newcyl2, mPc>=3) # mPc>=3인 행만 추출
grp <- group_by(newcyl3, cyl) # cyl 기준으로 그룹화
summarise(grp, n(), mean(mPc), mean(mpg)) # 그룹별 행 개수, mPc 평균, mpg 평균

# 위 코드와 동일 %>% 연산자 사용
mtcars %>%
  select(mpg, cyl) %>%
  mutate(mPc=mpg/cyl) %>%
  filter(mPc>=3) %>%
  group_by(cyl) %>%
  summarise(n(), mean(mPc), mean(mpg))