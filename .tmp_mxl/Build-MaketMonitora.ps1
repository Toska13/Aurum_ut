# Build МакетМонитора JSON, compile, post-process rectangles + connector pictures
$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$root = "c:\repo\Aurum.ut"
$jsonPath = Join-Path $root ".tmp_mxl\maket-monitora.json"
$outPath = Join-Path $root "ut\src\Reports\АУ_КонтрольЗаказовКлиентов\Templates\МакетМонитора\Template.mxlx"
$compile = Join-Path $root ".cursor\skills\1c-metadata-manage\tools\1c-mxl-compile\scripts\mxl-compile.ps1"
$validate = Join-Path $root ".cursor\skills\1c-metadata-manage\tools\1c-mxl-validate\scripts\mxl-validate.ps1"
$info = Join-Path $root ".cursor\skills\1c-metadata-manage\tools\1c-mxl-info\scripts\mxl-info.ps1"

function New-CellsFromHeaders([string[]]$headers) {
	$cells = @()
	$col = 1
	foreach ($h in $headers) {
		$cells += @{ col = $col; style = "hdr"; text = $h }
		$col++
	}
	return $cells
}

function Style-ForParam([string]$p) {
	$money = @("СуммаЗаказано","СуммаПришло","Заявлено","ОплаченоПоставщику","СуммаСебестоимости","Прибыль")
	$qty = @("Заказано","Отгружено","ОтгруженоСкладом","ЗаказаноПоставщику","Приобретено","ПринятоСкладом","ОсталосьЗаказать","ВСборке","Собрано","ОсталосьСобрать","Принято","Остаток")
	if ($money -contains $p) { return "rowNum" }
	if ($qty -contains $p) { return "rowQty" }
	if ($p -eq "ДатаРасчета") { return "rowDate" }
	return "rowText"
}

function New-CellsFromParams([string[]]$params) {
	$cells = @()
	$col = 1
	foreach ($p in $params) {
		$cells += @{ col = $col; style = (Style-ForParam $p); param = $p }
		$col++
	}
	return $cells
}

function Add-Pair([System.Collections.Generic.List[object]]$areas, [string]$prefix, [string[]]$headers, [string[]]$params) {
	$areas.Add([ordered]@{
		name = "${prefix}_Шапка"
		rows = @(@{ cells = @(New-CellsFromHeaders $headers) })
	})
	$areas.Add([ordered]@{
		name = "${prefix}_Строка"
		rows = @(@{ cells = @(New-CellsFromParams $params) })
	})
}

$areas = New-Object System.Collections.Generic.List[object]

$areas.Add([ordered]@{
	name = "Отчет_Шапка"
	rows = @(@{
		height = 80
		cells = @(
			@{ col = 1; style = "title"; param = "ЗаголовокЗаказа" },
			@{ col = 2; style = "rowDate"; param = "ДатаРасчета" }
		)
	})
})

$hU1 = @(
	"Представление","Сумма заказано","Сумма пришло","Заявлено","Оплачено поставщ.","Себестоимость","Прибыль",
	"Кол-во заказано","Отгружено","Отгружено складом","Заказано поставщ.","Приобретено","Принято складом",
	"Осталось заказать","В сборке","Собрано","Осталось собрать"
)
$pU1 = @(
	"Представление","СуммаЗаказано","СуммаПришло","Заявлено","ОплаченоПоставщику","СуммаСебестоимости","Прибыль",
	"Заказано","Отгружено","ОтгруженоСкладом","ЗаказаноПоставщику","Приобретено","ПринятоСкладом",
	"ОсталосьЗаказать","ВСборке","Собрано","ОсталосьСобрать"
)
Add-Pair $areas "Ур1" $hU1 $pU1

$hU2Z = @(
	"Представление","Сумма заказано","Сумма пришло","Заявлено","Оплачено поставщ.","Прибыль",
	"Кол-во заказано","Отгружено","Отгружено складом","Заказано поставщ.","Приобретено","Принято складом",
	"Осталось заказать","В сборке","Собрано","Осталось собрать"
)
$pU2Z = @(
	"Представление","СуммаЗаказано","СуммаПришло","Заявлено","ОплаченоПоставщику","Прибыль",
	"Заказано","Отгружено","ОтгруженоСкладом","ЗаказаноПоставщику","Приобретено","ПринятоСкладом",
	"ОсталосьЗаказать","ВСборке","Собрано","ОсталосьСобрать"
)
Add-Pair $areas "Ур2З" $hU2Z $pU2Z
Add-Pair $areas "Ур2С" $hU2Z $pU2Z

