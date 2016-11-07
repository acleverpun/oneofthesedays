System = require('vendor/secs/lib/system')

class CommandSystem extends System

	@criteria: System.Criteria({ 'commandQueue' })

	update: (dt) =>
		for entity in *@entities
			{ :commandQueue } = entity\get()

			while #commandQueue > 0
				command = commandQueue[1]
				command\exec()
				table.remove(commandQueue)
