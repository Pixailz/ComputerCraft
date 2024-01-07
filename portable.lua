-- INIT
local	apis_folder = "/"..shell.dir().."/api"
local	test_folder = "/"..shell.dir().."/test"

function	include()
	os.loadAPI(apis_folder.."/Config")
	Config.profile = "server"

	os.loadAPI(apis_folder.."/Monitor")
	os.loadAPI(apis_folder.."/Periph")

	os.loadAPI(apis_folder.."/Terminate")
	os.loadAPI(apis_folder.."/Bigint")
	os.loadAPI(test_folder.."/TBigint")
	os.loadAPI(apis_folder.."/Drive")

	os.loadAPI(apis_folder.."/Key")
	os.loadAPI(apis_folder.."/Modem")

	os.loadAPI(apis_folder.."/Info")
	os.loadAPI(apis_folder.."/InfoReactor")

	os.loadAPI(apis_folder.."/Server")
	os.loadAPI(apis_folder.."/Monitoring")

	os.loadAPI(apis_folder.."/Client")
end

include()

-- MAIN

-- parallel.waitForAll(Client.run, Terminate.handle)
