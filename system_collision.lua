S_Collision=Tiny.processingSystem()
S_Collision.active=false;

function S_Collision:filter(e)
    return e:has_active('c_b') and Xtype.is(e, E_Foo)
end

function S_Collision.__filter_colls(e,o)
    local c_b=e.c_b
    if Xtype.is(o, E_Tile) then
        local c_tile = o.c_tile

        if c_tile:has_prop(Tl.Prop.Ground) then
            return 'slide'
        end
    end
end

function S_Collision:process(e, dt)
    local c_b=e.c_b
    local goal_x=c_b.x + c_b.vx * dt
    local goal_y=c_b.y + c_b.vy * dt
    local colls={}

    local c_sm = e.c_state_machine

    goal_x, goal_y, colls, _=GAME.bump_world:check(e, goal_x, goal_y, self.__filter_colls)
    c_b.colls=colls

    --== collision events reset
    c_b.hit_ceil=nil
    c_b.hit_ground=nil

    c_b.can_grab_platform = nil

    --== collisions handling
    for _,coll in ipairs(colls) do
        local o = coll.other
        --== collision avec tiles
        if Xtype.is(o, E_Tile) then
            local tl=o
            local c_tile=o.c_tile

            
        end
    end

    -- c_sm = e.c_state_machine
    -- if c_sm then
    --     local state = c_sm:get()
    --     if Xtype.is(state, C_HangPlatformState) and state.is_climbing then
    --         local coll = state.args.platform_coll
       
    --         goal_y = coll.other.c_b:top()-c_b.h
       
    --       --print('=>',state.args.platform_coll.other)
    --     end
    end

    --== is still on ground ?
    if c_b.on_ground then
        local query_rect_h=2
        --== ground tile below
        local below, below_len=GAME.bump_world:queryRect(goal_x, goal_y+c_b.h, c_b.w, query_rect_h, function(item)
            local c_tile=item.c_tile
            return Xtype.is(item, E_Tile) and c_tile:has_prop(Tl.Prop.Ground)
        end)
        --== empty tile at bottom
        local bottom, bottom_len=GAME.bump_world:queryRect(goal_x, goal_y+c_b.h-query_rect_h, c_b.w, query_rect_h, function(item)
            local c_tile=item.c_tile
            return Xtype.is(item, E_Tile) and c_tile:has_prop(Tl.Prop.Empty)
        end)
        c_b.on_ground=below_len>0 and bottom_len>0
    end
    --== hit ground = on ground
    if c_b.hit_ground then
        c_b.on_ground=true
    end
    --== update actual position
    e.c_b.x=goal_x
    e.c_b.y=goal_y

end





S_UpdateBumpPosition=Tiny.processingSystem()
S_UpdateBumpPosition.active=false;

function S_UpdateBumpPosition:filter(e)
    return e:has_active('c_b') and Xtype.is(e, E_Foo)
end

function S_UpdateBumpPosition:process(e, dt)
    local c_b = e.c_b
    GAME.bump_world:update(e, c_b.x, c_b.y, c_b.w, c_b.h)
end








