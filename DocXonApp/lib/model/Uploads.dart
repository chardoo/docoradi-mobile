// import 'dart:ffi';

class Uploads {
  String documentType = "";
  String description = "";
  String file = "";
  String filename = "";
  Uploads(this.documentType, this.description, this.file, this.filename);

  Uploads.empty() {
    documentType = "";
    description = "";
    filename = "";
    file = "";
  }

  //deserialization
  factory Uploads.fromJson(Map<String, dynamic> json) {
    return Uploads(
      json["documentType"] as String,
      json["description"] as String,
      json["file"] as String,
      json["filename"] as String,
    );
  }

  //serialization
  Map<String, dynamic> toJson() {
    var map = {
      "properties": {
        "fields": [
          {
            "name": "documentType",
            "value": documentType,
          },
          {
            "name": "description",
            "value": description,
          }
        ],
        "type": {"name": documentType, "namespace": 'dxdt'},
      },
      "account": {"id": "appiahrichard1212@gmail.com", "type": "userId"},
      "document": {"filename": filename, "mime": "img/jpg", "file": file},
    };
    return map;
  }
}
