############################################
# 26/08/2024 script5Generation.ps1
# 27/08/2024 8 à 16 hex par ligne
###########################################
function Generer($nomDuFichier, $nombreDeByte) {
    Write-Host "nomDuFichier=$nomDuFichier";
    Write-Host "nombreDeByte=$nombreDeByte";

    $path = ".\$nomDuFichier"
    $bytes = @()
    
    for ($i = 0; $i -lt $nombreDeByte; $i++) {
        $randomByte = Get-Random -Minimum 0 -Maximum 256
        $bytes += '{0:X2}' -f $randomByte
    }

    $byteLines = @()
    $index = 0

    while ($index -lt $bytes.Count) {
        $line = $bytes[$index..($index+15)] # 27/08/2024 : 7 -> 15 
        $index += 16 # 27/08/2024 : 8 -> 16
        $byteLine = ".BYTE $" + ($line -join ', $')
        $byteLines += $byteLine
    }

    $output = $byteLines -join "`n"
    Write-Host $output
    $output | Out-File $path
}
###########################################
# Exemple d'appel de la fonction
# Generer "src\dats1\LevelInfoUW1.inc" 15*16+12
# Generer "s.txt" (15*16+12)
Generer "s.txt" (48*16)
###########################################