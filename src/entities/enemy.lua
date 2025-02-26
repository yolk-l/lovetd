local Entity = require("src.entities.entity")

local Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy, { __index = Entity }) -- 继承自 Entity

function Enemy:new(x, y, size, speed, health)
    local enemy = setmetatable(Entity:new(x, y, size, size), Enemy)
    enemy.speed = speed
    enemy.health = health
    enemy.attackRange = 1
    return enemy
end

function Enemy:moveTowardsPlayer(towers)
    local target = towers[1] -- 默认向主塔移动
    if self.x > target.x then
        self.x = self.x - self.speed
    end
end

function Enemy:attack(towers)
    for _, tower in ipairs(towers) do
        if math.abs(self.x - tower.x) <= self.attackRange and math.abs(self.y - tower.y) <= self.attackRange then
            tower:takeDamage()
        end
    end
end

function Enemy:takeDamage(amount)
    self.health = self.health - amount
    if self.health <= 0 then
        self:destroy()
    end
end

function Enemy:destroy()
    if not enemies or #enemies == 0 then return end
    -- 从敌人列表中移除
    for i, enemy in ipairs(enemies) do
        if enemy == self then
            table.remove(enemies, i)
            break
        end
    end
end

function Enemy:draw()
    love.graphics.setColor(1, 0, 0) -- 红色
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Enemy