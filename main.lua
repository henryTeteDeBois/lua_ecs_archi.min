--== conf
love.graphics.setDefaultFilter("nearest", "nearest");
love.filesystem.setRequirePath('lib/?.lua;lib/hump/?.lua;')
io.stdout:setvbuf("no")
--== libs
V2 = require 'hump.vector';
Bump = require 'bump';
Tiny = require 'tiny';
Timer = require 'hump.timer';
Signal = require 'hump.signal';
Class = (require 'luaoop').class
Gamera = require 'gamera'
--== game
require 'component'
require 'entity'
require 'system'
require 'system_collision'
require 'system_physic'
require 'map'
require 'game'

Game = Game()

function love.graphics.load()
    Game:load()
end

function love.graphics.update()
    Game:update()
end

function love.graphics.draw()
    Game:draw()
end