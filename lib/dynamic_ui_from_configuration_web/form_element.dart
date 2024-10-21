// class FormElement {
//   //final String type; // Type of the element (e.g., Text, EditText, Button)
//   final Map<String, dynamic> attributes; // Dynamic attributes for the element
//
//   FormElement({
//    // required this.type,
//     required this.attributes,
//   });
//
//   factory FormElement.fromJson(Map<String, dynamic> json) {
//     return FormElement(
//       //type: json['Type'] ?? json['Type'],
//       attributes: Map<String, dynamic>.from(json), // Convert the whole JSON to a map
//     );
//   }
//
//   dynamic getAttribute(String key) {
//     return attributes[key];
//   }
// }
class FormElement {
  final Map<String, dynamic> attributes;

  FormElement({required this.attributes});

  factory FormElement.fromJson(Map<String, dynamic> json) {
    return FormElement(
      //type: json['Type'] ?? json['Type'],
      attributes: Map<String, dynamic>.from(json), // Convert the whole JSON to a map
    );
  }

  dynamic getAttribute(String key) {
    return attributes[key]; // Directly access the key in the attributes map
  }
}
