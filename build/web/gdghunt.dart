import 'dart:html';


import 'package:googleapis_auth/auth_browser.dart' as auth;

import 'package:googleapis/games/v1.dart';


void main() {
  var id = new auth.ClientId("1095911519905-p6c1e3mm7pr550fsm4m957rr47bjo44r.apps.googleusercontent.com", "1BPU5F-emV3OGNbVyS3SS4oR");
  var scopes = [GamesApi.PlusLoginScope, GamesApi.GamesScope];


  // Initialize the browser oauth2 flow functionality.
  auth.createImplicitBrowserFlow(id, scopes).then((auth.BrowserOAuth2Flow flow) {
   flow.clientViaUserConsent().then((auth.AutoRefreshingAuthClient client) {
    var game = new GamesApi(client);
        game.leaderboards.get("CgkIoe2qy_IfEAIQAg").then((Leaderboard leaderBoard) {
          print(leaderBoard.id);
        });
      client.close();
      flow.close();
    });
  });
  


}


void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
