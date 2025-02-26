local Entity = require("src.entities.entity")

local Tower = {}
Tower.__index = Tower
setmetatable(Tower, { __index = Entity }) -- 继承自 Entity

function Tower:new(x, y, width, height, attackRange, isMainTower)
    local tower = setmetatable(Entity:new(x, y, width, height), Tower)
    tower.attackRange = attackRange
    tower.isMainTower = isMainTower
    tower.canAttack = not isMainTower -- 主塔默认不能攻击
    return tower
end

function Tower:attack(enemies)
    if not self.canAttack then return end

    for _, enemy in ipairs(enemies) do
        if math.abs(enemy.x - self.x) <= self.attackRange and math.abs(enemy.y - self.y) <= self.attackRange then
            enemy:takeDamage(1) -- 简单攻击逻辑
        end
    end
end

function Tower:takeDamage()
    if self.isMainTower then
        self.canAttack = true -- 主塔被攻击后可以攻击
    end
end

function Tower:draw()
    love.graphics.setColor(self.isMainTower and {0, 0.5, 1} or {0, 1, 0}) -- 主塔蓝色，副塔绿色
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Tower