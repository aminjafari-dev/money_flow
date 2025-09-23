/// Request model for creating or updating transactions via API.
/// This model handles the data structure for API requests and validation.
///
/// Usage Example:
/// ```dart
/// // Create transaction request
/// final request = TransactionRequest(
///   amount: 25.50,
///   category: 'Food',
///   subcategory: 'Groceries',
///   description: 'Weekly shopping',
///   dateTime: DateTime.now(),
///   type: TransactionType.expense,
///   merchant: 'SuperMart',
/// );
///
/// // Convert to JSON for API call
/// final json = request.toJson();
/// ```
class TransactionRequest {
  /// Transaction amount (positive for income, negative for expense)
  final double amount;

  /// Main category of the transaction
  final String category;

  /// Specific subcategory within the main category
  final String subcategory;

  /// Optional description or notes about the transaction
  final String? description;

  /// Date and time when the transaction occurred
  final DateTime dateTime;

  /// Type of transaction (expense or income)
  final String type;

  /// Whether this transaction was created from SMS import
  final bool isFromSms;

  /// Merchant or vendor name
  final String? merchant;

  const TransactionRequest({
    required this.amount,
    required this.category,
    required this.subcategory,
    this.description,
    required this.dateTime,
    required this.type,
    this.isFromSms = false,
    this.merchant,
  });

  /// Creates a TransactionRequest from JSON data.
  /// This is used when receiving request data from client applications.
  ///
  /// Parameters:
  /// - [json]: Map containing request data
  ///
  /// Returns:
  /// - [TransactionRequest]: Parsed transaction request
  ///
  /// Example:
  /// ```dart
  /// final json = {
  ///   'amount': 25.50,
  ///   'category': 'Food',
  ///   'subcategory': 'Groceries',
  ///   'description': 'Weekly shopping',
  ///   'dateTime': '2024-01-15T10:30:00Z',
  ///   'type': 'expense',
  ///   'isFromSms': false,
  ///   'merchant': 'SuperMart',
  /// };
  /// final request = TransactionRequest.fromJson(json);
  /// ```
  factory TransactionRequest.fromJson(Map<String, dynamic> json) {
    return TransactionRequest(
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      description: json['description'] as String?,
      dateTime: DateTime.parse(json['dateTime'] as String),
      type: json['type'] as String,
      isFromSms: json['isFromSms'] as bool? ?? false,
      merchant: json['merchant'] as String?,
    );
  }

  /// Converts the request to JSON format.
  /// This is used when sending data to API endpoints.
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: JSON representation of the request
  ///
  /// Example:
  /// ```dart
  /// final request = TransactionRequest(...);
  /// final json = request.toJson();
  /// // Send to API endpoint
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'category': category,
      'subcategory': subcategory,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'type': type,
      'isFromSms': isFromSms,
      'merchant': merchant,
    };
  }

  /// Creates a copy of this request with updated fields.
  /// This is useful for updating request details while maintaining immutability.
  ///
  /// Parameters:
  /// - [amount]: Optional new amount
  /// - [category]: Optional new category
  /// - [subcategory]: Optional new subcategory
  /// - [description]: Optional new description
  /// - [dateTime]: Optional new date time
  /// - [type]: Optional new type
  /// - [isFromSms]: Optional new SMS flag
  /// - [merchant]: Optional new merchant
  ///
  /// Returns:
  /// - [TransactionRequest]: Updated transaction request
  TransactionRequest copyWith({
    double? amount,
    String? category,
    String? subcategory,
    String? description,
    DateTime? dateTime,
    String? type,
    bool? isFromSms,
    String? merchant,
  }) {
    return TransactionRequest(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      isFromSms: isFromSms ?? this.isFromSms,
      merchant: merchant ?? this.merchant,
    );
  }

  /// Validates the transaction request data.
  /// This ensures all required fields are present and valid.
  ///
  /// Returns:
  /// - [List<String>]: List of validation error messages (empty if valid)
  ///
  /// Example:
  /// ```dart
  /// final request = TransactionRequest(...);
  /// final errors = request.validate();
  /// if (errors.isNotEmpty) {
  ///   // Handle validation errors
  ///   print('Validation errors: ${errors.join(', ')}');
  /// }
  /// ```
  List<String> validate() {
    final errors = <String>[];

    // Validate amount
    if (amount == 0) {
      errors.add('Amount cannot be zero');
    }

    // Validate category
    if (category.trim().isEmpty) {
      errors.add('Category is required');
    }

    // Validate type
    if (type != 'expense' && type != 'income') {
      errors.add('Type must be either "expense" or "income"');
    }

    // Validate date time
    if (dateTime.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      errors.add('Transaction date cannot be more than 1 day in the future');
    }

    return errors;
  }

  /// Checks if the request is valid.
  /// This is a convenience method that returns true if validation passes.
  ///
  /// Returns:
  /// - [bool]: True if the request is valid, false otherwise
  ///
  /// Example:
  /// ```dart
  /// final request = TransactionRequest(...);
  /// if (request.isValid) {
  ///   // Proceed with API call
  ///   await apiService.createTransaction(request);
  /// } else {
  ///   // Show validation errors
  ///   final errors = request.validate();
  ///   showErrorDialog(errors);
  /// }
  /// ```
  bool get isValid => validate().isEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionRequest &&
        other.amount == amount &&
        other.category == category &&
        other.subcategory == subcategory &&
        other.description == description &&
        other.dateTime == dateTime &&
        other.type == type &&
        other.isFromSms == isFromSms &&
        other.merchant == merchant;
  }

  @override
  int get hashCode {
    return Object.hash(
      amount,
      category,
      subcategory,
      description,
      dateTime,
      type,
      isFromSms,
      merchant,
    );
  }

  @override
  String toString() {
    return 'TransactionRequest(amount: $amount, category: $category, subcategory: $subcategory, description: $description, dateTime: $dateTime, type: $type, isFromSms: $isFromSms, merchant: $merchant)';
  }
}

