import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskdimond/home_screen/home_screen_reading_writing.dart';

import '../domain/use_cases/fetch_movie_use_case.dart';

@Injectable()
class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenViewModelListeners? _organizationIdViewModelListeners;
  HomeScreenReadingWriting? readingWritingModel;
  final FetchMovieUseCase _fetchMovieUseCase;
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> mutableProducts = [];

  HomeScreenViewModel(this._fetchMovieUseCase);

  init(HomeScreenViewModelListeners homeScreenViewModelListeners) {
    _organizationIdViewModelListeners = homeScreenViewModelListeners;
    readingWritingModel = HomeScreenReadingWriting();
    loadProductsFromLocalStorage();
  }

  void loadProductsFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productsJson = prefs.getString('products');
    if (productsJson != null) {
      products = List<Map<String, dynamic>>.from(json.decode(productsJson));
      mutableProducts = List.from(products);
      notifyListeners();
    }
  }

  void saveProductsToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String productsJson = json.encode(products);
    await prefs.setString('products', productsJson);
  }

  void fetchProductDetails(String productId) {
    _fetchMovieUseCase.fetchProductDetails(productId).listen((value) {
      value.when(
        loading: () {
          print('loading');
        },
        error: (error, stack) {
          print(error);
        },
        data: (data) {
          products = List<Map<String, dynamic>>.from(data.asList());
          mutableProducts = List.from(products);
          saveProductsToLocalStorage();
          notifyListeners();
        },
      );
    });
  }
  void updateItem(int index, {
    String? title,
    String? image,
    String? description,
    double? price,
    String? category,
  }) {
    Map<String, dynamic> updatedData = mutableProducts[index];

    if (title != null) updatedData['title'] = title;
    if (image != null) updatedData['image'] = image;
    if (description != null) updatedData['description'] = description;
    if (price != null) updatedData['price'] = price;
    if (category != null) updatedData['category'] = category;

    mutableProducts[index] = updatedData;
    products = List.from(mutableProducts);
    saveProductsToLocalStorage();
    notifyListeners();
  }
  void addItem({
    required String title,
    required String image,
    required String description,
    required double? price,
    required String category,
  }) {
    Map<String, dynamic> newItem = {
      'title': title,
      'image': image,
      'description': description,
      'price': price,
      'category': category,
    };

    mutableProducts.add(newItem);
    products = List.from(mutableProducts);
    saveProductsToLocalStorage();
    notifyListeners();
  }


  void deleteItem(int index) {
    mutableProducts.removeAt(index);
    products = List.from(mutableProducts);
    saveProductsToLocalStorage();
    notifyListeners();
  }
}

abstract class HomeScreenViewModelListeners {}
