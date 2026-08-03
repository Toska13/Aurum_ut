#Requires -Version 5.1
# Batch B: regions + procedure formatting for ut.ДоработкиАурум Documents
# NO behavior change. Functions / #Вставка / #Удаление / &ИзменениеИКонтроль left intact.

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$Base = 'c:\repo\Aurum.ut\ut.ДоработкиАурум'
$Files = @(
'src/Documents/АвансовыйОтчет/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ВнутреннееПотребление/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ВнутреннееПотребление/ManagerModule.bsl',
'src/Documents/ВнутреннееПотребление/ObjectModule.bsl',
'src/Documents/ДоверенностьВыданная/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ДоверенностьВыданная/Forms/ФормаСписка/Module.bsl',
'src/Documents/ДоверенностьВыданная/Forms/ФормаСпискаДокументов/Module.bsl',
'src/Documents/ЗаказКлиента/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ЗаказКлиента/Forms/ФормаСписка/Module.bsl',
'src/Documents/ЗаказКлиента/Forms/ФормаСпискаДокументов/Module.bsl',
'src/Documents/ЗаказНаСборку/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ЗаказНаСборку/Forms/ФормаСписка/Module.bsl',
'src/Documents/ЗаказПоставщику/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ЗаказПоставщику/Forms/ФормаСпискаДокументов/Module.bsl',
'src/Documents/ЗаказПоставщику/ObjectModule.bsl',
'src/Documents/ЗаявкаНаРасходованиеДенежныхСредств/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ЗаявкаНаРасходованиеДенежныхСредств/Forms/ФормаСписка/Module.bsl',
'src/Documents/ЗаявкаНаРасходованиеДенежныхСредств/Forms/ФормаСпискаДокументов/Module.bsl',
'src/Documents/ЗаявкаНаРасходованиеДенежныхСредств/Forms/ФормаСпискаЗаявокКСогласованию/Module.bsl',
'src/Documents/ЗаявкаНаРасходованиеДенежныхСредств/ObjectModule.bsl',
'src/Documents/КорректировкаРегистров/Forms/ФормаСписка/Module.bsl',
'src/Documents/ОтборРазмещениеТоваров/ObjectModule.bsl',
'src/Documents/ПеремещениеТоваров/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ПеремещениеТоваров/ObjectModule.bsl',
'src/Documents/ПоручениеЭкспедитору/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ПоручениеЭкспедитору/Forms/ФормаСписка/Module.bsl',
'src/Documents/ПоручениеЭкспедитору/ManagerModule.bsl',
'src/Documents/ПоручениеЭкспедитору/ObjectModule.bsl',
'src/Documents/ПоступлениеБезналичныхДенежныхСредств/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ПоступлениеБезналичныхДенежныхСредств/ObjectModule.bsl',
'src/Documents/ПриобретениеТоваровУслуг/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ПриобретениеТоваровУслуг/ManagerModule.bsl',
'src/Documents/ПриходныйКассовыйОрдер/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ПриходныйКассовыйОрдер/ObjectModule.bsl',
'src/Documents/ПриходныйОрдерНаТовары/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ПрочееОприходованиеТоваров/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ПрочееОприходованиеТоваров/ObjectModule.bsl',
'src/Documents/РасходныйКассовыйОрдер/Forms/ФормаДокумента/Module.bsl',
'src/Documents/РасходныйКассовыйОрдер/ObjectModule.bsl',
'src/Documents/РасходныйОрдерНаТовары/Forms/ФормаДокумента/Module.bsl',
'src/Documents/РасходныйОрдерНаТовары/ManagerModule.bsl',
'src/Documents/РасходныйОрдерНаТовары/ObjectModule.bsl',
'src/Documents/СборкаТоваров/Forms/ФормаДокумента/Module.bsl',
'src/Documents/СписаниеБезналичныхДенежныхСредств/Forms/ФормаДокумента/Module.bsl',
'src/Documents/СписаниеБезналичныхДенежныхСредств/ObjectModule.bsl',
'src/Documents/СчетНаОплатуКлиенту/ObjectModule.bsl',
'src/Documents/СчетФактураВыданный/Forms/ФормаДокумента/Module.bsl',
'src/Documents/СчетФактураПолученный/ObjectModule.bsl',
'src/Documents/ТранспортнаяНакладная/Forms/ФормаДокумента/Module.bsl',
'src/Documents/ТранспортнаяНакладная/Forms/ФормаСписка/Module.bsl'
)

