S_Controlls=Tiny.processingSystem()
S_Controlls.active=false;

function S_Controlls:filter(e)
    return e:has_active('c_b', 'c_state_machine') and Xtype.is(e, E_Foo)
end

function S_Controlls:process(e, dt)
    local c_b=e.c_b
    local c_sm = e.c_state_machine

    local pad_r=love.keyboard.isDown('right')
    local pad_l=love.keyboard.isDown('left')
    local pad_d=love.keyboard.isDown('down')
    local pad_u=love.keyboard.isDown('up')
    local pad_a=love.keyboard.isDown('space')

    -- if c_b.hit_corner then
    --     if (c_b.hit_corner.normal.x==-1 and pad_r) or (c_b.hit_corner.normal.x==1 and pad_l) then
    --         c_sm:set(e.c_climb_corner_state, {corner_coll=c_b.hit_corner})
    --     end
    -- elseif c_b.hit_platform then
    --     c_sm:set(e.c_hang_platform_state)    
    -- elseif c_b.hit_ladder and c_b.on_ground and pad_u then
    --     c_sm:set(e.c_climb_ladder_state)
    -- end

    -- local state = c_sm:get()
    -- if state then
    --     if Xtype.is(state, C_ClimbCornerState) then

    --         local args=state.args
    --         local corner_coll=args.corner_coll
            
    --         if state.on_enter then
    --             e:off('c_gravity')
    --             e:off('C_MoveHrz')
    --             -- c_b.y=(corner_coll.other.c_tile.index.y-1)*Tl.Dim
    --         end

    --         if state.on_update then
                
    --         end

    --         if state.on_exit then
    --         end
        
    --     elseif Xtype.is(state, C_HangPlatformState) then
            
    --         local args=state.args
    --         local corner_coll=args.corner_coll
            
    --         if state.on_enter then
    --             e:off('c_gravity')
                
    --         end

    --         if state.on_update then
                
    --         end

    --         if state.on_exit then
    --         end

    --     elseif Xtype.is(state, C_ClimbLadderState) then
            
    --         local args=state.args
    --         local corner_coll=args.corner_coll
            
    --         if state.on_enter then
    --             e:off('c_gravity')
    --         end

    --         if state.on_update then
                
    --         end

    --         if state.on_exit then
    --         end
    --     end
    -- end

end

S_StateManager=Tiny.processingSystem()
S_StateManager.active=false;

function S_StateManager:filter(e)
    return e:has_active('c_b', 'c_state_machine')
end

function S_StateManager:process(e, dt)
    local c_b = e.c_b
    local c_sm = e.c_state_machine
    
    if c_b.can_grab_platform ~= nil then
      --print('rr',  c_b.can_grab_platform)
        c_sm:set(e.c_hang_platform_state, {platform_coll= c_b.can_grab_platform})
    end


end



S_PlatformState=Tiny.processingSystem()
S_PlatformState.active=false;

function S_PlatformState:filter(e)
    return e:has_active('c_b', 'c_state_machine')
end

function S_PlatformState:process(e, dt)
    local c_b = e.c_b
    local c_sm = e.c_state_machine

    local state = c_sm:get()

    -- if c_b.on_ground then
    --     c_b.platform_land_enabled = true
    -- end

    -- if Xtype.is(state, C_HangPlatformState) then
    --     local args=state.args
    --     local platform_coll=args.platform_coll

    --     if state.on_enter then
    --         e:off('c_gravity')
    --         state.is_climbing = false
    --       --print('on_enter')
    --     end

    --     if state.on_update then
    --         --== check falling
    --         local items,len=GAME.bump_world:queryRect(c_b.x, c_b.y, c_b.w, 20, function(item)
    --             local c_tile=item.c_tile
    --             return Xtype.is(item, E_Tile) and c_tile:has_prop(Tl.Prop.Platform)
    --         end)
    --         c_b.on_platform=len>0
    --         if c_b.on_platform == false then
    --             c_sm:set(nil)
    --         end
    --         if love.keyboard.isDown('down') then
    --             c_sm:set(nil)
    --         end
    --         if love.keyboard.isDown('up') then
    --             state.is_climbing = true
    --             c_sm:set(nil)
    --         end
    --     end

    --     if state.on_exit then
    --         c_b.on_platform = false
    --         c_b.platform_land_enabled = false
    --         e:on('c_gravity')
    --       --print('on_exit')
    --     end
    -- end

end