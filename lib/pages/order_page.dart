import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemModel {
  String name;
  String description;
  String image;
  String color;
  int price;
  int id;

  ItemModel({
    required this.name,
    required this.description,
    required this.color,
    required this.image,
    required this.price,
    required this.id,
  });
}

class OrderModel {
  String orderId;
  String customerName;
  String status;
  List<ItemModel> items;

  OrderModel(
      {required this.orderId,
      required this.customerName,
      required this.status,
      required this.items});
}

class Order extends StatefulWidget {
  const Order({super.key, required this.value1});
  final String value1;

  @override
  // ignore: no_logic_in_create_state
  State<Order> createState() => _OrderState(value1: value1);
}

class _OrderState extends State<Order> {
  final String value1;
  List<OrderModel> orders = [];
  _OrderState({required this.value1});

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$value1/order').get();
    List<ItemModel> it = [];
    if (snapshot.exists) {
      // print(snapshot.value);
      Object? res = snapshot.value;
      print(res);
      print(res.runtimeType);
      if (res is Map<Object?, Object?>) {
        print('entered');

        // Now, you can safely cast res to Map<String, dynamic>
        Map<Object?, Object?> r = res;
        r.forEach((key, value) {
          if (key != null &&
              value is Map<Object?, Object?> &&
              value['order_id'] != null) {
            String orderId = value['order_id']!.toString();
            print('Order ID: $orderId');
            String cust = value['customer_name']!.toString();
            print('Customer Name: $cust');
            String status = value['status']!.toString();
            print('Status : $status');

            var a = value['items'];
            // final a =
            print(a.runtimeType);
            if (a is Map<Object?, Object?>) {
              print('entered');
              Map<Object?, Object?> x = a;
              x.forEach((key, value) {
                if (value is Map<Object?, Object?> && value['image'] != null) {
                  String image = value['image']!.toString();
                  String name = value['name']!.toString();
                  String desc = value['desc']!.toString();
                  String color = value['color']!.toString();
                  int id = value['id'] as int;
                  int price = value['price'] as int;

                  ItemModel m = ItemModel(
                      color: color,
                      id: id,
                      price: price,
                      name: name,
                      description: desc,
                      image: image);
                  it.add(m);
                }
              });
            } else if (a is List<Object?>) {
              List<Object?> x = a;
              x.forEach((element) {
                if (element is Map<Object?, Object?>) {
                  print('entered');
                  Map<Object?, Object?> xa = element;
                  xa.forEach((key, value) {
                    if (value is Map<Object?, Object?> &&
                        value['image'] != null) {
                      String image = value['image']!.toString();
                      String name = value['name']!.toString();
                      String desc = value['desc']!.toString();
                      String color = value['color']!.toString();
                      int id = value['id'] as int;
                      int price = value['price'] as int;

                      ItemModel m = ItemModel(
                          color: color,
                          id: id,
                          price: price,
                          name: name,
                          description: desc,
                          image: image);
                      it.add(m);
                      print(it);
                    }
                  });
                }
              });
            }

            OrderModel order = OrderModel(
                orderId: orderId,
                customerName: cust,
                status: status,
                items: it);
            setState(() {
              orders.add(order);
              print(orders.length);
              // it.clear();
            });
            print(orders[0].items);
          }
        });
        // print(r);
        // Use r as needed
      } else {
        print("Error: Snapshot value is not a Map<String, dynamic>");
      }
    } else {
      print('No data available.');
    }
    print(orders[1].items.length);
  }

  @override
  Widget build(BuildContext context) {
    int total = 0;
    return Scaffold(
      backgroundColor: context.cardColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: "My Orders"
                    .text
                    .xl5
                    .bold
                    .color(context.theme.colorScheme.secondary)
                    .make(),
              ),
              SizedBox(
                height: 20,
              ),
              (orders.length != 0)
                  ? Container(
                      height: 700,
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(children: [
                                Container(),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Order_id : ${orders[index].orderId}')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Customer Name :  ${orders[index].customerName}')),
                                const SizedBox(
                                  height: 2,
                                ),
                                Divider(
                                  endIndent: 20,
                                  color: Colors.black54,
                                ),
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                      itemCount: orders[index].items.length,
                                      itemBuilder: (context, i) {
                                        total += orders[index].items[i].price;
                                        return Card(
                                          child: Row(
                                            children: [
                                              Image.network(
                                                orders[index].items[i].image,
                                                width: 80,
                                              ),
                                              Column(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      orders[index]
                                                          .items[i]
                                                          .name,
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      orders[index]
                                                          .items[i]
                                                          .description,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      orders[index]
                                                          .items[i]
                                                          .price
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                Divider(
                                  endIndent: 20,
                                  color: Colors.black54,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Text("Total No : "),
                                    ),
                                    Container(
                                      child: Text("\$ ${total}"),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      child: Image.asset('assets/images/no_order.png'),
                    )
            ],
          ),
        ),
      ),
      drawer: MyDrawer(value1: value1),
    );
  }
}
