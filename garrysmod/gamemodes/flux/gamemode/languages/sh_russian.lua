--[[
	Flux © 2016-2017 TeslaCloud Studios
	Do not share or re-distribute before
	the framework is publicly released.
--]]

local lang = fl.lang:GetTable("ru")

do
	local vowels = {
		["а"] = true,
		["е"] = true,
		["ё"] = true,
		["у"] = true,
		["и"] = true,
		["о"] = true,
		["ы"] = true,
		["э"] = true,
		["ю"] = true,
		["я"] = true
	}

	function lang:IsVowel(char)
		return vowels[char]
	end
end

lang["#second"] = "#1 секунда"
lang["#second_2"] = "#1 секунды"
lang["#second_5"] = "#1 секунд"
lang["#minute"] = "#1 минута"
lang["#minute_2"] = "#1 минуты"
lang["#minute_5"] = "#1 минут"
lang["#hour"] = "#1 час"
lang["#hour_2"] = "#1 часа"
lang["#hour_5"] = "#1 часов"
lang["#day"] = "#1 день"
lang["#day_2"] = "#1 дня"
lang["#day_5"] = "#1 дней"
lang["#week"] = "#1 неделя"
lang["#week_2"] = "#1 недели"
lang["#week_5"] = "#1 недель"
lang["#month"] = "#1 месяц"
lang["#month_2"] = "#1 месяца"
lang["#month_5"] = "#1 месяцев"
lang["#year"] = "#1 год"
lang["#year_2"] = "#1 года"
lang["#year_5"] = "#1 лет"
lang["#permanently"] = "навсегда"
lang["#for"] = "на"
lang["#and"] = "и"

function lang:PickEnding(n)
	local ns = tostring(n)
	local ending = tonumber(ns:sub(ns:len(), ns:len()))

	if (ending) then
		if (ending > 1 and ending < 5) then
			return "_2"
		elseif (ending == 0 or ending >= 5) then
			return "_5"
		end
	end

	return ""
end

function lang:NiceTime(time)
	if (time < 60) then
		return "#second"..self:PickEnding(time)..":"..time..";", 0
	elseif (time < (60 * 60)) then
		local t = math.floor(time / 60)

		return "#minute"..self:PickEnding(t)..":"..t..";", time - t * 60
	elseif (time < (60 * 60 * 24)) then
		local t = math.floor(time / 60 / 60)

		return "#hour"..self:PickEnding(t)..":"..t..";", time - t * 60 * 60
	elseif (time < (60 * 60 * 24 * 7)) then
		local t = math.floor(time / 60 / 60 / 24)

		return "#day"..self:PickEnding(t)..":"..t..";", time - t * 60 * 60 * 24
	elseif (time < (60 * 60 * 24 * 30)) then
		local t = math.floor(time / 60 / 60 / 24 / 7)

		return "#week"..self:PickEnding(t)..":"..t..";", time - t * 60 * 60 * 24 * 7
	elseif (time < (60 * 60 * 24 * 30 * 12)) then
		local t = math.floor(time / 60 / 60 / 24 / 30)

		return "#month"..self:PickEnding(t)..":"..t..";", time - t * 60 * 60 * 24 * 30
	elseif (time >= (60 * 60 * 24 * 365)) then
		local t = math.floor(time / 60 / 60 / 24 / 365)

		return "#year"..self:PickEnding(t)..":"..t..";", time - t * 60 * 60 * 24 * 365
	else
		return "#second:"..time..";", 0
	end
end

lang["#TabMenu_Expand"] = "Развернуть"
lang["#TabMenu_Characters"] = "Персонажи"
lang["#TabMenu_Inventory"] = "Инвентарь"
lang["#TabMenu_Settings"] = "Настройки"
lang["#TabMenu_Home"] = "Домашняя страница"
lang["#TabMenu_Scoreboard"] = "Игроки"
lang["#TabMenu_Admin"] = "Админка"
lang["#TabMenu_CloseMenu"] = "Закрыть"

lang["#BarText_Health"] = "ЗДОРОВЬЕ"
lang["#BarText_Armor"] = "БРОНЯ"
lang["#BarText_Respawn"] = "ВОЗРОЖДЕНИЕ..."

lang["#MainMenu_Disconnect"] = "Отключиться"
lang["#MainMenu_Settings"] = "Настройки"
lang["#MainMenu_Cancel"] = "Отменить"
lang["#MainMenu_Load"] = "Загрузить"
lang["#MainMenu_New"] = "Создать"

