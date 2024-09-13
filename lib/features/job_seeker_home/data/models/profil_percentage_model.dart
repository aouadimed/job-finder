// Postman Echo is service you can use to test your REST clients and make sample API calls.

// It provides endpoints for `GET`, `POST`, `PUT`, various auth mechanisms and other utility

// endpoints.

//

// The documentation for the endpoints as well as example responses can be found at

// [https://postman-echo.com](https://postman-echo.com/?source=echo-collection-app-onboarding)

// To parse this JSON data, do
//
//     final completionPercentage = completionPercentageFromJson(jsonString);

import 'dart:convert';

CompletionPercentage completionPercentageFromJson(String str) => CompletionPercentage.fromJson(json.decode(str));

String completionPercentageToJson(CompletionPercentage data) => json.encode(data.toJson());

class CompletionPercentage {
    int completionPercentage;
    List<String> errors;
    String message;

    CompletionPercentage({
        required this.completionPercentage,
        required this.errors,
        required this.message,
    });

    factory CompletionPercentage.fromJson(Map<String, dynamic> json) => CompletionPercentage(
        completionPercentage: json["completionPercentage"],
        errors: List<String>.from(json["errors"].map((x) => x)),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "completionPercentage": completionPercentage,
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "message": message,
    };
}
