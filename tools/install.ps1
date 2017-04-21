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

## Set 'Build Action' to 'CodeAnalysisDictionary' on custom dictionary
Write-Host "Configuring build action on CustomDictionary.xml"
$item = $project.ProjectItems.Item("CustomDictionary.xml")
$item.Properties.Item("BuildAction").Value = "CodeAnalysisDictionary"

$item = $project.ProjectItems.Item("stylecop.json")
$item.Properties.Item("BuildAction").Value = "AdditionalFiles"

## Enable code analysis on build and add ruleset
# This is what we want to add to the project
 #  <PropertyGroup Label="I8Beef.CodeAnalysis.RuleSet">
#    <RunCodeAnalysis>true</RunCodeAnalysis>
#    <CodeAnalysisRuleSet>I8Beef.CodeAnalysis.RuleSet.ruleset</CodeAnalysisRuleSet>
#  </PropertyGroup>

Write-Host "Configuring Code Analysis"
$propertyGroup = $projectRootElement.AddPropertyGroup()
$propertyGroup.Label = "I8Beef.CodeAnalysis.RuleSet"
$propertyGroup.AddProperty('RunCodeAnalysis', 'true')
$propertyGroup.AddProperty('CodeAnalysisRuleSet', 'I8Beef.CodeAnalysis.RuleSet.ruleset')

###################################
#        After Installing         #
###################################

$projectRootElement.Save()
Write-Host "Installed I8Beef.CodeAnalysis.RuleSet"