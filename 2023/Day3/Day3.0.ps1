

$array = New-Object string[] 142

$array[0] = $array[141] = ".............................................................................................................................................."
$linenum = 1
$numtemp = ""
$sum = 0
$match = $false


foreach ($line in Get-Content '.\AoC\Day3\Day3.txt') {

    ##write-host "line:$linenum is $($line.length) long: $line"
    $array[$linenum++] = @("." + $line + ".")

}

for ($i = 1; $i -le 140; $i++){   ###$($array.count - 2); $i++) {
    for ($j = 1; $j -le 140; $j++){ ###$($array[0].Length - 2); $j++ ) {

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
                Write-Host "$($array[$i-1][$j-1])$($array[$i-1][$j])$($array[$i-1][$j+1])"
                Write-Host "$($array[$i][$j-1])$($array[$i][$j])$($array[$i][$j+1])"
                Write-Host "$($array[$i+1][$j-1])$($array[$i+1][$j])$($array[$i+1][$j+1])"
                Write-Host "-$i-$j-$numtemp-"
            }
            
        } else{
            if($match -eq $true){
                $sum += [int]$numtemp
            }
            $numtemp = ""
            $match = $false
            
        } elseif($array[$i][$j] -eq '*'){
            ## we need to look for 2 numbers surrounding this *
            
        }
    }
}

Write-Host "the total is: $sum"