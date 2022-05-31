--===================================--
-- config
love.graphics.setDefaultFilter("nearest", "nearest");
love.filesystem.setRequirePath('lib/?.lua;lib/hump/?.lua;')
io.stdout:setvbuf("no")
--===================================--
-- libs
V2 = require 'hump.vector';
Bump = require 'bump';
Tiny = require 'tiny';
Timer = require 'hump.timer';
Signal = require 'hump.signal';
Class = (require 'luaoop').class
Gamera = require 'gamera'
XType = require "xtype"

--===================================--
-- GAME
require 'component'
require 'component_body'
require 'entity'
require 'system'
require 'system_collision'
require 'system_physic'
require 'map'
require 'game'

GAME = Game()

function love.load()
    GAME:load()
end

function love.update(dt)
    GAME:update()
end

function love.draw()
    GAME:draw()
end