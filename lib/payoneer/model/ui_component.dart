// class UIComponent {
//   final String type;
//   final String label;
//   final String? placeholder;
//   final String? value;
//   final ActionDetails? actionDetails;
//   final List<String>? options;
//
//   UIComponent({
//     required this.type,
//     required this.label,
//     this.placeholder,
//     this.value,
//     this.actionDetails,
//     this.options,
//   });
//
//   factory UIComponent.fromJson(Map<String, dynamic> json) {
//     return UIComponent(
//       type: json['type'],
//       label: json['label'],
//       placeholder: json['placeholder'],
//       value: json['value'],
//       actionDetails: json['actionDetails'] != null
//           ? ActionDetails.fromJson(json['actionDetails'])
//           : null,
//       options: json['options'] != null
//           ? List<String>.from(json['options'])
//           : null,
//     );
//   }
// }

class UIComponent {
  final String type;
  final String? label;
  final String? placeholder;
  final String? value;
  final ActionDetails? actionDetails;
  final List<UIComponent>? children; // For components with child elements

  UIComponent({
    required this.type,
    this.label,
    this.placeholder,
    this.value,
    this.actionDetails,
    this.children,
  });

  factory UIComponent.fromJson(Map<String, dynamic> json) {
    return UIComponent(
      type: json['type'] ?? '',
      label: json['label'],
      placeholder: json['placeholder'],
      value: json['value'],
      actionDetails: json['actionDetails'] != null
          ? ActionDetails.fromJson(json['actionDetails'])
          : null,
      children: json['children'] != null
          ? (json['children'] as List)
          .map((child) => UIComponent.fromJson(child))
          .toList()
          : null,
    );
  }
}

class ActionDetails {
  final String url;
  final String method;
  final String successMessage;
  final String errorMessage;

  ActionDetails({
    required this.url,
    required this.method,
    required this.successMessage,
    required this.errorMessage,
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

class APIResponse {
  final String statusCode;
  final String statusMessage;
  final List<UIComponent> components;

  APIResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.components,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      components: List<UIComponent>.from(
        json['components'].map((component) => UIComponent.fromJson(component)),
      ),
    );
  }
}
