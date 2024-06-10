import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final List<String> _productIds = [
    'com.petaverse.petography.completeedition',
    'com.petaverse.petography.removeads'
  ];
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  bool _isAvailable = false;

  @override
  void initState() {
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(_onPurchaseUpdated);
    _initialize();
    super.initState();
  }

  dddd() {
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(_onPurchaseUpdated);
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        dddd();
      }),
      body: _isAvailable
          ? ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.description),
                  trailing: Text(product.price),
                  onTap: () => _buyProduct(product),
                );
              },
            )
          : const Center(child: Text('Store not available')),
    );
  }

  Future<void> _verifyAndDeliverProduct(PurchaseDetails purchaseDetails) async {
    // Verify purchase with your server and deliver the product
    // Here we assume the purchase is valid and mark it as delivered
    if (purchaseDetails.productID == 'your_product_id_1') {
      // Deliver your product
    }
  }

  void _buyProduct(ProductDetails productDetails) {
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Handle pending purchase
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        _verifyAndDeliverProduct(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle the error
      }
      if (purchaseDetails.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _loadProducts() async {
    final response =
        await _inAppPurchase.queryProductDetails(_productIds.toSet());
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error
    }
    setState(() {
      _products = response.productDetails;
    });
  }

  Future<void> _initialize() async {
    _isAvailable = await _inAppPurchase.isAvailable();
    if (_isAvailable) {
      _loadProducts();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