$FormEvents = @(
'ПриСозданииНаСервере','ПриЧтенииНаСервере','ПриЗаписиНаСервере','ПередЗаписьюНаСервере','ПослеЗаписиНаСервере',
'ОбработкаПроверкиЗаполненияНаСервере','ПриОткрытии','ПриЗакрытии','ПередЗакрытием','ПриПовторномОткрытии',
'ОбработкаОповещения','ОбработкаВыбора','ОбработкаАктивизации','ОбработкаЗаписиНового','ВнешнееСобытие',
'ПриИзмененииПараметровЭкрана','ПередЗагрузкойДанныхИзНастроек','ПриЗагрузкеДанныхИзНастроек',
'ПриСохраненииДанныхВНастройках','ПриЧтенииСозданииНаСервере','Подключаемый_ОбработатьЗаписьОбъекта',
'ПослеЗаписи','ПередЗаписью','ПриСохраненииВариантаНаСервере','ПриЗагрузкеВариантаНаСервере',
'ПриСохраненииПользовательскихНастроекНаСервере','ПриЗагрузкеПользовательскихНастроекНаСервере',
'ПриОбновленииСоставаПользовательскихНастроекНаСервере','ОбработкаПерехода','ОбработкаНавигационнойСсылки',
'ПриИзмененииДоступностиОсновногоСервера'
)

$ObjectEvents = @(
'ОбработкаПроведения','ОбработкаУдаленияПроведения','ПередЗаписью','ПриЗаписи','ОбработкаПроверкиЗаполнения',
'ОбработкаЗаполнения','ПриКопировании','ПриУстановкеНовогоНомера','ПередУдалением','ПриУстановкеНовогоКода',
'ОбработкаФормированияПоВерсииИсторииДанных','ОбработкаПолученияПредставления','ОбработкаПолученияПолейПредставления'
)

$ManagerEvents = @(
'ДобавитьКомандыПечати','Печать','ДобавитьКомандыСозданияНаОсновании','ДобавитьКомандыОтчетов',
'ОбработкаПолученияДанныхВыбора','ОбработкаПолученияФормы','ОбработкаПолученияПолейПредставления',
'ОбработкаПолученияПредставления','ПриОпределенииНастроек','ПриОпределенииНастроекВариантовОтчетов'
)

$TableRowSuffixes = @(
'ПриАктивизацииСтроки','ПриАктивизацииЯчейки','ПередНачаломДобавления','ПередНачаломИзменения','ПередУдалением',
'ПослеУдаления','ПриНачалеРедактирования','ПередОкончаниемРедактирования','ПриОкончанииРедактирования',
'ВыборЗначения','ОбработкаВыбора','НачалоПеретаскивания','ПроверкаПеретаскивания','ОкончаниеПеретаскивания',
'Перетаскивание','ПередРазворачиванием','ПередСворачиванием','ПриСменеСтраницы'
) | Sort-Object { $_.Length } -Descending

$ColumnEventSuffixes = @(
'ПриИзменении','НачалоВыбора','НачалоВыбораИзСписка','Очистка','АвтоПодбор','ОкончаниеВводаТекста',
'ОбработкаВыбора','Создание','Регулирование','Открытие'
) | Sort-Object { $_.Length } -Descending

$BlockOpen = @{
'Тогда' = 'Если'; 'Цикл' = 'Цикл'; 'Попытка' = 'Попытка'; 'Исключение' = 'Исключение'
}
# Closing keywords decrease indent
$BlockClose = @('КонецЕсли','КонецЦикла','КонецПопытки')

function Get-ModuleKind([string]$RelPath) {
	if ($RelPath -match 'Forms[/\\].*Module\.bsl$') { return 'Form' }
	if ($RelPath -match 'ManagerModule\.bsl$') { return 'Manager' }
	if ($RelPath -match 'ObjectModule\.bsl$') { return 'Object' }
	return 'Other'
}

function Read-BslFile([string]$Path) {
	$bytes = [System.IO.File]::ReadAllBytes($Path)
	$bom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
	$enc = New-Object System.Text.UTF8Encoding $false
	$text = if ($bom) { $enc.GetString($bytes, 3, $bytes.Length - 3) } else { $enc.GetString($bytes) }
	# Normalize newlines to `n for processing; preserve final newline sense
	$text = $text -replace "`r`n", "`n" -replace "`r", "`n"
	return @{ Text = $text; Bom = $bom }
}

function Write-BslFile([string]$Path, [string]$Text, [bool]$Bom) {
	$enc = New-Object System.Text.UTF8Encoding $Bom
	# Write with CRLF for Windows 1C sources
	$out = ($Text -replace "`n", "`r`n")
	if (-not $out.EndsWith("`r`n")) { $out += "`r`n" }
	[System.IO.File]::WriteAllText($Path, $out, $enc)
}

function Strip-AuName([string]$Name) {
	$n = $Name
	if ($n.StartsWith('АУ_')) { $n = $n.Substring(3) }
	foreach ($sfx in @('После','Перед','Вместо')) {
		if ($n.EndsWith($sfx) -and $n.Length -gt $sfx.Length) {
			$n = $n.Substring(0, $n.Length - $sfx.Length)
			break
		}
	}
	return $n
}

