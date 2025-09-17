mkdir S:\EFI\OEM
xcopy /e /h /y S:\EFI\Microsoft\* S:\EFI\OEM\
del /a S:\EFI\OEM\Boot\BCD
bcdedit /createstore S:\BCD
bcdedit /store S:\BCD /create {bootmgr} /d "Windows Boot Manager"
bcdedit /store S:\BCD /set {bootmgr} device partition=S:
bcdedit /store S:\BCD /set {bootmgr} locale pt-br
bcdedit /store S:\BCD /set {bootmgr} integrityservices Enable

bcdedit /store S:\BCD /create {11111111-1111-1111-1111-111111111111} /d "Windows Recovery" /device
bcdedit /store S:\BCD /set {11111111-1111-1111-1111-111111111111} ramdisksdidevice partition=R:
bcdedit /store S:\BCD /set {11111111-1111-1111-1111-111111111111} ramdisksdipath \Recovery\WindowsRE\boot.sdi

bcdedit /store S:\BCD /create {22222222-2222-2222-2222-222222222222} /d "Windows Recovery Environment" /application osloader
bcdedit /store S:\BCD /set {bootmgr} default {22222222-2222-2222-2222-222222222222}
bcdedit /store S:\BCD /set {bootmgr} displayorder {22222222-2222-2222-2222-222222222222}

bcdedit /store S:\BCD /set {default} device ramdisk=[R:]\Recovery\WindowsRE\winre.wim,{11111111-1111-1111-1111-111111111111}
bcdedit /store S:\BCD /set {default} path \Windows\System32\winload.efi
bcdedit /store S:\BCD /set {default} locale pt-br
bcdedit /store S:\BCD /set {default} displaymessage "Recovery"
bcdedit /store S:\BCD /set {default} osdevice ramdisk=[R:]\Recovery\WindowsRE\winre.wim,{11111111-1111-1111-1111-111111111111}
bcdedit /store S:\BCD /set {default} systemroot \Windows
bcdedit /store S:\BCD /set {default} nx OptIn
bcdedit /store S:\BCD /set {default} bootmenupolicy Standard
bcdedit /store S:\BCD /set {default} winpe Yes

xcopy /h /y S:\BCD* S:\EFI\oem\Boot\.
del /a S:\BCD*