/// Request model for updating existing transactions.
/// This extends TransactionRequest with an ID field for updates.
///
/// Usage Example:
/// ```dart
/// final updateRequest = TransactionUpdateRequest(
///   id: 'txn_123',
///   amount: 30.00,
///   category: 'Food',
///   subcategory: 'Restaurant',
///   description: 'Updated description',
///   dateTime: DateTime.now(),
///   type: 'expense',
/// );
/// ```
class TransactionUpdateRequest extends TransactionRequest {
  /// Unique identifier of the transaction to update
  final String id;

  const TransactionUpdateRequest({
    required this.id,
    required super.amount,
    required super.category,
    required super.subcategory,
    super.description,
    required super.dateTime,
    required super.type,
    super.isFromSms,
    super.merchant,
  });

  /// Creates a TransactionUpdateRequest from JSON data.
  /// This is used when receiving update request data from client applications.
  ///
  /// Parameters:
  /// - [json]: Map containing update request data
  ///
  /// Returns:
  /// - [TransactionUpdateRequest]: Parsed transaction update request
  factory TransactionUpdateRequest.fromJson(Map<String, dynamic> json) {
    return TransactionUpdateRequest(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      description: json['description'] as String?,
      dateTime: DateTime.parse(json['dateTime'] as String),
      type: json['type'] as String,
      isFromSms: json['isFromSms'] as bool? ?? false,
      merchant: json['merchant'] as String?,
    );
  }

  /// Converts the update request to JSON format.
  /// This is used when sending update data to API endpoints.
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: JSON representation of the update request
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['id'] = id;
    return json;
  }

  /// Creates a copy of this update request with updated fields.
  /// This is useful for updating request details while maintaining immutability.
  ///
  /// Parameters:
  /// - [id]: Optional new ID
  /// - [amount]: Optional new amount
  /// - [category]: Optional new category
  /// - [subcategory]: Optional new subcategory
  /// - [description]: Optional new description
  /// - [dateTime]: Optional new date time
  /// - [type]: Optional new type
  /// - [isFromSms]: Optional new SMS flag
  /// - [merchant]: Optional new merchant
  ///
  /// Returns:
  /// - [TransactionUpdateRequest]: Updated transaction update request
  TransactionUpdateRequest copyWith({
    String? id,
    double? amount,
    String? category,
    String? subcategory,
    String? description,
    DateTime? dateTime,
    String? type,
    bool? isFromSms,
    String? merchant,
  }) {
    return TransactionUpdateRequest(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      isFromSms: isFromSms ?? this.isFromSms,
      merchant: merchant ?? this.merchant,
    );
  }

  @override
  List<String> validate() {
    final errors = super.validate();

    // Validate ID
    if (id.trim().isEmpty) {
      errors.add('Transaction ID is required for updates');
    }

    return errors;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionUpdateRequest &&
        other.id == id &&
        super == other;
  }

  @override
  int get hashCode {
    return Object.hash(id, super.hashCode);
  }

  @override
  String toString() {
    return 'TransactionUpdateRequest(id: $id, amount: $amount, category: $category, subcategory: $subcategory, description: $description, dateTime: $dateTime, type: $type, isFromSms: $isFromSms, merchant: $merchant)';
  }
}
