import 'package:flutter/services.dart';

import 'dart:developer';
import 'package:http/http.dart' as http;
import '../modal/photo_model.dart';
import '../constant.dart';

class ApiServices {
  // this function gets a list of photos from the database
  Future<List<PhotoModel>?> getPhotos() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.photosEndPoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<PhotoModel> model = photoModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
