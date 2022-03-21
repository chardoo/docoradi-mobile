/*
{
  email: "",
  firstName: "",
  lastName: "",
  mobile: "",
  password: "",
  
}
*/

class UploadedDocuments {
  final String documentURL;
  final String objectID;
  final String documentType;
  final String description;

  UploadedDocuments(
      this.documentURL, this.objectID, this.documentType, this.description);

  //deserialization
  factory UploadedDocuments.fromMap(Map<String, dynamic> json) {
    return UploadedDocuments(json["documentURL"], json["objectID"],
        json["docuemntType"], json["description"]);
  }
  Map<String, dynamic> toJson() => {
        "documentURL": documentURL,
        "objectID": objectID,
        "docuemntType": documentType,
        "isViewed": description,
      };

  //serialization

  @override
  String toString() {
    return "{ documentURL: $documentURL,  objectID: $objectID "
        " docuemntType: $documentType, description: $description}";
  }
}
