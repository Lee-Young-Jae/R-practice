# 데이터 mtcars에서 변수 cyl에 대한 빈도표를 구하고, 막대그래프 그리기

data(mtcars)

tbl <- table(myCars$cyl)
tbl

# 직사각형의 색상과 테두리 색상 지정하기
barplot(tbl, col = "gold", border = "red")

# 그룹별 다른 색 지정하기
barplot(tbl, col = c("red", "blue", "green"))

# 막대 그래프를 옆으로 그리기 (horiz = TRUE)
barplot(tbl, horiz = TRUE)

# 두 변수 gear와 cyl의 교차표 구하기
crosstbl <- table(myCars$gear, myCars$cyl)
crosstbl

# 교차표를 그래프로 나타내기 - 수직 누적 막대그래프
barplot(crosstbl, col = c("blue", "red", "orange"), legend=rownames(crosstbl))

# 교차표를 그래프로 나타내기 - 수평 누적 막대그래프
barplot(crosstbl, col = c("blue", "red", "orange"), legend=rownames(crosstbl), beside = TRUE)

# 가공된 데이터 직접 입력 - 벡터형으로
data <- c(36, 38, 55)
names(data) <- c("배드민턴", "탁구", "볼링")
print(data)

# 막대그래프 그리기 col=gold
barplot(data, col = "gold")

# 교차표 데이터 입력 - 행렬형으로 입력
data <- c(21, 15, 16, 22, 23, 32)
member <- matrix(data, 2, 3)

colnames(member) <- c("배드민턴", "탁구", "볼링")
rownames(member) <- c("남자", "여자")
print(member)

# 행렬형으로 입력된 교차표를 데이터 그래프로 나타내기
barplot(member, col = c("blue", "green"), legend=rownames(member))

# 데이터 chickwts에서 사료 (feed) 의 빈도표 구하기
tbl <- table(chickwts$feed)
tbl

# 원그래프, 색상은 랜덤
pie(tbl, col=runif(6, 0, 255))

# 비율(pct)을 구하여 label 붙여 원그래프 그리기
pct <- round(tbl/sum(tbl)*100, 2)
label <- paste0(names(tbl), " (", pct, "%)")
pie(tbl, col=runif(6, 0, 255), labels=label)

# 데이터 rivers (북아메리카 대륙의 강의 길이 데이터)
summary(rivers)

# 옵션 없이 히스토그램 그리기
hist(rivers)

# 계급 구간을 임의로 지정 0,100,500, 1000, 2000, 4000
hist(rivers, breaks=c(0,100,500, 1000, 2000, 4000))

# 계급 구간을 벡터로 지정 c(0 1000 2000 3000 4000)
hist(rivers, breaks=c(0, 1000, 2000, 3000, 4000))

# 계급 구간을 seq함수를 이용하여 지정
hist(rivers, breaks=seq(0, 4000, 1000))

# 계급 구간을 seq 함수를 이용하여 지정 (계급의 크기 500)
hist(rivers, breaks=seq(0, 4000, 500))


# 데이터 mtcars의 연비 mpg의 상자그림
boxplot(mtcars$mpg, col="gold")

# 실린더 수에 따른 상자그림
boxplot(mtcars$mpg ~ mtcars$cyl, col="gold")

# 데이터 cars(spped: 속도, dist: 정지거리)
head(cars)

# 산점도 plot(x, y)
plot(cars$speed, cars$dist)

# 기본 산점도 그리고 (data = cars: 속력에 따른 제동거리)
plot(cars$speed, cars$dist)

# 제목 붙이기
plot(cars$speed, cars$dist, main="속력에 따른 제동거리", xlab="속력", ylab="제동거리")

# 축의 범위 지정하기 -xlim, ylim
plot(cars$speed, cars$dist,
 main="속력에 따른 제동거리", 
 xlab="속력", 
 ylab="제동거리", 
 xlim=c(0, 50), 
 ylim=c(0, 200))

# 데이터: USAccDeaths: 1973년부터 1978년까지의 미국의 교통사고 사망자수
View(USAccDeaths)

# 선그래프 그리기 - 점과 선의 옵션 type="l" => option을 바꾸어 그래프 그려보기
year1973 <- USAccDeaths[1:12]
month <- 1:12
plot(month, year1973, type="l")

# 선과 점의 색 지정
plot(month, year1973, type="o", col="red", lty=6)

# 점의 모양과 크기 지정
plot(month, year1973, type="o", col="blue", lty=6, pch=15, cex=2)

# 점의 채우기 색상과 테두리 색상을 다르게 지정
plot(month, year1973, 
type="o", col="blue", 
lty=6, pch=21, 
cex=2, bg="gold")

# 데이터 mtcars: cyl수에 따라 산점도의 점의 색상 다르게
plot(mtcars$wt, mtcars$mpg, col=mtcars$cyl, cex=3, pch=20)

# 그래프와 width와 height 지정 (default = 7)
options(repr.plot.width=3, repr.plot.height=4)
plot(cars$speed, cars$dist, main="산점도")

# 뎅터 준비하기
year1973 <- USAccDeaths[1:12]
year1974 <- USAccDeaths[13:24]
df <- data.frame(month=1:12, y1973=year1973, y1974=year1974)
df

# 그래프 겹쳐 그리기 - 글씨, 축 모든 것이 다 겹쳐짐, y축 스케일도 다름
options(repr.plot.width=7, repr.plot.height=7)
plot(df$month, df$y1973, type="o", col="red", pch=19)
par(new=TRUE)
plot(df$month, df$y1974, type="o", col="blue", pch=15)

# 그래프 겹쳐그리기 - y축의 스케일을 동일하게
plot(df$month, df$y1973, col='red', type='o', pch=19, ylim=c(0,12000))
par(new=TRUE)
plot(df$month, df$y1974, col='blue', type='o', pch=15, ylim=c(0,12000))

# 두 개의 그래프를 옆으로 그리기
par(mfrow=c(1,2))
plot(df$month, df$y1973, col='red', type='o', ylim=c(0,12000))
plot(df$month, df$y1974, col='blue', type='o', ylim=c(0,12000))

# 두 개의 그래프를 위아래로 그리기
par(mfrow=c(2,1))
plot(df$month, df$y1973, col='red', type='o', ylim=c(0,12000))
plot(df$month, df$y1974, col='blue', type='o', ylim=c(0,12000))

# 저수준 작도하기
# 한번에 한 줄씩 입력하고 실행
# 모든 명령이 한 셀에 있어야 함.

plot(month, year1973, ylim=c(7000,12000), xlabel="Month", ylabel="Accident Deaths") # 그래프 그리기
lines(month, year1973, col="red") # 1973년도 선으로 표시 
axis(side=1, at=1:12, labels=month) # x 축 label 추가
grid(col="blue", lty=5) # 그리드 선 그리기(추가)
lines(month, year1974, col="green") # 1974년도 선으로 표시
points(month, year1974, col="green") # 1974년도 점으로 표시
legend("topright", legend=c("1973년", "1974년"), col=c("red", "green"), lty=c(1,1)) # 범례 추가
