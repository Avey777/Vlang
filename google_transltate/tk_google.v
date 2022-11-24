// fn JS.Math.tan(f64) f64
// fn JS.console.log(string)
// fn tan(x f64) f64 {
//     return f64(JS.Math.tan(x)) // do not forget to wrap return value in `f64` again, atm js gen does not do this automatically
// }
// JS.console.log("hello from js!")

import net.http

fn main(){
	r := request()!
	println(r)
}

fn request() !string {
	get_tk := '859249.762488'
	q := '我'
	mut req := http.Request{
		method: http.Method.get
		url: 'https://translate.google.com/translate_a/single?client=webapp&sl=zh-CN&tl=en&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=sos&dt=ss&dt=t&otf=2&ssel=0&tsel=0&kc=3&tk=' + get_tk + '&q=' + q
		// https://translate.google.com/translate_a/single?client=webapp&sl=zh-CN&tl=en&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=sos&dt=ss&dt=t&otf=2&ssel=0&tsel=0&kc=3&tk=3.97070 &q=我三十岁

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
	return reponse.body
}


// import requests
// import json
// import execjs

// def get_tk(q):
//     with open('google_tk.js', 'r', encoding='utf-8') as f:
//         js = f.read()
//     j = execjs.compile(js)
//     tk = j.call('pu', q)
//     return tk

// def translate_google():
//     q = input("请输入你要翻译的内容：")
//     headers = {
//         "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36",
//         "referer": "https://translate.google.cn/"
//     }
//     url = "https://translate.google.com/translate_a/single?client=webapp&sl=zh-CN&tl=en&hl=zh-CN&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=sos&dt=ss&dt=t&otf=2&ssel=0&tsel=0&kc=3&tk=" + get_tk(
//         q) + "&q=" + q
//     res = requests.get(url, headers=headers)
//     data = res.content.decode()
//     json_data = json.loads(data)
//     print(json_data[0][0][0])

// if __name__ == "__main__":
//     translate_google()

