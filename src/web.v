import vweb
// import json
import translate
import meilisearch {mysql_write_meili}

struct App {
	vweb.Context
}

fn main() {
	app := App{}
	vweb.run(app, 8081)
	
	
}

['/index';get;post]
pub fn (mut app App) index() vweb.Result {
	return app.json('Hello world from vweb!')
}

['/meilisearch';get;post]
pub fn (mut app App) meilisearch() !vweb.Result {

	mut req := mysql_write_meili()!
	if app.status == '200 OK'{
		return app.json(req)
	}else{
		return app.text('Meili 非正常响应')
	}
	// return app.json(req)
}



const (
	get_tk		= '193286.281871'
	q 			= '我是最好的中国人'
)

['/gtranslate';get;post]
pub fn (mut app App) gtranslate() !vweb.Result {

	mut response := translate.req_gtranslate(get_tk,q)!
	if app.status == '200 OK'{
		return app.json(response)
	}else{
		return app.text("GoogleTranslate 非正常响应")
	}
	// return app.json(response)
}