function Get-FirstParamName([string]$Signature) {
	# Signature like: Процедура Name(A, B) or Процедура Name(Знач A, B = 1)
	if ($Signature -notmatch '\((.*)\)') { return '' }
	$inside = $Matches[1].Trim()
	if ([string]::IsNullOrWhiteSpace($inside)) { return '' }
	$first = ($inside -split ',')[0].Trim()
	$first = $first -replace '^(Знач|Val)\s+', ''
	$first = ($first -split '=')[0].Trim()
	$first = ($first -split '\s+')[-1]
	return $first
}

function Test-IsFormEvent([string]$CoreName) {
	foreach ($e in $FormEvents) {
		if ($CoreName -eq $e) { return $true }
	}
	return $false
}

function Test-IsObjectEvent([string]$CoreName, [string]$Kind) {
	$list = if ($Kind -eq 'Manager') { $ManagerEvents } else { $ObjectEvents }
	foreach ($e in $list) {
		if ($CoreName -eq $e) { return $true }
	}
	# Extension interceptors on any event-like name
	return $false
}

function Find-TableRoot([string]$CoreName, [string[]]$KnownTables) {
	foreach ($t in ($KnownTables | Sort-Object { $_.Length } -Descending)) {
		if ($CoreName.StartsWith($t) -and $CoreName.Length -gt $t.Length) {
			return $t
		}
	}
	foreach ($sfx in $TableRowSuffixes) {
		if ($CoreName.EndsWith($sfx) -and $CoreName.Length -gt $sfx.Length) {
			return $CoreName.Substring(0, $CoreName.Length - $sfx.Length)
		}
	}
	# Column-style: TableFieldEvent — try known tables only
	foreach ($sfx in $ColumnEventSuffixes) {
		if ($CoreName.EndsWith($sfx) -and $CoreName.Length -gt $sfx.Length) {
			$rest = $CoreName.Substring(0, $CoreName.Length - $sfx.Length)
			foreach ($t in ($KnownTables | Sort-Object { $_.Length } -Descending)) {
				if ($rest.StartsWith($t)) { return $t }
			}
		}
	}
	return $null
}

function Collect-KnownTables($Methods) {
	$tables = New-Object System.Collections.Generic.HashSet[string]
	# Common defaults
	@('Товары','Список','СписокДоверенности','МатериалыИРаботы','Услуги','ЭтапыГрафикаОплаты',
	  'РасшифровкаПлатежа','НаборыТоваров','Серии','ДополнительныеРеквизиты','ОплатаПоставщикам',
	  'ПрочиеРасходы','Расходы','Приходы','ТоварыПоДаннымПоставщика','ШтрихкодыУпаковок') | ForEach-Object { [void]$tables.Add($_) }
	foreach ($m in $Methods) {
		$core = Strip-AuName $m.Name
		foreach ($sfx in $TableRowSuffixes) {
			if ($core.EndsWith($sfx) -and $core.Length -gt $sfx.Length) {
				[void]$tables.Add($core.Substring(0, $core.Length - $sfx.Length))
			}
		}
	}
	return @($tables)
}

function Classify-Method($Method, [string]$Kind, [string[]]$KnownTables) {
	$core = Strip-AuName $Method.Name
	$firstParam = Get-FirstParamName $Method.SignatureLine
	$hasInterceptor = $false
	foreach ($d in $Method.Directives) {
		if ($d -match '^&(Перед|После|Вместо)\(') { $hasInterceptor = $true; break }
	}

	if ($Kind -eq 'Form') {
		if (Test-IsFormEvent $core) { return @{ Region = 'ОбработчикиСобытийФормы'; Table = $null } }
		if ($firstParam -eq 'Команда' -or $firstParam -eq 'Кнопка') {
			return @{ Region = 'ОбработчикиКомандФормы'; Table = $null }
		}
		$table = Find-TableRoot $core $KnownTables
		if ($null -ne $table -and $firstParam -eq 'Элемент') {
			return @{ Region = "ОбработчикиСобытийЭлементовТаблицыФормы$table"; Table = $table }
		}
		# Table row events sometimes have more params
		if ($null -ne $table) {
			foreach ($sfx in $TableRowSuffixes) {
				if ($core.EndsWith($sfx)) {
					return @{ Region = "ОбработчикиСобытийЭлементовТаблицыФормы$table"; Table = $table }
				}
			}
			# Column events
			foreach ($sfx in $ColumnEventSuffixes) {
				if ($core.EndsWith($sfx) -and $core.StartsWith($table)) {
					return @{ Region = "ОбработчикиСобытийЭлементовТаблицыФормы$table"; Table = $table }
				}
			}
		}
		# Header element handlers: *ПриИзменении etc with Элемент
		if ($firstParam -eq 'Элемент') {
			foreach ($sfx in $ColumnEventSuffixes) {
				if ($core.EndsWith($sfx)) {
					return @{ Region = 'ОбработчикиСобытийЭлементовШапкиФормы'; Table = $null }
				}
			}
		}
		return @{ Region = 'СлужебныеПроцедурыИФункции'; Table = $null }
	}

	# Object / Manager
	if ($Method.IsExport -and -not $hasInterceptor -and -not (Test-IsObjectEvent $core $Kind)) {
		# Exported helpers rarely in extensions object modules; still route Export non-events to API
		# But print helpers etc. — if Export and not event → API
		if ($Method.Kind -eq 'Функция' -or $Method.IsExport) {
			# Prefer events first
		}
	}
	if ($hasInterceptor -or (Test-IsObjectEvent $core $Kind)) {
		return @{ Region = 'ОбработчикиСобытий'; Table = $null }
	}
	if ($Method.IsExport) {
		return @{ Region = 'ПрограммныйИнтерфейс'; Table = $null }
	}
	return @{ Region = 'СлужебныеПроцедурыИФункции'; Table = $null }
}

