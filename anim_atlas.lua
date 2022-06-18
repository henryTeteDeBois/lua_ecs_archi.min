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
Atlas.Hero['idle']=AnimProp(Spritesheet.Hero):contiguous(V2(0,0), V2(32,38), 9, 700):loop()
Atlas.Hero['run']=AnimProp(Spritesheet.Hero):contiguous(V2(0,38), V2(32,32), 12, 1000):loop()
