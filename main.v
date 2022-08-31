import mysql
import net.http
import json

fn main() {
	// a := qsqlqueryu('2','5') or {return}
	sqldata := sqlquery('1','100000')?
	println(sqldata)


	// data := '{"id": "6204", "tsin": "SPU000280COEY"}'
	mut jsonstr := json.encode(sqldata) //将[]map[string]string 数据类型 编码为 json 数据类型
	reponse := request(jsonstr)?
	// s := request(data)?
	println(reponse)
}
pub fn sqlquery(startpoint string, numperpage string) ?[]map[string]string {
	mut conn := mysql.Connection{
		host: '192.168.3.2'
		port: 3306
		username: 'admin'
		password: 'admin'
		dbname: 'tospinomall_product'
	}
	conn.connect()?
	// res := conn.query('show tables')?
	// mut sqlstr := 'select id,tsin from tospinomall_product.pms_goods_info limit 5'
	mut sqlstr := 'select id,id,tsin, good_title,main_picture_url,keyword,good_code,ifnull(seller_id,0),ifnull(shop_id,0),' +
	'ifnull(brand_id,0),ifnull(category_id,0),goods_type,ifnull(is_cash_delivery,0),ifnull(delivery_type,0),'+
	'transport_mode from tospinomall_product.pms_goods_info limit '+startpoint+','+numperpage
	
	mut res := conn.query(sqlstr)?
	mut mapstrlist := []map[string]string{} //创建空数组
	for row in res.rows() {
		//map的另一种写法
		// direct := {
		// 	'id': row.vals[0]
		// 	'tsin': row.vals[1]
		// }
		mut direct := map[string]string{} // a map with `string` keys and `string` values
		direct["id"] = row.vals[0]
		direct["objectID"] = row.vals[1]
		direct["tsin"] = row.vals[2]
		direct["good_title"] = row.vals[3]
		direct["poster"] = row.vals[4]+ "?.webp"  //不增加后缀，meilisearch不显示图片
		direct["keyword"] = row.vals[5]
		direct["good_code"] = row.vals[6]
		direct["seller_id"] = row.vals[7]
		direct["shop_id"] = row.vals[8]
		direct["brand_id"] = row.vals[9]
		direct["category_id"] = row.vals[10]
		direct["goods_type"] = row.vals[11]
		direct["is_cash_delivery"] = row.vals[12]
		direct["delivery_type"] = row.vals[13]
		direct["transport_mode"] = row.vals[14]
		// println(direct)
		mapstrlist << direct  //追加direct到mapstrlist 数组
	}	
	conn.close()
	return mapstrlist
}


fn request(data string) ?string {
	mut req := http.Request{
		method: http.Method.post
		url: "http://192.168.3.2:7700/indexes/tospinomall/documents"
		// data: "{'id': '6204', 'tsin': 'SPU000280COEY'}" // 此样式不可用
		// data: '{"id": "6204", "tsin": "SPU000280COEY"}'
		data: data
	}
	req.add_custom_header('Content-Type', 'application/json')?
	req.add_custom_header('Authorization', 'Bearer aveyamie')?
	reponse := req.do()?
	// println("打印req:$reponse")
	return reponse.body
}

