

$array = New-Object string[] 142

$array[0] = $array[141] = ".............................................................................................................................................."
$linenum = 1
$numtemp = ""
$sum = 0
$match = $false

function searchForNumber {
    param (
        [string]$SearchString,
        [int32]$StartIndex,
        [char]$Dir
    )
    if ($Dir -eq 'F') { $d = 1 }
    else { $d = -1 }

    $index = $StartIndex
    $feh = 1

    while( $SearchString[$index] -match '\d'){
        $index += $d
        $feh++
    }

    [int32]$retValue = $SearchString[$StartIndex, $feh]

    return $retValue

}


foreach ($line in Get-Content '.\2023\Day3\Day3.txt') {

    ##write-host "line:$linenum is $($line.length) long: $line"
    $array[$linenum++] = @("." + $line + ".")

}

for ($i = 1; $i -le 140; $i++) {
    ###$($array.count - 2); $i++) {
    for ($j = 1; $j -le 140; $j++) {
        ###$($array[0].Length - 2); $j++ ) {

        if ($array[$i][$j] -match '\d' ) {
            $numtemp += $array[$i][$j]

            if ( 
                #top row
                (( $array[$i - 1][$j - 1] -notmatch '\d' ) -and ($array[$i - 1][$j - 1] -ne '.'))`
                    -or `
                (( $array[$i - 1][$j] -notmatch '\d' ) -and ($array[$i - 1][$j] -ne '.'))`
                    -or `
                (( $array[$i - 1][$j + 1] -notmatch '\d' ) -and ($array[$i - 1][$j + 1] -ne '.'))`
                    -or `
                    #middle row
                (( $array[$i][$j - 1] -notmatch '\d' ) -and ($array[$i][$j - 1] -ne '.'))`
                    -or `
                (( $array[$i][$j + 1] -notmatch '\d' ) -and ($array[$i][$j + 1] -ne '.'))`
                    -or `
                    #bottom row
                (( $array[$i + 1][$j - 1] -notmatch '\d' ) -and ($array[$i + 1][$j - 1] -ne '.'))`
                    -or `
                (( $array[$i + 1][$j] -notmatch '\d' ) -and ($array[$i + 1][$j] -ne '.'))`
                    -or `
                (( $array[$i + 1][$j + 1] -notmatch '\d' ) -and ($array[$i + 1][$j + 1] -ne '.'))`
            ) {
                $match = $true
                ##Write-Host "$($array[$i-1][$j-1])$($array[$i-1][$j])$($array[$i-1][$j+1])"
                ##Write-Host "$($array[$i][$j-1])$($array[$i][$j])$($array[$i][$j+1])"
                ##Write-Host "$($array[$i+1][$j-1])$($array[$i+1][$j])$($array[$i+1][$j+1])"
                ##Write-Host "-$i-$j-$numtemp-"
            }
            
        }
        else {
            if ($match -eq $true) {
                $sum += [int]$numtemp
            }
            $numtemp = ""
            $match = $false
            
        }
        
        
        if ($array[$i][$j] -eq '*') {
            ## we need to look for 2 numbers surrounding this *
            ## I have not checked the file, but we need to check for a 3rd number and skip if we find one

            if (
                ($array[$i - 1][$j - 1] -match '\d')`
                    -or ($array[$i - 1][$j] -match '\d')`
                    -or ($array[$i - 1][$j + 1] -match '\d')`
            ) {
                ##we have a match in the first row, lets see if it is 2
                if ( ($array[$i - 1][$j - 1] -match '\d')`
                        -and `
                    ($array[$i - 1][$j] -notmatch '\d')`
                        -and `
                    ($array[$i - 1][$j + 1] -match '\d')`
                ) {
                    ##we have 2 in one line
                    #now what?
                    ##start from the first place ([-1][-1]) and work backwards until there is no more digits, then we can take the indices and [int] it
                    $string = [string]$array[$i-1]
                    $index = $i-1
                    $n1 = searchForNumber($string, $index, "B")
                    Write-Host $n1
                    exit
                    ##start from the last place ([-1][+1]) and work forwards until there is not more digits, then we can take the indices and [int] it
                    
                }
                else {
                    #we have one in this line
                    #we need to scan backwares then forwards to get it.

                    $i1 = $i - 1
                
                }

            }

            
        }
    }
}

Write-Host "Day3-1 the total is: $sum"
Write-host "Day3-2 the golden ratio is: $ratio"

