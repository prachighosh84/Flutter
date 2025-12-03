import 'package:flutter/cupertino.dart';
import 'package:m2i_cours_flutter/models/server_model.dart';

class ServerProvider with  ChangeNotifier {

 List<Server> ? _servers;
 Server? _selectedServer;
 List<Server>? get  servers => _servers;
  Server? get selectedServer => _selectedServer;


  void setServers(List<Server> servers) {
    _servers = servers;
    notifyListeners();
  }
 void setSelectedServer(Server server) {
   _selectedServer = server;
   notifyListeners();
 }

}