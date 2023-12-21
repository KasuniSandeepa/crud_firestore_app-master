import 'package:http/http.dart' as http;

void getData(url) async {
  print('in');
  http.Response response = await http.get(Uri.parse(url));
 // var response = await http.post(url, body: jsonEncode(<String, String>{'sender': '' , 'message': message}));
  print(response);
  //return response.body;
}

// Future getResponse(String message) async{
//   var res = <Response>[];
//   var url = Uri.parse('http://192.168.1.4/webhooks/rest/webhook');
//   var response = await http.post(url, body: jsonEncode(<String, String>{'sender': '' , 'message': message}));
//   Iterable list = json.decode(response.body);
//   res = list.map((model) => Response.fromJson(model)).toList();
//   callbackFunction(res[0].text,false);
// }

