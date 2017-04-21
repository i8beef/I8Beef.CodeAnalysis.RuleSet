param($installPath, $toolsPath, $package, $project)

function RemovePropertyGroups($projectRootElement) {
    # If there are any PropertyGroups with a label of "Ignition" they will be removed
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

###################################
#       After Uninstalling        #
###################################

Write-Host "Uninstalled I8Beef.CodeAnalysis.RuleSet"