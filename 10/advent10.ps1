<#
--- Part Two ---
Ding! The "fasten seat belt" signs have turned on. Time to find your seat.

It's a completely full flight, so your seat should be the only missing boarding pass in your list. However, there's a catch: some of the seats at the very front and back of the plane don't exist on this aircraft, so they'll be missing from your list as well.

Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.

What is the ID of your seat?
#>
$InputData = get-content .\input.txt
$flightIds = @()

foreach($pass in $InputData) {
    $pass = $pass -replace 'F', '0' -replace 'B', '1' -replace 'L', '0' -replace 'R', '1'

    $rowData = $pass.Substring(0,7)
    $columnData = $pass.Substring(7,3)

    $rowNumber = [Convert]::ToInt32($rowData,2)
    $columnNumber = [Convert]::ToInt32($columnData,2)

    $id = 8 * $rowNumber + $columnNumber
    $flightIds += $id        
}

$flightIds = $flightIds | sort-object

for($i = 0; $i -lt $flightIds.Length; $i++) {
    if($flightIds[$i] + 2 -eq $flightIds[$i + 1]) {
        Write-Output ($flightIds[$i] + 1)
    }
}