wineTest = read.csv(file="wine_test.csv")
str(wineTest)
predictTest = predict(model4, newdata=wineTest)
predictTest

# Compare R^2 value = R^2 = 1-SSE/SST
SSE = sum(wineTest$Price - predictTest^2)
SST = sum(wineTest$Price- mean(wine$Price)^2)
1 - SSE/SST