function Test-MethodLocked($Method) {
	if ($Method.Kind -eq 'Функция') { return $true }
	foreach ($d in $Method.Directives) {
		if ($d -match '&ИзменениеИКонтроль') { return $true }
	}
	$body = $Method.Body
	if ($body -match '(?m)^\s*#(Вставка|Удаление)\b') { return $true }
	return $false
}

# --- Tokenize module into leading trivia + methods ---
function Parse-Module([string]$Text) {
	$lines = $Text -split "`n", -1
	$methods = New-Object System.Collections.Generic.List[object]
	$i = 0
	$pendingDirectives = New-Object System.Collections.Generic.List[string]
	$pendingComments = New-Object System.Collections.Generic.List[string]
	$leading = New-Object System.Collections.Generic.List[string]
	$sawMethod = $false

	while ($i -lt $lines.Count) {
		$line = $lines[$i]
		$trim = $line.Trim()

		# Skip existing region markers and #Если wrappers at top level (we rebuild)
		if ($trim -match '^#Область\s' -or $trim -eq '#КонецОбласти' -or
			$trim -match '^#Если\s+Сервер\s+Или\s+ТолстыйКлиентОбычноеПриложение\s+Или\s+ВнешнееСоединение\s+Тогда\s*$' -or
			($trim -eq '#КонецЕсли' -and $sawMethod)) {
			$i++; continue
		}
		# Keep other preprocessor at module level with next method or leading
		if ($trim -match '^#Если\b' -or $trim -eq '#КонецЕсли') {
			if (-not $sawMethod) { $leading.Add($line) } else { $pendingDirectives.Add($line) }
			$i++; continue
		}

		if ($trim -match '^&') {
			$pendingDirectives.Add($trim)
			$i++; continue
		}

		if ($trim -match '^(Процедура|Функция)\s+([^\s(]+)\s*\(' -or $trim -match '^(Процедура|Функция)\s+([^\s(]+)\s*$') {
			$sawMethod = $true
			$kind = $Matches[1]
			$name = $Matches[2]
			# Collect signature (may span lines until closing paren)
			$sigLines = New-Object System.Collections.Generic.List[string]
			$sigLines.Add($line)
			$sigText = $line
			$parenDepth = 0
			foreach ($ch in $line.ToCharArray()) {
				if ($ch -eq '(') { $parenDepth++ }
				elseif ($ch -eq ')') { $parenDepth-- }
			}
			while ($parenDepth -gt 0 -and ($i + 1 -lt $lines.Count)) {
				$i++
				$line = $lines[$i]
				$sigLines.Add($line)
				$sigText += "`n" + $line
				foreach ($ch in $line.ToCharArray()) {
					if ($ch -eq '(') { $parenDepth++ }
					elseif ($ch -eq ')') { $parenDepth-- }
				}
			}
			$isExport = ($sigText -match '\)\s*Экспорт\s*$')
			$endToken = if ($kind -eq 'Процедура') { 'КонецПроцедуры' } else { 'КонецФункции' }
			$bodyLines = New-Object System.Collections.Generic.List[string]
			$i++
			while ($i -lt $lines.Count) {
				$bl = $lines[$i]
				if ($bl.Trim() -eq $endToken) { break }
				$bodyLines.Add($bl)
				$i++
			}
			$endLine = if ($i -lt $lines.Count) { $lines[$i] } else { $endToken }
			$methods.Add([pscustomobject]@{
				Kind = $kind
				Name = $name
				Directives = @($pendingDirectives)
				Comments = @($pendingComments)
				SignatureLines = @($sigLines)
				SignatureLine = ($sigLines -join "`n")
				BodyLines = @($bodyLines)
				Body = ($bodyLines -join "`n")
				EndLine = $endLine
				IsExport = $isExport
				OriginalIndex = $methods.Count
			})
			$pendingDirectives = New-Object System.Collections.Generic.List[string]
			$pendingComments = New-Object System.Collections.Generic.List[string]
			$i++
			continue
		}

		# Comments / blanks before first method → leading; after → attach to next method as comments
		if (-not $sawMethod) {
			if ($trim -ne '' -or $leading.Count -gt 0) {
				# skip pure blank leading
				if ($trim -ne '' -or ($leading | Where-Object { $_.Trim() -ne '' }).Count -gt 0) {
					$leading.Add($line)
				}
			}
		} else {
			if ($trim -match '^//' -or $trim -eq '') {
				$pendingComments.Add($line)
			} else {
				# unknown top-level — keep as comment-ish pending
				$pendingComments.Add($line)
			}
		}
		$i++
	}

	return [pscustomobject]@{ Methods = @($methods.ToArray()); Leading = @($leading.ToArray()) }
}

