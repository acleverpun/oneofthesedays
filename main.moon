paths = {
	'./vendor/?.lua',
	'./vendor/luajson/lua/?.lua',
	'./vendor/love-spriter/?.lua',
	package.path
}
package.path = table.concat(paths, ';')

require('src/game')
