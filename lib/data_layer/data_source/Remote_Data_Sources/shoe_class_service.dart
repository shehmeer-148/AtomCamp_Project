import 'dart:convert';
import 'package:http/http.dart';
import '../../model/shoe_data_model.dart';

class ShoeService {
  final apikey = "https://api.escuelajs.co/api/v1/categories/4/products";


  Future<List<ShoeDataModel>?> fetchShoeData() async {
    final url = Uri.parse(apikey);

    try {
      Response response = await get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) {
          return ShoeDataModel.fromjson(item);
        }).toList();
      } else {
        throw Exception("Failed to Load Shoes");
      }
    } catch (e) {
      return null;
    }
  }
}