# --- Format procedure body ---
function Protect-StringsAndComments([string]$Line) {
	# Returns list of (type, text) segments — simplified mask for = spacing
	$chars = $Line.ToCharArray()
	$parts = New-Object System.Collections.Generic.List[object]
	$buf = New-Object System.Text.StringBuilder
	$mode = 'code' # code | str | comment
	$strQuote = $null
	for ($k = 0; $k -lt $chars.Length; $k++) {
		$ch = $chars[$k]
		if ($mode -eq 'comment') {
			[void]$buf.Append($ch)
			continue
		}
		if ($mode -eq 'str') {
			[void]$buf.Append($ch)
			if ($ch -eq $strQuote) {
				# doubled quote?
				if ($k + 1 -lt $chars.Length -and $chars[$k + 1] -eq $strQuote) {
					[void]$buf.Append($chars[$k + 1]); $k++; continue
				}
				$parts.Add([pscustomobject]@{ Type = 'str'; Text = $buf.ToString() })
				$buf = New-Object System.Text.StringBuilder
				$mode = 'code'
			}
			continue
		}
		# code
		if ($ch -eq '"' -or $ch -eq "'") {
			if ($buf.Length -gt 0) { $parts.Add([pscustomobject]@{ Type = 'code'; Text = $buf.ToString() }); $buf = New-Object System.Text.StringBuilder }
			$mode = 'str'; $strQuote = $ch; [void]$buf.Append($ch); continue
		}
		if ($ch -eq '/' -and $k + 1 -lt $chars.Length -and $chars[$k + 1] -eq '/') {
			if ($buf.Length -gt 0) { $parts.Add([pscustomobject]@{ Type = 'code'; Text = $buf.ToString() }); $buf = New-Object System.Text.StringBuilder }
			$mode = 'comment'; [void]$buf.Append($ch); continue
		}
		[void]$buf.Append($ch)
	}
	if ($buf.Length -gt 0) {
		$parts.Add([pscustomobject]@{ Type = $mode; Text = $buf.ToString() })
	}
	return [object[]]$parts.ToArray()
}

function Format-SpacesAroundEquals([string]$Line) {
	$parts = Protect-StringsAndComments $Line
	$sb = New-Object System.Text.StringBuilder
	foreach ($p in $parts) {
		if ($p.Type -ne 'code') {
			[void]$sb.Append($p.Text)
			continue
		}
		[void]$sb.Append((Format-SpacesAroundEquals-Code $p.Text))
	}
	return $sb.ToString().TrimEnd()
}

function Format-SpacesAroundEquals-Code([string]$t) {
	$out = New-Object System.Text.StringBuilder
	$tc = $t.ToCharArray()
	for ($k = 0; $k -lt $tc.Length; $k++) {
		$ch = $tc[$k]
		if ($ch -eq '<') {
			if ($k + 1 -lt $tc.Length -and ($tc[$k+1] -eq '>' -or $tc[$k+1] -eq '=')) {
				[void]$out.Append($ch); [void]$out.Append($tc[$k+1]); $k++; continue
			}
		}
		if ($ch -eq '>') {
			if ($k + 1 -lt $tc.Length -and $tc[$k+1] -eq '=') {
				[void]$out.Append($ch); [void]$out.Append($tc[$k+1]); $k++; continue
			}
		}
		if ($ch -eq '=') {
			if ($out.Length -gt 0) {
				$prev = $out.Chars($out.Length - 1)
				if ($prev -eq '<' -or $prev -eq '>') { [void]$out.Append($ch); continue }
				if ($prev -ne ' ') { [void]$out.Append(' ') }
			}
			[void]$out.Append('=')
			if ($k + 1 -lt $tc.Length) {
				if ($tc[$k + 1] -ne ' ') { [void]$out.Append(' ') }
			} else {
				[void]$out.Append(' ')
			}
			continue
		}
		[void]$out.Append($ch)
	}
	return $out.ToString()
}

function Format-CommaSpaces([string]$Line) {
	$parts = Protect-StringsAndComments $Line
	$sb = New-Object System.Text.StringBuilder
	foreach ($p in $parts) {
		if ($p.Type -eq 'code') {
			[void]$sb.Append([regex]::Replace($p.Text, ',(?!\s)', ', '))
		} else {
			[void]$sb.Append($p.Text)
		}
	}
	return $sb.ToString()
}

