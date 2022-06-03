Game=Class('Game')

function Game:__construct()
    self.tiny_world=nil
    self.bump_world=nil
    self.cam=nil
    self.map=Map()
    --== entities
    self.e_foo=nil
end

function Game:load()
    --== libs
    self.tiny_world=Tiny.world( -- ECS engine
        S_DrawBodyOutline,
        S_Collision,
        S_Physic,
        S_Mario_Physic
    )
    self.bump_world=Bump.newWorld(8) -- collisions engine
    -- self.cam=Gamera.new(-2000,-2000,4000,4000)

    --== entities
    self.e_foo=E_Foo(50, 50, 16, 16)
    -- self.tiny_world:addEntity(self.e_foo)
    self.map:load()
    --== other
end

function Game:update(dt)
    -- self.e_foo.c_b.x=self.e_foo.c_b.x-50*dt
    self.tiny_world:update()

    S_Physic:update(dt)
    S_Mario_Physic:update(dt)
    S_Collision:update(dt)
end

function Game:draw()
    self.map:draw()
    S_DrawBodyOutline:update()
end