$hU2Sk = @(
	"Представление","Сумма заказано","Сумма пришло","Себестоимость","Прибыль",
	"Кол-во заказано","Отгружено","Отгружено складом","Заказано поставщ.","Приобретено","Принято складом",
	"Осталось заказать","В сборке","Собрано","Осталось собрать"
)
$pU2Sk = @(
	"Представление","СуммаЗаказано","СуммаПришло","СуммаСебестоимости","Прибыль",
	"Заказано","Отгружено","ОтгруженоСкладом","ЗаказаноПоставщику","Приобретено","ПринятоСкладом",
	"ОсталосьЗаказать","ВСборке","Собрано","ОсталосьСобрать"
)
Add-Pair $areas "Ур2Ск" $hU2Sk $pU2Sk

Add-Pair $areas "Ур3О" @("Представление","Сумма пришло") @("Представление","СуммаПришло")
Add-Pair $areas "Ур3П" @("Представление") @("Представление")
Add-Pair $areas "Ур3Т_ЗнС" @("Представление","В сборке") @("Представление","ВСборке")
Add-Pair $areas "Ур3Т_ЗП" @("Представление","Контрагент","Договор","Заказано поставщику") @("Представление","Контрагент","Договор","ЗаказаноПоставщику")
Add-Pair $areas "Ур3Т_РТУ" @("Представление","Отгружено") @("Представление","Отгружено")
Add-Pair $areas "Ур4Т_ПТУ" @("Представление","Контрагент","Договор","Приобретено") @("Представление","Контрагент","Договор","Приобретено")
Add-Pair $areas "Ур4Т_ЗП" @("Представление","Контрагент","Договор","Заказано поставщику") @("Представление","Контрагент","Договор","ЗаказаноПоставщику")
Add-Pair $areas "Ур4П" @("Представление","Контрагент","Договор","Заявлено") @("Представление","Контрагент","Договор","Заявлено")
Add-Pair $areas "Ур4С" @("Представление","Сумма себестоимости") @("Представление","СуммаСебестоимости")
Add-Pair $areas "Ур5Т_ПТУ" @("Представление","Контрагент","Договор","Приобретено") @("Представление","Контрагент","Договор","Приобретено")
Add-Pair $areas "Ур5П" @("Представление","Контрагент","Договор","Оплачено поставщику") @("Представление","Контрагент","Договор","ОплаченоПоставщику")
Add-Pair $areas "Ур6Т_ПО" @("Представление","Принято складом") @("Представление","ПринятоСкладом")
Add-Pair $areas "Ур7ШК" @("Представление","Принято","Остаток") @("Представление","Принято","Остаток")
Add-Pair $areas "Ур7Т_Сборка" @("Представление","Собрано") @("Представление","Собрано")
Add-Pair $areas "Ур8Т_РТУ" @("Представление","Отгружено") @("Представление","Отгружено")
Add-Pair $areas "Ур9Т_РО" @("Представление","Отгружено складом") @("Представление","ОтгруженоСкладом")
Add-Pair $areas "Ур10ШК" @("Представление","Отгружено","Остаток") @("Представление","Отгружено","Остаток")

foreach ($cn in @("КоннекторВерхПравоНиз","КоннекторВерхПраво","КоннекторВерхНиз","Отступ")) {
	$areas.Add([ordered]@{
		name = $cn
		connector = $true
		rows = @(@{ height = 60; cells = @(@{ col = 1; style = "conn" }) })
	})
}

$def = [ordered]@{
	columns = 17
	defaultWidth = 88
	columnWidths = [ordered]@{ "1" = 280; "2-17" = 88 }
	fonts = [ordered]@{
		default = @{ face = "Arial"; size = 8 }
		bold    = @{ face = "Arial"; size = 8; bold = $true }
		title   = @{ face = "Arial"; size = 10; bold = $true }
	}
	styles = [ordered]@{
		title   = @{ font = "title"; align = "left"; wrap = $true }
		hdr     = @{ font = "bold"; align = "center"; valign = "center"; border = "all"; wrap = $true }
		rowText = @{ font = "default"; align = "left"; border = "all"; wrap = $true }
		rowNum  = @{ font = "default"; align = "right"; border = "all"; format = "ЧДЦ=2; ЧН=0,00" }
		rowQty  = @{ font = "default"; align = "right"; border = "all"; format = "ЧДЦ=3; ЧН=0,000" }
		rowDate = @{ font = "default"; align = "left"; border = "all"; format = "ДФ=dd.MM.yyyy HH:mm" }
		conn    = @{ font = "default"; align = "center" }
	}
	areas = $areas
}

