import 'dart:developer';

import 'package:bookly_app/core/utils/api_keys.dart';
import 'package:bookly_app/core/widgets/custom_button.dart';
import 'package:bookly_app/features/home/data/models/amount_model/amount_model.dart';
import 'package:bookly_app/features/home/data/models/amount_model/details.dart';
import 'package:bookly_app/features/home/data/models/item_list_model/item.dart';
import 'package:bookly_app/features/home/data/models/item_list_model/item_list_model.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/presentation/views/thank_you_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class BookPayment extends StatelessWidget {
  const BookPayment({super.key, required this.bookEntity});
  final BookEntity bookEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              onPressed: () {
                var transctionsData = getTransctionsData(bookEntity);
                exceutePaypalPayment(context, transctionsData);
              },
              text: 'Payment',
              backgroundColor: Colors.white,
              textColor: const Color(0xffEF8262),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
    );
  }
}

void exceutePaypalPayment(BuildContext context,
    ({AmountModel amount, ItemListModel itemList}) transctionsData) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.clientID,
        secretKey: ApiKeys.paypalSecretKey,
        transactions: [
          {
            "amount": transctionsData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transctionsData.itemList.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ThankYouView()));
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ),
  );
}

({AmountModel amount, ItemListModel itemList}) getTransctionsData(
    BookEntity bookEntity) {
  var amount = AmountModel(
      total: "${bookEntity.price}",
      currency: 'USD',
      details: Details(
        shipping: "0",
        shippingDiscount: 0,
        subtotal: '${bookEntity.price}',
      ));
  List<OrderItemModel> orders = [
    OrderItemModel(
      currency: 'USD',
      name: bookEntity.title,
      price: "${bookEntity.price}",
      quantity: 1,
    ),
  ];
  var itemList = ItemListModel(orders: orders);
  return (amount: amount, itemList: itemList);
}
