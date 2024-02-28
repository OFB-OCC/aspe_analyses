ls()
library(dplyr)

#import donnees ASPE sauf MEI (attention, mettre la dernière version disponible sur la GED)
load(file= "data/tables_sauf_mei_2024_01_22_12_13_56.RData")

#import donnees ASPE MEI (attention, mettre la dernière version disponible sur la GED))
load(file= "data/mei_2024_01_22_12_13_56.RData")

#Selection des poissons de taille supérieure à 1000 mm
bigfish<-filter(mesure_individuelle,mei_taille>1000)


### A partir description package Aspe de Pascal IRZ : https://pascalirz.github.io/aspe/articles/aspe_02_construire_un_jeu_de_donnees.html


#Activation des packages et chargement des données
library(aspe)
library(dplyr)
library(stringr)

#Mise en correspondance des identifiants des tables principales
passerelle <- aspe::mef_creer_passerelle()

#Sélection d’un périmètre géographique (dans l'exemple ci-dessous, dpts de la région Occitanie)
aspe_occ <- passerelle %>%
  mef_ajouter_dept() %>%
  filter(dept %in% c("09", "11", "12", "30", "31", "32", "34", "65", "66", "46", "48", "81", "82"))

#Sélection d’une fenêtre temporelle (dans exemple ci-dessous, selection depuis 1994 sur selection dept précédente)
table(aspe_occ$dept)
aspe_occ <- aspe_occ %>%
  mef_ajouter_ope_date() %>%
  filter(annee > 1994)

#Ajout des mesures individuels à la sélection précédente
## Attention bien vérifier avec le menu aide les arguments nécessaires
?mef_ajouter_mei
mei_1994<-aspe_occ %>%
  mef_ajouter_mei()

#Ajout des mesures individuels à la sélection précédente
## Attention bien vérifier avec le menu aide les arguments nécessaires
?mef_ajouter_esp
mei_sp_1994 <-mei_1994 %>%
  mef_ajouter_lots() %>%
  mef_ajouter_esp()

bigfish<-filter(mei_sp_1994,mei_taille>1000)
