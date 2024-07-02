import 'dart:convert';
import 'package:flutt/src/providers/carrito_provider.dart';
import 'package:flutt/src/services/actualizar_puntos.dart';
import 'package:flutt/src/services/factura_productos.dart';
import 'package:flutt/src/services/pdf_factura.dart';
import 'package:flutt/src/widgets/puntos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;
  Future<void> makePayment(
      {required String amount,
      required String currency,
      required WidgetRef ref,
      required BuildContext context,
      required double puntos,
      required int id}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        double monto = double.parse(amount);
        monto = monto / 100;
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          primaryButtonLabel: 'Pagar Bs $monto',
        ));
        displayPaymentSheet(ref, context, puntos, id);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(
      WidgetRef ref, BuildContext context, double puntos, int id) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      String ruta =
          await pdfFactura(ref.watch(carritoStateNotifierProvider), id);
      facturaProducto(ref.watch(carritoStateNotifierProvider), id);
      ref.invalidate(carritoStateNotifierProvider);
      ref.invalidate(contadorProvider);
      ref.read(terminadoProvider.notifier).update((state) => true);
      actualizarPuntos(id, puntos);
      puntosPromotor(context, puntos.toString());
      ref.read(facturaProvider.notifier).update((state) => ruta.toString());
      Get.snackbar('Pago', 'Pago exitoso',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      // ignore: deprecated_member_use
      launch(ruta);
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Oxs9QCMuDUzDr4EBTIaRnaR60mIbSbdvodcb1TgtSNyGM2lTBgcphx5xGPh625YE8WzWyO7alqEqhqJocWuHqXp0081UI1P6q',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
