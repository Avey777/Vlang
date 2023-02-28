module translate

import net.http
import json



<<<<<<< HEAD:src/transltate/vweb_translate.v
fn main() {
	// app := App{}
	// vweb.run(app, http_port)
	vweb.run(&App{}, http_port)
}

['/index';get;post]
pub fn (mut app App) index() !vweb.Result {


	mut response := request(get_tk,q)!
	if app.status == '200 OK'{

	mut responsejson := json.encode(response)
		return app.json(responsejson)
	}else{
		return app.text("GoogleTranslate 非正常响应")
	}

}

fn request(get_tk string, q string) !string {
=======
pub fn req_gtranslate(get_tk string, q string) !string {
>>>>>>> b87c12e0421b91c6be479530cef3c904c2d01a56:src/translate/gtranslate.v
	// get_tk := '859249.762488'
	// q := '我'

	// get_tk := '193286.281871'
	// q := '我是最好的中国人'

	mut req := http.Request{
		method: http.Method.get
		url: 'https://translate.google.com/translate_a/single?client=webapp&sl=zh-CN&tl=en&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=sos&dt=ss&dt=t&otf=2&ssel=0&tsel=0&kc=3&tk=' + get_tk + '&q=' + q

		// url: "https://ms-43c9c269b6b3-327.lon.meilisearch.io/indexes/tospinomall/documents"
		// data: "{'id': '6204', 'tsin': 'SPU000280COEY'}" // 此样式不可用
		// data: '{"id": "6204", "tsin": "SPU000280COEY"}'
		// data: data
	}
	// req.add_custom_header('Content-Type', 'application/json')!
	req.add_custom_header('user-agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36')!
	req.add_custom_header('referer', 'https://translate.google.cn/')!
	reponse := req.do()!
	// println("打印req:$reponse")
	return json.encode(reponse.body)
}


/*

# 配置http访问的;# 配置https访问的
export http_proxy=http://127.0.0.1:32345
export https_proxy=http://127.0.0.1:32345
# 配置http和https访问
export all_proxy=socks5://127.0.0.1:32346

# ip代理查询
curl cip.cc
curl ipinfo.io
#查看是否可以访问google
curl -v google.com
*/

/*
配置 Git 代理

执行如下命令可设置代理：
git config --global http.proxy http://127.0.0.1:1088
git config --global https.proxy https://127.0.0.1:1088

执行如下命令则取消代理：
git config --global --unset http.proxy
git config --global --unset https.proxy

*/