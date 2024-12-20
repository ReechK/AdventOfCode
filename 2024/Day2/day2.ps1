
$linenum = 0
$safe = 0
$output = '.\Day2\output.txt'
$hostorFile = $true # true for host


function Test-output-it {
    param (
        [string]$outstring,
        [bool]$outputtohost,
        [string]$output1
    )
    if ($outputtohost -eq $true){
        Write-Host $outstring
    }
    else {
        $outstring | Out-File $output1 -Append
    }
}

$out = 'start of run'
$out | Out-File $output ## this initializes the file (not -append)

foreach($line in Get-Content '.\Day2\input') {
    $linenum++
    $herp = "line: $linenum ->$line<-"
    Test-output-it $herp $hostorFile $output

    [array]$feh = $line.split(" ")


    $inc = $true
    $dec = $true
    $rangeOK = $true
    $safe = $false
        
    for( $i = 1; $i -lt $feh.count; $i++) {

        [int] $first = $feh[$i]
        [int] $second = $feh[$i-1]

        $derp = [Math]::abs(($feh[$i]-$feh[$i-1]))

        $herp = "$i - $derp"
        
        Test-output-it $herp $hostorFile $output

        if(($derp -gt 3) -or ($derp -lt 1)){
            $rangeOK=$false
            $i = $feh.count
            Test-output-it "Range" $hostorFile $output
        }

        if ($first -gt $second){
            $dec = $false
        }
        elseif ($first -lt $second){
            $inc = $false
        }
        else { #numbers are the same
            $inc=$false
            $dec=$false
            $i = $feh.count
            Test-output-it "Same #" $hostorFile $output
        }

    }

    if( (-not $inc -and -not $dec ) -or (-not $rangeOK)){

        Test-output-it @("neither - this is a fail for this line AKA not safe ($safe)") $hostorFile $output
        ## now we need to loop again dropping 1 # at a time and see if we get a safe one
        
        $feh2 = @($null) * ($feh.Count - 1)
        $safe = $false
        $inc2 = $false
        $dec2 = $false
        $rangeOK2 = $true

        for($i=0; $i -lt $feh.Count; $i++){
            Write-Host $i
            $ctr = 0
            for($f=0; $f -lt $feh.Count; $f++) {
                if($i -ne $f){
                    $feh2[$ctr++] = $feh[$f]
                }
            }
            ## check the new array to see if it is now safe
            for($i=1;$i -lt $feh2.Count;$i++){
                $first = [int]$feh2[$i]
                $second = [int]$feh2[$i-1]
                Write-Host $first - $second
                $derp = [Math]::abs(($feh2[$i]-$feh2[$i-1]))
                if(($derp -gt 3) -or ($derp -lt 1)){
                    $rangeOK2=$false
                    $i = $feh2.count
                }
        
                if ($first -gt $second){
                    $dec2 = $false
                }
                elseif ($first -lt $second){
                    $inc2 = $false
                }
                else { #numbers are the same
                    $inc2=$false
                    $dec2=$false
                    $i = $feh2.count
                }
            }
        }
        ##now what?
        if( (-not $inc2 -and -not $dec2 ) -or (-not $rangeOK2) ){
            $safe = $true
        }
    }
    else {
       $safe = $true
    }
    if($safe){
        $safe_count++
        Test-output-it "This is safe; safe lines: $safe_count" $hostorFile $output
    }
}

Test-output-it "--->safe:$safe_count" $hostorFile $output






function Test-IsSafe{
    param (
        [array]$TestArray
    )
    # need to do the testing logic here - this can be the original array or the shortened array
    if($doStuff){
        
    }
}