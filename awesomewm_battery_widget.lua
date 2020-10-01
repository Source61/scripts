-- Battery widget for awesomeWM on Linux

	local adapter = "BAT0"

	local fcur = io.open("/sys/class/power_supply/"..adapter.."/charge_now")    
	local fcap = io.open("/sys/class/power_supply/"..adapter.."/charge_full")
	local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
	if fcur and fcap and fsta then
		local cur = fcur:read()
		local cap = fcap:read()
		local sta = fsta:read()
		local battery = math.floor(cur * 100 / cap)
		fcur:close()
		fcap:close()
		fsta:close()
		if sta == 'Charging' or sta == 'Unknown' then
			if battery > 80 then
				print "charging over 80 "
			elseif battery > 60 then
				print "charging over 60"
			elseif battery > 40 then
				print "charging over 40"
			elseif battery > 20 then
				print "charging over 20"
			else
				print "charging critical"
			end
		elseif sta == 'Discharging' then
			if battery > 80 then
				print "over 80"
			elseif battery > 60 then
				print "over 60"
			elseif battery > 40 then
				print "over 40"
			elseif battery > 20 then
				print "over 20"
			else
				print "critical"
			end
		elseif sta == 'Full' then
			print("full " .. sta)
		else
			print("missing " .. sta)
		end
	else
		wbattery.text = 0
	end
