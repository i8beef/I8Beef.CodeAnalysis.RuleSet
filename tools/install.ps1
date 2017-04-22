param($installPath, $toolsPath, $package, $project)

###################################
#        Before Installing        #
###################################

Write-Host ("Installing I8Beef.CodeAnalysis.RuleSet to project " + $project.FullName)
$project.Save()
$projectRootElement = [Microsoft.Build.Construction.ProjectRootElement]::Open($project.FullName)

###################################
#          Code Analysis          #
###################################

## Enable code analysis on build and add ruleset
# This is what we want to add to the project
 #  <PropertyGroup Label="I8Beef.CodeAnalysis.RuleSet">
#    <RunCodeAnalysis>true</RunCodeAnalysis>
#    <CodeAnalysisRuleSet>$(SolutionDir)packages/I8Beef.CodeAnalysis.RuleSet.1.0.0/tools/I8Beef.CodeAnalysis.RuleSet.ruleset</CodeAnalysisRuleSet>
#  </PropertyGroup>
Write-Host "Configuring Code Analysis"
$propertyGroup = $projectRootElement.AddPropertyGroup()
$propertyGroup.Label = "I8Beef.CodeAnalysis.RuleSet"
$propertyGroup.AddProperty('RunCodeAnalysis', 'true')
$propertyGroup.AddProperty('CodeAnalysisRuleSet', '$(SolutionDir)packages/I8Beef.CodeAnalysis.RuleSet.' + $package.Version + '/tools/I8Beef.CodeAnalysis.RuleSet.ruleset')

# Add stylecop.json link
Write-Host "Adding stylecop.json link"
$stylecopJsonItem = $projectRootElement.AddItem('AdditionalFiles', '$(SolutionDir)packages/I8Beef.CodeAnalysis.RuleSet.' + $package.Version + '/tools/stylecop.json')
$stylecopJsonItem.Label = 'I8Beef.CodeAnalysis.RuleSet'
$stylecopJsonItem.AddMetadata('Link', 'stylecop.json')

###################################
#        After Installing         #
###################################

$projectRootElement.Save()
Write-Host "Installed I8Beef.CodeAnalysis.RuleSet"