###########################################
# script4Build.ps1
###########################################
param ( [int] $RepertoireNb)
# Escalate any statement-terminating error to a script-terminating one.
trap { break }
. (join-path $PSScriptRoot script2Util.ps1)
###########################################
function ReassembleIncsToDats($i)
{
    $incRootPath = resolve-path .\src\dats$i
    $datRootPath = resolve-path .\bin\dat

    # Ensure output directory exists
    mkdir $datRootPath -ErrorAction Ignore > $null

    # Get all .inc files
    $incFiles = Get-ChildItem $incRootPath -Filter *.inc

    foreach ($incFile in $incFiles)
    {
        $datPath = join-path $datRootPath ($incFile.BaseName + ".dat")
        write-host "Reassembling $($incFile.FullName) to $datPath"

        # Convert .inc content back to binary format
        $incContent = [IO.File]::ReadAllText($incFile.FullName)
        $byteArray = ConvertIncContentToBytes $incContent
        [IO.File]::WriteAllBytes($datPath, $byteArray)
    }
}
###########################################
function ConvertIncContentToBytes($incContent)
{
    $bytes = @()
    foreach ($line in $incContent -split "`r`n")
    {
        # write-host "Processing line: $line"  # Log the current line being processed
        if ($line.StartsWith(".BYTE"))
        {
            $byteValues = $line -replace ".BYTE", "" -replace "\s", "" -split ',' 
            foreach ($byteValue in $byteValues)
            {
                # write-host "Processing byte value: $byteValue"  # Log the byte value being processed
                if ($byteValue -match '^\$([0-9A-F]{2})')
                {
                    $bytes += [Convert]::ToByte($matches[1], 16)
                    # write-host "Added byte: $($matches[1])"  # Log the byte successfully added
                }
                else
                {
                    write-host "Failed to match byte value: $byteValue"  # Log a failed match
                }
            }
        }
    }
    return $bytes
}
###########################################
function Assemble( $srcPath, $objPath )
{
	write-host "Assembling $srcPath and $objPath"
	.\ext\ca65 $srcPath -o $objPath --bin-include-dir .\bin
	$passed = $LastExitCode -eq 0
	$script:assemblyPassed = $script:assemblyPassed -and $passed
	if ( !$passed ) { write-host "" }
}
###########################################
function Compile()
{
    $srcPaths = @()
    $objPaths = @()
    foreach ( $file in (dir src\*.asm) )
    {
	    $base = [IO.Path]::GetFileNameWithoutExtension( $file )
	    $srcPaths += "src\$base.asm"
	    $objPaths += "obj\$base.o"
    }
    foreach ( $i in 0..($srcPaths.length-1) )
    {
	    Assemble $srcPaths[$i] $objPaths[$i]
    } 
    echo "Linking"
    .\ext\ld65 -o bin\Z.bin -C src\Z.cfg $objPaths
    if ( $LastExitCode -ne 0 ) { exit }
    echo "Combining raw ROM with NES header"
    JoinFiles bin\Z.nes -in OriginalNesHeader.bin, bin\Z.bin
}

# Call function to reassemble .inc files to .dat
ReassembleIncsToDats($RepertoireNb)
# Call function to compile
Compile
