import vweb
import json
// import Vlang.src.translate
import Vlang.src.meilisearch

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
pub fn (mut app App) meilisearch() vweb.Result {

	mut sqldata := meilisearch.sqlquery('1','1000')!
	mut jsonstr := json.encode(sqldata) //将[]map[string]string 数据类型 编码为 json 数据类型
	// reponse := request(jsonstr)!
	// println(reponse)
	return app.json("jsonstr")

}

// ['/translate']
// pub fn (mut app App) translate() !string {
// 	r := translate.request()!
// 	println(r)
// }