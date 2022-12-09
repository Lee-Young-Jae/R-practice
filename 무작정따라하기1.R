print(1+2-3*4/2+6^2)

print(44/44)

print(4/4+4/4)

print((4+4+4)/ 4)


height <- 1.7
weight <- 65
bmi <- weight / height^2
print(bmi)

str1 <- "Hello world"
print(nchar(str1)) # 문자열의 길이는 nchar()로 구한다

 x <- c(2,3,5,7,9,11) # 벡터형 자료 생성
print(x) # 변수 x의 내용 확인
print(x[0]) # R에서 처음 시작 index가 0이 아님
print(x[1]) # 시작 index는 1부터 시작함
print(length(x)) # 벡터의 길이는 len이 아니라 length

x <- c(1,2,3,4,5,6,7,8,9,10); print(x) # 1부터 10까지 직접 입력
y <- 1:10; print(y) # 간단히 벡터 생성, c 생략 가능
x+y # 두 벡터의 합
x*y # 두 벡터의 곱
x+100 # 모든 원소에 100 더하기
x^2 # 모든 원소의 제곱
y^0.5 # 제곱근(1/2제곱)

x <- floor(runif(20,0,100); print(x) # 난수 20개로 벡터 생성
mean(x)
sum(x)
min(x)
max(x)
median(x) # 중앙값
sd(x) # 표준편차

m1 <- matrix(c(1:12),3,4); print(m1) # 행렬
m2 <- matrix(c(1:12), nrow=3); print(m2)
m1 * 2
m1 - m2

list_data <- list(color=c("red", "green"), score=c(11,22,33))
print(list_data)
str(list_data)
list_data$color
list_data$score

chars <- LETTERS[1:10]
print(chars)
letters[]

m <- floor(runif(20)*100) # 난수 생성(0부터 100사이)
 print(m)
f <- floor(runif(20)*100)
print(f)
mydf <- data.frame(mid=m, final=f)
print(mydf)
head(mydf)
str(mydf)
mydf$sum <- mydf$mid + mydf$final
print(mydf)
str(mydf)
hist(mydf$mid) # 히스토그램
plot(mydf$mid, mydf$final) # 산점도
head(iris)
library(ggplot2)
p <- ggplot(iris, aes(Petal.Length, Petal.Width, col=Species))
p + geom_point(size=4)