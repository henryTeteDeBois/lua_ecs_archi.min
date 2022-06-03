S_Collision=Tiny.processingSystem()
S_Collision.active=false;

function S_Collision:filter(e)
    return e:has_active('c_b') and Xtype.is(e, E_Foo)
end

function S_Collision.__filter_colls(e,o)
    if Xtype.is(e, E_Foo) and Xtype.is(o, E_Tile) and o.type == Tl.Type.Wall then
        -- print(o.ix, o.iy, e.c_b.)
        return 'slide'
    end
end

function S_Collision:process(e, dt)
    local c_b=e.c_b
    local goal_x=c_b.x + c_b.vx * dt
    local goal_y=c_b.y + c_b.vy * dt
    local colls={}

    goal_x, goal_y, colls, _=GAME.bump_world:check(e, goal_x, goal_y, self.__filter_colls)

    for _,coll in ipairs(colls) do
        local o = coll.other
        if Xtype.is(o, E_Tile) then
            if o.type == Tl.Type.Wall and coll.normal.y == -1 then
                c_b.on_ground = true
            end
        end
    end

    c_b.colls = colls

    e.c_b.x=goal_x
    e.c_b.y=goal_y
    GAME.bump_world:update(e, c_b.x, c_b.y, c_b.w, c_b.h)
end




