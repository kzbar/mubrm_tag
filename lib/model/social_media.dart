import 'dart:convert';

class SocialMedia {
  SocialMedia(
      {this.id,
      this.firebaseId,
      this.socialName,
      this.socialLinkIos,
      this.socialLinkAndroid,
      this.socialLinkWeb,
      this.socialIcon,
      this.socialIsSelect,
      this.socialAddedTo,
      this.value,
      this.messageAR,
      this.messageEN});
  int id;
  String firebaseId;
  String socialName;
  String socialLinkIos;
  String socialLinkAndroid;
  String socialLinkWeb;
  String socialIcon;
  bool socialIsSelect;
  bool socialAddedTo;
  String value;
  String messageAR;
  String messageEN;

  factory SocialMedia.fromRawJson(String str) =>
      SocialMedia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
      id: json["id"],
      socialName: json["socialName"],
      socialLinkIos: json["socialLinkIos"],
      socialLinkAndroid: json["socialLinkAndroid"],
      socialLinkWeb: json["socialLinkWeb"],
      socialIcon: json["socialIcon"],
      socialAddedTo: json["socialAddedTo"],
      socialIsSelect: json["socialIsSelect"],
      value: json["value"],
      messageAR: json['messageAR'] ,
      messageEN: json['messageEN'] );
  factory SocialMedia.fromJsonFireStore(Map<String, dynamic> json, String id) =>
      SocialMedia(
          firebaseId: id,
          id: json["id"],
          socialName: json["socialName"],
          socialLinkIos: json["socialLinkIos"],
          socialLinkAndroid: json["socialLinkAndroid"],
          socialLinkWeb: json["socialLinkWeb"],
          socialIcon: json["socialIcon"],
          socialAddedTo: json["socialAddedTo"],
          socialIsSelect: json["socialIsSelect"],
          value: json["value"],
          messageAR: json['messageAR'] ,
          messageEN: json['messageEN'] );

  Map<String, dynamic> toJson() => {
        "id": id,
        "socialName": socialName,
        "socialLinkIos": socialLinkIos,
        "socialLinkAndroid": socialLinkAndroid,
        "socialLinkWeb": socialLinkWeb,
        "socialIcon": socialIcon,
        "socialIsSelect": socialIsSelect,
        "socialAddedTo": socialAddedTo,
        "value": value,
        "messageAR": messageAR,
        "messageEN": messageEN,
      };
}
