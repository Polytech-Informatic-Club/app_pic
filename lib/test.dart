import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tester"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                sendFCMMessage();
              },
              child: Text("Tester"))
        ],
      ),
    );
  }
}

Future<String> getAccessToken() async {
  // Your client ID and client secret obtained from Google Cloud Console
  final serviceAccountJson = {
    "type": "service_account",
    "project_id": "ept-app-46930",
    "private_key_id": "0c55b410a7d473217a2bfc83575c3ea75c754433",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDeWbvIK5GZZyrd\nxrWNZDsDlhrBGMKrYdZwyYiNN5XjUTK5lNA8ulI88lcUPfTRHc7ka8k2sSsbosoR\nd0wmH3cwKPMKznrSaPEtvcR3YVfrCWG9mbsR69+jZLN/NMnSR6Ustkywu4k8ma0U\nf/31a5q1VSMTbAHjKa0Kpje+8iOl9yepMXi9buKBbYRfYQs1SJsrl+qmIdanqg6x\nzJXwyBjkDnhlKKBJK2D8vstXljK7JruSztxisksy/vOuIniDw/4tFtEBpZrODyfu\nEBoljh7kejWyG8aKELfVVH6SuYuKdcoc8gUEMTVepC3GLoalYpPtvEnwaU38XTLB\ndAW52s/3AgMBAAECggEAFyfPJ3xqEEivLSNpes0KXEhAhwV2GHT66QoD33j/cgnd\nt3fo67oXoGM4cFI3caOiDSWwcbKno5wjYQhEdN/oAKrzDJgOMGVfYH0Xvbr0dfSn\nKiCdW7Ntuc1d6AxuTCjL6ckeWXVeSGJUpQLjRrCrDuFL4tTnqWmIrMg8m/UJg1n1\nGI5hLCGMMouCiEtdNxxwueRujZLq+c5eZYUeieaE4II8FWGtySKaUEwrbgGlsNU5\ngP24zYyDbZcQrGKV0Gz56/jVQrLfO/ZKChyBeTdi/gWQXCUuTxNT5yQzASZB/5pa\nwKT1hbzWiHkWgVcVST1wCiQqD3QhKnHERDcpezo6OQKBgQD5apEHFHs4a7n4vYTE\n5nFSPfEV7kXKZ3CEz3e/t/nRQSditcm7vucky8nuqeRXn075M7y/07qTPcTTHGvh\nwoaQIOmNZRoLvCFMPePk1yC+hsOLKXccg6hMyz2h24e4FJTBuU/3kbKcb9/0Tqko\ngEE4QHTopavoddicAc2PCsmmPQKBgQDkOEUU9KfiMetRk0+PBTkwnCNrbgYczYJC\n4il5WTYmqizd9fjJWlpPqYfCE/EbkamJDJ39raNmG+sCseyFAzn3S6bI+WAWmMrc\nr5bv9lxqGma4ReTmeuzJ64P4iMk1Gh5PNN6y1iSQtN3YE7l7Y9shZ0dyj3yriJVd\nxdxWj7hmQwKBgGxlFfZfvlV86+vgYY05IVK+vMHtNcOLROlTSRW3HQkGKdnKa4v+\noXHqZy4kA6rY/3dqNsOfftxy4dFl7rTE17pXs2jR4YnsDwSVeS+BFyf2ZZFbSfrI\ndSI6yeRIBinIOAYhRVGwrlEyhcAlV3rUkoOh760UIyv521OhrPZXl995AoGAH6ha\nlNyXST5JeUho+drsovyVwTpC6M3tKt/6htXEODrU/Hk5aJz6+B/5MAfaI0via5tv\ncxgaGXj38ajCuXTIHrDE0w4csSXCxjgpROI00ZcV9qvjY8FbhWsBJIG8/3u/Bpe7\n6Kzh55zfRTD/QsmIRSrxc0fKMHVC2v4uYWeQWccCgYB+qAbZHwEkg0cHKoO0RUIK\n4QLWUBI10RtVDaa190eRbwA3fydA4kqrMLcEUQ6EFuGIc73W3qDJyRwsxdytMvvU\nB0xmDy9AOmwgNAlVE4EG2lCkhk+Lt8yBsM/iP6A5aji3tpMwiEom10BXwE6kA/VZ\nSqapwtuGamtTc9j0OlXlXA==\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-91d7o@ept-app-46930.iam.gserviceaccount.com",
    "client_id": "113199413543103261361",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-91d7o%40ept-app-46930.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };

  List<String> scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/firebase.database",
    "https://www.googleapis.com/auth/firebase.messaging"
  ];

  http.Client client = await auth.clientViaServiceAccount(
    auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
    scopes,
  );

  // Obtain the access token
  auth.AccessCredentials credentials =
      await auth.obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
          scopes,
          client);

  // Close the HTTP client
  client.close();

  // Return the access token
  return credentials.accessToken.data;
}

Future<void> sendFCMMessage() async {
  final String serverKey = await getAccessToken(); // Your FCM server key
  final String fcmEndpoint =
      'https://fcm.googleapis.com/v1/projects/ept-app-46930/messages:send';
  final currentFCMToken = await FirebaseMessaging.instance.getToken();
  print("fcmkey : $currentFCMToken");
  final Map<String, dynamic> message = {
    'message': {
      'token':
          currentFCMToken, // Token of the device you want to send the message to
      'notification': {
        'body': 'This is an FCM notification message!',
        'title': 'FCM Message'
      },
      'data': {
        'current_user_fcm_token':
            currentFCMToken, // Include the current user's FCM token in data payload
      },
    }
  };

  final http.Response response = await http.post(
    Uri.parse(fcmEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    },
    body: jsonEncode(message),
  );

  if (response.statusCode == 200) {
    print('FCM message sent successfully');
  } else {
    print('Failed to send FCM message: ${response.statusCode}');
  }
}

// void _handleSignOut(BuildContext context) async {
//   try {
//     FirebaseAuth.instance.signOut();
//     await _googleSignIn.signOut();
//     // After sign out, navigate to the login or home screen
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 LoginPage())); // Replace '/login' with your desired route
//   } catch (error) {
//     print("Error signing out: $error");
//   }
// }
