paths = {
	'./vendor/?.lua',
	 package.path
}
package.path = table.concat(paths, ';')

require('src/game')
