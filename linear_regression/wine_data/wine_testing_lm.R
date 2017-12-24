# Predictive analytics
wine = read.csv("wine.csv")
str(wine)
#price -dependent variable
# age, AGST independent variable.

summary(wine) # give min, max, mean median
#lm is liner regression model. In paranthesis - right dependent variant, after tilde write independent varianb;e 

model1 = lm(Price ~ AGST, data = wine)
summary(model1)

model1$residuals # returns the vector of residuals

SSE = sum(model1$residuals ^ 2)

SSE

# model with two indendent variable
model2 = lm(Price ~ AGST + HarvestRain), data = wine)
summary(model2)
SSE = sum(model2$residuals ^ 2)
SSE

model3 = lm(Price ~ AGST + HarvestRain + WinterRain + Age +FrancePop, data=wine)
summary(model3)
# adding more independent variables model is better

SSE = sum(model3$residuals)
SSE

#Removed the FrancePop
model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data=wine)
summary(model4)

# Remove age also.

model5 = lm(Price ~ AGST + HarvestRain + WinterRain, data=wine)
summary(model5)

