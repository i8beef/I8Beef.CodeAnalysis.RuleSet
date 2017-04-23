# I8Beef.CodeAnalysis.RuleSet
Personal Code Analysis Analyzers

# Usage
Make sure the project in question has a nuget.config in the main solution directory that matches the following:

```
<?xml version="1.0" encoding="utf-8"?> <configuration> <packageSources>  <add key="MyGet I8Beef" value="https://www.myget.org/F/i8beef/api/v2" /> </packageSources> </configuration>
```

Install the package I8Beef.CodeAnalysis.RuleSet to each project in the target solution.