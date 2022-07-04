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
        -- S_Controlls,
        S_MapInterractions,
        S_StateMachine,
        S_HeroWanderSt,
        S_UpdateBumpPosition,
        -- S_StateManager,
        S_PlatformState,
        S_Animate,
        S_Animate_Hero_Atlas,
        S_ClimbCornerAct,
        S_HangPlatformStance,
        S_ClimbPlatformAct,
        S_DuckStance,
        S_ClimbLadderStance
        -- S_Mario_Physic
    )
    self.bump_world=Bump.newWorld(8) -- collisions engine
    -- self.cam=Gamera.new(-2000,-2000,4000,4000)

    --== entities
    self.e_foo=E_Foo(Tl.Dim*18, Tl.Dim*10, 12, Tl.Dim)
    -- self.tiny_world:addEntity(self.e_foo)
    self.map:load()
    --== other
end

function Game:update(dt)
    -- self.e_foo.c_b.x=self.e_foo.c_b.x-50*dt
    self.tiny_world:update()

    -- S_HeroWanderSt:update(dt)
    -- S_HangPlatformStance:update(dt)
    -- S_ClimbCornerAct:update(dt)
    -- S_ClimbPlatformAct:update(dt)
    -- S_DuckStance:update(dt)
    -- S_ClimbLadderStance:update(dt)

    -- S_StateMachineHandler:update(dt)
    S_Physic:update(dt)
    S_Collision:update(dt)
    S_UpdateBumpPosition:update(dt)

    -- S_Controlls:update(dt)
    
    S_StateMachine:update(dt)
    -- S_PlatformState:update(dt)
    S_Animate_Hero_Atlas:update(dt)
    -- S_MapInterractions:update(dt)
end

function Game:draw()
    self.map:draw()
    -- S_DrawBodyOutline:update()

    S_Animate:update(love.timer.getDelta())
end
