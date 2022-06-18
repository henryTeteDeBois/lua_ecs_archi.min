S_Animate=Tiny.processingSystem()
S_Animate.active=false;

function S_Animate:filter(e)
    return e:has_active('c_b','c_anim')
end

function S_Animate:process(e, dt)
    local c_b=e.c_b
    local c_anim=e.c_anim
    local props=c_anim.props

    if not props then return end

    local duration=props.duration

    c_anim.timer=c_anim.timer+dt
    if c_anim.timer > duration then
        if props.loop then
            c_anim.timer=c_anim.timer-duration
        else
            c_anim.timer=duration
        end
    end

    local cur_frame_i = math.ceil(c_anim.timer / (duration / #props.frames))
    local cur_frame=props.frames[cur_frame_i];
    local x = c_b.x+c_b.w*c_anim.ox
    local y = c_b.y+c_b.h*c_anim.oy
    local sx = c_anim.dir

    love.graphics.draw(props.spritesheet, cur_frame.quad, x, y, 0, sx, 1, cur_frame.ox, cur_frame.h)
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

    if c_b.on_ground then

        if love.keyboard.isDown('left') then
            c_anim:set('run')
            c_anim.dir=-1
        elseif love.keyboard.isDown('right') then
            c_anim:set('run')
            c_anim.dir=1
        else
            c_anim:set('idle')
        end
    end
end