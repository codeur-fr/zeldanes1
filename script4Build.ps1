#
# script4Build.ps1
#
param ( [switch] $NoVerify )

# Import utilities if necessary
. (join-path $PSScriptRoot util.ps1)

function ReassembleIncsToDats()
{
    $incRootPath = resolve-path .\src\dats
    $datRootPath = resolve-path .\bin

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


CheckRequirements # Assuming you have a similar requirements check

if (!$NoVerify)
{
    # Your verification logic if needed
}

# Call function to reassemble .inc files to .dat
ReassembleIncsToDats
