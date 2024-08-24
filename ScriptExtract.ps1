function ExtractAndFormatBins()
{
    $romPath = resolve-path .\ext\Original.nes
    $binXmlPath = resolve-path .\src\bins.xml
    $binRootPath = resolve-path .\src\dats\inc  # Modification ici pour diriger vers le nouveau dossier

    $xml = new-object Xml
    $xml.Load( $binXmlPath )

    $image = [IO.File]::ReadAllBytes( $romPath )

    foreach ( $bin in $xml.Binaries.Binary )
    {
        $incPath = ($bin.FileName -replace "dat$", "inc") # Change file extension to .inc
        $incFullPath = join-path $binRootPath $incPath
        $incDir = split-path $incFullPath
        mkdir $incDir -ErrorAction Ignore > $null  # S'assure que le dossier 'inc' existe

        $offset = [int] $bin.Offset + 16
        $buf = new-object byte[] $bin.Length
        [Array]::Copy( $image, $offset, $buf, 0, $bin.Length )
        
        # Format and write include file
        $incContent = FormatAsAssembly $buf
        [IO.File]::WriteAllText( $incFullPath, $incContent )
        
        # Write the name of the generated file to the console for tracking
        write-host "Generated file: $incFullPath"
    }
}

function FormatAsAssembly([byte[]] $data)
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


ExtractAndFormatBins