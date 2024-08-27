#
# README
#
Zelda randomiseur basée sur l'IA

# Pour compiler
Pour executer : Set-ExecutionPolicy RemoteSigned

# Fichiers
script1Build.ps1 : génère Z.nes à partir de la rom originale "Legend of Zelda, The (U) (PRG0) [!].nes"
renommer l'original en Original.nes dans \ext

script2Util.ps1 : Utilitaire

script3Extract.ps1 : extrait les data de la rom pour les placer dans \src\dats\*.inc

script4Build.ps1 : place les fichiers \src\dats\*.inc dans \bin\dat\*.dat et génère Z.NES

.\script4Build.ps1 -RepertoireNb 0 : Z.NES sera le jeu original

.\script4Build.ps1 -RepertoireNb 1 : Z.NES sera zeldaChaos


