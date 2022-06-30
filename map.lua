Map=Class('Map')

--== Tl <=> TiLe
Tl={}
Tl.Type={Err=1,Empty=2,Wall=3,Platform=4,LadW=5,Lad=6}
Tl.Prop={Ground=1,Ceil=2,Platform=4,Ladder=8,Wall=16, Empty=32}
Tl.Dim=32

function Map:__construct()
    self.x=0
	self.y=0
	self.iw=0
	self.ih=0
    self.__grid={}
    self.__scheme={}
    --== tileset
    self.__tileset_img=love.graphics.newImage('asset/tileset-judo-commando.png')
    self.__tileset_str='x #=^"'
    self.__tileset_quads={}
    for i=0, #self.__tileset_str-1 do
		self.__tileset_quads[i+1]=love.graphics.newQuad(i*Tl.Dim, 0, Tl.Dim, Tl.Dim, self.__tileset_img:getDimensions())
	end
    --==
    self.__scheme={
        '#                       #',
        '#                       #',
        '#                       #',
        '#                       #',
        '#                       #',
        '#                       #',
        '#                       #',
        '#                       #',
        '#                       #',
        '#                       #',
        '#       ====            #',
        '#                       #',
        '#                       #',
        '#   ###====   ^##       #',
        '#             "    ##   #',
        '#             "         #',
        '#########################',
    }
end

function Map:load()
    self.iw=#self.__scheme[1]
	self.ih=#self.__scheme
    --==
	for y=1, self.ih do
		self.__grid[y]={}
		for x=1, self.iw do
			local tile_char=string.sub(self.__scheme[y], x, x)
			for i=1, #self.__tileset_str do
				if (tile_char == string.sub(self.__tileset_str, i, i)) then
                    self.__grid[y][x]=E_Tile(x, y, i)
					break
				end
			end
		end
	end
end

function Map:draw()
    for y=1, self.ih do
		for x=1, self.iw do
			local e_tile=self.__grid[y][x]
			if e_tile then
                local c_tile=e_tile.c_tile
				local quad=self.__tileset_quads[c_tile.type]
                if c_tile.type ~= Tl.Type.Empty then
                    love.graphics.draw(self.__tileset_img, quad, (x-1) * Tl.Dim, (y-1) * Tl.Dim)
                end
			end
		end
	end
end

function Map:is_valid_index(ix, iy)
    return ix>0 and iy>0 and ix<self.iw and iy<self.ih
end

function Map:get_tl_by_index(ix, iy)
    return self:is_valid_index(ix, iy) and self.__grid[iy][ix] or nil
end

function Map:is_tl_corner_wall(ix, iy, dir) --== dir=1 or -1
    local t = self:get_tl_by_index(ix, iy)
    local t_b = self:get_tl_by_index(ix-dir, iy)
    local t_u = self:get_tl_by_index(ix, iy-1)
    local t_bu = self:get_tl_by_index(ix-dir, iy-1)

    if not t or not t_b or not t_u or not t_bu then
        return false
    end

    return  t.c_tile:has_prop(Tl.Prop.Wall) and t_b.c_tile:has_prop(Tl.Prop.Empty) and t_u.c_tile:has_prop(Tl.Prop.Empty) and t_bu.c_tile:has_prop(Tl.Prop.Empty)
end