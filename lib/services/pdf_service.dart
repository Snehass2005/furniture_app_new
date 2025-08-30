import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<Uint8List> generateBill(List items, double totalPrice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("🛒 Furniture Shop", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text("Bill Summary", style: pw.TextStyle(fontSize: 18)),
              pw.Divider(),

              // Items
              ...items.map((item) {
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(item.title),
                    pw.Text("₹${item.price} x ${item.quantity}"),
                    pw.Text("₹${item.price * item.quantity}"),
                  ],
                );
              }).toList(),

              pw.Divider(),
              pw.SizedBox(height: 10),

              // Total
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Total:", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.Text("₹$totalPrice", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
