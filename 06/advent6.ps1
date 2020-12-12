<#
--- Part Two ---
Time to check the rest of the slopes - you need to minimize the probability of a sudden arboreal stop, after all.

Determine the number of trees you would encounter if, for each of the following slopes, you start at the top-left corner and traverse the map all the way to the bottom:

Right 1, down 1.
Right 3, down 1. (This is the slope you already checked.)
Right 5, down 1.
Right 7, down 1.
Right 1, down 2.
In the above example, these slopes would find 2, 7, 3, 4, and 2 tree(s) respectively; multiplied together, these produce the answer 336.

What do you get if you multiply together the number of trees encountered on each of the listed slopes?
#>
$InputData = import-csv .\input.txt -Header "Data" | Select-Object @{Name="Data";Expression={[string]$_.Data}}
$treeCharacter = '#'
function MoveTaboggan([ref]$Position, [ref]$Slope, $Map, [ref]$treesHit) {
    $Position.Value.x += $Slope.Value.x
    $Position.Value.y += $Slope.Value.y
    $Position.Value.x = $Position.Value.x % $Map[$Position.Value.y].Data.Length #Wrap due to "arboreal genetics XD"
    if($Map[$Position.Value.y].Data[$Position.Value.x] -eq $treeCharacter) {
        $treesHit.Value++
    }
}
function CalculateTreeHitsForSlope([int]$x, [int]$y){
    $Slope = @{x=$x;y=$y}
    $Position = @{x=0;y=0}
    $treesHit = 0
    while($Position.y -lt $InputData.Length - 1) {
        MoveTaboggan -Position ([ref]$Position) -Slope ([ref]$Slope) -Map ($InputData) -treesHit ([ref]$treesHit)
    }
    return $treesHit
}
Write-Output ((CalculateTreeHitsForSlope -x 1 -y 1) * (CalculateTreeHitsForSlope -x 5 -y 1) * (CalculateTreeHitsForSlope -x 3 -y 1) * (CalculateTreeHitsForSlope -x 7 -y 1) * (CalculateTreeHitsForSlope -x 1 -y 2))