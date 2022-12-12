# chickwts에 대한 정보를 출력하는 코드 쓰기
# chickwts(dataset) R Documentation
#
# Chicken Weights by Feed Type
# Description
#
# An experiment was conducted to measure
# and compare the effectiveness of various
# feed types on the growth of chickens.

# data frame chickwts의 구조 (str) 출력하기
str(chickwts)

# 아래와 같이 데이터프레임의 두 변수 weight와 feed 의 요약 통계량을 출력하는 코드 작성
summary(chickwts)

# 데이터프레임 chickwts의 변수 feed 의 빈도표를 구하여 변수 tbl에 저장하고, tbl의 내용을 출력하는 코드 작성
tbl <- table(chickwts$feed)
tbl

# 5. 데이터프레임 chickwts의 변수 feed에 대하여 아래와 같이 막대그래프(barplot)을 그리는 코드 작성. 그래프의 제목은 “Feed Type”, x축의 제목은 “feed”, y축의 제목은 “빈도수”, 막대의 색상은 gold, 막대의 테두리 색상은 blue
barplot(tbl, main="Feed Type", xlab="feed", ylab="빈도수", col="gold", border="blue")

# 6. 데이터프레임 chickwts의 변수 feed에 따른 weight의 평균을 구하여 result에 저장하고, result의 내용을 출력하는 코드 작성
result <- tapply(chickwts$weight, chickwts$feed, mean)
result

# 7. 데이터프레임 chickwts의 변수 feed에 따른 weight의 평균을 구하여 result에 저장하고, result의 내용을 출력하는 코드 작성
# 그래프의 제목은 “Weight By Feed Type”, x축의 제목은 “feed”, y축의 제목은 “weight 평균”, 막대의 색상은 gold, 막대의 테두리 색상은 red
barplot(result, main="Weight By Feed Type", xlab="feed", ylab="weight 평균", col="gold", border="red")

# 8. 데이터프레임 chickwts의 변수 weight에 대하여 아래와 같이 계급의 크기를 50일 때의 빈도를 구하는 코드 작성
table(cut(chickwts$weight, breaks=seq(100, 450, 50)))

# 9. 아래 그림과 같이 변수 weight에 대하여 계급의 크기가 50인 히스토그램 출력하는 코드 작성. 메인 제목, x축과 y축의 제목을 아래 그림과 같이 명시. 색상은 lightgreen
hist(chickwts$weight, main="Chicken Weight", xlab="weight", ylab="빈도수", col="lightgreen")

# 10 변수 feed의 값에 따라 변수 weight의 상자 그림을 아래와 같이 출력하는 코드 작성
boxplot(weight ~ feed, data=chickwts, xlab="chickwts$feed", ylab="chickwts$weight")

# 11. 자료실의 "K팀 대학 생활 만족도 설문(응답).xlsx" 파일을 읽어와서 데이터프레임으로 저장한 후 데이터 프레임 변수 df에 저장
df <- read_excel("K팀 대학 생활 만족도 설문(응답).xlsx")

# 두 변수 Q1(성별) Q2(학년)에 대하여 아래와 같은 교차표를 변수 result에 저장하고 출력하는 코드 작성
result <- table(df$Q1, df$Q2)
result

# 위에서 구한 result를 이용하여 수직 누적 막대 그래프를 출력 범레포함 color는 green과 gold
barplot(result, col=c("green", "gold"), legend=rownames(result))

# 13. 서울시 미세먼지 데이터(‘서울시 일별 평균 대기오염도 정보.xlsx’)에 대하여 강남구 5월 데이터만 추출하여 gangnam, 강북구 5월 데이터만 추출하여 gangbuk에 저장하여, head를 각 2줄씩 출력하는 코드 작성
seoul <- read_excel("서울시 일별 평균 대기오염도 정보.xlsx")
gangnam <- seoul[seoul$Month == "5" & seoul$Point == "강남구", ]
head(gangnam, 2)

gangbuk <- seoul[seoul$Month == "5" & seoul$Point == "강북구", ]
head(gangbuk, 2)

# 14. 위 결과를 PM10만 그래프를 그려 한줄에 출력하기. 각 그래프의 label을 지정하고 y축의 범위는 0에서 100까지 options()에서 그래프의 너비는 15
options(repr.plot.width=15)
options(repr.plot.height=3)
par(mfrow=c(1,2))
# 점과 선으로 이루어진 그래프
plot(gangnam$PM10, type="o", col="red", ylim=c(0, 100), xlab="일", ylab="PM10 농도", main="강남구")
plot(gangbuk$PM10, type="o", col="blue", ylim=c(0, 100), xlab="일", ylab="PM10 농도", main="강북구")

# 15. gangnam과 gangbuk을 이용하여 다음과 같은 그래프를 출력하는 코드를 작성(저수준 작도 이용) 
# a. 그래프의 제목, x축과 y축의 제목
# b. 강남구는 red, 강북구는 blue
# c. 선스타일(lty) 강남구는 실선, 강북구는 점선
# d. 그래프의 오른쪽 위에 범례 추가
# e. x 축의 눈금은 1부터 31까지


plot(gangnam$PM10, type="o", col="red", ylim=c(0, 100), xlab="일", ylab="PM10 농도", main="강남구")
lines(gangbuk$PM10, type="o", col="blue", lty=2)
legend("topright", legend=c("강남구", "강북구"), col=c("red", "blue"), lty=c(1, 2))
axis(side=1, at=1:31)


