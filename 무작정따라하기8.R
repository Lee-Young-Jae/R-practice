# 데이터 iris 헤드 보기
head(iris, 10)

# 변수 Species 빈도표 확인
table(iris$Species)

# Petal. Length와 Petal. Width의 산점도 그리기
library(ggplot2)
p <- ggplot(iris, aes(Petal.Length, Petal.Width, color=Species, shape=Species))
p + geom_point(size=3)

# Petal. Length와 Petal. Width는 3, 4 번째 변수
petal <- head(iris[, 3:5])
head(petal, 10)

# 중심을 3개로 하는 군집 구하기 (Petal만 사용)
petal.kmeans <- kmeans(petal[1:2], centers=3, iter.max=1000)
petal.kmeans

# 군집 결과 (cluster)를 데이터프레임 iris$cluster에 저장
iris$cluster <- petal.kmeans$cluster
head(iris, 10)

# 교차표로 비교
table(iris$Species, iris$cluster)

# 군집의 중심 확인
petal.kmeans$centers

# 3개의 중심을 데이터프레임 centers에 저장
centers <- petal.kmeans$centers
centers <- as.data.frame(centers)

# 산점도와 중심을 그래프로 나타내기 aes를 Petal의 Length와 Width로 하고 color를 cluster로 하는 p를 만들고  (data를 centers로)
p + geom_point(data=centers, aes(Petal.Length, Petal.Width, color=factor(1:3), shape=factor(1:3)), size=5)


# 군집별 평행 좌표 그림
library(GGally)
petal$cluster <- as.factor(petal.kmeans$cluster)

p <- ggparcoord(data=petal, columns=c(1:2), groupColumn="cluster", scale="std")
p

# 군집별 타원 그림
library(factoextra)
fviz_cluster(petal.kmeans, petal[1:2], ellipse.type="norm")

# 의사결정나무 분석
library(rpart)
r <- rpart(Species ~ ., data=iris)
r

# 그래프로 나타내기
par(mfrow=c(1, 1), xpd=NA)
plot(r)
text(r, use.n=TRUE)

# 요약 결과 출력
summary(r)


# 의사결정나무 그래프 다시
library(rpart.plot)
rpart.plot(r)

# 데이터 iris에서 랜덤하게 10개 추출하여 newdata에 저장
newdata <- iris[sample(1:nrow(iris), 10), ]
newdata

# newdata의 4개의 변수를 사용하여 분류 예측
p <- predict(r, newdata, type="class")
p

# 교차표로 비교
table(p, newdata$Species)

# 기계학습을 이용하기 위하여 iris 데이터 중 변수 Species를 기준으로 70%의 데이터 추출(인덱스로)
# 추출된 70%의 데이터는 훈련용 데이터(training), 나머지 30%의 데이터는 테스트용 데이터(testing)
library(caret)
indexTrain <- createDataPartition(iris$Species, p = .7, list = FALSE)

traning <- iris[indexTrain, ]
testing <- iris[-indexTrain, ]

# 훈련용 데이터의 빈도 확인
table(traning$Species)

# 훈련용 데이터를 이용하여 분류 규칙 구하기
r <- rpart(Species ~ ., data=traning)
r

# 의사 결정 나무로 나타내기
rpart.plot(r)

# 위 분류 규칙 r을 이용하여 테스트용 데이터를 분류하고, 그 결과를 testing$predict에 저장
testing$predict <- predict(r, testing, type="class")
head(testing)

# 교차표로 정확도 확인
table(testing$Species, testing$predict)

# 규칙의 정확도 구하기
p <- predict(r, testing, type='class')
confusionMatrix(p, testing$Species)