//v -gc none -autofree rates.v
//v -gc none -autofree run rates.v
module main
import net.http
import json



struct Currency{
    success bool
    aed f64 [json:AED]
    afn f64 [json:AFN]
    all f64 [json:ALL]
}

struct Rates{
    success bool
    cucy Currency [json:'2022-12-15']
}

struct Data{
	success bool
	base string
	rates Rates
}

struct Rts {
	is_loading bool [json:isLoading]
	data Data
}

fn main() {

	reponse := '{
    "isLoading": true,
    "data": {
        "success": true,
        "timeseries": true,
        "start_date": "2022-12-15",
        "end_date": "2023-12-15",
        "base": "GHS",
        "rates": {
            "2022-12-15": {
                "AED": 0.403447,
                "AFN": 9.556748,
                "ALL": 11.808015,
                "AMD": 43.308356,
                "ANG": 0.198057,
                "AOA": 55.406054,
                "ARS": 18.929951,
                "AUD": 0.163815
            },
            "2022-12-16": {
                "AED": 0.410378,
                "AFN": 9.720288,
                "ALL": 12.09449,
                "AMD": 44.182554,
                "ANG": 0.201421,
                "AOA": 56.352001,
                "ARS": 19.266475,
                "AUD": 0.166384
            }
        }
    }
}'

	r := json.decode(Rts,reponse) or {
		eprintln('Failed to decode json, error: ${err}')
		return
	}
	// println(r)
	println(r.data)
	// println(r.rate)

}

fn request() !string {
	mut req := http.Request{
		method: http.Method.get
		url: "https://console-mock.apipost.cn/mock/e8c24164-d42e-43c7-a574-317c768d0142/rate?apipost_id=eca7f5"
		// url: "https://ms-43c9c269b6b3-327.lon.meilisearch.io/indexes/tospinomall/documents"
		// data: "{'id': '6204', 'tsin': 'SPU000280COEY'}" // 此样式不可用
		// data: '{"id": "6204", "tsin": "SPU000280COEY"}'
		// data: data
	}
	req.add_custom_header('Content-Type', 'application/json')!
	// req.add_custom_header('Authorization', 'Bearer aveyamie')!
	// req.add_custom_header('Authorization', 'Bearer d54cef574e174d918572faf6a2b5f53da067f1a8')?
	reponse := req.do()!
	// println("打印req:$reponse")
	return reponse.body
}

