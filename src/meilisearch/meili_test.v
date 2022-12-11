module main
import json

fn test_request() {
	data := '{"id": "1", "tsin": "SPU000280COEY"}'
	reponse := request(data)?
	println(reponse)
}

