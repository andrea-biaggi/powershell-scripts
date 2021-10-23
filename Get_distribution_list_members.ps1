$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
$Groups = Get-DistributionGroup
$Groups | ForEach-Object {
$group = $_.Name
$members = ''
Get-DistributionGroupMember -Credential $UserCredential -Identity $group | ForEach-Object {
        If($members) {
              $members=$members + ";" + $_.Name
           } Else {
              $members=$_.Name
           }
  }
New-Object -TypeName PSObject -Property @{
      GroupName = $group
      Members = $members
     }
} | Export-CSV "C:\Distribution-Group-Members.csv" -NoTypeInformation -Encoding UTF8
Remove-PSSession $Session
