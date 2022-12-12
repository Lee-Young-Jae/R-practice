# 1. 데이터 mtcars의 변수 gear에 대하여 빈도표를 구하고, 이름(names)를 다음과 같이 변경하여 저장/출력하는 코드
# 3단 4단 5단
# 15 12 5

myCars <- mtcars
tbl <- table(myCars$gear)
names(tbl) <- c("3단", "4단", "5단")
tbl

# 위 결과를 막대그래프로 그리는 코드 색상은 gold 경계선은 red  3단 4단 5단 대신 3개 4개 5개로 표시
barplot(tbl, col = "gold", border = "red", names.arg = c("3개", "4개", "5개"))


# 3. 기어(gear) 개수에 따른 qsec의 평균을 구하여 출력하는 코드(tapply 이용)
tapply(myCars$qsec, myCars$gear, mean)

# 4. 기어(gear) 개수에 따른 도수(빈도, length)와 qsec의 평균을 구하여 출력하는 코드 (summaryBy 이용)
View(summaryBy(qsec ~ gear, data = myCars, FUN = list(length, mean)))

# 5. 기어(gear) 개수에 따른 도수(빈도, n())와 qsec의 평균을 구하여 출력하는 코드(패키지 dplyr의 group_by(), summarize()와 chain rule 이용)
myCars %>% group_by(gear) %>% summarize(n = n(), mean = mean(qsec))

# 데이터 파일 “도로교통공단_시군구별 월별 교통사고 통계_20211231.xlsx”에 대하여 다음을 수행하시오.

# 6. 파일을 읽고 앞부분의 3줄을 출력하는 코드
accident <- read_excel("도로교통공단_시군구별 월별 교통사고 통계_20211231.xlsx")
head(accident, 3)

# 7. lapply를 이용하여 accident부터 report까지 5개의 변수의 전체 평균을 구하는 코드
# $사고건수 $사망자수  $중상자수 $경상자수 $부상신고자수

lapply(accident[, c("사고건수", "사망자수", "중상자수", "경상자수", "부상신고자수")], mean)


# 8. sapply를 이용하여 “사고건수”부터 “부상신고자수”까지 5개의 변수의 평균을 구하는 코드(round를 이용하여 소수점 둘째자리까지만 표시)

result <- sapply(accident[, c("사고건수", "사망자수", "중상자수", "경상자수", "부상신고자수")], mean) %>% round(2)
result

# 9. 데이터 data에서 “시도”가 서울인 데이터만 추출하여 seoul에 저장하고 빈도표 출력
seoul <- accident[accident$시도 == "서울", ]
table(seoul$시도)

# 10. 데이터 seoul에 대하여 sapply를 이용하여 “사고건수”부터 “부상신고자수”까지 5개의 변수의 평균을 구하는 코드(round를 이용하여 소수점 둘째자리까지만 표시)
result2 <- sapply(seoul[, c("사고건수", "사망자수", "중상자수", "경상자수", "부상신고자수")], mean) %>% round(2)
result2

# result1 과 result2의 결과를 데이터프레임 acc로 저장하는 코드
acc <- data.frame(Total=result, Seoul=result2)
acc

# 전체 교통사고 수 "사고건수"의 기본 통계량을 구하는 코드
summary(accident$사고건수)

# 13. 발생월당 사고건수가 1인 도시만 출력하는 코드
accident[accident$사고건수 == 1, ]

# 14. 패키지 doBy를 이용하여 전국 월별 ‘사고건수’의 평균을 구하는 코드
accident %>% group_by(발생월) %>% summarize(사고건수 = mean(사고건수))

# 15. ‘경상자수’에 대하여 계급의 크기가 100인 도수분포표를 출력하는 코드
table(cut(accident$경상자수, breaks = seq(0, 600, 100)))

# 16. ‘경상자수’에 대한 히스토그램(계급의 크기 100)를 출력하는 코드 col = gold border = red
hist(accident$경상자수, breaks = seq(0, 600, 100), col = "gold", border = "red")

# 17. 다음 코드는 강원도 데이터만 추출하여 ‘사고건수’의 평균과 최댓값을 구하는 코드이다.
# library(doBy)
# gw <- subset(data, 시도=="강원")
# summaryBy(사고건수 ~ 시군구, data=gw, FUN=c(mean, max))

# 위 코드를 패키지 dplyr를 이용하여 작성
accident %>% filter(시도 == "강원") %>% group_by(시군구) %>% summarize(사고건수.mean = mean(사고건수), 사고건수.max= max(사고건수))

# 18. 강원도 데이터 gw에서 “**시”인 데이터만 추출하여 gw_city에 저장하고 빈도표를 구하는 코드
gw <- accident[accident$시도 == "강원", ]
gw_city <- gw[grepl("시$", gw$시군구), ]
table(gw_city$시군구)

# 19. 데이터 gw_city에 각 시의 ‘사고건수’의 평균을 구하는 코드 – tapply 이용
round(tapply(gw_city$사고건수, gw_city$시군구, mean), 2)

# 20. 데이터 gw_city에 각 시의 ‘사고건수’의 평균을 높이로 하는 막대그래프를 그리는 코드
barplot(round(tapply(gw_city$사고건수, gw_city$시군구, mean), 2), col = "gold", border = "red")

# 21. 데이터 gw_city 에서 월별 x 시군구별 ‘경상자수’의 평균을 구하는 코드 matrix로 출력
round(tapply(gw_city$경상자수, list(gw_city$발생월, gw_city$시군구), mean), 2)
