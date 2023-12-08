

$maxRed = 12
$maxGreen = 13
$maxBlue = 14

$red = $blue = $green = 0
$total = $totalPowerOfCubes = 0


foreach ($line in Get-Content '.\2023\Day2\Day2.0.txt') {
    Write-Host $line
    $gameText = $line.Substring(0, $line.IndexOf(":"))
    [string]$gameNumber = $gametext[4..$gameText.Length] -join ''
    $gn = [int]$gameNumber
    $fail = $false
    $red = $blue = $green = 0
        
    $rounds = $($line[$($line.IndexOf(":") + 1)..$line.Length] -join '') -split ";"
    foreach ($round in $rounds) {
        $picks = $round -split ","

        foreach ($pick in $picks) {
            $fehs = $pick -split " "
            $num = [int]$fehs[1] 
            $color = $fehs[2]
            ##write-host "num: $num color: $color"
            switch -exact ($color) {
                "red" {
                    ##do red stuff here
                    ##Write-Host "red $color $num"
                    if ($num -gt $maxRed) { $fail = $true }
                    if ($num -gt $red) { $red = $num }
                    break
                }
                "blue" {
                    ##do blue stuff here
                    ##Write-Host "blue $color $num"
                    if ($num -gt $maxBlue) { $fail = $true }
                    if ($num -gt $blue) { $blue = $num }
                    break
                }
                "green" {
                    ##Green stuff here
                    ##Write-Host "green $color $num"
                    if ($num -gt $maxGreen) { $fail = $true }
                    if ($num -gt $green) { $green = $num }
                    break
                }
                Default {
                    Write-Host "unknown color: $color"
                    exit
                }
            }
        }
    }
    if ($fail -eq $false) {
        write-host "we have a winner!"
        $total += $gn
    }
    $powerOfCubes = $red * $blue * $green
    $totalPowerOfCubes += $powerOfCubes
    Write-Host "min red: $red min blue: $blue min green: $green and thier power is: $powerOfCubes bringing the total power of cubes to: $totalPowerOfCubes"
}

Write-Host "total of game number: $total"
Write-Host "total of power of cubes: $totalPowerOfCubes"