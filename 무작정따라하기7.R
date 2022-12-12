library(ggplot2)

# 막대그래프 그리기
p <- ggplot(mtcars, aes(factor(cyl)))
p + geom_bar()

# 막대그래프 옵션 추가하기
p <- pplot(mtcars, aes(factor(cyl)))
p <- p + geom_bar(fill="gold", color="red", size=3, width=0.5)
p

# 막대그래프 옆으로 회전
p <- ggplot(mtcars, aes(factor(cyl)))
p <- p + geom_bar(fill="gold", color="red", size=3, width=0.5)
p + coord_flip()

# 수직누적막대 그래프 그리기
p <- ggplot(mtcars, aes(factor(cyl)))
p + geom_bar(aes(fill=factor(gear)))

# 수직 누적 막대 그래프 그리기 - 2
p <- ggplot(mtcars, aes(factor(cyl),fill=factor(gear)))
p + geom_bar()

# 데이터 mtcars에서 cyl 개수에 따라 연비(mpg)의 평균 구하기 – 결과를 데이터프레임으로
library(doBy)
tbl <- summaryBy(mpg ~ cyl, data=mtcars, FUN=mean)
tbl
# mpg 평균을 높이로 하는 막대그래프 그리기
p <- ggplot(tbl, aes(cyl, mpg.mean))
p + geom_bar(stat='identity')
# base로
tbl <- tapply(mtcars$mpg, mtcars$cyl, mean)
tbl_df <- data.frame(cyl=names(tbl), mean=tbl)
p <- ggplot(tbl_df, aes(cyl, mean))
p + geom_bar(stat='identity', fill='gold', color='red')

# 데이터 준비 – 교통사고 데이터에서 3개 도시 데이터 추출하여 데이터프레임으로 저장
library(readxl)
data <- read_xlsx("도로교통공단_시군구별 월별 교통사고 통계_20211231.xlsx")
chungju <- subset(data, 시군구=="충주시")
cheongju <- subset(data, 시군구=="청주시")
jecheon <- subset(data, 시군구=="제천시")
df <- data.frame(month=1:12, chungju=chungju$사고건수, 
 cheongju=cheongju$사고건수, jecheon=jecheon$사고건수)
df


# 시계열 그래프(꺾은선 그래프)
p <- ggplot(df, aes(month, chungju))
p + geom_point() + geom_line()
# 선과 점의 옵션 추가하기
p <- ggplot(df, aes(month, chungju))
p <- p + geom_line(color='blue', linetype=2, size=2)
p <- p + geom_point(color='red', shape=16, size=4) 
p
# 두 그래프 한 평면에 그리기
p <- ggplot(df, aes(x=month))
p <- p + geom_line(aes(y=chungju), color='red')
p <- p + geom_line(aes(y=cheongju), color='blue')
p
# 3개 그래프 한 평면에 그리기
p <- ggplot(df, aes(x=month))
p <- p + geom_line(aes(y=chungju), color='red') + 
 geom_point(aes(y=chungju), color='red')
p <- p + geom_line(aes(y=cheongju), color='blue') + 
 geom_point(aes(y=cheongju), color='blue')
p <- p + geom_line(aes(y=jecheon), color='green') + 
 geom_point(aes(y=jecheon), color='green')
p


# 그룹별 시계열 그래프 그리기 – 데이터 준비
library(dplyr)
cb <- data %>%
 filter(시도=="충북") %>%
 filter(grepl("시$", 시군구)) %>%
 select(발생월, 시군구, 사고건수) 
cb[c(1,2, 13,14, 25, 26), ]

# 데이터 준비 – 2 (base로)
cb <- subset(data, 시군구 %in% c("충주시", "청주시", "제천시"),
 select=c(발생월, 시군구, 사고건수))
cb[c(1,2, 13,14, 25, 26), ]

# 점과 선의 색상을 그룹 변수로 지정하여 그룹별 시계열 그래프
p<-ggplot(cb, aes(발생월, 사고건수))
p + geom_line(aes(col=시군구)) + geom_point(aes(col=시군구))


# 산점도 그리기 – 기본 작도
plot(mtcars$wt, mtcars$mpg, col=factor(mtcars$cyl), pch=17, cex=3)
# 산점도 그리기
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point()
# 옵션 추가하여 그리기
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(color='blue', shape=17, size=4)
# cyl의 값에 따라 색상 다르게
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(aes(col=factor(cyl)), shape=17, size=4)

# iris 데이터에서 산점도 그리기
head(iris)
p <- ggplot(iris, aes(Petal.Length, Petal.Width, color=Species))
p + geom_point(size=4)

# 히스토그램 그리기
p <- ggplot(chickwts, aes(weight))
p + geom_histogram(bins=5, breaks=100*(1:5),
 fill='gold', color='red')

# 상자그림(boxplot)
p <- ggplot(chickwts, aes(feed, weight))
p + geom_boxplot(color='red', fill='gold')

# 옵션 추가하기 – 제목
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point() +
 labs(title="mpg vs wt", x="weight", y='mpg')

 # 옵션 추가하기 – 제목 테마 지정
p <- ggplot(mtcars, aes(wt, mpg))
p <- p + geom_point(aes(color=factor(cyl)))
p <- p + labs(title="Mpg vs weight", x="weight", y="mpg")
p + theme(plot.title=element_text(color="tomato", size=30),
 axis.title.x=element_text(size=20),
 axis.title.y=element_text(size=20, color='blue'))

# x, y 축 범위 지정, 눈금 지정
p <- ggplot(mtcars, aes(wt, mpg))
p <- p + geom_point(aes(color=factor(cyl)))
p + scale_x_continuous(limits=c(0,10), breaks=1:10) +
 scale_y_continuous(limits=c(0,40), breaks=seq(0,40,5))

# 여러 그래프의 layout 지정하기
library(gridExtra)
p1 <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
p2 <- ggplot(chickwts, aes(feed, weight)) + geom_boxplot()
grid.arrange(p1, p2, ncol=2)

# 여러 그래프의 layout 지정하기
library(gridExtra)
p1 <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
p2 <- ggplot(chickwts, aes(feed, weight)) + geom_boxplot()
grid.arrange(p1, p2, nrow=2)