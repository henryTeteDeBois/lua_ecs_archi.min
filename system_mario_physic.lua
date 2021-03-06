S_Mario_Physic=Tiny.processingSystem()
S_Mario_Physic.active=false;

function S_Mario_Physic:filter(e)
    return e:has_active('c_mario_controls')
end

function S_Mario_Physic:process(e, dt)
    local c_b=e.c_b
    local c_mc=e.c_mario_controls
    local vx=c_b.vx
    local vy=c_b.vy

    local MIN_WALK=4.45
    local MAX_WALK=93.75
    local MAX_RUN=153.75
    local ACC_WALK=133.59/60
    local ACC_RUN=200.39/60
    local DEC_REL=182.81/60
    local DEC_SKID=365.62/60

    local FALL_MIN=30
    local FALL_ACC=400.39/60
    local FALL_MAX=250.75

    local pad_r=love.keyboard.isDown('right')
    local pad_l=love.keyboard.isDown('left')
    local pad_j=love.keyboard.isDown('space')

    -- local acc=0
    -- local dec=0
    
    local abs_vx=math.abs(vx)

    --== on ground
    if c_b.on_ground then
        vy=0
        if pad_j then
            c_mc.state='jump'
        end
        if abs_vx < MIN_WALK then
            c_mc.state='idle'
        elseif abs_vx >= MIN_WALK then
            c_mc.state=(abs_vx < MAX_WALK and 'walk' or 'run')
        end
        
        if abs_vx < MIN_WALK then
            vx=0
        end

        if c_mc.state == 'idle' then
            if pad_r then 
                vx=MIN_WALK
            elseif pad_l then 
                vx=-MIN_WALK
            end
        end
    
        if c_mc.state == 'walk' then
            if pad_r then 
                vx=vx+ACC_WALK
            end
            if pad_l then 
                vx=vx-ACC_WALK
            end
        end
        
        if c_mc.state == 'run' then
            if pad_r then 
                vx=vx+ACC_RUN
            end
            if pad_l then 
                vx=vx-ACC_RUN
            end
    
            if vx > MAX_RUN then
                vx=MAX_RUN
            end
            if vx < -MAX_RUN then
                vx=-MAX_RUN
            end
        end
    
        if vx > 0 and not pad_r then
            if pad_l then
                vx=vx-DEC_SKID
            else
                vx=vx-DEC_REL
            end
        end
    
        if vx < 0 and not pad_l then
            if pad_r then
                vx=vx+DEC_SKID
            else
                vx=vx+DEC_REL
            end
        end
    --== fall
    elseif c_b.on_ground == false then
        vy=vy+FALL_ACC
        if vy > FALL_MAX then
            vy=FALL_MAX
        end
    end

    c_b.vx=vx --+ (acc * dt) - (dec * dt)
    c_b.vy=vy --+ (acc * dt) - (dec * dt)
    c_mc.old_r=pad_r
end