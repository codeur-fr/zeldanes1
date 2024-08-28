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

script4Build.ps1 -RepertoireNb 0 : Z.NES génère le jeu original

script4Build.ps1 -RepertoireNb 1 : Z.NES génère zeldaChaos

script5Generation : modifie les .inc de manière aléatoire

# Les INC
LevelBlockOW.inc
(18400) 48 lignes

01-08 : T0 : Grottes
xxxx ....	Position horizontale à l'extérieur des grottes
.... x...	L'écran contient Zola (sauf s'il n'y a pas de tuile d'eau)
.... .x..	Son de l'océan
.... ..xx	Code pour la palette 0 (Bordure extérieure)

09-16 : T1 : Grottes
xxxx xx..	Destination de la grotte
.... ..xx	Code pour la palette 1 (Section intérieure)

17-24 : T2 : Ennemis
xx.. ....	Code de la quantité (0 = 1 / 1 = 4 / 2 = 5 / 3 = 6)
..xx xxxx	Code de l'ennemi

25-32 : T3 : Code écran
.xxx xxxx	Code de l'écran
x... ....	Les ennemis sont de types mixtes

33-40 : T4 : Objets dans les grottes et les boutiques

41-48 : T5 :
.... .xxx	Position verticale à l'extérieur des grottes (0 = deuxième rangée à partir du haut)
.... x...	Les ennemis apparaissent sur les côtés de l'écran
..xx ....	Code de position des escaliers (lorsque quelque chose est poussé)
.x.. ....	Secret dans la 1ère quête seulement
x... ....	Secret dans la 2ème quête seulement


LevelBlockUW1Q1.inc
(18700) 48 lignes

01-08 : T0 : Portes Nord-Sud
xxx. .... Type nord
...x xx.. Type sud
.... ..xx Code pour la palette 0 (Bord exterieur)

09-16 : T1: Portes Ouest-Est
xxx. .... Type ouest
...x xx.. Type est
.... ..xx Code pour la palette 1 (Section interne)

17-24 : T2: Ennemis
xx.. ....	Code nombre (0 = 1(3?) / 1 = 4(5?) / 2 = 5(6?) / 3 = 6(8?)
..xx xxxx	Code ennemi

25-32 : T3 : Blocs
..xx xxxx	Code écran
.x.. ....	Block bougeable dans la salle (quand la salle est vidée)
x... ....	Les ennemis sont de types mélangés

33-40 : T4 : Item
...x xxxx	Item
..x. ....	Boss cri Son 1 (Aquamentus, Manhandla, Gleeok, Digdogger)
.x.. ....	Boss cri Son 2 (Dodongo, Gohma)
x... ....	La salle est sombre

41-48 : T5 : 
xx.. ....	? Jamais utilisé
..xx ....	Code position item
.... x...	? Jamais utilisé
.... .x..	Secret activaté / Item apparait (quand la salle est vidée)
.... ..x.	La salle a ennemi maître
.... ...x	Les portes s'ouvrent / L'escalier apparaît (quand la salle est vidée)

LevelInfoUW1.inc
(193FC)
Données du 1er donjon

(1943B)
Données de la carte dessinée (16 colonnes)
