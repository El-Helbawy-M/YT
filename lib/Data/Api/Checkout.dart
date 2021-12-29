import 'dart:convert';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:yt/System/Constants.dart';
import 'package:http/http.dart' as http;

class CheckOut {
  static String link = "https://api.stripe.com/v1/payment_intents";
  String key = "sk_test_51Ja1YnJKjCFQ66toXU69QKm9nINfovetxblyKJSCLA7zdL7xKNbIOoda5GcMx59y1JclXDAs8DohKE5u4fWPzmMS00dugioJ2d";
  CreditCard _card;
  static Map<String, String> requestHeaders = {
    'Authorization': 'Bearer sk_test_51Ja1YnJKjCFQ66toXU69QKm9nINfovetxblyKJSCLA7zdL7xKNbIOoda5GcMx59y1JclXDAs8DohKE5u4fWPzmMS00dugioJ2d',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  CheckOut.init() {
    StripePayment.setOptions(StripeOptions(publishableKey: "pk_test_51Ja1YnJKjCFQ66to3bqCJzZlcVJmoeybzj1sFXjW1zgGvcsp38X7ONjOYFbTqnRnkdu2koJF0o5EvTRS7ZGWrOek00yP08fXcf", merchantId: "test", androidPayMode: 'test'));
  }
  CheckOut(this._card);
  Future<RequestState> pay(int amount) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(PaymentMethodRequest(card: this._card));
      var paymentIntent = await _createPaymentIntent(amount);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(clientSecret: paymentIntent['client_secret'], paymentMethodId: paymentMethod.id));
      return response.status == "succeeded" ? RequestState.OK : RequestState.Unknown;
    } catch (e) {
      print(e);
      return RequestState.Unknown;
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(int amount) async {
    try {
      Map<String, dynamic> body = {'amount': amount.toString(), 'currency': "USD"};
      var response = await http.post(Uri.parse(link), headers: requestHeaders, body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print('error Happened');
      throw error;
    }
  }
}
