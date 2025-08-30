import 'package:flutter/material.dart';
import 'package:furniture_ui/constants/assets_manager.dart';
import 'package:furniture_ui/homepage/models/product_model.dart';
import 'package:get/get.dart';

final List<ProductModel> sampleProducts = [
  ProductModel(
    id:'1',
    title: "Modern Sofa",
    imageUrl: AssetsManager.sofa1,
    imageList: [
      AssetsManager.sofa1,
      AssetsManager.sofa2,
      AssetsManager.sofa3,
    ],
    price: 24999.0,
    category: "Sofa",
    rating: 4.2,
    colors: [Colors.grey, Colors.green],
    isNew: true,
    isPopular: false,
  ),
  ProductModel(
    id:'2',
    title: "Stylish Chair",
    imageUrl: AssetsManager.chair1,
    imageList: [
        AssetsManager.chair1,
        AssetsManager.chair2,
        AssetsManager.chair3,
    ],
    price: 10999.0,
    category: "Chair",
    rating: 4.2,
    colors: [Colors.grey, Colors.green],
    isNew: false,
    isPopular: true,

  ),
  ProductModel(
    id:'3',
    title: "Luxury Lamp",
    imageUrl: AssetsManager.lamp1,
    imageList: [
      AssetsManager.lamp1,
      AssetsManager.lamp2,
      AssetsManager.lamp3,
    ],
    price: 5999.0,
    category: "Lamp",
    rating: 4.2,
    colors: [Colors.grey, Colors.green],
    isNew: true,
    isPopular: true,

  ),
  ProductModel(
    id:'4',
    title: "Classic Cupboard",
    imageUrl: AssetsManager.cupboard1,
    imageList: [
       AssetsManager.cupboard1,
       AssetsManager.cupboard2,
       AssetsManager.cupboard3,
    ],
    price: 31999.0,
    category: "Cupboard",
    rating: 4.2,
    colors: [Colors.grey, Colors.green],
    isNew:false,
    isPopular: false,
  ),
  ProductModel(
    id:'5',
    title: "bedroom",
    imageUrl: AssetsManager.bedroom,
    imageList: [
      AssetsManager.bedroom,
      AssetsManager.bedroom1,
    ],
    price: 31999.0,
    category: "bedroom",
    rating: 4.2,
    colors: [Colors.grey, Colors.green],
    isNew:true,
    isPopular: false,
  ),
];
