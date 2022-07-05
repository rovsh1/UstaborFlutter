// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

IOSVersionCheck iOSVersionCheckFromJson(String str) => IOSVersionCheck.fromJson(json.decode(str));

String iOSVersionCheckToJson(IOSVersionCheck data) => json.encode(data.toJson());

class IOSVersionCheck {
  IOSVersionCheck({
   required this.resultCount,
   required this.results,
  });

  int resultCount;
  List<Result> results;

  factory IOSVersionCheck.fromJson(Map<String, dynamic> json) => IOSVersionCheck(
    resultCount: json["resultCount"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resultCount": resultCount,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
  required  this.screenshotUrls,
  required  this.ipadScreenshotUrls,
  required  this.artworkUrl60,
  required  this.artworkUrl512,
  required  this.artworkUrl100,
  required  this.artistViewUrl,
  required  this.appletvScreenshotUrls,
  required  this.features,
  required  this.supportedDevices,
  required  this.advisories,
   required this.isGameCenterEnabled,
   required this.kind,
   required this.minimumOsVersion,
   required this.trackCensoredName,
   required this.languageCodesIso2A,
   required this.fileSizeBytes,
   required this.formattedPrice,
   required this.contentAdvisoryRating,
   required this.averageUserRatingForCurrentVersion,
   required this.userRatingCountForCurrentVersion,
   required this.averageUserRating,
   required this.trackViewUrl,
   required this.trackContentRating,
   required this.bundleId,
   required this.trackId,
   required this.trackName,
   required this.releaseDate,
   required this.genreIds,
   required this.primaryGenreName,
   required this.isVppDeviceBasedLicensingEnabled,
   required this.sellerName,
   required this.currentVersionReleaseDate,
   required this.releaseNotes,
   required this.primaryGenreId,
   required this.currency,
   required this.artistId,
   required this.artistName,
   required this.genres,
   required this.price,
   required this.description,
   required this.version,
  required  this.wrapperType,
  required  this.userRatingCount,
  });

