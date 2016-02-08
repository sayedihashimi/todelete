[cmdletbinding()]
param()

$templateInfo = New-Object -TypeName psobject -Property @{
    Name = 'sample2'
    Type = 'ProjectTemplate'
}

Add-Replacement $templateInfo 'WebApplication1' {$ProjectName} {$DefaultProjectName}
Add-Replacement $templateInfo 'SolutionDir' {$SolutionDir} {'..\..\'}
Add-Replacement $templateInfo '..\..\artifacts' {$ArtifactsDir} {$SolutionDir + 'artifacts'}
Add-Replacement $templateInfo 'C348D13D-1D07-4EEB-B025-889D7AF6391B' {$ProjectId} {[System.Guid]::NewGuid()}

# when the template is run any filename with the given string will be updated
Update-FileName $templateInfo 'WebApplication1' {$ProjectName}
# excludes files from the template
Exclude-File $templateInfo 'pw-*.*','*.user','*.suo','*.userosscache','project.lock.json','*.vs*scc'
# excludes folders from the template
Exclude-Folder $templateInfo '.vs','artifacts'

# This will register the template with pecan-waffle
Set-TemplateInfo -templateInfo $templateInfo
