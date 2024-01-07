-- INIT

os.loadAPI("/"..shell.dir().."/api".."/Config")

Config.profile = "server"

Config.api_dir = "/"..shell.dir().."/api"
Config.test_dir = "/"..shell.dir().."/test"

os.loadAPI(Config.api_dir.."/Include")

-- MAIN

-- parallel.waitForAll(Server.listen, Server.monitor, Terminate.handle)

function	monitor_button(mon)
	while Config.running do
		local	event, side, x, y = os.pullEvent("monitor_touch")

		if side == Config.counter.side then
			if Config.counter["button"]["dec"]["x"] == x and Config.counter["button"]["dec"]["y"] == y then
				Counter.dec(Config.counter.side)
			elseif Config.counter["button"]["inc"]["x"] == x and Config.counter["button"]["inc"]["y"] == y then
				Counter.inc(Config.counter.side)
			elseif Config.counter["button"]["rst"]["x"] == x and Config.counter["button"]["rst"]["y"] == y then
				Counter.rst(Config.counter.side)
			elseif Config.counter["button"]["set"]["x"] == x and Config.counter["button"]["set"]["y"] == y then
				Counter.set(Config.counter.mon, Config.counter.side)
			end
		end
	end
end

function	print_button(x, y, color)
	Config.counter.mon.setCursorPos(x, y)
	Monitor.pc(Config.counter.mon, " ", colors.white, color);
end

function	monitor_counter(mon)
	Counter.new(Config.counter.side);
	while Config.running do
		print_button(Config.counter["button"]["inc"]["x"], Config.counter["button"]["inc"]["y"], Config.counter["button"]["inc"]["color"])
		print_button(Config.counter["button"]["dec"]["x"], Config.counter["button"]["dec"]["y"], Config.counter["button"]["dec"]["color"])
		print_button(Config.counter["button"]["rst"]["x"], Config.counter["button"]["rst"]["y"], Config.counter["button"]["rst"]["color"])
		print_button(Config.counter["button"]["set"]["x"], Config.counter["button"]["set"]["y"], Config.counter["button"]["set"]["color"])

		Config.counter.mon.setCursorPos(7, 1)
		Monitor.p(Config.counter.mon, Counter.get(Config.counter.side));

		os.sleep(1/20)
		while Config.counter.reading do
			os.sleep(1/20)
		end
		Config.counter.mon.setCursorPos(1, 1)
		Monitor.p(Config.counter.mon, string.rep(" ", 20));
	end
end

Config.counter = {}

Config.counter["mon"] = Monitor.counter
Config.counter["side"] = Config.conf[Config.profile]["monitor"]["id_counter"]
Config.counter["button"] = {}
Config.counter["reading"] = false

Config.counter["button"]["set"] = {}
Config.counter["button"]["set"]["x"] = 2
Config.counter["button"]["set"]["y"] = 1
Config.counter["button"]["set"]["color"] = colors.blue

Config.counter["button"]["rst"] = {}
Config.counter["button"]["rst"]["x"] = 3
Config.counter["button"]["rst"]["y"] = 1
Config.counter["button"]["rst"]["color"] = colors.purple

Config.counter["button"]["dec"] = {}
Config.counter["button"]["dec"]["x"] = 4
Config.counter["button"]["dec"]["y"] = 1
Config.counter["button"]["dec"]["color"] = colors.red

Config.counter["button"]["inc"] = {}
Config.counter["button"]["inc"]["x"] = 5
Config.counter["button"]["inc"]["y"] = 1
Config.counter["button"]["inc"]["color"] = colors.green

parallel.waitForAny(monitor_button, monitor_counter)