  List<String> screenshotUrls;
  List<dynamic> ipadScreenshotUrls;
  String artworkUrl60;
  String artworkUrl512;
  String artworkUrl100;
  String artistViewUrl;
  List<dynamic> appletvScreenshotUrls;
  List<dynamic> features;
  List<String> supportedDevices;
  List<dynamic> advisories;
  bool isGameCenterEnabled;
  String kind;
  String minimumOsVersion;
  String trackCensoredName;
  List<String> languageCodesIso2A;
  String fileSizeBytes;
  String formattedPrice;
  String contentAdvisoryRating;
  int averageUserRatingForCurrentVersion;
  int userRatingCountForCurrentVersion;
  int averageUserRating;
  String trackViewUrl;
  String trackContentRating;
  String bundleId;
  int trackId;
  String trackName;
  DateTime releaseDate;
  List<String> genreIds;
  String primaryGenreName;
  bool isVppDeviceBasedLicensingEnabled;
  String sellerName;
  DateTime currentVersionReleaseDate;
  String releaseNotes;
  int primaryGenreId;
  String currency;
  int artistId;
  String artistName;
  List<String> genres;
  int price;
  String description;
  String version;
  String wrapperType;
  int userRatingCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    screenshotUrls: List<String>.from(json["screenshotUrls"].map((x) => x)),
    ipadScreenshotUrls: List<dynamic>.from(json["ipadScreenshotUrls"].map((x) => x)),
    artworkUrl60: json["artworkUrl60"],
    artworkUrl512: json["artworkUrl512"],
    artworkUrl100: json["artworkUrl100"],
    artistViewUrl: json["artistViewUrl"],
    appletvScreenshotUrls: List<dynamic>.from(json["appletvScreenshotUrls"].map((x) => x)),
    features: List<dynamic>.from(json["features"].map((x) => x)),
    supportedDevices: List<String>.from(json["supportedDevices"].map((x) => x)),
    advisories: List<dynamic>.from(json["advisories"].map((x) => x)),
    isGameCenterEnabled: json["isGameCenterEnabled"],
    kind: json["kind"],
    minimumOsVersion: json["minimumOsVersion"],
    trackCensoredName: json["trackCensoredName"],
    languageCodesIso2A: List<String>.from(json["languageCodesISO2A"].map((x) => x)),
    fileSizeBytes: json["fileSizeBytes"],
    formattedPrice: json["formattedPrice"],
    contentAdvisoryRating: json["contentAdvisoryRating"],
    averageUserRatingForCurrentVersion: json["averageUserRatingForCurrentVersion"],
    userRatingCountForCurrentVersion: json["userRatingCountForCurrentVersion"],
    averageUserRating: json["averageUserRating"],
    trackViewUrl: json["trackViewUrl"],
    trackContentRating: json["trackContentRating"],
    bundleId: json["bundleId"],
    trackId: json["trackId"],
    trackName: json["trackName"],
    releaseDate: DateTime.parse(json["releaseDate"]),
    genreIds: List<String>.from(json["genreIds"].map((x) => x)),
    primaryGenreName: json["primaryGenreName"],
    isVppDeviceBasedLicensingEnabled: json["isVppDeviceBasedLicensingEnabled"],
    sellerName: json["sellerName"],
    currentVersionReleaseDate: DateTime.parse(json["currentVersionReleaseDate"]),
    releaseNotes: json["releaseNotes"],
    primaryGenreId: json["primaryGenreId"],
    currency: json["currency"],
    artistId: json["artistId"],
    artistName: json["artistName"],
    genres: List<String>.from(json["genres"].map((x) => x)),
    price: json["price"],
    description: json["description"],
    version: json["version"],
    wrapperType: json["wrapperType"],
    userRatingCount: json["userRatingCount"],
  );

  Map<String, dynamic> toJson() => {
    "screenshotUrls": List<dynamic>.from(screenshotUrls.map((x) => x)),
    "ipadScreenshotUrls": List<dynamic>.from(ipadScreenshotUrls.map((x) => x)),
    "artworkUrl60": artworkUrl60,
    "artworkUrl512": artworkUrl512,
    "artworkUrl100": artworkUrl100,
    "artistViewUrl": artistViewUrl,
    "appletvScreenshotUrls": List<dynamic>.from(appletvScreenshotUrls.map((x) => x)),
    "features": List<dynamic>.from(features.map((x) => x)),
    "supportedDevices": List<dynamic>.from(supportedDevices.map((x) => x)),
    "advisories": List<dynamic>.from(advisories.map((x) => x)),
    "isGameCenterEnabled": isGameCenterEnabled,
    "kind": kind,
    "minimumOsVersion": minimumOsVersion,
    "trackCensoredName": trackCensoredName,
    "languageCodesISO2A": List<dynamic>.from(languageCodesIso2A.map((x) => x)),
    "fileSizeBytes": fileSizeBytes,
    "formattedPrice": formattedPrice,
    "contentAdvisoryRating": contentAdvisoryRating,
    "averageUserRatingForCurrentVersion": averageUserRatingForCurrentVersion,
    "userRatingCountForCurrentVersion": userRatingCountForCurrentVersion,
    "averageUserRating": averageUserRating,
    "trackViewUrl": trackViewUrl,
    "trackContentRating": trackContentRating,
    "bundleId": bundleId,
    "trackId": trackId,
    "trackName": trackName,
    "releaseDate": releaseDate.toIso8601String(),
    "genreIds": List<dynamic>.from(genreIds.map((x) => x)),
    "primaryGenreName": primaryGenreName,
    "isVppDeviceBasedLicensingEnabled": isVppDeviceBasedLicensingEnabled,
    "sellerName": sellerName,
    "currentVersionReleaseDate": currentVersionReleaseDate.toIso8601String(),
    "releaseNotes": releaseNotes,
    "primaryGenreId": primaryGenreId,
    "currency": currency,
    "artistId": artistId,
    "artistName": artistName,
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "price": price,
    "description": description,
    "version": version,
    "wrapperType": wrapperType,
    "userRatingCount": userRatingCount,
  };
}
