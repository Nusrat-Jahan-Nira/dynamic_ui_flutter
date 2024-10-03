
class UIComponent {
  String type; // e.g., "text", "button", "dropdown"
  String label; // Display label
  String? placeholder; // Placeholder for input fields
  ActionDetails? actionDetails; // Details for the action to be taken
  List<String>? options; // List of options for dropdown components

  UIComponent({
    required this.type,
    required this.label,
    this.placeholder,
    this.actionDetails,
    this.options,
  });

  // Factory constructor to parse JSON
  factory UIComponent.fromJson(Map<String, dynamic> json) {
    return UIComponent(
      type: json['type']??"",
      label: json['label']??"",
      placeholder: json['placeholder']??"",
      actionDetails: json['actionDetails'] != null
          ? ActionDetails.fromJson(json['actionDetails'])
          : null,
      options: json['options'] != null
          ? List<String>.from(json['options']) // Parse options if present
          : null,
    );
  }
}

class ActionDetails {
  String? url; // API endpoint
  String method; // HTTP method (GET/POST)
  String? successMessage; // Message on success
  String? errorMessage; // Message on error

  ActionDetails({
     this.url,
     required this.method,
     this.successMessage,
     this.errorMessage,
  });

  factory ActionDetails.fromJson(Map<String, dynamic> json) {
    return ActionDetails(
      url: json['url'],
      method: json['method'],
      successMessage: json['successMessage'],
      errorMessage: json['errorMessage'],
    );
  }
}
class LoginResponseModel {
  final String? statusCode;
  final String? statusMessage;
  final List<UIComponent>? components;

  LoginResponseModel({
     this.statusCode,
     this.statusMessage,
     this.components,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      components: json['components'] != null
          ? List<UIComponent>.from(
          (json['components'] as List)
              .map((component) => UIComponent.fromJson(component))
      )
          : null,
    );
  }
}

