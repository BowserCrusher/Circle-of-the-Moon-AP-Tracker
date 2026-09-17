-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end
function has_more_then_n_consumable(n)
    local count = Tracker:ProviderCountForCode('consumable')
    local val = (count > tonumber(n))
    if ENABLE_DEBUG_LOG then
        print(string.format("called has_more_then_n_consumable: count: %s, n: %s, val: %s", count, n, val))
    end
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function jumplv1()
	return (has("double") or has("roc"))
end

function jumplv2()
	return (has("roc"))
end

function jumplv3()
	if(has("nerf_roc")) then
		return(has("roc") and (has("double") or has("kick")))
	else
		return(has("roc"))
	end
end

function jumplv4()
	if(has("nerf_roc")) then
		return(has("roc") and has("kick"))
	else
		return(has("roc"))
	end
end

function jumplv5()
	if(has("nerf_roc")) then
		return(has("roc") and has("double") and has("kick"))
	else
		return(has("roc"))
	end
end

function freeze()
    return ((has("mars") or has("mercury")) and (has("serpent") or has("cockatrice")))
  
end
-- jumplv1
function doublejump()
    return ((has("double") or has("roc")))
  
end
--jumplv2 near wall
function walljump()
    return ((has("kick") or has("roc")))
  
end
--jumplv1 or wall jump
function height()
    return ((has("kick") or has("roc") or has("double")))
  
end
--jump lv2
function extraheight()
    return ((has("double") and has("kick")) or has("roc"))
  
end
function cleansed()
    return ((has("cleansing") or has("ignore")))
  
end
function asaccess()
    return (jumplv1() or has("kick"))
  
end
function araccess()
    return (asaccess() and jumplv1())
  
end
function ctaccess()
    return (araccess() and ((jumplv2() and freeze()) or jumplv3() or has("kick")))
  
end
function mtaccess()
    return (araccess() and ((jumplv2() or has("kick")) or has("tackle")))
  
end
function uwaccess()
    return (araccess() and has("push") and has("tackle"))
  
end
function ugwaccess()
    return (araccess() and has("openmaiden") and has("push"))
  
end
function ugeaccess()
    return (((has("double") and has("kick")) or jumplv2()) and has("openmaiden"))
end
function wateraccess()
    return (((has("double") and has("kick")) or jumplv2()) and (asaccess() and has("openmaiden") and has("$cleansed")))
  
end


function keys()
    local keys = Tracker:ProviderCountForCode("last_keys")
    local goal = Tracker:FindObjectForCode("finalkeys").CurrentStage
    if (keys >= (goal + 1)) then
        return true
    else
        return false
    end
  end  
