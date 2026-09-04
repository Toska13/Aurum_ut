// MIT License
//
// Copyright (c) 2020 Alexander Shkuraev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#Область Прочее

Процедура ДобавитьКоманду(Команды, Представление, Идентификатор, Использование, Оповещение = Ложь, Модификатор = "")
	
	НоваяКоманда = Команды.Добавить();
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = Оповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Возвращает данные для регистрации в качестве внешней обработки
// 
// Возвращаемое значение:
//  Структура - вся информация для регистрации
//
Функция СведенияОВнешнейОбработке() Экспорт
	
	РегистрационныеДанные = Новый Структура;
	
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор"  , Новый ОписаниеТипов("Строка"));
	
	ДобавитьКоманду(Команды, "Консоль кода", "КонсольКода", "ОткрытиеФормы");
	
	РегистрационныеДанные.Вставить("Вид"             , "ДополнительнаяОбработка");
	РегистрационныеДанные.Вставить("Назначение"      , Неопределено);
	РегистрационныеДанные.Вставить("Наименование"    , "Консоль кода");
	РегистрационныеДанные.Вставить("Версия"          , "20221014");
	РегистрационныеДанные.Вставить("БезопасныйРежим" , Ложь);
	РегистрационныеДанные.Вставить("Информация"      , "Консоль кода для управляемых форм");
	РегистрационныеДанные.Вставить("Команды"         , Команды);
	
	Возврат РегистрационныеДанные;
	
КонецФункции

#КонецОбласти