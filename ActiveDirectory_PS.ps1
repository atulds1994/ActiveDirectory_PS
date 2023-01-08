# MODIFY THESE VARIABLES AS PER YOUR NEED

$USER_LIST = Get-Content .\names.txt
$USER_PASSWORD = "Changeme007"
$password = ConvertTo-SecureString $USER_PASSWORD -AsPlainText -Force
New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false

foreach ($users in $USER_LIST)
{
   $first = $users.Split(" ")[0].ToLower()
   $last = $users.Split(" ")[1].ToLower()
   $username = "$($first.Substring(0,1))$($last)".ToLower()
   Write-Host "User Created: $($username)" -BackgroundColor White -ForegroundColor Red
  
   New-ADUser -AccountPassword $password `
              -GivenName $first `
              -SurName $last `
              -DisplayName $username `
              -Name $username `
              -EmployeeID $username `
              -PasswordNeverExpires $true `
              -Path "ou=_USERS,$(([ADSI]`"").distinguishedName)" `
              -Enabled $true
}