function Get-LeadingIndentLevel([string]$Line) {
	$n = 0
	$i = 0
	while ($i -lt $Line.Length) {
		$ch = $Line[$i]
		if ($ch -eq "`t") { $n++; $i++; continue }
		if ($ch -eq ' ') {
			$spaces = 0
			while ($i -lt $Line.Length -and $Line[$i] -eq ' ') { $spaces++; $i++ }
			$n += [int][Math]::Ceiling($spaces / 4.0)
			continue
		}
		break
	}
	return $n
}

function Format-ProcedureBody([string[]]$BodyLines) {
	if ($null -eq $BodyLines -or $BodyLines.Count -eq 0) { return [string[]]@() }

	$inString = $false
	$formatted = New-Object System.Collections.Generic.List[string]

	foreach ($raw in $BodyLines) {
		if ($inString) {
			$formatted.Add($raw)
			$chars = $raw.ToCharArray()
			$q = [char]'"'
			for ($k = 0; $k -lt $chars.Length; $k++) {
				if ($chars[$k] -eq $q) {
					if ($k + 1 -lt $chars.Length -and $chars[$k + 1] -eq $q) { $k++; continue }
					$inString = $false
					break
				}
			}
			continue
		}

		if ($raw.Trim() -eq '') {
			$formatted.Add('')
			continue
		}

		$level = Get-LeadingIndentLevel $raw
		if ($level -lt 1) { $level = 1 }
		$trim = $raw.Trim()

		$parts = Protect-StringsAndComments $trim
		$spacedParts = New-Object System.Text.StringBuilder
		foreach ($p in $parts) {
			if ($p.Type -eq 'code') {
				[void]$spacedParts.Append((Format-SpacesAroundEquals-Code $p.Text))
			} else {
				[void]$spacedParts.Append($p.Text)
			}
		}
		$spaced = Format-CommaSpaces ($spacedParts.ToString())
		$formatted.Add((("`t" * $level) + $spaced).TrimEnd())

		# unclosed string?
		$mode = 'code'
		$q = [char]'"'
		$chars2 = $trim.ToCharArray()
		for ($k = 0; $k -lt $chars2.Length; $k++) {
			$ch = $chars2[$k]
			if ($mode -eq 'comment') { break }
			if ($mode -eq 'str') {
				if ($ch -eq $q) {
					if ($k + 1 -lt $chars2.Length -and $chars2[$k + 1] -eq $q) { $k++; continue }
					$mode = 'code'
				}
				continue
			}
			if ($ch -eq '/' -and $k + 1 -lt $chars2.Length -and $chars2[$k + 1] -eq '/') { $mode = 'comment'; break }
			if ($ch -eq $q) { $mode = 'str' }
		}
		if ($mode -eq 'str') { $inString = $true }
	}

	$result = New-Object System.Collections.Generic.List[string]
	for ($i = 0; $i -lt $formatted.Count; $i++) {
		$cur = $formatted[$i]
		$curTrim = $cur.Trim()
		$result.Add($cur)
		if ($curTrim -eq '') { continue }
		$isOpen = ($curTrim -match '\bТогда\s*$' -or $curTrim -match '\bЦикл\s*$' -or $curTrim -eq 'Попытка' -or $curTrim -eq 'Исключение' -or $curTrim -eq 'Иначе' -or ($curTrim -match '^ИначеЕсли\b' -and $curTrim -match '\bТогда\s*$'))
		if ($isOpen) {
			$j = $i + 1
			while ($j -lt $formatted.Count -and $formatted[$j].Trim() -eq '') { $j++ }
			if ($j -lt $formatted.Count) {
				$nextTrim = $formatted[$j].Trim()
				$nextIsClose = ($nextTrim -match '^КонецЕсли\b' -or $nextTrim -match '^КонецЦикла\b' -or $nextTrim -match '^КонецПопытки\b' -or $nextTrim -eq 'Исключение' -or $nextTrim -eq 'Иначе' -or $nextTrim -match '^ИначеЕсли\b')
				if (-not $nextIsClose) {
					if ($i + 1 -ge $formatted.Count -or $formatted[$i + 1].Trim() -ne '') {
						$result.Add('')
					}
				}
			}
		}
	}

	$final = New-Object System.Collections.Generic.List[string]
	for ($i = 0; $i -lt $result.Count; $i++) {
		$cur = $result[$i]
		$curTrim = $cur.Trim()
		$isClose = ($curTrim -match '^КонецЕсли\b' -or $curTrim -match '^КонецЦикла\b' -or $curTrim -match '^КонецПопытки\b')
		if ($isClose -and $final.Count -gt 0) {
			$prevIdx = $final.Count - 1
			while ($prevIdx -ge 0 -and $final[$prevIdx].Trim() -eq '') { $prevIdx-- }
			if ($prevIdx -ge 0) {
				$prevTrim = $final[$prevIdx].Trim()
				$prevIsOpen = ($prevTrim -match '\bТогда\s*$' -or $prevTrim -match '\bЦикл\s*$' -or $prevTrim -eq 'Попытка' -or $prevTrim -eq 'Исключение' -or $prevTrim -eq 'Иначе')
				$alreadyBlank = ($final[$final.Count - 1].Trim() -eq '')
				if (-not $prevIsOpen -and -not $alreadyBlank) { $final.Add('') }
			}
		}
		$final.Add($cur)
	}

	while ($final.Count -gt 0 -and $final[0].Trim() -eq '') { $final.RemoveAt(0) }
	while ($final.Count -gt 0 -and $final[$final.Count - 1].Trim() -eq '') { $final.RemoveAt($final.Count - 1) }

	$collapsed = New-Object System.Collections.Generic.List[string]
	$blankRun = 0
	foreach ($l in $final) {
		if ($l.Trim() -eq '') {
			$blankRun++
			if ($blankRun -le 1) { $collapsed.Add('') }
		} else {
			$blankRun = 0
			$collapsed.Add($l)
		}
	}
	return [string[]]$collapsed.ToArray()
}

