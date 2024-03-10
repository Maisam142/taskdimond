import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskdimond/home_screen/home_screen_view_model.dart';

void showEditDialogEdit(BuildContext context, int index) {
  var mutableProducts = Provider.of<HomeScreenViewModel>(context, listen: false).mutableProducts;
  print('mutableProducts: $mutableProducts');
  print('index: $index');
  TextEditingController titleController = TextEditingController(text: mutableProducts[index]['title']);
  TextEditingController imageController = TextEditingController(text: mutableProducts[index]['image']);
  TextEditingController descriptionController = TextEditingController(text: mutableProducts[index]['description']);
  TextEditingController priceController = TextEditingController(text: mutableProducts[index]['price']?.toString());
  TextEditingController categoryController = TextEditingController(text: mutableProducts[index]['category']);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<HomeScreenViewModel>(context, listen: false).updateItem(
                index,
                title: titleController.text,
                image: imageController.text,
                description: descriptionController.text,
                price: double.tryParse(priceController.text),
                category: categoryController.text,
              );
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}
void showEditDialogAdd(BuildContext context, {int? index}) {
  var mutableProducts = Provider.of<HomeScreenViewModel>(context, listen: false).mutableProducts;
  print('mutableProducts: $mutableProducts');

  TextEditingController titleController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  if (index != null) {
    titleController.text = mutableProducts[index]['title'];
    imageController.text = mutableProducts[index]['image'];
    descriptionController.text = mutableProducts[index]['description'];
    priceController.text = mutableProducts[index]['price'].toString();
    categoryController.text = mutableProducts[index]['category'];
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(index != null ? 'Edit Product' : 'Add Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (index != null) {
                Provider.of<HomeScreenViewModel>(context, listen: false).addItem(
                  title: titleController.text,
                  image: imageController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  category: categoryController.text,
                );
              } else {
                Provider.of<HomeScreenViewModel>(context, listen: false).addItem(
                  title: titleController.text,
                  image: imageController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  category: categoryController.text,
                );
              }
              Navigator.of(context).pop();
            },
            child: Text(index != null ? 'Save Changes' : 'Add'),
          ),
        ],
      );
    },
  );
}
