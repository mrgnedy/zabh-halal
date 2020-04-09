import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zabh_halal/model/allProducts_model.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/product_details.dart';
import 'package:zabh_halal/utilities/colors.dart';

class ProductsPage extends StatefulWidget {
  final List<Products> products;
  final String title;
  ProductsPage(this.products, this.title);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: TextD(
              title: '${widget.title}',
              fontSize: 22,
              textColor: Colors.white,
              height: 0.8,
            ),
          )
        ],
      ),
      body:widget.products.isEmpty?Center(child: TextD(title: 'لا توجد منجات متاحة',fontSize: 16,),): GridView.count(
        childAspectRatio: 1.4,
        crossAxisSpacing: 10,
        padding: EdgeInsets.all(8),
        mainAxisSpacing: 20,
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate((widget.products.length), (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, anim, secAnim) => ProductDetails(
                          'product$index',
                          widget.products[index],
                          service: widget.title,
                        ),
                        transitionDuration: Duration(seconds: 1),
                      )),
                  child: Hero(
                    tag: 'product$index',
                    child: Image.network(
                      'http://noura.store/public/dash/assets/img/${widget.products[index].image}',
                      // height: 100,
                      // width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 45,
                    color: Colors.white54,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextD(
                          title: '${widget.products[index].name}',
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
