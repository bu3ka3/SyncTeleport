local sampev = require 'samp.events' -- ���������� ���������� "SAMP.Lua"

function main() -- ��������� ���������� ������� 
    while not isSampAvailable() do wait(0) end -- �������� �� ���������� ����
        sampRegisterChatCommand('stp', function(tp) -- ����� ���� � ���������� �������
            lua_thread.create(function(tp) -- ��������� �����
            local result, mX, mY, mZ = getTargetBlipCoordinates() -- ��������� � ��������� ���������� ��������� ��������� � ���������� �����
            if result then -- ���� ��������� �������, ��
                setCharCoordinates(PLAYER_PED, 0.0, 0.0, 0.0) -- ������������� � ����� �����
                wait(200)
                setCharCoordinates(PLAYER_PED, mX, mY, mZ) -- ������������� �� �����
                sampAddChatMessage('��������������', -1) -- ������� ���������
            end
        end)
    end)
    wait(-1)
end

function sampev.onSetPlayerPos(position) -- �������� �������� RPC 
    if tp then
        return false
    end
end

function sampev.onSendPlayerSync(data) -- �������� ��������� �����
    lua_thread.create(function()
        if tp then
            data.position = { x = 0.0, y = 0.0, z = 0.0 }
            wait(200)
            data.position = {mX, mY, mZ}
        end
    end)
end