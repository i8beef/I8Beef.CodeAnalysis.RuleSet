param($installPath, $toolsPath, $package, $project)

function RemovePropertyGroups($projectRootElement) {
    # If there are any PropertyGroups with a label of "I8Beef.CodeAnalysis.RuleSet" they will be removed
    $propertyGroupsToRemove = @()
    
    foreach($propertyGroup in $projectRootElement.PropertyGroups) {
        if($propertyGroup.Label -and [string]::Compare("I8Beef.CodeAnalysis.RuleSet", $propertyGroup.Label, $true) -eq 0) {
            # Remove this property group
            $propertyGroupsToRemove += $propertyGroup
        }
    }

    foreach ($propertyGroup in $propertyGroupsToRemove) {
        $propertyGroup.Parent.RemoveChild($propertyGroup)
    }
}

function RemoveItems($projectRootElement) {
    # If there are any Items with a label of "I8Beef.CodeAnalysis.RuleSet" they will be removed
    $itemsToRemove = @()
    
    foreach($item in $projectRootElement.Items) {
        if($item.Label -and [string]::Compare("I8Beef.CodeAnalysis.RuleSet", $item.Label, $true) -eq 0) {
            # Remove this property group
            $itemsToRemove += $item
        }
    }

    foreach ($item in $itemsToRemove) {
        $item.Parent.RemoveChild($item)
    }
}

###################################
#       Before Uninstalling       #
###################################

Write-Host ("Uninstalling I8Beef.CodeAnalysis.RuleSet from project " + $project.FullName)
$project.Save()
$projectRootElement = [Microsoft.Build.Construction.ProjectRootElement]::Open($project.FullName)

###################################
#     Code Analysis & Signing     #
###################################

Write-Host "Removing configuration of Code Analysis"
RemovePropertyGroups -projectRootElement $projectRootElement
RemoveItems -projectRootElement $projectRootElement

###################################
#       After Uninstalling        #
###################################

$projectRootElement.Save()
Write-Host "Uninstalled I8Beef.CodeAnalysis.RuleSet"