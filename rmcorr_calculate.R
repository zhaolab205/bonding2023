library(rmcorr)


setwd("E:/NTU_fNIRS/")

# load data
data <- read.table("rmcorr_eas_mo.txt", header=TRUE)

# get questionnaire and behavior data 
questionnaire <- data[, 2:7]
behavior <- data[, 8:13]


rmcorr_result <- data.frame(questionnaire = character(), behavior = character(), rmcorr = numeric(), stringsAsFactors = FALSE)

# calculate rmcorr
for (i in 1:ncol(questionnaire)) {
  for (j in 1:ncol(behavior)) {
    # 从原始数据中选择对应的列
    measure1 <- questionnaire[, i]
    measure2 <- behavior[, j]
    participant <- data$Patients
    # 将数据合并为数据框
    dataset <- data.frame(Participant = participant, Measure1 = measure1, Measure2 = measure2)
    # 计算重复测量相关性
    rmc.out <- rmcorr(participant, measure1, measure2, dataset, CIs = c("analytic"), nreps = 100, bstrap.out = FALSE)
    #print(rmc.out)
    # 将结果添加到数据框中
    rmcorr_result <- rbind(rmcorr_result, data.frame(questionnaire = names(questionnaire)[i], behavior = names(behavior)[j], rmcorr = rmc.out$p))
  }
}
# check result
rmcorr_result