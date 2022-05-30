Entity = Class('Entity')

function Entity:__construct()

end

function Entity:__set_component_active(value, ...)
    local comps_attribute_as_string = {...}
    for _, comp_name in ipairs(comps_attribute_as_string) do
        local comp = self[comp_name]
        if comp then
            comp.active = false
        end
    end
end

function Entity:disable(...)
    self.__set_component_active(false, ...)
end

function Entity:enable(...)
    self.__set_component_active(true, ...)
end

function Entity:has_active(...)
    local comps_attribute_as_string = {...}
    for _, comp_name in ipairs(comps_attribute_as_string) do
        local comp = self[comp_name]
        if not comp or not comp.active then
            return false
        end
    end
    return true
end

--===================================--
--

E_Foo = Class('E_Foo', Entity)

function E_Foo:__construct()
    Entity:__construct()
    self.c_b = C_Body(self)
end

