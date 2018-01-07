#########################################################################################
### This program calculates MELD, MELD_Na, and MELD_Plus scores.                      ###   
### Kartoun U, Corey KE, Simon TG, Zheng H, Aggarwal R, Ng K, Shaw SY.                ### 
### The MELD-Plus: A generalizable prediction risk score in cirrhosis. PLoS One.      ### 
### 2017 Oct 25;12(10):e0186301. doi: 10.1371/journal.pone.0186301. eCollection 2017. ###
#########################################################################################
rm(list=ls());
#########################################################################################
### Specify variables:
Total_Bilirubin = 2.486604493
INR = 1.499619615
Creatinine = 1.375274633
Sodium = 136.5401552
Albumin = 2.888940902
WBC = 6.673836966
Total_Cholesterol = 133.6246914
Age = 60.0
Length_of_stay = 7.3
#########################################################################################

#Calculate scores:

# MELD and MELD-Na values are in the range of  6 (less ill) to 40 (gravely ill):
MELD = round(10 * ((0.957 * log(Creatinine)) + (0.378 * log(Total_Bilirubin)) + (1.12 * log(INR))) + 6.43, 1)
MELD_Na = round(MELD + 1.59 * (135 - Sodium), 1)

# MELD-Plus variables represent probability in the range of 0.0 (less ill) to 1.0 (gravely ill):
linear_part_7_Varaibles = +8.53499496 + 2.06503238 * log10(1 + Total_Bilirubin) + 2.59679650 * log10(1 + Creatinine) - 6.34990436 * log10(1 + Albumin) + 2.99724802 * log10(1 + INR) + 1.92811726 * log10(1 + WBC) + 0.04070442 * Age -6.47834101 * log10(1 + Sodium)
MELD_Plus_7_Varaibles = round(exp(linear_part_7_Varaibles) /  (1 + exp(linear_part_7_Varaibles)), 2)

linear_part_9_Varaibles = +11.794383 + 2.076192 * log10(1 + Total_Bilirubin) + 2.525904 * log10(1 + Creatinine) - 6.04954 * log10(1 + Albumin) + 2.525904 * log10(1 + INR) + 1.911856 * log10(1 + WBC) + 0.041047 * Age -6.62527 * log10(1 + Sodium) -1.445666 * log10(1 + Total_Cholesterol) + 0.015411 * Length_of_stay
MELD_Plus_9_Varaibles = round(exp(linear_part_9_Varaibles) /  (1 + exp(linear_part_9_Varaibles)), 2)

all_scores_string = paste(paste(paste(paste(paste(paste(paste(paste('MELD:', MELD, ''), ', MELD_Na:', ''), MELD_Na, ''), ', MELD_Plus_7_Varaibles:', ''), MELD_Plus_7_Varaibles, ''), ', MELD_Plus_9_Varaibles:', ''), MELD_Plus_9_Varaibles, ''))
print(all_scores_string)

#########################################################################################