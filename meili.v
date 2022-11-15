import mysql
import net.http
import json


fn main() {

	// sqldata := sqlquery('1','10000')?
	sqldata := Con{} 
	// sqldata := mysql_orm('1','10000')? //orm
	// println(sqldata)
	mut jsonstr := json.encode(sqldata) //将[]map[string]string 数据类型 编码为 json 数据类型
	reponse := request(jsonstr)!
	println(reponse)

	// data := '{"id": "6204", "tsin": "SPU000280COEY"}'
	// reponse := request(data)?
	// println(reponse)
}

fn request(data string) !string {
	mut req := http.Request{
		method: http.Method.post
		url: "http://192.168.3.2:7700/indexes/tospinomall/documents"
		// url: "https://ms-43c9c269b6b3-327.lon.meilisearch.io/indexes/tospinomall/documents"
		// data: "{'id': '6204', 'tsin': 'SPU000280COEY'}" // 此样式不可用
		// data: '{"id": "6204", "tsin": "SPU000280COEY"}'
		data: data
	}
	req.add_custom_header('Content-Type', 'application/json')!
	req.add_custom_header('Authorization', 'Bearer aveyamie')!
	// req.add_custom_header('Authorization', 'Bearer d54cef574e174d918572faf6a2b5f53da067f1a8')?
	reponse := req.do()!
	// println("打印req:$reponse")
	return reponse.body
}

[params]
struct Con {
	// host: '192.168.3.2'
	// port: 3306
	// username: 'admin'
	// password: 'admin'

	host string = '42.193.159.7'
	// port i64 = '3306'
	username string = 'select'
	password string = 'Dgxdl021'
	dbname string = 'tospinomall_product'
}

pub fn (c Con) sqlquery(startpoint string, numperpage string) ?[]map[string]string {
	mut conn := mysql.Connection{

		host: c.host
		port: 3306
		username: c.username
		password: c.password
		dbname: c.dbname
	}
	conn.connect()?
	// res := conn.query('show tables')?
	// mut sqlstr := 'select id,tsin from tospinomall_product.pms_goods_info limit 5'
	mut sqlstr := 'select id,id,tsin, good_title,main_picture_url,keyword,good_code,ifnull(seller_id,0),ifnull(shop_id,0),' +
	'ifnull(brand_id,0),ifnull(category_id,0),goods_type,ifnull(is_cash_delivery,0),ifnull(delivery_type,0),'+
	'transport_mode from tospinomall_product.pms_goods_info limit '+startpoint+','+numperpage

	mut res := conn.query(sqlstr)?
	// println(res)
	mut mapstrlist := []map[string]string{} //创建空数组
	for row in res.rows() {
		// map的另一种写法
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


// ORM ---
[table: 'pms_goods_info']
struct Module {
	id           int    [primary; sql: serial]
	tsin         string
	good_title	string
	main_picture_url	string
	keyword	string
	good_code	string
	seller_id 	int
	shop_id		int
	brand_id	int
	category_id	int
	goods_type	int
	is_cash_delivery int
	delivery_type int
	transport_mode int
	examine_status int
}

fn mysql_orm(startpoint string, numperpage string) ?[]map[string]string {
	mut conn := mysql.Connection{
		// host: '10.243.0.2'
		// port: 3306
		// username: 'admin'
		// password: 'admin'

		host: '42.193.159.7'
		port: 3306
		username: 'select'
		password: 'Dgxdl021'
		dbname: 'tospinomall_product'
	}
	conn.connect() or { panic(err) }

	res := sql conn {
		select from Module where examine_status==2  limit startpoint+','+numperpage
	}
	// eprintln('$row.id')
	mut mapstrlist := []map[string]string{} //创建空数组
	for row in res {
		mut direct := map[string]string{} // a map with `string` keys and `string` values
		direct["id"] = '$row.id'
		direct["objectID"] = '$row.id'
		direct["tsin"] = '$row.tsin'
		direct["good_title"] = '$row.good_title'
		direct["poster"] = '$row.main_picture_url'+ "?.webp"  //不增加后缀，meilisearch不显示图片
		direct["keyword"] = '$row.keyword'
		direct["good_code"] = '$row.good_code'
		direct["seller_id"] = '$row.seller_id'
		direct["shop_id"] = '$row.shop_id'
		direct["brand_id"] = '$row.brand_id'
		direct["category_id"] = '$row.category_id'
		direct["goods_type"] = '$row.goods_type'
		direct["is_cash_delivery"] = '$row.is_cash_delivery'
		direct["delivery_type"] = '$row.delivery_type'
		direct["transport_mode"] = '$row.transport_mode'
		// println(direct)
		mapstrlist << direct  //追加direct到mapstrlist 数组
	}
	// println(mapstrlist)
	conn.close()
	return mapstrlist
}