function Emit-Method($Method, [bool]$FormatBody) {
	$sb = New-Object System.Collections.Generic.List[string]
	foreach ($c in $Method.Comments) {
		if ($c.Trim() -match '^//' -or $c.Trim() -eq '') {
			# skip blank comments padding
			if ($c.Trim() -match '^//') { $sb.Add($c.TrimEnd()) }
		}
	}
	foreach ($d in $Method.Directives) {
		$sb.Add($d.Trim())
	}
	# Signature: keep first line structure; for multi-line sig of functions keep as-is; for procedures format lightly
	if ($Method.Kind -eq 'Функция' -or -not $FormatBody) {
		foreach ($s in $Method.SignatureLines) { $sb.Add($s) }
		foreach ($b in $Method.BodyLines) { $sb.Add($b) }
		$sb.Add($Method.EndLine)
	} else {
		# Format signature: spaces after commas in params on single-line signatures
		$sig = ($Method.SignatureLines -join ' ').Trim()
		# Collapse whitespace in signature to single spaces carefully
		if ($Method.SignatureLines.Count -eq 1) {
			$sigOne = $Method.SignatureLines[0].Trim()
			$sigOne = Format-SpacesAroundEquals $sigOne
			# space after commas
			$sigOne = [regex]::Replace($sigOne, ',(?!\s)', ', ')
			$sigOne = [regex]::Replace($sigOne, '\(\s+', '(')
			$sigOne = [regex]::Replace($sigOne, '\s+\)', ')')
			$sb.Add($sigOne)
		} else {
			foreach ($s in $Method.SignatureLines) { $sb.Add($s.TrimEnd()) }
		}
		$body = Format-ProcedureBody $Method.BodyLines
		$sb.Add('')
		foreach ($b in $body) { $sb.Add($b) }
		if ($body.Count -gt 0) { $sb.Add('') }
		$sb.Add('КонецПроцедуры')
	}
	return $sb
}

function Build-FormModule($Methods) {
	$known = Collect-KnownTables $Methods
	$buckets = [ordered]@{
		'ОбработчикиСобытийФормы' = New-Object System.Collections.Generic.List[object]
		'ОбработчикиСобытийЭлементовШапкиФормы' = New-Object System.Collections.Generic.List[object]
	}
	$tableBuckets = @{}  # name -> list
	$buckets['ОбработчикиКомандФормы'] = New-Object System.Collections.Generic.List[object]
	$buckets['СлужебныеПроцедурыИФункции'] = New-Object System.Collections.Generic.List[object]

	foreach ($m in $Methods) {
		$cls = Classify-Method $m 'Form' $known
		$r = $cls.Region
		if ($r -like 'ОбработчикиСобытийЭлементовТаблицыФормы*') {
			if (-not $tableBuckets.ContainsKey($r)) {
				$tableBuckets[$r] = New-Object System.Collections.Generic.List[object]
			}
			$tableBuckets[$r].Add($m)
		} elseif ($buckets.Contains($r)) {
			$buckets[$r].Add($m)
		} else {
			$buckets['СлужебныеПроцедурыИФункции'].Add($m)
		}
	}

	$out = New-Object System.Collections.Generic.List[string]
	$addRegion = {
		param([string]$Name, $List, $OutList)
		$OutList.Add("#Область $Name")
		$OutList.Add('')
		$first = $true
		foreach ($m in $List) {
			if (-not $first) { $OutList.Add('') }
			$first = $false
			$locked = Test-MethodLocked $m
			$lines = Emit-Method $m (-not $locked)
			foreach ($l in $lines) { $OutList.Add($l) }
		}
		if ($List.Count -gt 0) { $OutList.Add('') }
		$OutList.Add('#КонецОбласти')
		$OutList.Add('')
	}

	& $addRegion 'ОбработчикиСобытийФормы' $buckets['ОбработчикиСобытийФормы'] $out
	& $addRegion 'ОбработчикиСобытийЭлементовШапкиФормы' $buckets['ОбработчикиСобытийЭлементовШапкиФормы'] $out
	foreach ($tn in ($tableBuckets.Keys | Sort-Object)) {
		& $addRegion $tn $tableBuckets[$tn] $out
	}
	& $addRegion 'ОбработчикиКомандФормы' $buckets['ОбработчикиКомандФормы'] $out
	& $addRegion 'СлужебныеПроцедурыИФункции' $buckets['СлужебныеПроцедурыИФункции'] $out

	# Remove trailing blank
	while ($out.Count -gt 0 -and $out[$out.Count - 1].Trim() -eq '') { $out.RemoveAt($out.Count - 1) }
	return ($out -join "`n") + "`n"
}

