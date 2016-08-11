
library(FrF2)
library(gplots)

###########################################################################
# SCREENING EXPERIMENT: 8 FACTORS, 2 LEVELS
factor.names=list(alpha=c(15,45),
                  beta=c(0,30),
                  Aq=c(2e­06,4e­06),
                  d=c(0.1,0.2),
                  mt=c(0.01,0.02),
                  mf=c(0.01,0.02),
                  pin=c(1,2),
                  dzul=c(5,10))
# Design to create txt
design1 <­ FrF2(16, 8, factor.names = factor.names, randomize = FALSE,
                alias.info = 3);
design1.df <­ data.frame(design1)
write.table(design1.df, "design1.txt", sep="\t", quote=FALSE, dec=".",
row.names=FALSE)
# Read output from web
result1 <­ read.delim("result1.txt")
# Append output to design
exp1 <­ data.frame(desnum(design1))
exp1$range <­ result1$RANGE

###########################################################################
# FIRST MODEL
# Model with main effects and two­ way interactions
model1 <­ lm(range ~ (.)^2, data=exp1)
summary(model1)
aliases(model1)
 # Include the following two factor interactions in the model:
# alpha:beta + alpha:Aq + alpha:d + alpha:mt + alpha:mf + alpha:pin +
alpha:dzul
model1a <­ lm(range ~ alpha + beta + Aq + d + mt + mf + pin + dzul
              + alpha:beta + alpha:Aq + alpha:d + alpha:mt + alpha:mf
              + alpha:pin + alpha:dzul, data=exp1)
summary(model1a)
par(mfrow=c(1,1))
effects <­ 2*model1a$coefficients[2:length(model1a$coefficients)]
q <­ qqnorm(effects, main = "QQ­Plot of Effects", pch = 21, bg =
'darkblue',
            cex = .5)
qqline(effects)
abs(q$y)[order(­abs(q$y))]

###########################################################################
# SECOND MODEL WITH LARGEST EFFECTS
model1b <­ lm(range ~ pin + alpha + Aq + d + alpha:d + alpha:Aq, data=exp1)
summary(model1b)

###########################################################################
#
# SECOND EXPERIMENT: 4 FACTORS, 2 LEVELS
# Set any factor not in the experiment to its low value.
factor.names2=list(alpha=c(15,45),
                   Aq=c(2e­06,4e­06),
                   d=c(0.1,0.2),
                   pin=c(1,2))
design2 <­ FrF2(16, 4, factor.names = factor.names2, replications = 3,
                randomize = FALSE, alias.info = 3);
design2.df <­ data.frame(design2)
write.table(design2.df, "design2.txt", sep="\t", quote=FALSE, dec=".",
row.names=FALSE)
# Read output from web
result2 <­ read.delim("result2.txt")
exp2 <­ data.frame(desnum(design2))
exp2$range <­ result2$RANGE

###########################################################################
# FINAL MODEL: WITH ALL THREE­WAY INTERACTIONS
# Starting with a model with all three way interactions, each term in the
# following model is significant after backwards elimination.
# Remove Aq1:d1:pin1  alpha1:pin1  alpha1:d1:pin1
model2 <­ lm(range ~ (.)^3 ­ Aq1:d1:pin1 ­ alpha1:pin1 ­ alpha1:d1:pin1
             ­ alpha1:Aq1:pin1, data=exp2)
summary(model2)
par(mfrow=c(2,2), oma = c(0,0,2,0))
ylab = "Range"
plotmeans(formula = range~pin1, data=exp2, ylab = ylab, xlab = "pin", ylim
= c(0, 7))
plotmeans(formula = range~alpha1, data=exp2, ylab = ylab, xlab = "alpha",
ylim = c(0, 7))
plotmeans(formula = range~Aq1, data=exp2, ylab = ylab, xlab = "Aq", ylim =
c(0, 7))
plotmeans(formula = range~d1, data=exp2, ylab = ylab, xlab = "d", ylim =
c(0, 7))
mtext("Main Effect Plots", outer = TRUE, cex = 1.5)
pin <­ exp2$pin1
alpha <­ exp2$alpha1
Aq <­ exp2$Aq1
d <­ exp2$d
range <­ exp2$range
par(mfrow=c(2,2), oma = c(0,0,2,0))
interaction.plot(alpha, Aq, range, ylab = "Mean Response Rate", main =
"alpha:Aq", ylim = c(0, 7))
interaction.plot(alpha, d, range, ylab = "Mean Response Rate", main =
"alpha:d", ylim = c(0, 7))
interaction.plot(Aq, d, range, ylab = "Mean Response Rate", main = "Aq:d",
ylim = c(0, 7))
interaction.plot(Aq, pin, range, ylab = "Mean Response Rate", main =
"Aq:pin", ylim = c(0, 7))
mtext("Interaction Plots", outer = TRUE, cex = 1.5)
par(mfrow=c(1,1))
interaction.plot(d, pin, range, ylab = "Mean Response Rate", main =
"d:pin", ylim = c(0, 7))

###########################################################################
# PREDICTION AND CONFIRMATION RUNS
# Prediction
optimal <­ data.frame('alpha1' = 1, 'Aq1' = 1, 'd1' = ­1, 'pin1' = 1)
predict(model2, optimal, interval = "predict")
# 10 confirmation runs
result3 <­ read.delim("result3.txt")
mean(result3$RANGE)

###########################################################################
# RESIDUAL ANALYSIS
par(mfrow = c(2,2))
hist(model2$residuals, main = "Histogram of Residuals", breaks = 30,
     col = 'aliceblue')
qqnorm(model2$residuals, main = "QQ­Plot of Residuals", pch = 21, bg =
'darkblue',
       cex = .5)
qqline(model2$residuals, col = "red")
plot(model2$residuals, main = "Residuals vs. Order", ylab = "Residuals",
     pch = 21, bg = 'darkblue', cex = .5)
abline(h = 0, col = "red")
plot(model2$fitted, model2$residuals, main = "Residuals vs. Fitted Values",
     ylab = "Residuals", xlab = "Fitted Values",
     pch = 21, bg = 'darkblue', cex = .5)
abline(h = 0, col = "red")
# Residual analysis tests:
# Durbin Watson
library(lmtest)
dwtest(model2)
# Shapiro
shapiro.test(model2$residuals)
# Breusch­Pagan
bptest(model2)