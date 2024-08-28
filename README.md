#
# README
#
Zelda randomiseur bas�e sur l'IA

# Pour compiler
Pour executer : Set-ExecutionPolicy RemoteSigned

# Fichiers
script1Build.ps1 : g�n�re Z.nes � partir de la rom originale "Legend of Zelda, The (U) (PRG0) [!].nes"
renommer l'original en Original.nes dans \ext

script2Util.ps1 : Utilitaire

script3Extract.ps1 : extrait les data de la rom pour les placer dans \src\dats\*.inc

script4Build.ps1 : place les fichiers \src\dats\*.inc dans \bin\dat\*.dat et g�n�re Z.NES

script4Build.ps1 -RepertoireNb 0 : Z.NES g�n�re le jeu original

script4Build.ps1 -RepertoireNb 1 : Z.NES g�n�re zeldaChaos

script5Generation : modifie les .inc de mani�re al�atoire

# Les INC
LevelBlockOW.inc
(18400) 48 lignes

01-08 : T0 : Grottes
xxxx ....	Position horizontale � l'ext�rieur des grottes
.... x...	L'�cran contient Zola (sauf s'il n'y a pas de tuile d'eau)
.... .x..	Son de l'oc�an
.... ..xx	Code pour la palette 0 (Bordure ext�rieure)

09-16 : T1 : Grottes
xxxx xx..	Destination de la grotte
.... ..xx	Code pour la palette 1 (Section int�rieure)

17-24 : T2 : Ennemis
xx.. ....	Code de la quantit� (0 = 1 / 1 = 4 / 2 = 5 / 3 = 6)
..xx xxxx	Code de l'ennemi

25-32 : T3 : Code �cran
.xxx xxxx	Code de l'�cran
x... ....	Les ennemis sont de types mixtes

33-40 : T4 : Objets dans les grottes et les boutiques

41-48 : T5 :
.... .xxx	Position verticale � l'ext�rieur des grottes (0 = deuxi�me rang�e � partir du haut)
.... x...	Les ennemis apparaissent sur les c�t�s de l'�cran
..xx ....	Code de position des escaliers (lorsque quelque chose est pouss�)
.x.. ....	Secret dans la 1�re qu�te seulement
x... ....	Secret dans la 2�me qu�te seulement


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
..xx xxxx	Code �cran
.x.. ....	Block bougeable dans la salle (quand la salle est vid�e)
x... ....	Les ennemis sont de types m�lang�s

33-40 : T4 : Item
...x xxxx	Item
..x. ....	Boss cri Son 1 (Aquamentus, Manhandla, Gleeok, Digdogger)
.x.. ....	Boss cri Son 2 (Dodongo, Gohma)
x... ....	La salle est sombre

41-48 : T5 : 
xx.. ....	? Jamais utilis�
..xx ....	Code position item
.... x...	? Jamais utilis�
.... .x..	Secret activat� / Item apparait (quand la salle est vid�e)
.... ..x.	La salle a ennemi ma�tre
.... ...x	Les portes s'ouvrent / L'escalier appara�t (quand la salle est vid�e)

LevelInfoUW1.inc
(193FC)
Donn�es du 1er donjon

(1943B)
Donn�es de la carte dessin�e (16 colonnes)
