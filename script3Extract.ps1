# 26/08/2024 .\script3Extract.ps1
# 27/08/2024 Sur 1 ligne 8 à 16
# Extrait les datas de la rom dans src/dats

function ExtractAndFormatBins()
{
    $romPath = resolve-path .\ext\Original.nes
    $binXmlPath = resolve-path .\src\bins.xml
    $binRootPath = resolve-path .\src\dats0  # Assure que les fichiers vont directement dans \src\dats

    $xml = new-object Xml
    $xml.Load( $binXmlPath )

    $image = [IO.File]::ReadAllBytes( $romPath )

    foreach ( $bin in $xml.Binaries.Binary )
    {
        $incFileName = [IO.Path]::GetFileNameWithoutExtension($bin.FileName) + ".inc"
        $incFullPath = join-path $binRootPath $incFileName
        $incDir = split-path $incFullPath
        mkdir $incDir -ErrorAction Ignore > $null  # S'assure que le dossier nécessaire existe

        $offset = [int] $bin.Offset + 16
        $buf = new-object byte[] $bin.Length
        [Array]::Copy( $image, $offset, $buf, 0, $bin.Length )
        
        # Format and write include file
        $incContent = FormatAsAssembly16 $buf # 27/08/2024
        [IO.File]::WriteAllText( $incFullPath, $incContent )
        
        # Write the name of the generated file to the console for tracking
        write-host "Generated file: $incFullPath"
    }
}
###########################################
function FormatAsAssembly8([byte[]] $data)
{
    $output = ""
    for ($i = 0; $i -lt $data.Length; $i += 8)
    {
        $lineData = $data[$i..($i+7)]
        $hexData = ($lineData | ForEach-Object { "`$$(("{0:X2}" -f $_))" }) -join ', ' # Format bytes as hexadecimal
        $output += ".BYTE $hexData`r`n"
    }
    return $output
}
###########################################
# 27/08/2024
function FormatAsAssembly16([byte[]] $data)
{
    $output = ""
    for ($i = 0; $i -lt $data.Length; $i += 16)
    {
        $lineEnd = [Math]::Min($i + 15, $data.Length - 1) # Ensure it does not exceed bounds
        $lineData = $data[$i..$lineEnd]
        $hexData = ($lineData | ForEach-Object { "`$$(("{0:X2}" -f $_))" }) -join ', ' # Format bytes as hexadecimal
        $output += ".BYTE $hexData`r`n"
    }
    return $output
}
###########################################
ExtractAndFormatBins