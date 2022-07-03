class ChangeFavouritesModel {
  dynamic status;
   String? message;

  ChangeFavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
  
}