function Build-ObjectManagerModule($Methods, [string]$Kind) {
	$buckets = [ordered]@{
		'ПрограммныйИнтерфейс' = New-Object System.Collections.Generic.List[object]
		'ОбработчикиСобытий' = New-Object System.Collections.Generic.List[object]
		'СлужебныеПроцедурыИФункции' = New-Object System.Collections.Generic.List[object]
	}
	foreach ($m in $Methods) {
		$cls = Classify-Method $m $Kind @()
		$buckets[$cls.Region].Add($m)
	}

	$out = New-Object System.Collections.Generic.List[string]
	$out.Add('#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда')
	$out.Add('')

	foreach ($rn in @('ПрограммныйИнтерфейс','ОбработчикиСобытий','СлужебныеПроцедурыИФункции')) {
		$out.Add("#Область $rn")
		$out.Add('')
		$list = $buckets[$rn]
		$first = $true
		foreach ($m in $list) {
			if (-not $first) { $out.Add('') }
			$first = $false
			$locked = Test-MethodLocked $m
			$lines = Emit-Method $m (-not $locked)
			foreach ($l in $lines) { $out.Add($l) }
		}
		if ($list.Count -gt 0) { $out.Add('') }
		$out.Add('#КонецОбласти')
		$out.Add('')
	}

	$out.Add('#КонецЕсли')
	while ($out.Count -gt 0 -and $out[$out.Count - 1].Trim() -eq '') { $out.RemoveAt($out.Count - 1) }
	return ($out -join "`n") + "`n"
}

# --- Main ---
$report = New-Object System.Collections.Generic.List[object]
$changed = 0
$skipped = 0

foreach ($rel in $Files) {
	$path = Join-Path $Base ($rel -replace '/', '\')
	if (-not (Test-Path -LiteralPath $path)) {
		$report.Add([pscustomobject]@{ File = $rel; Status = 'MISSING'; Note = '' })
		continue
	}
	$kind = Get-ModuleKind $rel
	$rf = Read-BslFile $path
	$parsed = Parse-Module $rf.Text
	if ($parsed.Methods.Count -eq 0) {
		# Still ensure regions for empty? Skip if no methods
		$report.Add([pscustomobject]@{ File = $rel; Status = 'SKIP_EMPTY'; Note = 'no methods' })
		$skipped++
		continue
	}

	if ($kind -eq 'Form') {
		$newText = Build-FormModule $parsed.Methods
	} elseif ($kind -eq 'Object' -or $kind -eq 'Manager') {
		$newText = Build-ObjectManagerModule $parsed.Methods $kind
	} else {
		$report.Add([pscustomobject]@{ File = $rel; Status = 'SKIP_KIND'; Note = $kind })
		$skipped++
		continue
	}

	$oldNorm = ($rf.Text -replace "`r`n", "`n" -replace "`r", "`n")
	if (-not $oldNorm.EndsWith("`n")) { $oldNorm += "`n" }
	if ($oldNorm -eq $newText) {
		$report.Add([pscustomobject]@{ File = $rel; Status = 'UNCHANGED'; Note = "$($parsed.Methods.Count) methods" })
		$skipped++
		continue
	}

	Write-BslFile $path $newText $rf.Bom
	$changed++
	$report.Add([pscustomobject]@{ File = $rel; Status = 'CHANGED'; Note = "$kind $($parsed.Methods.Count) methods" })
}

Write-Output "CHANGED=$changed SKIPPED=$skipped"
$report | ForEach-Object { Write-Output ("{0}`t{1}`t{2}" -f $_.Status, $_.Note, $_.File) }
$report | ConvertTo-Json -Depth 3 | Set-Content -LiteralPath 'c:\repo\Aurum.ut\.tmp-batch-b-report.json' -Encoding UTF8
