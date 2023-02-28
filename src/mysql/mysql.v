import db.mysql
// import net.http
// import json

fn main() {
	// a := qsqlqueryu('2','5') or {return}
	// sqldata := sqlquery('1','10')?
	// println(sqldata)
	// mysql_orm('1','2')
	orm := mysql_orm('1','2')
	println(orm)
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

[table: 'pms_goods_info']
struct Pgi {
	id           int    [primary; sql: serial]
	tsin         string [nonull]
	good_title	string [nonull]
	main_picture_url	string [nonull]
	// keyword	string [nonull]
	// good_code	string [nonull]
	// ifnull(seller_id,0) 	int
	// shop_id		int	
	// brand_id	int	
	// category_id	int	
	// goods_type	int	
	// is_cash_delivery int	
	// delivery_type int		
	// transport_mode string		
	examine_status int	
}


fn mysql_orm(startpoint string, numperpage string) []map[string]string {
	mut conn := mysql.Connection{
		host: '10.243.0.2'
		port: 3306
		username: 'admin'
		password: 'admin'
		dbname: 'tospinomall_product'
	}
	conn.connect() or { panic(err) }

	res := sql conn {
		select  from Pgi where examine_status==2  limit startpoint+','+numperpage
	}
	eprintln('$res')
	mut mapstrlist := []map[string]string{} //创建空数组
	for row in res {
		
		mut direct := map[string]string{} // a map with `string` keys and `string` values
		direct["id"] = '$row.id'
		direct["objectID"] = '$row.id'
		direct["tsin"] = '$row.tsin'
		direct["good_title"] = '$row.good_title'
		direct["poster"] = '$row.main_picture_url'+ "?.webp"  //不增加后缀，meilisearch不显示图片
		// direct["keyword"] = '$row.keyword'
		// direct["good_code"] = '$row.good_code'
		// direct["seller_id"] = '$row.seller_id'
		// direct["shop_id"] = '$row.shop_id'
		// direct["brand_id"] = '$row.brand_id'
		// direct["category_id"] = '$row.category_id'
		// direct["goods_type"] = '$row.goods_type'
		// direct["is_cash_delivery"] = '$row.is_cash_delivery'
		// direct["delivery_type"] = '$row.delivery_type'
		// direct["transport_mode"] = '$row.transport_mode'
		// println(direct)
		mapstrlist << direct  //追加direct到mapstrlist 数组
	}	
	// println(mapstrlist)
	conn.close()
	return mapstrlist
}
