{ Engine: ToysEngine } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')

class Engine extends ToysProxy(ToysEngine)
