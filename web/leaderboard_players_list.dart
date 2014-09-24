import 'package:polymer/polymer.dart';
import 'dart:html';

import 'package:googleapis_auth/auth_browser.dart' as auth;
import 'package:googleapis/games/v1.dart';


var id = new auth.ClientId("<YOUR_CLIENT_ID>", "<SECRET>");
var scopes = [GamesApi.PlusLoginScope, GamesApi.GamesScope];

@CustomTag('leaderboard-players-list')
class LeaderboardPlayersList extends PolymerElement {  
  
  @observable List<LeaderboardEntry> leaderboardPlayersList = toObservable([]);

  @observable String leaderboardName = toObservable([]);

  LeaderboardPlayersList.created() : super.created(); 
  

  void populateList(Event e, var detail, Node target) {
       leaderboardPlayersList.clear();
     

       auth.createImplicitBrowserFlow(id, scopes).then((auth.BrowserOAuth2Flow flow) {
         flow.clientViaUserConsent().then((auth.AuthClient client) {

           var game = new GamesApi(client);
           
           game.leaderboards.get("<LEADERBOARD_ID").then( (Leaderboard leaderboard) {
             leaderboardName = leaderboard.name;
           });

           game.scores.list("<LEADERBOARD_ID>", 'public', 'all_time').then((LeaderboardScores scores) {
               leaderboardPlayersList = scores.items;
           });


           client.close();
           flow.close();
         });
       });

  }
}