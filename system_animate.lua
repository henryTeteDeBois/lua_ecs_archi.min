S_Animate=Tiny.processingSystem()
S_Animate.active=false;

function S_Animate:filter(e)
    return e:has_active('c_b','c_anim')
end

function S_Animate:process(e, dt)
    local c_b=e.c_b
    local c_anim=e.c_anim
    local props=c_anim.props
    local duration=0

    if not props then return end

    duration=props.duration
    if not c_anim.is_paused then

        c_anim.timer=c_anim.timer+dt
        if c_anim.timer > duration then
            if props.__loop then
                c_anim.timer=c_anim.timer-duration
            else
                c_anim.is_over=true
                c_anim.timer=duration
            end
        end
    end

    local cur_frame_i = math.ceil(c_anim.timer / (duration / #props.frames))

    if c_anim.timer == 0 then
        cur_frame_i=1
    end
    local cur_frame=props.frames[cur_frame_i];
    local x = c_b.x+c_b.w*c_anim.ox
    local y = c_b.y+c_b.h*c_anim.oy
    local sx = c_anim.dir

    if cur_frame then
        love.graphics.draw(props.spritesheet, cur_frame.quad, x, y, 0, sx, 1, cur_frame.ox, cur_frame.h)        
    end
end

--===================================#
--

S_Animate_Hero_Atlas=Tiny.processingSystem()
S_Animate_Hero_Atlas.active=false;

function S_Animate_Hero_Atlas:filter(e)
    return e:has_active('c_b','c_anim') and e.c_anim.atlas == Atlas.Hero
end

function S_Animate_Hero_Atlas:process(e, dt)
    local c_b = e.c_b
    local c_anim = e.c_anim
    local c_sm = e.c_state_machine

    local state = c_sm:get()
    local args = state.args

    if c_sm:is(C_ClimbCornerAct) then
        local coll = args.coll

        if state.on_enter then
            
            if c_b.vx > 0 then -- pourri
                c_anim.dir = 1
            elseif c_b.vx < 0 then
                c_anim.dir = -1
            end

            if coll.normal.x == -1 then
                c_anim:set('climb_corner', 1.05, 0.95)
            else
                c_anim:set('climb_corner', -0.05, 0.95)
            end
        end
    
    elseif c_sm:is(C_HangPlatformStance) then
        if state.on_enter then
            c_anim:set('platf_move')
        end
        if state.on_update then
            if c_b.vx > 0 then
                c_anim.dir = 1
            elseif c_b.vx < 0 then
                c_anim.dir = -1
            end
            if c_b.vx ~= 0 then
                c_anim:play()
            else
                c_anim:pause()
            end
        end

    elseif c_sm:is(C_ClimbPlatformAct) then
        if state.on_enter then
            c_anim:set('platf_climb')
        end

    elseif c_sm:is(C_HeroWanderSt) then
        
        if c_b.vx > 0 then
            -- print(c_b.vx)
            c_anim.dir = 1
            c_anim:set('run')
        elseif c_b.vx < 0 then
            -- print(c_b.vx)

            c_anim.dir = -1
            c_anim:set('run')
        else
            c_anim:set('idle')
        end
    
    elseif c_sm:is(C_DuckStance) then
        if state.on_enter then
            c_anim:set('duck')
        end
    end

end