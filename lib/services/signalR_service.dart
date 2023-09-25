import 'package:bid_online_app_v2/constants.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  // The location of the SignalR Server.
  final serverUrl = "https://bids-online.azurewebsites.net";

  HubConnection initSignalR(
      String hubName, String methodName, Function(List<Object?>?) function) {
    HubConnection hubConnection = HubConnectionBuilder()
        .withAutomaticReconnect()
        .withUrl(apiUrl + hubName)
        .build();
    hubConnection.onclose(
      ({error}) => print('Connection close'),
    );
    hubConnection.on(methodName, function);
    // _hubConnection!.on('ReceiveFee', (arguments) {
    //   setState(() {
    //       for (var arg in arguments!) {
    //         if (arg is List<dynamic>) {
    //           // if (arg.cast<Fee>() is List<Fee>) {
    //           for (var fee in arg.map((e) => Fee.fromJson(e)).toList()) {
    //             setState(() {
    //               updatedFee.add(fee);
    //             });
    //             // }
    //           }
    //         }
    //       }

    //   });
    // });

    // try {
    //   setState(() {
    //     print(
    //         "load...: ${_hubConnection!.state == HubConnectionState.Disconnected}");
    //   });
    //   _hubConnection!.state == HubConnectionState.Disconnected
    //       ? await _hubConnection!.start()
    //       : print("hiiiiii");
    //   setState(() {
    //     print(
    //         "load...: ${_hubConnection!.state == HubConnectionState.Disconnected}");
    //   });
    // } catch (e) {
    //   print("signal err: $e");
    //   print("retry...");
    //   await _hubConnection!.start();
    //   print("ok...");
    // }
    return hubConnection;
  }
}