$json = $def | ConvertTo-Json -Depth 12 -Compress:$false
New-Item -ItemType Directory -Force -Path (Split-Path $jsonPath) | Out-Null
[System.IO.File]::WriteAllText($jsonPath, $json, (New-Object System.Text.UTF8Encoding $true))
Write-Host "[OK] JSON: $jsonPath"

New-Item -ItemType Directory -Force -Path (Split-Path $outPath) | Out-Null
& powershell.exe -NoProfile -File $compile -JsonPath $jsonPath -OutputPath $outPath
if ($LASTEXITCODE -ne 0) { throw "mxl-compile failed: $LASTEXITCODE" }

# Post-process: Rectangle named items + connector column set + v8ui pictures
[xml]$doc = Get-Content -Path $outPath -Encoding UTF8
$ns = New-Object System.Xml.XmlNamespaceManager($doc.NameTable)
$ns.AddNamespace("d", "http://v8.1c.ru/8.2/data/spreadsheet")
$root = $doc.DocumentElement

function New-El([string]$name) {
	return $doc.CreateElement($name, "http://v8.1c.ru/8.2/data/spreadsheet")
}

# Map area name -> (beginRow, endRow, maxCol 0-based)
$areaCols = @{}
foreach ($area in $def.areas) {
	$maxCol = 0
	foreach ($row in $area.rows) {
		foreach ($cell in $row.cells) {
			$end = [int]$cell.col - 1
			if ($end -gt $maxCol) { $maxCol = $end }
		}
	}
	$areaCols[$area.name] = $maxCol
}

foreach ($ni in $root.SelectNodes("d:namedItem", $ns)) {
	$name = $ni.SelectSingleNode("d:name", $ns).InnerText
	$area = $ni.SelectSingleNode("d:area", $ns)
	$typeNode = $area.SelectSingleNode("d:type", $ns)
	$typeNode.InnerText = "Rectangle"
	$bc = $area.SelectSingleNode("d:beginColumn", $ns)
	$ec = $area.SelectSingleNode("d:endColumn", $ns)
	$bc.InnerText = "0"
	if ($areaCols.ContainsKey($name)) {
		$ec.InnerText = [string]$areaCols[$name]
	} else {
		$ec.InnerText = "0"
	}
}

# Additional 1-col set for connectors
$colSetId = [guid]::NewGuid().ToString()
$connCols = New-El "columns"
$idEl = New-El "id"; $idEl.InnerText = $colSetId; [void]$connCols.AppendChild($idEl)
$sizeEl = New-El "size"; $sizeEl.InnerText = "1"; [void]$connCols.AppendChild($sizeEl)
$ci = New-El "columnsItem"
$idx = New-El "index"; $idx.InnerText = "0"; [void]$ci.AppendChild($idx)
$col = New-El "column"
$fi = New-El "formatIndex"
# reuse last format or 1 — add dedicated width format
$fi.InnerText = "1"
[void]$col.AppendChild($fi)
[void]$ci.AppendChild($col)
[void]$connCols.AppendChild($ci)

$firstCols = $root.SelectSingleNode("d:columns", $ns)
[void]$root.InsertAfter($connCols, $firstCols)

# Add width-24 format for connector column
$fmtConn = New-El "format"
$w = New-El "width"; $w.InnerText = "24"; [void]$fmtConn.AppendChild($w)
$formats = $root.SelectNodes("d:format", $ns)
$lastFmt = $formats[$formats.Count - 1]
[void]$root.InsertAfter($fmtConn, $lastFmt)
$connFmtIndex = $formats.Count + 1
$fi.InnerText = [string]$connFmtIndex

$connNames = @("КоннекторВерхПравоНиз","КоннекторВерхПраво","КоннекторВерхНиз","Отступ")
$namedByName = @{}
foreach ($ni in $root.SelectNodes("d:namedItem", $ns)) {
	$n = $ni.SelectSingleNode("d:name", $ns).InnerText
	$namedByName[$n] = $ni
}