lang["#Err_NotValidEntity"] = "Вы должны смотреть на энтити!"
lang["#Err_CannotStaticThis"] = "Вы не можете сохранить этот энтити!"
lang["#Err_AlreadyStatic"] = "Этот энтити уже сохранен!"
lang["#Err_NotStatic"] = "Этот энтити не сохранен!"
lang["#Static_Added"] = "Вы сохранили этот энтити."
lang["#Static_Removed"] = "Вы убрали этот энтити из сохранения."

lang["#CharCreate"] = "CREATE A CHARACTER"
lang["#CharCreateText"] = "CHARACTER CREATION"
lang["#CharCreate_Create"] = "CREATE"
lang["#CharCreate_ModelButton"] = "Model"
lang["#CharCreate_FactionButton"] = "Faction"
lang["#CharCreate_GenText"] = "General Character Information"
lang["#CharCreate_Name"] = "Name:"
lang["#CharCreate_Desc"] = "Description:"
lang["#CharCreate_Gender"] = "Gender:"
lang["#CharCreate_Gender_S"] = "Select Gender"
lang["#CharCreate_Gender_M"] = "Male"
lang["#CharCreate_Gender_F"] = "Female"
lang["#CharCreate_GenFacWarning"] = "You have to select a gender or faction first!"
lang["#CharCreate_Model_S"] = "Select a model"
lang["#CharCreate_Fac_S"] = "Select a faction"
lang["#CharCreat_FacTitle"] = "Faction:"

lang["#Settings_Dashboard"] = "Меню"
lang["#Settings_Theme"] = "Тема"
lang["#Settings_AdminESP"] = "ESP Админа"
lang["#Settings_Binds"] = "Клавиши"
lang["#Settings_General"] = "Общее"
lang["#Settings_HUD"] = "HUD"

lang["#Settings_BackgroundURL"] = "Введите ссылку на картинку для фона."
lang["#Settings_BackgroundColor"] = "Цвет фона TAB меню:"
lang["#Settings_MenuBackColor"] = "Цвет панелей:"
lang["#Settings_TextColor"] = "Цвет текста:"
lang["#Settings_EnableAdminESP"] = "Включить ESP администратора"
lang["#Settings_FitType"] = "Выберите как следует масштабировать картинку фона."
lang["#Settings_DrawBars"] = "Отрисовывать полоски в HUD'е (здоровье, броня, и.т.п)."
lang["#Settings_DrawBarText"] = "Отрисовывать текст на полосках."
lang["#Settings_UseTabDash"] = "Выберите, чтобы использовать дэшборд-меню, снимите галочку, чтобы использовать классический вид."

lang["#Settings_Fit_Tiled"] = "Плитки"
lang["#Settings_Fit_Center"] = "Центрировать"
lang["#Settings_Fit_Fill"] = "Заполнить"
lang["#Settings_Fit_Fit"] = "Подогнать размер"

lang["#Settings_DrawLegs"] = "Draw your legs."
lang["#Settings_ToggleAutoWalk"] = "Toggle Auto-Walk"
lang["#Settings_ToggleThirdPerson"] = "Переключить вид от третьего лица"

lang["#TargetID_Information"] = "Нажмите 'E', чтобы посмотреть информацию."
lang["#TargetID_Action"] = "Нажмите 'E' для выполнения действия."

lang["#tool.static.name"] = "Сохранение/Удаление Энтити"
lang["#tool.static.desc"] = "Сохраняет энтити между рестартами или удаляет его из сохранения."
lang["#tool.static.0"] = "ЛКМ: Сохранить, ПКМ: Удалить."

--[[
	Misc. Things added by plugins
--]]

lang["#PressJumpToGetup"]		= "Нажмите 'прыжок', чтобы встать..."

lang["#Hint_Forums"]			= "Форум"
lang["#Hint_Hints"]				= "Подсказки"
lang["#Hint_TAB"]				= "TAB"
lang["#Hint_Inventory"]			= "Инвентарь"
lang["#Hint_Commands"]			= "Команды"
lang["#Hint_Bugs"]				= "Баги"
lang["#Hint_ForumsText"]		= "Зайдите на форум TeslaCloud, чтобы получить поддержку, скачать плагины\nи просто общаться с другими пользователями Flux!"
lang["#Hint_HintsText"]			= "Эти подсказки можно выключить через меню настроек.\nПравда не в этой версии."
lang["#Hint_TABText"]			= "Нажмите кнопку показа счёта (по умолчанию TAB), чтобы открыть меню."
lang["#Hint_InventoryText"]		= "Перетащите предмет за пределы инвентаря, чтобы его выбросить."
lang["#Hint_CommandsText"]		= "Начните вводить команду в чат, чтобы увидеть её описание\nи документацию по использованию."
lang["#Hint_BugsText"]			= "Нашли баг? У вас есть идея, которую мы могли бы воплотить в Flux?\nПосетите наш форум TeslaCloud.net и расскажите нам об этом!"