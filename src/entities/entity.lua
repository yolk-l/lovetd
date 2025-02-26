-- 实体基类
local Entity = {}
Entity.__index = Entity

function Entity:new(x, y, width, height)
    local entity = setmetatable({}, Entity)
    entity.x = x
    entity.y = y
    entity.width = width
    entity.height = height
    return entity
end

function Entity:draw()
    -- 默认绘制逻辑（子类可以重写）
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Entity:update(dt)
    -- 默认更新逻辑（子类可以重写）
end

return Entity