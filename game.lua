Game = Class('Game')

function Game:__construct()
    self.tiny_world = nil
    self.bump_world = nil
    self.cam = nil
    --== entities
    self.e_foo = nil
end

function Game:load()
    --== libs
    self.tiny_world = Tiny.world() -- ECS
    self.bump_world = Bump.newWorld(8) -- collisions
    self.cam = Gamera.new(-2000,-2000,4000,4000)
    --== entities
    self.e_foo = E_Foo()
    self.e_foo:has_active(C_Body)
    --== other
end

function Game:update()
end

function Game:draw()
end
