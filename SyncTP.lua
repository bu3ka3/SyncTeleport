local sampev = require 'samp.events' -- подключаем библиотеку "SAMP.Lua"

function main() -- объявляем глобальную область
    while not isSampAvailable() do wait(0) end -- ïðîâåðêà íà çàïóùåííóþ èãðó
        sampRegisterChatCommand('stp', function(tp) -- çàäà¸ì òåëî â ãëîáàëüíóþ îáëàñòü
            lua_thread.create(function(tp) -- îáúÿâëÿåì ïîòîê
            local result, mX, mY, mZ = getTargetBlipCoordinates() -- îáúÿâëÿåì â ëîêàëüíóþ ïåðåìåííóþ ðåçóëüòàò òåëåïîðòà è êîîðäèíàòû ìåòêè
            if result then -- åñëè ðåçóëüòàò óñïåøåí, òî
                setCharCoordinates(PLAYER_PED, 0.0, 0.0, 0.0) -- òåëåïîðòèðóåì â öåíòð êàðòû
                wait(200)
                setCharCoordinates(PLAYER_PED, mX, mY, mZ) -- òåëåïîðòèðóåì íà ìåòêó
                sampAddChatMessage('Òåëåïîðòèðîâàí', -1) -- âûâåäåì ðåçóëüòàò
            end
        end)
    end)
    wait(-1)
end

function sampev.onSetPlayerPos(position) -- âûçûâàåì âõîäÿùèé RPC 
    if tp then
        return false
    end
end

function sampev.onSendPlayerSync(data) -- âûçûâàåì èñõîäÿùèé ïàêåò
    lua_thread.create(function()
        if tp then
            data.position = { x = 0.0, y = 0.0, z = 0.0 }
            wait(200)
            data.position = {mX, mY, mZ}
        end
    end)
end
