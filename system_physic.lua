S_Physic=Tiny.processingSystem()
S_Physic.active=false;

function S_Physic:filter(e)
    return e:has_active('c_b') and Xtype.is(e, E_Foo)
end

function S_Physic:process(e, dt)
    local c_b=e.c_b

    local RUN_ACC=Tl.Dim*70*dt
    local RUN_DEC=Tl.Dim*40*dt
    local RUN_MAX=Tl.Dim*5
    local RUN_MIN=Tl.Dim*1

    local FALL_ACC=Tl.Dim*30*dt
    local FALL_MAX=Tl.Dim*13

    local pad_r=love.keyboard.isDown('right')
    local pad_l=love.keyboard.isDown('left')
    local pad_d=love.keyboard.isDown('down')
    local pad_u=love.keyboard.isDown('up')
    local pad_a=love.keyboard.isDown('space')

    local vx=c_b.vx
    local vy=c_b.vy

    -- if c_b.state=='ladder' then
    --     e:off('c_gravity')
    -- elseif c_b.state=='platform' then
    --     e:off('c_gravity')
    -- elseif c_b.state=='corner' then
    --     e:off('c_gravity')
    -- end

    -- if c_b.grab_platform_ok then
    --     e:off('c_gravity')
    -- else
    --     e:on('c_gravity')

    --== move
    if e:has_active('c_move_hrz') then
        if pad_r then
            vx=vx+RUN_ACC
            if vx > RUN_MAX then vx=RUN_MAX end
        elseif pad_l then
            vx=vx-RUN_ACC
            if vx < -RUN_MAX then vx=-RUN_MAX end
        end
    end
    --== deceleration
    if vx > 0 then
        if pad_l then
            vx=0
        elseif not pad_r then
            vx=vx-RUN_DEC
            if vx<RUN_MIN then vx=0 end        
        end
    elseif vx < 0 and not pad_l then
        if pad_r then
            vx=0
        elseif not pad_l then
            vx=vx+RUN_DEC
            if vx>RUN_MIN then vx=0 end
        end
    end
    --== jump
    if c_b.on_ground then
        if pad_a then
            vy=-380
        else
            vy=0
        end
    --== fall/gravity
    elseif e:has_active('c_gravity') then
        if c_b.hit_ceil then --== hit plafond
            vy=0
        end
        vy=vy+FALL_ACC
        if vy > FALL_MAX then vy=FALL_MAX end
    elseif not e:has_active('c_gravity') then
        vy=0
    end
    --==
    c_b.vx=vx
    c_b.vy=vy
end