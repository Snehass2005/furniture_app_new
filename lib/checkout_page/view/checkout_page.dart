import 'package:flutter/material.dart';
import 'package:furniture_ui/cardpage/viewmodel/card_viewmodel.dart';
import 'package:furniture_ui/services/pdf_service.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              /// Delivery Address
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.blue),
                  title: const Text("Chris Hemsworth"),
                  subtitle: const Text("H: R-56, West Street, Pennsylvania, USA\n+96-012 3445 44"),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {}, // TODO: add edit address
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// ✅ Shopping List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return ListTile(
                    leading: Image.asset(item.imageUrl, width: 50),
                    title: Text(item.title),
                    subtitle: Text("₹${item.price} x ${item.quantity}"),
                    trailing: Text("₹${item.price * item.quantity}"),
                  );
                },
              ),

              const SizedBox(height: 20),
              /// ✅ Voucher / Promo
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.card_giftcard, color: Colors.orange),
                  title: const Text("Voucher & Promo"),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter code",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("Apply"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// ✅ Order Summary
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _summaryRow("Sub Total", "\$${cart.totalPrice.toStringAsFixed(2)}"),
                      _summaryRow("Shipping Fee", "\$12.00"),
                      _summaryRow("Discount (10%)", "-\$${(cart.totalPrice * 0.1).toStringAsFixed(2)}"),
                      const Divider(),
                      _summaryRow(
                        "Total",
                        "\$${(cart.totalPrice + 12 - (cart.totalPrice * 0.1)).toStringAsFixed(2)}",
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ✅ Pay Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Order placed successfully!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Pay Now",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),

              const SizedBox(height: 12),

              /// ✅ Download PDF Bill Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final pdfService = PdfService();
                    final pdfData = await pdfService.generateBill(cart.items, cart.totalPrice);

                    /// Opens PDF preview & allows download
                    await Printing.layoutPdf(
                      onLayout: (format) async => pdfData,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("Download Bill (PDF)",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ✅ Add this helper function
Widget _summaryRow(String title, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
