# 벡터
x <- c(1,2,3,4,5,6,7,8,9,10) # 벡터 생성하기
x # 벡터 출력하기
x[1] # 벡터의 첫 번째 성분 출력하기
x[length(x)] # 벡터의 마지막 성분 출력하기
x[c(1,3,5)] # 벡터의 첫 번째, 세 번째, 다섯 번째 성분 출력하기
x[c(8,7,5,2)] # 벡터의 여덟 번째, 일곱 번째, 다섯 번째, 두 번째 성분 출력하기 
x[3] <- 33 # 벡터의 세 번째 성분을 33으로 수정하기
x # 벡터 출력하기
y <- x[-1]; y # 벡터의 첫 번째 성분을 제외한 나머지 성분을 벡터 y에 저장하기
z <- x[-c(1,3,5)]; z # 벡터의 첫 번째, 세 번째, 다섯 번째 성분을 제외한 나머지 성분을 벡터 z에 저장하기
X <- c(1,2,3,4,5) # 벡터 X 생성하기
append(x, 99); x # 벡터 x에 99를 추가하기
append(x, 88, after=2) # 벡터 x에 88을 두 번째 성분 뒤에 추가하기
append(x, c(100, 200, 300)) # 벡터 x에 100, 200, 300을 추가하기
append(x, c(100, 200, 300), after=0) # 벡터 x에 100, 200, 300을 첫 번째 성분 뒤에 추가하기
1:10 # 1부터 10까지의 숫자를 벡터로 생성하기
10:-10 # 10부터 -10까지의 숫자를 벡터로 생성하기
seq(from=0, to=10, by=2) # 0부터 10까지 2씩 증가하는 숫자를 벡터로 생성하기
seq(0, 10, 2) # 0부터 10까지 2씩 증가하는 숫자를 벡터로 생성하기
seq(0, 50, length=6) # 0부터 50까지 6개의 숫자를 생성하기
x <- seq(-3, 3, length=500); x # -3부터 3까지 500개의 숫자를 생성하기
y <- exp(-x^2); y # y = exp(-x^2)를 계산하기
plot(x, y) # 그래프 그리기
plot(x, y, type="l") # 선 그래프 그리기
z <- rnorm(100) # 정규분포를 따르는 난수 100개 생성하기
z # 난수 출력하기
hist(z) # 히스토그램 그리기
x <- rnorm(100, mean=160, sd=10) # 평균이 160이고 표준편차가 10인 정규분포를 따르는 난수 100개 생성하기
x # 난수 출력하기
hist(x) # 히스토그램 그리기

runif(100) # 0부터 1까지 균일분포를 따르는 난수 100개 생성하기
u <- runif(100, 0, 200) # 0부터 200까지 균일분포를 따르는 난수 100개 생성하기
hist(u)

x<-floor(runif(10, 0, 100)) # 0부터 100까지 균일분포를 따르는 난수 10개 생성하기
x

x1 <- x[x >25]; x1 # 벡터 x에서 25보다 큰 값만 추출하기

x2 <- ifelse(x > 25, "T", "F") # 벡터 x에서 25보다 큰 값은 1, 작은 값은 0으로 변환하기
x2

# 행렬
A <- matrix(1:20, nrow=4, ncol=5) # 1부터 20까지의 숫자를 4행 5열로 구성한 행렬 m 생성하기
A
A[3, 4] # 행렬 A의 3행 4열의 성분을 추출하기
A[1, ] # 행렬 A의 1행의 성분을 추출하기
A[1:2, ] # 행렬 A의 1행과 2행의 성분을 추출하기
A[, 2] # 행렬 A의 2열의 성분을 추출하기
A[ , 2:4] # 행렬 A의 2열부터 4열의 성분을 추출하기
rsum <- apply(A, 1, sum);rsum # 행렬 A의 각 행의 합을 계산하기
rmean <- apply(A, 1, mean);rmean # 행렬 A의 각 행의 평균을 계산하기
csum <- apply(A, 2, sum);csum # 행렬 A의 각 열의 합을 계산하기
cmean <- apply(A, 2, mean);cmean # 행렬 A의 각 열의 평균을 계산하기

# 데이터 프레임 만들기
m <- c(70, 80, 90)
k <- c(85, 90, 95)
score <- data.frame(math=m, kor=k)
View(score)
score$math
score$kor
score$sum <- score$math + score$kor
score

# data mtcars
mycars <- mtcars # mtcars는 내장되어 있는 데이터
str(mycars) # 데이터의 구조를 출력하기
mean(mycars$mpg) # 데이터의 평균을 계산하기
hist(mycars$mpg) # 히스토그램 그리기
mycars[1:10, 1:3] # 데이터의 일부를 추출하기 1행부터 10행까지, 1열부터 3열까지
mycars[1:5, ] # 데이터의 일부를 추출하기 1행부터 5행까지, 모든 열
mynewcars <- mycars[, c(1,2,4,6)] # 데이터의 일부를 추출하기 모든 행, 1열, 2열, 4열, 6열
str(mynewcars)
table(mycars$gear) # gear 변수의 도수 분포표
gear3 <- subset(mycars, mycars$gear == 3) # 기어 == 3 인 자료 추출
gear3
gearcyl <- subset(mycars, mycars$gear >= 4 & mycars$cyl >= 6) # 기어 >= 4 & 실린더 >= 6 인 자료 추출 
gearcyl


# 데이터 ToothGrowth
library(datasets)

TG <- ToothGrowth # ToothGrowth는 내장되어 있는 데이터
str(TG) # 데이터의 구조를 출력하기
nrow(TG) # 행의 개수(데이터의 레코드 수 확인)
ncol(TG) # 열의 개수(데이터의 변수 수 확인)
TG[order(TG$len), ] # len 변수를 기준으로 오름차순 정렬하기
TG[order(-TG$dose),] # dose 변수를 기준으로 내림차순 정렬하기
summary(TG) # 요약 통계량
table(TG$supp) # supp 변수의 빈도표
OJ <- subset(TG, supp=="OJ") # supp 변수가 OJ인 자료 추출
OJ
nrow(OJ) # 행의 수 출력
VC <- subset(TG, supp=="VC") # supp 변수가 VC인 자료 추출
VC
OJ_mean <- c(mean(OJ$dose), mean(OJ$len)) # OJ의 두 변수의 평균
OJ_mean
TG[1:10, ] # 데이터프레임 TG의 1 행부터 10까지만 추출
TG[11:nrow(TG), ] # 데이터프레임 TG의 11 행부터 마지막 행까지 추출
TG <- TG[, c(3, 2, 1)] # TG의 변수의 순서를 3, 2, 1, 의 순서로
TG[, 1] # TG의 첫번째 변수만 -> 벡터

