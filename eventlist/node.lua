gl.setup(1920, 1200)

color={1,1,1,1}

util.resource_loader{
    "font.ttf";
}

local Absatz = "absatz"

local events = {
    {"9:00",   "foo"},
    {"10:00",  "bar"},
    Absatz,
    {"13:37",	"baz"},
}

function Eventliste(events, x, y, spacing, size)
    local row
    local col
    local next_kaputt

    function select_next()
        repeat
            row = math.random(#events)
        until events[row] ~= Absatz
        local time, description = unpack(events[row])
        col = math.random(#time - 1)
        next_kaputt = sys.now() + math.random() * 60 + 30
    end

    select_next()

    function draw()
        local yy = y
	local rgb_r, rgb_g, rgb_b, rgb_a = unpack(color)
        for n, item in pairs(events) do
            if item == Absatz then
                yy = yy + size
            else
                local time, description = unpack(item)
                if sys.now() > next_kaputt - 3 and n == row then
                    local a = time:sub(1, col-1)
                    local b = time:sub(col, col)
                    local c = time:sub(col+1, col+1)
                    local d = time:sub(col+2)
                    time = a .. c .. b .. d
                    font:write(x, yy, time, size, rgb_r, rgb_g, rgb_b, rgb_a)
                elseif sys.now() > next_kaputt then
                    select_next()
                    font:write(x, yy, time, size, rgb_r, rgb_g, rgb_b, rgb_a)
                else
                    font:write(x, yy, time, size, rgb_r, rgb_g, rgb_b, rgb_a)
                end
                font:write(x + spacing, yy, description, size, rgb_r, rgb_g, rgb_b, rgb_a)
                yy = yy + size
            end
        end
    end
    return {
        draw = draw;
    }
end

local eventliste = Eventliste(events, 0, 0, 200, 50)

function node.render()
    gl.clear(1,1,1,0)
    eventliste:draw()
end
