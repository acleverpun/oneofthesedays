{ EventManager: ToysEventManager } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')

class EventManager extends ToysProxy(ToysEventManager)
