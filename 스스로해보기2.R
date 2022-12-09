# 벡터 (410, 413, 204, 105, 401, 502, 516, 409) 생성하여 a에 저장
a <- c(410, 413, 204, 105, 401, 502, 516, 409)

# 2. 벡터 b를 seq()함수를 사용하여 벡터 10부터 50까지 5씩 증가하도록 생성
b <- seq(10, 50, 5)

# 3. 벡터 a와 b를 합쳐서 벡터 c로 저장 (a 뒤에 b)
c <- c(a, b)

# 4. 벡터 c의 5번째 원소를 삭제하여 d로 저장
d <- c[-5]
d

# 5. 벡터 d의 길이 구하기
length(d)

# 6. 벡터 d의 5번째 원소부터 15번째 원소를 추출하여 벡터 e로 저장
e <- d[5:15]

# 7. 벡터 e의 평균 구하기
mean(e)

# 8. “a”, “b”, “c”, “d”를 4번 반복하여 벡터 z 생성
z <- rep(c("a", "b", "c", "d"), 4)
z

# 9. “a”, “b”, “c”, “d”를 각각 2번씩 반복하여 벡터 y 생성
y <- rep(c("a", "b", "c", "d"), each = 2)
y

# 10. 0부터 50사이의 정수 1000개를 생성하여 mydata에 저장
mydata <- runif(1000, 0, 50)

# 11. 다음 표와 같이 각 범위에 들어 있는 수의 개수를 구하여 벡터 count에 저장
# 구간 저장 인덱스
# 10 이하 count[1]
# 10 초과 20 이하 count[2]
# 20 초과 30 이하 count[3]
# 30 초과 40 이하 count[4]
# 40 초과 50 이하 count[5]

count <- c( length(mydata[mydata<=10]), length(mydata[mydata>10&mydata<=20]) , length(mydata[mydata>20&mydata<=30]), length(mydata[mydata>30&mydata<=40]), length(mydata[mydata>40&mydata<=50]))
count

# 12. 벡터 count의 원소의 합을 구하시오. (1000임을 확인)
sum(count)

# 13. mydata의 히스토그램 출력(hist(breaks=5) 사용)
hist(mydata, breaks=5)

# 14. 문자열 벡터 n <- c(“kim”, “park”, “lee”) 생성
n <- c("kim", "park", "lee")

# 15. 벡터 m <- c(71,89,95) 생성
m <- c(71,89,95)

# 16. 벡터 f <- c(83,74,91) 생성
f <- c(83,74,91)

# 17. 세 벡터 n, m, f을 묶어 데이터프레임 변수 score 생성
score <- data.frame(name=n, mid=m, final=f)

# 18. score의 구조 확인(str() 사용)
str(score)
# 19. mid와 final의 평균을 구하여 새로운 키(변수) mean에 저장
score$mean <- (score$mid + score$final)/2
score

# 20. 벡터 (100,90,100)를 벡터 attend에 저장
attend <- c(100,90,100)

# 21. 벡터 (100,90,80)를 벡터 hw에 저장
hw <- c(100,90,80)

# 22. 두 벡터 attend, hw를 score의 새로운 키(변수)로 추가
score$attend <- attend
score$hw <- hw

# 23. 평균 wmean을 다음과 같이 계산하여 score의 키로 추가
# mid: 40%, final: 40%, attend: 10%, hw: 10%
score$wmean <- (score$mid*0.4 + score$final * 0.4 + score$attend * 0.1 + score$hw * 0.1)/4

# 24. score의 구조 확인(str() 사용)
str(score)

# score의 내용 출력
score

# 26. 내장 데이터 Orange를 myO로 저장
myO <- Orange

# 27. myO의 구조 출력
str(myO)
# 28. 변수 age의 오름차순으로 정렬
myO[order(myO$age),]
# 29. 변수 Tree의 값이 1인 데이터만 추출하여 O1에 저장. 
O1 <- myO[myO$Tree==1,]
# 30. O2, O3, O4, O5도 마찬가지로 Tree의 값에 따라 데이터를 추출하여 저장
O2 <- myO[myO$Tree==2,]
O3 <- myO[myO$Tree==3,]
O4 <- myO[myO$Tree==4,]
O5 <- myO[myO$Tree==5,]

# 31. Tree의 값은 1, 2, 3, 4, 5의 5종류가 있다. 각 그룹별 circumference의 평균을 구하여 벡터 average에 저장.
average <- c(mean(O1$circumference), mean(O2$circumference), mean(O3$circumference), mean(O4$circumference), mean(O5$circumference))

# 32. barplot(average, col=’gold’, border=’red’)를 이용하여 막대그래프 그리기
barplot(average, col='gold', border='red')

# 33. O1, O2, …, O5에서 circumference 변수만 각각 추출하여 오른쪽 그림과 같이 새로운 데이터 프레임 변수 OO를 생성. age는 한 번만.(같은 age에 5개씩)

## age O1 O2 O3 O4 O5
df <- data.frame(age=unique(myO$age))
df$O1 <- O1$circumference
df$O2 <- O2$circumference
df$O3 <- O3$circumference
df$O4 <- O4$circumference
df$O5 <- O5$circumference

# 34. OO의 구조 출력
str(df)

print(df)
