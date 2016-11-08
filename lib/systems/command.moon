System = require('vendor/secs/lib/system')

class CommandSystem extends System

	@criteria: System.Criteria({ 'commandQueue' })

	update: (dt) =>
		for entity in *@entities
			{ :commandQueue } = entity\get()

			for command in entity.commandQueue\process()
				command\exec()
