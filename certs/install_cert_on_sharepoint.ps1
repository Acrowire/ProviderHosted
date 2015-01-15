$publicCertPath = "E:\Certs\acroDomainCert.cer"
$certificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificates.X509Certificate2($publicCertPath)

New-SPTrustedRootAuthority -Name "HighTrustSampleCert" -Certificate $certificate

$realm = Get-SPAuthenticationRealm
$specificIssuerId = "11111111-1111-1111-1111-111111111111"
$fullIssuerIdentifier = $specificIssuerId + '@' + $realm

New-SPTrustedSecurityTokenIssuer -Name "acrowire domain cert" -Certificate $certificate -RegisteredIssuerName $fullIssuerIdentifier -IsTrustBroker
iisreset 

$serviceConfig = Get-SPSecurityTokenServiceConfig 
$serviceConfig.AllowOAuthOverHttp = $true
$serviceConfig.Update()