-- NAMING CONVENTION

-- variables/functions: snake_case.
-- constants: UPPER_CASE.
-- classes: PascalCase.
-- private: __snake_case.

--===================================#
-- config
if arg[#arg] == "vsc_debug" then require("lldebugger").start() end
love.graphics.setDefaultFilter("nearest", "nearest");
love.filesystem.setRequirePath('lib/?.lua;lib/hump/?.lua;')
io.stdout:setvbuf("no")
--===================================#
-- libs
V2=require 'hump.vector';
Bump=require 'bump';
Tiny=require 'tiny';
Timer=require 'hump.timer';
Signal=require 'hump.signal';
Class=(require 'luaoop').class
Gamera=require 'gamera'
Xtype=require "Xtype"
Bit=require 'bit'
--===================================#
-- GAME
require 'anim_atlas'
require 'component'
require 'component_body'
require 'component_states'
require 'entity'
require 'system'
require 'system_collision'
require 'system_physic'
require 'system_states'
require 'map'
require 'game'
require 'system_mario_physic'
require 'system_controlls'
require 'system_map_interractions'
require 'system_animate'


GAME=Game()

function love.load()
    GAME:load()
end

function love.update(dt)
    GAME:update(dt)
end

function love.draw()
    GAME:draw()
end