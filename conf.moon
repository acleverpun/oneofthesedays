testFile = (name) ->
	f = io.open('dist/' .. name, 'r')
	if f != nil then io.close(f), true else false

love.conf = (conf) ->
	conf.version = '0.10.1'

	conf.window.title = 'One of these days'

	conf.modules.audio = false
	conf.modules.joystick = false

	localConf = 'local-conf'
	if testFile(localConf .. '.lua') then require(localConf)(conf)
