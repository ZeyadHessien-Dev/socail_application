class MessageModel {
  String? text;
  String? dateTime;
  String? senderUID;
  String? receiverUID;

  MessageModel({
    this.text,
    this.dateTime,
    this.receiverUID,
    this.senderUID,
});

  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    dateTime = json['dateTime'];
    receiverUID = json['receiverUID'];
    senderUID = json['senderUID'];
  }

  Map<String,dynamic> toMap() {
    return {
      'text' : text,
      'dateTime' : dateTime,
      'senderUID' : senderUID,
      'receiverUID' : receiverUID,
    };
  }
}