import 'package:flutter/material.dart';
import 'package:projectmanagment/ViewModel/Auth/select_categories_view_model.dart';
import 'package:provider/provider.dart';

class ImageListScreen extends StatelessWidget {
  final List<String> imageUrls = List.generate(
    90,
    (index) => 'https://avatar.iran.liara.run/public/${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    final SelectCategoriesViewModel selectCategoriesViewModel =
        Provider.of<SelectCategoriesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Avatar'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 sütun olacak şekilde düzenliyoruz
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                selectCategoriesViewModel.changeSelectedImageIndex(index + 1);
                Navigator.pop(context);
              },
              child: Container(
                child: Image.network(
                  imageUrls[index],
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Icon(Icons.error);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
