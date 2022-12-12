# 1.  데이터 chickwts에는 범주형 변수 ‘feed’와 연속형 변수 ‘weight’가 있다. 변수 ‘feed’의 빈도표를 출력
table(chickwts$feed)

# 2. 데이터프레임 chickwts의 변수 ‘feed’에 대하여 아래와 같이 막대그래프(barplot)을 그리는 코드 작성. 그래프의 제목은 “Feed Type”, x축의 제목은 “Feed”, y축의 제목은 “빈도수”, 막대의 색상은 gold, 막대의 테두리 색상은 red
barplot(table(chickwts$feed), main="Feed Type", xlab="Feed", ylab="빈도수", col="gold", border="red")

# ggplot2를 이용하여 2번 문제를 해결
ggplot(chickwts, aes(x=feed)) + geom_bar(fill="gold", color="red") + labs(title="Feed Type", x="Feed", y="빈도수")

# 3. 변수 ‘feed’에 따라 변수 ‘weight’의 평균을 구하여 새로운 데이터프레임 변수 average에 저장하고 출력하는 코드
average <- chickwts %>% group_by(feed) %>% summarise(mean=mean(weight))
View(average)

# 3번 문제를 tapply() 함수를 이용하여 해결
tapply(chickwts$weight, chickwts$feed, mean)
# 데이터프레임으로 변환
average <- data.frame(feed=names(tapply(chickwts$weight, chickwts$feed, mean)), mean=tapply(chickwts$weight, chickwts$feed, mean))
View(average)

# 4. chickwts의 average를 높이로 하는 막대그래프. 그래프의 제목은 “Average Weight”, 색상은 feed의 값에 따라 지정
ggplot(average, aes(x=feed, y=mean, fill=feed)) + geom_bar(stat="identity") + labs(title="Average Weight")
# 변수 ‘feed’에 따라 ‘weight’의 평균을 높이로 하는 막대그래프. 
# 그래프의 제목은 “Average Weight”, 색상은 feed의 값에 따라 지정


# 5. 변수 ‘weight’에 대하여 계급의 크기가 50인 도수분포표를 구하는 코드
dosu <- table(cut(chickwts$weight, breaks=seq(100, 450, 50)))
dosu

# 6. 아래 그림과 같이 변수 ‘weight’에 대하여 계급의 크기가 50인 히스토그램 출력하는 코드 작성. 색상은 lightgreen, 테두리 색상은 yellow, 눈금은 0부터 500까지 50씩 증가
hist(chickwts$weight, breaks=seq(100, 450, 50), col="lightgreen", border="yellow", xlab="weight", ylab="count",  xlim=c(0, 500), ylim=c(0, 20), axes=FALSE)

# 6번 문제를 ggplot2를 이용하여 해결 (y는 dosu)
ggplot(chickwts, aes(x=weight)) + geom_histogram(breaks=seq(0, 500, 50), fill="lightgreen", color="yellow") + labs(x="weight", y="count") + scale_x_continuous(breaks=seq(0, 500, 50)) + scale_y_continuous(breaks=seq(0, 20, 2))

# 7. 자료실의 “K팀 대학 생활 만족도 설문(응답).xlsx”를 읽어 데이터프레임 변수 df에 저장하고, df의 변수 Q1에 대한 막대그래프를 출력하는 코드 작성. 막대색상은 lightgreen
df <- read_excel("K팀 대학 생활 만족도 설문(응답).xlsx")
ggplot(df, aes(x=Q1)) + geom_bar(fill="lightgreen") + labs(title="Q1", x="Q1", y="빈도수")

# 8. 아래와 같이 변수 Q2에 대한 막대그래프를 그리되, 막대에 변수 Q1에 따라 다른 색으로. 즉 수직누적막대그래프를 출력하는 코드 작성
# 학년이 x축 누적막대 그래프
ggplot(df, aes(x=Q2, fill=factor(Q1))) + geom_bar() + labs(title="Q1", x="Q2", y="count")

# 9. 아래와 같이 서울시 미세먼지 데이터(서울시 일별 평균 대기오염도 정보.xlsx)에 대하여 변수 ‘Point’의 값이 “강남구”인 데이터만 추출하여 변수 gangnam에 저장하고 처음 2행과 마지막 2행 출력
gangnam <- read_excel("서울시 일별 평균 대기오염도 정보.xlsx")
gangnam <- gangnam[gangnam$Point == "강남구", ]
head(gangnam, 2)
tail(gangnam, 2)

# 10. 데이터 gangnam에 대하여 월별 PM10의 평균을 구하여 다음과 같이 데이터프레임 gangnam_PM10에 저장하고 출력
gangnam_PM10 <- gangnam %>% group_by(Month) %>% summarise(mean_PM10 = mean(PM10))
gangnam_PM10

# 11. 위 10번 결과 gangnam_PM10을 이용하여 시계열 그래프. 점, 선 추가, 색상은 blue, x축 눈금 추가
ggplot(gangnam_PM10, aes(Month, mean_PM10 )) + scale_x_continuous(breaks=seq(1, 9, 1)) + geom_point(col="blue") + geom_line(col="blue") + scale_y_continuous(limits=c(0,50), breaks=seq(0,50,10))

# 12. 위 10번 결과 gangnam_PM10을 이용하여 아래 그림과 같이 막대그래프
ggplot(gangnam_PM10, aes(x=Month, y=mean_PM10)) + geom_bar(stat="identity", fill="gold", color="red") + labs( x="Month", y="mean_PM10") 

# 13. 데이터 data에서 Point가 “남산”, “관악산”, “북한산”인 3지역의 3월 데이터만 추출하여 변수 san에 저장하고 함수 tapply를 이용하여 월별 x 지역별 PM10의 평균을 구하여 출력
data <- read_excel("서울시 일별 평균 대기오염도 정보.xlsx")
san <- data[data$Point %in% c("남산", "관악산", "북한산"), ]
san <- san[san$Month == 3, ]
tapply(san$PM10, san$Point, mean)

# 14. 아래와 같이 3지역의 PM10의 시계열 그래프 (점, 선 추가) 일은 x축 눈금 추가
ggplot(san, aes(x=Date, y=PM10, col=Point)) + geom_point() + geom_line() + scale_x_continuous(breaks=seq(1, 31, 1))

# 15. 아래와 같이 3지역의 PM10의 그래프를 나누어 그리는 코드
ggplot(san, aes(x=Date, y=PM10, col=Point)) + geom_point() + geom_line() + facet_wrap(~Point)
