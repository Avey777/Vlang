import vweb
import json
import translate {req_gtranslate}
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

	req := mysql_write_meili()!
	return app.json(req)
}



const (
	get_tk		= '193286.281871'
	q 			= '我是最好的中国人'
)

['/gtranslate';get;post]
pub fn (mut app App) gtranslate() !vweb.Result {

	mut response := req_gtranslate(get_tk,q)!
	if app.status == '200 OK'{
	
	mut responsejson := json.encode(response)
		return app.json(responsejson)
	}else{
		return app.text("GoogleTranslate 非正常响应")
	}
	return app.json(response)
}