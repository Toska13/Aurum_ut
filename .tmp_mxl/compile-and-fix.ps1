# ASCII-only: compile MXL JSON then post-process named areas / connectors
$ErrorActionPreference = "Stop"
$root = "c:\repo\Aurum.ut"
$jsonPath = Join-Path $root ".tmp_mxl\maket-monitora.json"
$tmpXml = Join-Path $root ".tmp_mxl\Template.mxlx"
$compile = Join-Path $root ".cursor\skills\1c-metadata-manage\tools\1c-mxl-compile\scripts\mxl-compile.ps1"
$validate = Join-Path $root ".cursor\skills\1c-metadata-manage\tools\1c-mxl-validate\scripts\mxl-validate.ps1"
$info = Join-Path $root ".cursor\skills\1c-metadata-manage\tools\1c-mxl-info\scripts\mxl-info.ps1"
$py = Join-Path $root ".tmp_mxl\postprocess_mxl.py"

& powershell.exe -NoProfile -File $compile -JsonPath $jsonPath -OutputPath $tmpXml
if ($LASTEXITCODE -ne 0) { throw "mxl-compile failed: $LASTEXITCODE" }

& python.exe $py $jsonPath $tmpXml
if ($LASTEXITCODE -ne 0) { throw "postprocess failed: $LASTEXITCODE" }

& powershell.exe -NoProfile -File $validate -TemplatePath $tmpXml -Detailed
Write-Host "VALIDATE_EXIT=$LASTEXITCODE"
& powershell.exe -NoProfile -File $info -TemplatePath $tmpXml -MaxParams 20 -Limit 300
