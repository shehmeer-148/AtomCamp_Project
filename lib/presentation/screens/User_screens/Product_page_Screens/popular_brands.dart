
import 'package:flutter/material.dart';

import '../../../../data_layer/data_source/Remote_Data_Sources/shoe_class_service.dart';
import '../../../../data_layer/model/shoe_data_model.dart';

class PopularBrands extends StatefulWidget {
  const PopularBrands({super.key});

  @override
  State<PopularBrands> createState() => _PopularBrandsState();
}

class _PopularBrandsState extends State<PopularBrands> {
  final ShoeService shoeService = ShoeService();
  Future<List<ShoeDataModel>?>? futureShoeData;

  @override
  void initState() {
    super.initState();
    futureShoeData = shoeService.fetchShoeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shoes')),
      body: FutureBuilder<List<ShoeDataModel>?>(
        future: futureShoeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final shoe = data[index];
                return ListTile(
                  leading: shoe?.image != null && shoe!.image.isNotEmpty
                      ? Image.network(
                    shoe!.image.trim(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network('https://via.placeholder.com/150');
                    },
                  ):Image.network('https://via.placeholder.com/150'),
                  title: Text(shoe.title),
                  subtitle: Text('\$${shoe.price}'),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
