<#
The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.

In your expense report, what is the product of the three entries that sum to 2020?

Your puzzle answer was 42140160.
#>
$InputData = import-csv .\input.txt -Header "Data" | Select-Object @{Name="Data";Expression={[int]$_.Data}}
$InputData = $InputData | Sort-Object -Property "Data"

$sum = 0
$result = 0

for($i = 0; $i -lt $InputData.Length; $i++){
    for($j = 0; $j -lt $InputData.Length; $j++) {
        if($j -eq $i) {
            continue
        }
        for($k = 0; $k -lt $InputData.Length; $k++){
            if($k -eq $j) {
                continue
            }
            $sum = $InputData[$i].Data + $InputData[$j].Data + $InputData[$k].Data
            if($sum -eq 2020) {
                $result = $InputData[$i].Data * $InputData[$j].Data * $InputData[$k].Data
                break
            }
            if($sum -gt 2020) {
                break
            }
        }
        if($result -gt 0) {
            break
        }
        if($sum -gt 2020) {
            if($InputData[$i].Data + $InputData[$j].Data -gt 2020){
                break
            }
        }
    }
    if($result -gt 0) {
        break
    }
}
Write-Output $result