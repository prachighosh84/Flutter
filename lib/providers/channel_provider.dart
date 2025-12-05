import 'package:flutter/cupertino.dart';
import 'package:m2i_cours_flutter/models/channel_model.dart';

class ChannelProvider with  ChangeNotifier {

 List<Channel> ? _channels;
 Channel? _selectedChannel;
 List<Channel>? get  channels => _channels;
 Channel? get selectedChannel => _selectedChannel;


  void setChannels(List<Channel> channels) {
    _channels = channels;
    notifyListeners();
  }
 void setSelectedChannel(Channel channel) {
   _selectedChannel = channel;
   notifyListeners();
 }

}