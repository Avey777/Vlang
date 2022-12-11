// blog.v
module main

import vweb

struct App {
	vweb.Context
}

fn main() {
	app := App{}
	vweb.run(app, 8081)
}

['/index']
pub fn (mut app App) index() vweb.Result {
	return app.text('Hello world from vweb!')
}