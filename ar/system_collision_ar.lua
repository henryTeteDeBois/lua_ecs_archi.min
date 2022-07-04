S_Collision=Tiny.processingSystem()
S_Collision.active=false;

function S_Collision:filter(e)
    return e:has_active('c_b') and Xtype.is(e, E_Foo)
end

function S_Collision.__filter_colls(e,o)
    local c_b=e.c_b
    if Xtype.is(o, E_Tile) then
        local c_tile = o.c_tile

        if c_tile:has_prop(Tl.Prop.Platform) then
            return 'cross'
        end

        if c_tile:has_prop(Tl.Prop.Ground) then
            return 'slide'
        end

        if c_tile:has_prop(Tl.Prop.Wall) then
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

    if e.has_active('c_climb_corner_act') then
        e.c_climb_corner_act.is_entering_ok = false
    end

    if e.has_active('c_hang_platform_stance') then
        e.c_hang_platform_stance.is_entering_ok = false
    end

    --== collisions handling
    for _,coll in ipairs(colls) do
        local o = coll.other
        --== collision avec tiles
        if Xtype.is(o, E_Tile) then
            local tl=o
            local c_tile=o.c_tile

            --== hang to platform
            if e.has_active('c_hang_platform_stance') and e.c_hang_platform_stance.can_enter then
                if c_b.vy > 0 and c_tile:has_prop(Tl.Prop.Platform) then
                    if goal_y > tl.c_b:top()-2 and goal_y < o.c_b:top()+4 then
                        e.c_hang_platform_stance.is_entering_ok = true
                        e.c_hang_platform_stance.platform_coll = coll
                    end
                end
            end

            --== hit corner wall
            if e.has_active('c_climb_corner_act') and c_b.vy > 0 and coll.normal.x ~= 0 then
                if GAME.map:is_tl_corner_wall(c_tile.index.x, c_tile.index.y, -coll.normal.x) then
                    
                    if goal_y > o.c_b:top()-4 and goal_y < o.c_b:top()+6 then
                        e.c_climb_corner_act.is_entering_ok = true
                        e.c_climb_corner_act.corner_coll=coll
                    end
                
                end
            end

            --== hit ground
            if coll.normal.y == -1 then

                if c_tile:has_prop(Tl.Prop.Platform) then
                    if goal_y+c_b.h < tl.c_b:top()+6 and not c_b.ignore_platform then
                        c_b.hit_ground=true
                        goal_y=tl.c_b:top()-c_b.h
                        print('hit ground1')
                    end

                elseif c_tile:has_prop(Tl.Prop.Ground) then
                    c_b.hit_ground=true
                    print('hit ground2')
                end
            end
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
    -- end

    --== is still on ground ?
    if c_b.on_ground and not c_b.ignore_platform then
        local query_rect_h=2
        
        --== ground tile below
        local below, below_len=GAME.bump_world:queryRect(goal_x, goal_y+c_b.h, c_b.w, query_rect_h, function(item)
            local c_tile=item.c_tile
            return Xtype.is(item, E_Tile) and c_tile:has_prop(Tl.Prop.Ground)
        end)
        --== empty tile at bottom
        local bottom_empty, bottom_empty_len=GAME.bump_world:queryRect(goal_x, goal_y+c_b.h-query_rect_h, c_b.w, query_rect_h, function(item)
            local c_tile=item.c_tile
            return Xtype.is(item, E_Tile) and c_tile:has_prop(Tl.Prop.Empty)
        end)
        c_b.on_ground=bottom_empty_len>0 and below_len>0
        
        --== is ground platform
        below, below_len=GAME.bump_world:queryRect(goal_x, goal_y+c_b.h, c_b.w, query_rect_h, function(item)
            local c_tile=item.c_tile
            return Xtype.is(item, E_Tile) and not c_tile:has_prop(Tl.Prop.Platform) and not c_tile:has_prop(Tl.Prop.Empty)
        end)
        c_b.standing_on_platform = below_len==0 and bottom_empty_len>0
         
        --== is ground ladder
        below, below_len=GAME.bump_world:queryRect(goal_x, goal_y+c_b.h, c_b.w, query_rect_h, function(item)
            local c_tile=item.c_tile
            return Xtype.is(item, E_Tile) and c_tile:has_prop(Tl.Prop.Ladder)
        end)
        c_b.standing_on_ladder = below_len>0 and bottom_empty_len>0
    else
        c_b.on_ground=false
    end
    --== hit ground = on ground
    if c_b.hit_ground then
        c_b.on_ground=true
    end
    

    if  c_b.ignore_platform == true then
        local query_rect_h=2
        --== empty tile at bottom
        local below_empty, below_empty_len=GAME.bump_world:queryRect(goal_x, goal_y+c_b.h, c_b.w, query_rect_h, function(item)
            local c_tile=item.c_tile
            if Xtype.is(item, E_Tile) then
                -- print(c_tile:has_prop(Tl.Prop.Empty), c_tile.index.x, c_tile.index.y, c_tile.type)
            end
            return Xtype.is(item, E_Tile) and not c_tile:has_prop(Tl.Prop.Empty)
        end)

        local bottom_platf, bottom_platf_len=GAME.bump_world:queryRect(goal_x, goal_y+c_b.h-query_rect_h, c_b.w, query_rect_h, function(item)
            local c_tile=item.c_tile
            if Xtype.is(item, E_Tile) then
                -- print(c_tile:has_prop(Tl.Prop.Empty), c_tile.index.x, c_tile.index.y, c_tile.type)
            end
            return Xtype.is(item, E_Tile) and c_tile:has_prop(Tl.Prop.Platform)
        end)

        print(bottom_platf_len , below_empty_len )
        if bottom_platf_len > 0 and below_empty_len == 0 then
            print('c_b.ignore_platform = false')
            c_b.ignore_platform = false          
        end
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