foreach ($cn in $connNames) {
	$ni = $namedByName[$cn]
	$br = [int]$ni.SelectSingleNode("d:area/d:beginRow", $ns).InnerText
	$rowItem = $null
	foreach ($ri in $root.SelectNodes("d:rowsItem", $ns)) {
		if ([int]$ri.SelectSingleNode("d:index", $ns).InnerText -eq $br) {
			$rowItem = $ri
			break
		}
	}
	if ($rowItem) {
		$row = $rowItem.SelectSingleNode("d:row", $ns)
		$cid = New-El "columnsID"
		$cid.InnerText = $colSetId
		[void]$row.InsertBefore($cid, $row.FirstChild)
	}
}

# Pictures + drawings for the three line connectors (Отступ has no picture)
$pics = @(
	"v8ui:КоннекторВерхПравоНиз",
	"v8ui:КоннекторВерхПраво",
	"v8ui:КоннекторВерхНиз"
)
$pIdx = 0
foreach ($ref in $pics) {
	$pic = New-El "picture"
	$ix = New-El "index"; $ix.InnerText = [string]$pIdx; [void]$pic.AppendChild($ix)
	$inner = $doc.CreateElement("picture", "http://v8.1c.ru/8.2/data/spreadsheet")
	$inner.SetAttribute("t", "false")
	$inner.SetAttribute("ref", $ref)
	[void]$pic.AppendChild($inner)
	[void]$root.AppendChild($pic)
	$pIdx++
}

$drawFmt = New-El "format"
$db = New-El "drawingBorder"; $db.InnerText = "1"; [void]$drawFmt.AppendChild($db)
$hl = New-El "hyperLink"; $hl.InnerText = "false"; [void]$drawFmt.AppendChild($hl)
[void]$root.AppendChild($drawFmt)
$drawFmtIndex = ($root.SelectNodes("d:format", $ns)).Count

$drawId = 1
$pictureIndex = 1
foreach ($cn in @("КоннекторВерхПравоНиз","КоннекторВерхПраво","КоннекторВерхНиз")) {
	$ni = $namedByName[$cn]
	$br = [int]$ni.SelectSingleNode("d:area/d:beginRow", $ns).InnerText
	$dr = New-El "drawing"
	$dt = New-El "drawingType"; $dt.InnerText = "Picture"; [void]$dr.AppendChild($dt)
	$id = New-El "id"; $id.InnerText = [string]$drawId; [void]$dr.AppendChild($id)
	$df = New-El "formatIndex"; $df.InnerText = [string]$drawFmtIndex; [void]$dr.AppendChild($df)
	$x = New-El "beginRow"; $x.InnerText = [string]$br; [void]$dr.AppendChild($x)
	$x = New-El "beginRowOffset"; $x.InnerText = "0"; [void]$dr.AppendChild($x)
	$x = New-El "endRow"; $x.InnerText = [string]$br; [void]$dr.AppendChild($x)
	$x = New-El "endRowOffset"; $x.InnerText = "57"; [void]$dr.AppendChild($x)
	$x = New-El "beginColumn"; $x.InnerText = "0"; [void]$dr.AppendChild($x)
	$x = New-El "beginColumnOffset"; $x.InnerText = "0"; [void]$dr.AppendChild($x)
	$x = New-El "endColumn"; $x.InnerText = "0"; [void]$dr.AppendChild($x)
	$x = New-El "endColumnOffset"; $x.InnerText = "57"; [void]$dr.AppendChild($x)
	$x = New-El "autoSize"; $x.InnerText = "false"; [void]$dr.AppendChild($x)
	$x = New-El "pictureSize"; $x.InnerText = "Proportionally"; [void]$dr.AppendChild($x)
	$x = New-El "zOrder"; $x.InnerText = [string]$drawId; [void]$dr.AppendChild($x)
	$x = New-El "pictureIndex"; $x.InnerText = [string]$pictureIndex; [void]$dr.AppendChild($x)
	# insert drawings before namedItem
	$firstNamed = $root.SelectSingleNode("d:namedItem", $ns)
	[void]$root.InsertBefore($dr, $firstNamed)
	$drawId++
	$pictureIndex++
}

$settings = New-Object System.Xml.XmlWriterSettings
$settings.Indent = $true
$settings.IndentChars = "`t"
$settings.Encoding = New-Object System.Text.UTF8Encoding $true
$settings.OmitXmlDeclaration = $false
$writer = [System.Xml.XmlWriter]::Create($outPath, $settings)
$doc.Save($writer)
$writer.Close()
Write-Host "[OK] Post-processed: $outPath"

& powershell.exe -NoProfile -File $validate -TemplatePath $outPath -Detailed
Write-Host "validate exit=$LASTEXITCODE"
& powershell.exe -NoProfile -File $info -TemplatePath $outPath -MaxParams 20 -Limit 250
