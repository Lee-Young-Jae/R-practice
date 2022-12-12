# 문자열 합치기
paste("The life of", "Pi") # 두 문자열 합치기
paste("The life of", pi) # pi는 내장되어 있는 상수
paste("Q", 1:10, sep=".") # sep=""는 구분자를 없애는 옵션

paste0("Q", 1:10) # paste0()는 sep="" 옵션을 기본으로 가지고 있음
vec <- c("건국대학교", "과학기술대학", "소프트웨어 전공")
paste(vec)   # 3개를 합치지는 못한다.
paste(vec, collapse=" ") # collapse=""는 구분자를 없애는 옵션

# nchar() 는 문자열의 길이, length()는 문자열의 개수를 반환
nchar(c("건국대학교", "과학기술대학", "소프트웨어 전공")) # 5, 6, 8
length(c("건국대학교", "과학기술대학", "소프트웨어 전공")) # 3

# 소문자 - 대문자 변환
tolower(c("KUNGLAB", "T.J.MAX", "Sears")) # 소문자로 변환
toupper(c("kunglab", "t.j.max", "sears")) # 대문자로 변환

# 문자열 추출
substr("KUNGLAB", 1, 3) # 1번째부터 3번째까지 추출

# YOUNGJAE의 JAE만 추출하기
substr("YOUNGJAE", 6, 8) # 6번째부터 8번째까지 추출

# 문자열 대체 - sub()는 첫글자만 대체, gsub()은 모든 글자를 대체
fruits <- c("apple", "banana", "orange", "grape", "mandarin")
sub("a", "A", fruits) # 첫글자만 대체 (처음으로 마주치는)

fruits <- c("apple", "banana", "orange", "grape", "mandarin")
gsub("a", "A", fruits) # 모든 글자를 대체

# 정규식 (Regular Expression)
code <- c("JAVA", "C", "C++", "C#", "PYTHON", "R", "MATLAB", "javascript", "PHP")
# P로 시작하는 단어 검색
grep("^P", code) # 5, 9 (PYTHON, PHP)
# 소문자로 끝나는 단어 검색
grep("t$", code) # 8 (javascript)
grep("[a-z]$", code) # 8 (javascript)")
# r 또는 R을 포함하는 단어 검색
grep("r|R", code) # 6, 8 (R,  javascript)
grep("[rR]", code) # 6, 8 (R,  javascript)

# a-k로 시작하는 단어 검색
grep("^[a-kA-K]", code) # 1, 2, 3, 4, 8 (JAVA, C, C++, C#, javascript)

# 모음을 포함하는 단어 검색
code[grep("[aeiou]", code)] # 8 (javascript)

# 모음을 포함하는 단어 검색, 대소문자 구분 없이
code[grep("[aeiou]", code, ignore.case=TRUE)] # 1, 5, 7, 8 (JAVA, PYTHON, MATLAB, javascript)


# 데이터: “도로교통공단_시군구별 월별 교통사고 통계_20211231.xlsx”

# 데이터 불러오기
library(readxl)
data <- read_excel("도로교통공단_시군구별 월별 교통사고 통계_20211231.xlsx")
head(data)

# 뒷부분 출력
tail(data)

# 서울 데이터만 추출
# seoul <- data[data$시도 == "서울", ]
seoul <- subset(data, 시도 == "서울")
table(seoul$시도)
table(seoul$시군구)

# '강' 으로 시작되는 구만 검색하여 gang에 저장
idx <- grep("^강", seoul$시군구)
gang <- seoul[idx, ]
# 빈도표 확인
table(gang$시군구)

# 4개 구의 월평균 사고건수
result <- tapply(gang$사고건수, gang$발생월, mean)
round(result, 1)

# 충북 데이터만 추출
cb <- subset(data, 시도 == "충북")
table(cb$시군구)

# 충북에서 '시'로 끝나는 도시만 검색/빈도표로 확인
idx <- grep("시$", cb$시군구)
city <- cb[idx, ]
table(city$시군구)

