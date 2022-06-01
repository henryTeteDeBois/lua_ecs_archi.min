S_Collision = Tiny.processingSystem()
S_Collision.active = false;

function S_Collision:filter(e)
    return e:has_active('c_b') and Xtype.is(e, E_Foo)
end

function S_Collision.__filter_colls(e,o)
    -- print(e, o)
    if Xtype.is(e, E_Foo) and Xtype.is(o, E_Tile) and o.type == Tl.Type.Wall then
        -- print('ici')
        return 'slide'
    end
end

function S_Collision:process(e, dt)
    local c_b = e.c_b
    local goal_x = c_b.x
    local goal_y = c_b.y
    local colls = {}
    -- print(e, o)

    goal_x, goal_y, colls, _ = GAME.bump_world:check(e, goal_x, goal_y, self.__filter_colls)

    e.c_b.x = goal_x
    e.c_b.y = goal_y
end




