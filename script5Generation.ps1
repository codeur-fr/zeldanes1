#
# scriptGeneration.ps1
#
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
        $line = $bytes[$index..($index+7)]
        $index += 8
        $byteLine = ".BYTE $" + ($line -join ', $')
        $byteLines += $byteLine
    }

    $output = $byteLines -join "`n"
    Write-Host $output
    $output | Out-File $path
}

# Exemple d'appel de la fonction
Generer "s.txt" 96
