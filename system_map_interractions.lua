S_MapInterractions=Tiny.processingSystem()
S_MapInterractions.active=false;

function S_MapInterractions:filter(e)
    return e:has_active('c_b') and Xtype.is(e, E_Foo)
end

function S_MapInterractions:process(e, dt)

    
end