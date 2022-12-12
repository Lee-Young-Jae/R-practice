# 자료실에서 “score.xlsx”를 다운받아 데이터프레임 score로 읽고, 물음에 답하시오.

# 1. 두 개의 변수 mid와 final 성적을 이용하여 4개의 그룹으로 분류한 결과를 출력 (결과는 예시와 다를 수 있음)
score <- read_excel("score.xlsx")
score
p <- kmeans(score[, 1:2], 4)
p

# 2. 결과 중 cluster의 값을 score$cluster로 저장하고 두 변수 score$degree, score$cluster의 교차표를 구하시오. (결과는 예시와 다를 수 있음)
score$cluster <- p$cluster
table(score$degree, score$cluster)

# 3. 다음 과정에 따라 다음 그래프를 그리시오. (결과는 예시와 다를 수 있음)
# A.분류분석의 결과 중 중심(centers)의 값 (벡터)를 변수 centers에 저장(데이터프레임 형식으로)
# B.분류분석의 결과 중 군집(cluster) 결과를 score의 cluster로 저장
# C.ggplot을 이용하여 df$mid와 df$final의 산점도를 그린다. 색상과 점의 모양을 cluster에 따라 다르게.
# D.그 위에 centers의 중심 좌표를 그린다.

centers <- as.data.frame(p$centers)
centers
score$cluster <- p$cluster
# 점과 모양을 cluster에 따라 다르게
ggplot(score, aes(x=mid, y=final, color=cluster)) + geom_point() + geom_point(data=centers, size=3, color="red")

# 4. cluster별 군집별 평행 좌표 그림 그리기
library(GGally)
# ggpairs(score[, 1:2], columns=1:2, lower=list(continuous="points"), upper=list(continuous="blank"), diag=list(continuous="blank"), ggplot2::aes(color=score$cluster))

# 5. 군집 그래프 그리기
library(factoextra)
fviz_cluster(p, data=score[, 1:2], ellipse.type="euclid", repel=TRUE)
