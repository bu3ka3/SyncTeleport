local sampev = require 'samp.events' -- подключаем библиотеку "SAMP.Lua"

function main() -- объ€вл€ем глобальную область 
    while not isSampAvailable() do wait(0) end -- проверка на запущенную игру
        sampRegisterChatCommand('stp', function(tp) -- задаЄм тело в глобальную область
            lua_thread.create(function(tp) -- объ€вл€ем поток
            local result, mX, mY, mZ = getTargetBlipCoordinates() -- объ€вл€ем в локальную переменную результат телепорта и координаты метки
            if result then -- если результат успешен, то
                setCharCoordinates(PLAYER_PED, 0.0, 0.0, 0.0) -- телепортируем в центр карты
                wait(200)
                setCharCoordinates(PLAYER_PED, mX, mY, mZ) -- телепортируем на метку
                sampAddChatMessage('“елепортирован', -1) -- выведем результат
            end
        end)
    end)
    wait(-1)
end

function sampev.onSetPlayerPos(position) -- вызываем вход€щий RPC 
    if tp then
        return false
    end
end

function sampev.onSendPlayerSync(data) -- вызываем исход€щий пакет
    lua_thread.create(function()
        if tp then
            data.position = { x = 0.0, y = 0.0, z = 0.0 }
            wait(200)
            data.position = {mX, mY, mZ}
        end
    end)
end