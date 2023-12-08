


$tot = 0

foreach ($line in Get-Content '.\AoC\Day1\Day1.0.txt') {
    #get ready for a line
    $firstnum = -1
    $lastnum = -1
    
    $len = $line.Length
    ##write-host ".$line. is $len long"
    $curpos = 0
    while ( $curpos -lt $len) {
        
        #do stuff
        $str = $line[$curpos..$len] -join ''
        $char = $line[$curpos..$curpos] -join ''
        ## Write-Host ".$str."
        ## write-host ".$char."
        $int = -1

        switch -regex ($str) {
            "^one" {
                $int = 1; break 
            }
            "^two" {
                $int = 2; break 
            }
            "^three" {
                $int = 3; break 
            }
            "^four" {
                $int = 4; break 
            }
            "^five" {
                $int = 5; break 
            }
            "^six" {
                $int = 6; break 
            }
            "^seven" {
                $int = 7; break 
            }
            "^eight" {
                $int = 8; break 
            }
            "^nine" {
                $int = 9; break 
            }
            "^zero" {
                $int = 0; break 
            }
        }
 
        if ( $int -eq -1) {
            if ( $char -match "\d" ) {
                $int = [int]$char
            }
        }

        if ( $int -ne -1) {
            if ($firstnum -eq -1) {
                $firstnum = $int
            }
            else {
                $lastnum = $int
            }
        }        
        $curpos += 1
    }


    if ( $lastnum -eq -1 ) {
        $lastnum = $firstnum
    }
    $num = ( $firstnum * 10 ) + $lastnum
    $tot += $num 
    Write-Host "$line -> ($firstnum $lastnum) $num -> $tot"
    ##write-host "firstnum $firstnum lastnum $lastnum which is $num making the total $tot"
    ##Write-Host "========================================================="
    #finish line
}
Write-Host "the total is: $tot"