## Signs a file
param([string] $file=$(throw "Please specify a filename."))
$cert = @(Get-ChildItem cert:\CurrentUser\My -codesigning)[0]
Set-AuthenticodeSignature $file $cert
# SIG # Begin signature block
# MIIFlAYJKoZIhvcNAQcCoIIFhTCCBYECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUcfqVa1GUaGDvMBRcKQrOyTzk
# Jt6gggMiMIIDHjCCAgagAwIBAgIQN3M70tg1lY9NwPFShbP+qzANBgkqhkiG9w0B
# AQsFADAnMSUwIwYDVQQDDBxQb3dlclNoZWxsIENvZGUgU2lnbmluZyBDZXJ0MB4X
# DTIzMDYwMjExMTUwNVoXDTI0MDYwMjExMzUwNVowJzElMCMGA1UEAwwcUG93ZXJT
# aGVsbCBDb2RlIFNpZ25pbmcgQ2VydDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBALvwXOiwp2moPGR1RIJWitZS4Zkp5DdiDfIszNUbwd9nED4TRN1MFVp0
# TcywqsapCZQRzrcR+YqWOoSJVqO6YtpCHzbZ9uV8WPMy7wl85kIljFQqm7eZoD9x
# PcZoiy7ZASFmRO8dSfHILA6gJsQEbqenuRXHI5R9bHEF6unh0/fQUum2iylCTFjL
# Gv0u4HQai/WOQTO+wzTELUa/b/4n6LAapVkQJh2RidC08GRgbLw0IO+9eQ/Eo2Dw
# 4U1WChyTmd0KhKyPTgyNjvhw+SrZj5NYz8/at3Lf5Pmij8882U1hP4sAb5kfTYsD
# n9S5r5gCWj22zBr/vBjFgqkVfkvxF7UCAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeA
# MBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBQgxlgaSC82xgTtrxpXNBr8
# uvtEbzANBgkqhkiG9w0BAQsFAAOCAQEASSDCsvbRdHQRFi8DYafehN5yEtvfaQa9
# escDGqldfL0nhpLlzJcEL+R667UK43b0VkKJ0XgWMJpzHnoF08nhpNyXjUaiaLsu
# qf5RUe4E06m9rMVHsHJUF5i2t1lE3BUwVoBFaY5+iX8gBIqi/g94wWslgvBa2nux
# dCrXGr5byt/Nv5N7BU6FAyPL8hq6m3Pd3RpK1pqjL7BA8jg38tbAakn3OnkBE5At
# J5iocKFg41XJPQOeNRmgEs/p0THUkyCi/bdzg7CuDzlGctHexjtwpIbo0k/8B+Us
# Cinkn5sDKpHgqvhzWnX37n+vCfpOdaEdXKIltczO7gVTZBBMG/N4lzGCAdwwggHY
# AgEBMDswJzElMCMGA1UEAwwcUG93ZXJTaGVsbCBDb2RlIFNpZ25pbmcgQ2VydAIQ
# N3M70tg1lY9NwPFShbP+qzAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAig
# AoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgEL
# MQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUg6Gejd/Vr6lC36eex24/
# 9KqK/hgwDQYJKoZIhvcNAQEBBQAEggEAMzFonlqYoBJPvzZ+Eo0D3AJh6vXgBEO/
# FQSmpy8I7Fd9YOidRkrQsjOQj8KMW+IXhnzV9LNJ2ooWCFDB1axkXHGQ5o1tQspR
# k3qCZE3w6dFyf4C5NYXpSwVX3xIboeCBuU7bIMoimuMI+Ts/Ng5WFU6aWZ256uiK
# v3OMaQZC+n6Aw1v9w+kowWLOWAYfwNOvolWdaS15p+ce9c7zsiS3EtbTVmcGpR7b
# Aew+9kHc9fvrzL7GeLpAKdwZu8zYOQarWPdVhYWL2Om+YRaNyp/npYQqqXsu5zVj
# ZOUZ2nfuxfyhJSemzPw9ueXric2jguHi0u66/Stdmcfzg2j0KM8Ubw==
# SIG # End signature block
