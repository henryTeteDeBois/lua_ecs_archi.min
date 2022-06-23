S_Controlls=Tiny.processingSystem()
S_Controlls.active=false;

function S_Controlls:filter(e)
    return e:has_active('c_b', 'c_state_machine') and Xtype.is(e, E_Foo)
end

--== stance hub
function S_Controlls:process(e, dt)
    local c_b=e.c_b
    local c_sm = e.c_state_machine

    local pad_r=love.keyboard.isDown('right')
    local pad_l=love.keyboard.isDown('left')
    local pad_d=love.keyboard.isDown('down')
    local pad_u=love.keyboard.isDown('up')
    local pad_a=love.keyboard.isDown('space')



    if c_sm:is(C_HeroWanderSt) then
        if c_b.on_ground then
            
        else
            --== hang to platform
            if e.has_active('c_hang_platform_stance') and e.c_hang_platform_stance.is_entering_ok then
                    c_sm:set(e.c_hang_platform_stance, {coll=e.c_hang_platform_stance.platform_coll})                    

            --== climb corner
            elseif e.has_active('c_climb_corner_act') and e.c_climb_corner_act.is_entering_ok then
                local nx = e.c_climb_corner_act.corner_coll.normal.x
                if (nx == -1 and pad_r) or (nx == 1 and pad_l) then
                    c_sm:set(e.c_climb_corner_act, {coll=e.c_climb_corner_act.corner_coll})
                end
            end
        end
    end

    -- if e.has_active('c_climb_corner_act') and e.c_climb_corner_act.is_entering_ok then
    --     local nx = e.c_climb_corner_act.corner_coll.normal.x
    --     if (nx == -1 and pad_r) or (nx == 1 and pad_l) then
    --         c_sm:set(e.c_climb_corner_act, {coll=e.c_climb_corner_act.corner_coll})
    --     end
    -- end

end
