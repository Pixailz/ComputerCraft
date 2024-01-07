function	rm(path)
	if fs.exists(path) then
		shell.run("rm "..path)
	end
end

function mkdir(path)
	if not fs.exists(path) then
		shell.run("mkdir "..path)
	end
end

local	ip = "IP:PORT"
local	base_url = "http://"..ip

local	base_dir = "/"..shell.dir()
local	api_dir = base_dir.."/api"
local	test_dir = base_dir.."/test"

function	wget(file)
	rm(base_dir..file)
	shell.run("wget "..base_url..file.." "..base_dir..file)
end

-- API

mkdir("/key")
mkdir(api_dir)

wget(api_dir.."/Include")

wget(api_dir.."/Config")
wget(api_dir.."/Monitor")
wget(api_dir.."/Periph")

wget(api_dir.."/Terminate")
wget(api_dir.."/Bigint")
wget(test_dir.."/TBigint")
wget(api_dir.."/Drive")
wget(api_dir.."/Counter")

wget(api_dir.."/Key")
wget(api_dir.."/Modem")

wget(api_dir.."/Info")
wget(api_dir.."/InfoReactor")

wget(api_dir.."/Server")
wget(api_dir.."/Monitoring")

wget(api_dir.."/Client")

-- MAINS

wget("/client.lua")
wget("/server.lua")
wget("/portable.lua")

