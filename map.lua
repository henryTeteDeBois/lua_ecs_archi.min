Map = Class('Map')

--== Tl <=> TiLe
Tl = {}
Tl.Type = {Empty=1, Wall=2}

function Map:__construct()
    self.x=0
	self.y=0
	self.iw=0
	self.ih=0
    self.__grid = {}
    self.__scheme = {}
    --== tileset
    self.__tileset_img=love.graphics.newImage('asset/tileset-mario-min.png')
    self.__tileset_str = ' #'
    self.__tileset_quads = {}
    for i=0, #self.__tileset_str-1 do
        print(i)
		self.__tileset_quads[i+1] = love.graphics.newQuad(i*16, 0, 16, 16, self.__tileset_img:getDimensions())
	end
    --==
    self.__scheme = {
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#                   #####               #',
        '#                                       #',
        '#                                       #',
        '#                                       #',
        '#########################################'
    }
end

function Map:load()
    self.iw = #self.__scheme[1]
	self.ih = #self.__scheme
    --==
	for y=1, self.ih do
		self.__grid[y] = {}
		for x=1, self.iw do
			local tile_char = string.sub(self.__scheme[y], x, x)
			for i=1, #self.__tileset_str do
				if (tile_char == string.sub(self.__tileset_str, i, i)) then
					-- self.__grid[y][x] = i--Tile(self, x, y, i )
						self.__grid[y][x] = E_Tile(x, y, i)
					break
				end
			end
		end
	end
end

function Map:draw()
    for y=1, self.ih do
		for x=1, self.iw do
			local e_tile = self.__grid[y][x]
			if e_tile then
				local quad = self.__tileset_quads[e_tile.type]
                if e_tile.type ~= Tl.Type.Empty then
                    -- print('oo')
                    love.graphics.draw(self.__tileset_img, quad, x * 16, y * 16)
                end
			end
		end
	end
end