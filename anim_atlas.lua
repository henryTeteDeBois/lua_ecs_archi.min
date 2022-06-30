AnimProp = Class('AnimProp')

function AnimProp:__construct(spritesheet)
    self.spritesheet=spritesheet
    self.frames={}
    self.duration=0
    self.__loop=false
    return self
end

function AnimProp:contiguous(offset, frame_size, frame_cnt, duration_ms)
    self.duration=duration_ms/1000
    for i=1, frame_cnt do
        local frame_offset_x = offset.x+(i-1)*frame_size.x
		local quad = love.graphics.newQuad(frame_offset_x, offset.y, frame_size.x, frame_size.y,  self.spritesheet:getDimensions())
        self.frames[i]=AnimFrame(quad, frame_size.x, frame_size.y)
	end
    return self
end

function AnimProp:loop()
    self.__loop=true
    return self
end

function AnimProp:dup(frame_i, ntime)
    local ntime=ntime or 1
    for i=1, ntime do
        table.insert(self.frames, frame_i+1, self.frames[frame_i])
    end
    return self
end


--===================================#
--

AnimFrame = Class('AnimFrame')

function AnimFrame:__construct(quad, w, h)
    self.quad=quad
    self.w=w
    self.h=h
    self.ox=w*.5
end

--===================================#
--

Spritesheet={
    Hero=love.graphics.newImage('asset/hero.png')
}

Atlas={
    Hero={}
}
Atlas.Hero['idle']=AnimProp(Spritesheet.Hero):contiguous(V2(0,0), V2(32,38),  9, 700):loop()
Atlas.Hero['run']=AnimProp(Spritesheet.Hero):contiguous(V2(0,38), V2(32,32), 12, 1000):loop()
Atlas.Hero['platf_move']=AnimProp(Spritesheet.Hero):contiguous(V2(0,70), V2(32,32), 6, 1200):loop()
Atlas.Hero['platf_climb']=AnimProp(Spritesheet.Hero):contiguous(V2(331,451), V2(32,50), 5, 400)
Atlas.Hero['duck']=AnimProp(Spritesheet.Hero):contiguous(V2(224,70), V2(32,32), 2, 80)
Atlas.Hero['climb_corner']=AnimProp(Spritesheet.Hero):contiguous(V2(0,451), V2(34,61), 9, 500 ):dup(2, 1):dup(8, 1)
