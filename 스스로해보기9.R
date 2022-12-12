# 1. 데이터 cars는 차량의 속력(speed)에 따른 제동거리(dist)에 대한 자료이다. 상관계수를 구하시오.
result <- cor(cars)
result

# 2. 데이터 cars에 대하여 x축은 speed, y축은 dist인 산점도를 ggplot을 이용하여 그리시오.
ggplot(cars, aes(x=speed, y=dist)) + geom_point()

# 3. 변수 speed를 독립변수(설명변수), 변수 dist를 종속변수(반응변수)로 하는 회귀분석의 결과를 출력하시오.
reg <- lm(dist ~ speed, data=cars)
summary(reg)

# 4. 산점도에 회귀직선과 예측치를 추가하여 나타내시오. (회귀직선의 색상은 red, 예측치는 점 (크기 크게)으로 나타내시오.)
ggplot(cars, aes(x=speed, y=dist)) + geom_point(size=3) + geom_smooth(method=lm, se=FALSE, color="red") + geom_point(aes(y=predict(reg)), color="red", size=3)

# 5. 잔차(residuals)를 cars의 변수 residuals에 저장하고 아래와 같이 잔차의 산점도를 그리시오. 
cars$residuals <- residuals(reg)
ggplot(cars, aes(x=speed, y=residuals)) + geom_point(size=3) + geom_hline(yintercept=0, color="blue",)

# 6. 다음과 같이 속력(speed)가 5, 10, ..., 50일 때, 제동거리(dist)의 예측치를 구하여 데이터프레임으로 저장/출력하시오. (제동거리는 반올림하여 소수점 1자리까지로)
speed <- seq(5, 50, 5)
dist <- predict(reg, data.frame(speed=speed))
result <- data.frame(speed, round(dist, 1))
result