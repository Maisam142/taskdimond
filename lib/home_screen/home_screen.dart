import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskdimond/home_screen/home_screen_view_model.dart';

import '../component/showDialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> implements HomeScreenViewModelListeners{
  HomeScreenViewModel? vm;

  @override
  void initState() {
    vm =  Provider.of<HomeScreenViewModel>(context, listen: false);
    vm!.init(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    vm!.fetchProductDetails('productId');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Consumer<HomeScreenViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.mutableProducts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: viewModel.mutableProducts.length,
              itemBuilder: (context, index) {
                final product = viewModel.mutableProducts[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.network(
                            product['image'] ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['title'] ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                            SizedBox(height: 4),
                            Text(
                              product['description'] ?? '',
                              style: TextStyle(fontSize: 5),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${product['price']?.toString() ?? ''}',
                              style: TextStyle(color: Colors.green, fontSize: 10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      showEditDialogEdit(context,index);
                                    },
                                    icon: Icon(Icons.edit, size: 12),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      Provider.of<HomeScreenViewModel>(context, listen: false).deleteItem(index);
                                    },
                                    icon: Icon(Icons.delete, size: 12, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showEditDialogAdd(context);

        },
        child: Icon(Icons.add),
      ),
    );
  }

}