result <- tapply(city$사고건수, city$시군구, mean)
round(result, 1)

# for loop와 if문
data <- floor(runif(10, 1, 100)) # 1~100 사이의 실수를 10개 생성 
print(data)

# 짝수를 찾는 함수
even <- c()
for (num in data) {
  if (num %% 2 == 0) {
    even <- c(even, num)
  }
}

even

even_R <- data[data %% 2 == 0] # R로 필터로 짝수 찾기
print(even_R)

# ‘기업조사결과.zip’를 다운받아 사용(35 개의 엑셀 파일)

# 엑셀 파일 목록 확인하기 - 여기서 S1.xlsx 부터 S35.xlsx가 다 있어야한다.

# 정규 표현식으로 파일명 찾기 - S로 시작하고 숫자로 끝나는 파일명 찾기
files <- list.files(pattern = "^S[0-9]+.xlsx")
length(files)

# 35개의 엑셀 파일을 읽어 하나의 데이터 프레임으로 합치기 (rbind)
library(readxl)

df <- as.data.frame(read_excel(files[1]))
for (i in 2:length(files)) {
  df <- rbind(df, read_excel(files[i]))
}

# 데이터 확인
head(df)
View(df)
str(df)

# 데이터 다시 읽고 확인하기 (S19가 컬럼 이름을 바꿔놔서 다시 읽어야함 설립년 -> 설립년 (년도) 이런식으로 바꿔놓음)
df <- as.data.frame(read_xlsx(files[1]))
for(x in c(2:length(files))) {
 tmp <- as.data.frame(read_xlsx(files[x]))
 df <- rbind(df, tmp[1:5, ])
}
str(df)

# 데이터 프레임 df에 학생의 고유 아이디가 없기때문에 아이디 문자열 생성 하기
S1 <- paste0("S0", 1:9)
S2 <- paste0("S", 10:35)
S <- c(S1, S2)
id <- rep(S, each = 5)
id

# 데이터 프레임 df에 아이디 컬럼 추가 (순서를 맨 앞으로)
df$id <- id

# 아이디 컬럼을 맨 앞으로 이동
df <- df[, c(9, 1:8)]
head(df)
View(df)



# 변수 이름을 영어로 바꾸기
names(df)
names(df) <- c("id", "no" ,"company", "solution", "location", "year", "sales", "employee", "rank")
head(df)
View(df, 5)

# 두 변수 id, rank 순으로 정렬하여 df2에 저장하기
df2 <- df[order(df$id, df$rank), ]

# 기업이름 (company)의 빈도표
table(df2$company)

# 굿모닝 아이텍 굿모닝아이텍, 삼성SDS 삼성 SDS 공백에 문제가 있음
# 공백을 제거하고 빈도표를 다시 만들기
library(stringr)
df2$company <- gsub(" ", "", df2$company)

# 소문자를 대문자로
df2$company <- toupper(df2$company)

# 좌우공백 없애기
df2$company <- str_trim(df2$company)

# 빈도표 다시 만들기
table(df2$company)

# gsub()를 이용하여 수정/확인
df2$company <- gsub("데이터솔루션", "데이타솔루션", df2$company)
df2$company <- gsub("KTNEXR", "KT넥스알", df2$company)
table(df2$company)

# company * rank의 이차원 교차표 구하기 -> 데이터 프레임으로 저장
result <- as.data.frame.array(table(df2$company, df2$rank))
names(result) <- paste0("R", 1:5)
result

# 각 랭킹의 합으로 cross check (데이터 확인)
apply(result, 2, sum)

# 1위 5점, 2위 4점 ... 5위 1점으로 점수 계산/ 내림차순 출력
result$score <- result$R1 * 5 + result$R2 * 4 + result$R3 * 3 + result$R4 * 2 + result$R5 * 1
result <- result[order(-result$score), ]
View(result)
