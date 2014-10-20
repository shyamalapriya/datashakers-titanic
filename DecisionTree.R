

# Set working directory and import datafiles
setwd("~/Kaggle/datashakers-titanic")
train <- read.csv("./data/train.csv")
test <- read.csv("./data/test.csv")

# Install and load required packages for fancy decision tree plotting
#nstall.packages('rattle')
#install.packages('rpart.plot')
#install.packages('RColorBrewer')
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# Recreate the gender model
fit <- rpart(Survived ~ Sex, data=train, method="class")
fancyRpartPlot(fit)

# Build a deeper tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class")
# Plot it with base-R
plot(fit)
text(fit)
# And then make it look better with fancyRpartPlot!
fancyRpartPlot(fit)

# Now  make a prediction and write a submission file
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

# Make changes to the rpart.control
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=2, cp=0))
fancyRpartPlot(fit)

# Now let's make a prediction and write a submission file
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "mysecondFullGrowntree.csv", row.names = FALSE)