Game = Class('Game')

function Game:__construct()
    self.tiny_world = nil
    self.bump_world = nil
    self.cam = Gamera.new(-2000,-2000,4000,4000)

    -- self.map = nil,
end

function Game:load()
    self.tiny_world = Tiny.world()
    self.bump_world = Bump.newWorld(8);
end

function Game:update()
end

function Game:draw()
end
