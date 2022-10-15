import 'package:flutter/material.dart';
import 'package:myapp/widget.dart/Widgets.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CategoryContainer(
            theText: "Want to make mony?\nBuy.Chat.Sell",
            imageLink:
                "https://cdn.pixabay.com/photo/2016/11/22/19/24/archive-1850170_960_720.jpg",
            myHeight: 200,
            myWidth: double.infinity),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryContainer(
                      theText: "Cars and Bikes",
                      imageLink:
                          "https://cdn.pixabay.com/photo/2018/03/04/18/17/car-3198788_960_720.jpg",
                      myHeight: 150,
                      myWidth: 185),
                  CategoryContainer(
                      theText: "Mobile-Tablet",
                      imageLink:
                          "https://cdn.pixabay.com/photo/2015/06/24/15/45/hands-820272_960_720.jpg",
                      myHeight: 150,
                      myWidth: 185),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryContainer(
                      theText: "Video Games&\nConsoles",
                      imageLink:
                          "https://cdn.pixabay.com/photo/2017/05/19/14/09/ps4-2326616_960_720.jpg",
                      myHeight: 150,
                      myWidth: 185),
                  CategoryContainer(
                      theText: "Electronics-\nAppliances",
                      imageLink:
                          "https://media.istockphoto.com/photos/3d-set-of-home-appliances-on-white-background-picture-id993760082",
                      myHeight: 150,
                      myWidth: 185),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryContainer(
                      theText: "Computers&\n Laptops",
                      imageLink:
                          "https://cdn.pixabay.com/photo/2015/01/21/14/14/apple-606761_960_720.jpg",
                      myHeight: 150,
                      myWidth: 185),
                  CategoryContainer(
                      theText: "Home & Garden",
                      imageLink:
                          "https://cdn.pixabay.com/photo/2018/05/12/02/05/wooden-bench-3392273_960_720.jpg",
                      myHeight: 150,
                      myWidth: 185),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryContainer(
                      theText: "Men's Fashion",
                      imageLink:
                          "https://cdn.pixabay.com/photo/2016/03/27/19/31/fashion-1283863_960_720.jpg",
                      myHeight: 150,
                      myWidth: 185),
                  CategoryContainer(
                      theText: "Women's Fashion",
                      imageLink:
                          "https://cdn.pixabay.com/photo/2017/08/17/08/20/online-shopping-2650383_960_720.jpg",
                      myHeight: 150,
                      myWidth: 185),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
