local Tower = require("src.entities.tower")
local Enemy = require("src.entities.enemy")

local mapWidth = 21
local mapHeight = 9
local tileSize = 32
local screenWidth = mapWidth * tileSize
local screenHeight = mapHeight * tileSize

local towers = {}
local enemies = {}

function love.load()
    love.window.setTitle("My Tower Defense Game")
    love.window.setMode(screenWidth, screenHeight)

    -- 初始化塔
    table.insert(towers, Tower:new(
        0, -- x
        (mapHeight - 3) / 2 * tileSize, -- y
        3 * tileSize, -- width
        3 * tileSize, -- height
        6 * tileSize, -- attackRange
        true -- isMainTower
    )) -- 主塔

    table.insert(towers, Tower:new(
        4 * tileSize, -- x
        0, -- y
        3 * tileSize, -- width
        3 * tileSize, -- height
        3 * tileSize, -- attackRange
        false -- isMainTower
    )) -- 上方副塔

    table.insert(towers, Tower:new(
        4 * tileSize, -- x
        (mapHeight - 3) * tileSize, -- y
        3 * tileSize, -- width
        3 * tileSize, -- height
        3 * tileSize, -- attackRange
        false -- isMainTower
    )) -- 下方副塔

    -- 生成敌人
    for i = 1, math.random(3, 5) do
        table.insert(enemies, Enemy:new(
            (mapWidth - 1) * tileSize, -- x
            math.random(0, mapHeight - 1) * tileSize, -- y
            tileSize, -- size
            math.random(1, 2) * tileSize, -- speed
            math.random(2, 5) -- health
        ))
    end
end

function love.update(dt)
    -- 更新敌人逻辑
    for _, enemy in ipairs(enemies) do
        enemy:update(dt)
        enemy:moveTowardsPlayer(towers)
        enemy:attack(towers)
    end

    -- 更新塔逻辑
    for _, tower in ipairs(towers) do
        tower:attack(enemies)
    end
end

function love.draw()
    -- 绘制地图
    for x = 0, mapWidth - 1 do
        for y = 0, mapHeight - 1 do
            local color = (x + y) % 2 == 0 and {0.8, 0.8, 0.8} or {0.6, 0.6, 0.6}
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", x * tileSize, y * tileSize, tileSize, tileSize)
        end
    end

    -- 绘制塔
    for _, tower in ipairs(towers) do
        tower:draw()
    end

    -- 绘制敌人
    for _, enemy in ipairs(enemies) do
        enemy:draw()
    end
end