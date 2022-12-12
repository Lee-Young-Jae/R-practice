# 데이터 galton 헤드 보기
library(UsingR)
head(galton)

# 데이터 galton의 도움말 보기
?galton

#. 두 변수 child와 parent의 분포를 히스토그램으로 확인
par(mfrow=c(1, 2))
hist(galton$child, col="blue", breaks=10)
hist(galton$parent, col="blue", breaks=10)
par(mfrow=c(1, 1))

# 산점도와 추세선 그리기
library(ggplot2)
p <- ggplot(galton, aes(x=parent, y=child))
p + geom_point() + geom_count() + geom_smooth(method="lm")

# 두 변수 광고비(cost)와 판매수익(sales)의 상관계수 (cor) 구하기
c = c(2,3,6,4,7,4,8,6)
s = c(8,9,18,17,21,14,27,22)
df <- data.frame(cost=c, sales=s)
cor(df$cost, df$sales)

# 산점도와 추세선 그리기
p <- ggplot(df, aes(x=cost, y=sales))
p + geom_point(size=3) + geom_smooth(method="lm")

# cost를 독립변수로, sales를 종속변수로 하여 회귀분석/ 결과출력
reg <- lm(sales ~ cost, data=df)
reg

# 회귀분석 결과 확인
summary(reg)


# 예측치와 잔치를 df의 변수로 저장
df$fitted <- reg$fitted.values
df$residuals <- reg$residuals
df

# 관측치 + 추세선 + 예측치를 한 평면에 그리기
p <- ggplot(df, aes(x=cost, y=sales))
p + geom_point(size=3) + 
 geom_abline(intercept=reg$coefficients[1],
 slope=reg$coefficients[2], color='red') +
 geom_point(aes(cost, fitted), color='red', size=4)

# 잔차(residual)의 그래픅 그리기
p <- ggplot(df, aes(x=cost, y=residuals))
p + geom_point(size=3) + geom_hline(yintercept=0, color='blue', linetype=2)

# predict() 함수를 이용하여 예측치 구하기
x <- data.frame(cost=df$cost)
df$new_pre <- predict(reg, x)
df

# cost의 값이 5부터 10까지의 예측치
x <- data.frame(cost=c(5:10))
x$pre <- predict(reg, x)
x

# 과제 2(중간고사 점수로 기말고사 점수 예측하기 – 회귀분석 이용)
# 데이터 읽기
library(readxl)
data <- read_xlsx("hw2-2기말성적예측-2022.xlsx")
head(data)

# 회귀분석
reg <- lm(기말 ~ 중간, data=data)
reg

# 중간고사 성적이 30, 50, 70점인 학생들의 기말고사 점수 예측치 구하기
x <- data.frame(중간=c(30, 50, 70))
predict <- predict(reg, x)
result <- data.frame(x=x, predict=predict)
result

# 데이터 women
head(women)

# 산점도 그리기
ggplot(women, aes(height, weight)) + geom_point(size=4)

# 회귀분석
reg <- lm(weight ~ height, data=women)
summary(reg)

# 추세선(회귀직선) 그리기
p <- ggplot(women, aes(height, weight))
p <- p + geom_point(size=4)
p + geom_abline(intercept = reg$coefficients[1],
 slope = reg$coefficients[2], color='red')

 # 잔차를 저장하고 그래프 그리기
women$residuals <- reg$residuals

p <- ggplot(women, aes(height, residuals))
p + geom_point(size=4) +
 geom_hline(yintercept=0, color='blue', linetype=2)

 # 2차 모형의 회귀분석
reg2 <- lm(weight ~ height + I(height^2), data=women)
summary(reg2)

# 회귀곡선(2차식) 그리기
women$fitted_values <- reg2$fitted.values
p <- ggplot(women, aes(height, weight)) + geom_point()
p + geom_line(aes(height, fitted_values), color='red')

# 19. 잔차를 저장하고 그래프로 나타내기
women$residuals <- reg2$residuals
ggplot(women, aes(height, residuals)) + geom_point(size=1) +
 geom_hline(yintercept = 0, color='blue')

# 데이터 mtcars
# 상관계수 행렬 구하기
result <- cor(mtcars)
round(result,2)

# 회귀분석: 종속변수는 mpg, 나머지 모든 변수는 독립변수
reg <- lm(mpg ~ . , data=mtcars)
summary(reg)


# 다중공선성 확인(VIF의 제곱근)
library(car)
as.data.frame(sqrt(vif(reg)))

# 데이터 mtcars의 다중 회귀 모형: 독립변수는 모두 다, 종속변수는 mpg(연비)
reg <- lm(mpg ~ ., data=mtcars)
step(reg, directions='backward'