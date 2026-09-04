Функция КонвертироватьЗначениеИзДиадок(СтрокаУровняДоступаДиадок) Экспорт
	
	// https://api-docs.diadoc.ru/ru/latest/proto/DocumentAccessLevel.html
	
	Если СтрокаУровняДоступаДиадок = "UnknownDocumentAccessLevel" Тогда 
		Возврат UnknownDocumentAccessLevel;
	ИначеЕсли СтрокаУровняДоступаДиадок = "DepartmentOnly" Тогда 
		Возврат DepartmentOnly;
	ИначеЕсли СтрокаУровняДоступаДиадок = "DepartmentAndSubdepartments" Тогда 
		Возврат DepartmentAndSubdepartments;
	ИначеЕсли СтрокаУровняДоступаДиадок = "AllDocuments" Тогда 
		Возврат AllDocuments;
	ИначеЕсли СтрокаУровняДоступаДиадок = "SelectedDepartments" Тогда
		Возврат SelectedDepartments;
	Иначе
		Возврат ПустаяСсылка();	
	КонецЕсли;
	
КонецФункции
