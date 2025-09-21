import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';
import 'package:money_flow/features/transactions/domain/repositories/transaction_repository.dart';

/// Use case for suggesting category and subcategory based on transaction details.
/// This use case uses AI/ML patterns to suggest appropriate categories for transactions.
///
/// Usage Example:
/// ```dart
/// final useCase = SuggestCategoryUseCase(repository: getIt<TransactionRepository>());
///
/// final result = await useCase.call(SuggestCategoryParams(
///   amount: 25.50,
///   description: 'Grocery shopping at SuperMart',
///   merchant: 'SuperMart',
/// ));
///
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (suggestion) => print('Suggested: ${suggestion.suggestedCategory} - ${suggestion.suggestedSubcategory}'),
/// );
/// ```
class SuggestCategoryUseCase {
  final TransactionRepository repository;

  SuggestCategoryUseCase({required this.repository});

  /// Executes the suggest category use case.
  /// This method analyzes transaction details and suggests appropriate categories.
  ///
  /// Parameters:
  /// - [params]: Parameters containing transaction details for analysis
  ///
  /// Returns:
  /// - [Either<Failure, CategorySuggestion>]: Success with suggestions or failure
  ///
  /// This method handles:
  /// - Input validation
  /// - Repository call for category suggestions
  /// - Fallback to pattern-based suggestions if repository fails
  /// - Error handling and failure propagation
  Future<Either<Failure, CategorySuggestion>> call(
    SuggestCategoryParams params,
  ) async {
    try {
      // Validate input parameters
      final validationResult = _validateParams(params);
      if (validationResult != null) {
        return Left(ValidationFailure(validationResult));
      }

      // Get suggestions from repository
      final result = await repository.suggestCategory(
        amount: params.amount,
        description: params.description,
        merchant: params.merchant,
      );

      return result.fold(
        (failure) {
          // If repository fails, use pattern-based suggestions
          return Right(_getPatternBasedSuggestion(params));
        },
        (suggestion) {
          // Return repository suggestions
          return Right(suggestion);
        },
      );
    } catch (e) {
      // Return pattern-based suggestions on any error
      return Right(_getPatternBasedSuggestion(params));
    }
  }

  /// Validates the input parameters for category suggestion.
  /// This method ensures the parameters are valid for analysis.
  ///
  /// Parameters:
  /// - [params]: Parameters to validate
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  ///
  /// This method checks:
  /// - Amount is not zero
  /// - At least one of description or merchant is provided
  String? _validateParams(SuggestCategoryParams params) {
    // Validate amount
    if (params.amount == 0) {
      return 'Transaction amount cannot be zero';
    }

    // Validate that we have some text to analyze
    if ((params.description?.trim().isEmpty ?? true) &&
        (params.merchant?.trim().isEmpty ?? true)) {
      return 'Either description or merchant must be provided for category suggestion';
    }

    return null; // Valid
  }

  /// Gets pattern-based category suggestions when repository fails.
  /// This method provides fallback suggestions using simple pattern matching.
  ///
  /// Parameters:
  /// - [params]: Parameters containing transaction details
  ///
  /// Returns:
  /// - [CategorySuggestion]: Pattern-based category suggestion
  ///
  /// This method uses simple keyword matching to suggest categories
  /// when the repository-based suggestions are not available.
  CategorySuggestion _getPatternBasedSuggestion(SuggestCategoryParams params) {
    final text = '${params.description ?? ''} ${params.merchant ?? ''}'
        .toLowerCase();

    // Food-related keywords
    if (text.contains(
      RegExp(
        r'\b(food|restaurant|cafe|grocery|supermarket|market|dining|eat|meal|pizza|burger|coffee|tea|bakery|deli)\b',
      ),
    )) {
      return CategorySuggestion(
        suggestedCategory: 'Food',
        suggestedSubcategory: _getFoodSubcategory(text),
        confidence: 0.8,
        alternativeCategories: [
          'Transportation',
          'Entertainment',
          'Utilities',
          'Other',
        ],
      );
    }

    // Transportation-related keywords
    if (text.contains(
      RegExp(
        r'\b(transport|taxi|uber|lyft|bus|train|metro|gas|fuel|parking|car|vehicle|auto|garage|repair)\b',
      ),
    )) {
      return CategorySuggestion(
        suggestedCategory: 'Transportation',
        suggestedSubcategory: _getTransportationSubcategory(text),
        confidence: 0.8,
        alternativeCategories: ['Food', 'Entertainment', 'Utilities', 'Other'],
      );
    }

    // Entertainment-related keywords
    if (text.contains(
      RegExp(
        r'\b(entertainment|movie|cinema|theater|game|sport|gym|fitness|music|book|streaming|netflix|spotify|amazon|apple|google)\b',
      ),
    )) {
      return CategorySuggestion(
        suggestedCategory: 'Entertainment',
        suggestedSubcategory: _getEntertainmentSubcategory(text),
        confidence: 0.8,
        alternativeCategories: ['Food', 'Transportation', 'Utilities', 'Other'],
      );
    }

    // Utilities-related keywords
    if (text.contains(
      RegExp(
        r'\b(utility|electric|water|internet|phone|mobile|bill|payment|subscription|wifi|cable|insurance)\b',
      ),
    )) {
      return CategorySuggestion(
        suggestedCategory: 'Utilities',
        suggestedSubcategory: _getUtilitiesSubcategory(text),
        confidence: 0.8,
        alternativeCategories: [
          'Food',
          'Transportation',
          'Entertainment',
          'Other',
        ],
      );
    }

    // Default to Other category
    return CategorySuggestion(
      suggestedCategory: 'Other',
      suggestedSubcategory: 'Misc',
      confidence: 0.3,
      alternativeCategories: [
        'Food',
        'Transportation',
        'Entertainment',
        'Utilities',
      ],
    );
  }

  /// Gets food subcategory based on text analysis.
  /// This method analyzes text to suggest appropriate food subcategories.
  ///
  /// Parameters:
  /// - [text]: Text to analyze
  ///
  /// Returns:
  /// - [String]: Suggested food subcategory
  String _getFoodSubcategory(String text) {
    if (text.contains(
      RegExp(r'\b(grocery|supermarket|market|store|walmart|target|costco)\b'),
    )) {
      return 'Groceries';
    }
    if (text.contains(
      RegExp(r'\b(restaurant|cafe|dining|eat|meal|diner|bistro)\b'),
    )) {
      return 'Restaurant';
    }
    if (text.contains(
      RegExp(r'\b(fast|quick|mcdonald|burger|kfc|pizza|domino)\b'),
    )) {
      return 'Fast Food';
    }
    if (text.contains(RegExp(r'\b(coffee|starbucks|tim|dunkin|tea|latte)\b'))) {
      return 'Coffee';
    }
    return 'Groceries';
  }

  /// Gets transportation subcategory based on text analysis.
  /// This method analyzes text to suggest appropriate transportation subcategories.
  ///
  /// Parameters:
  /// - [text]: Text to analyze
  ///
  /// Returns:
  /// - [String]: Suggested transportation subcategory
  String _getTransportationSubcategory(String text) {
    if (text.contains(
      RegExp(r'\b(gas|fuel|petrol|shell|exxon|bp|chevron)\b'),
    )) {
      return 'Gas';
    }
    if (text.contains(RegExp(r'\b(taxi|uber|lyft|ride|driver)\b'))) {
      return 'Taxi';
    }
    if (text.contains(RegExp(r'\b(bus|train|metro|public|transit|subway)\b'))) {
      return 'Public Transport';
    }
    if (text.contains(RegExp(r'\b(parking|garage|lot|meter)\b'))) {
      return 'Parking';
    }
    return 'Gas';
  }

  /// Gets entertainment subcategory based on text analysis.
  /// This method analyzes text to suggest appropriate entertainment subcategories.
  ///
  /// Parameters:
  /// - [text]: Text to analyze
  ///
  /// Returns:
  /// - [String]: Suggested entertainment subcategory
  String _getEntertainmentSubcategory(String text) {
    if (text.contains(
      RegExp(r'\b(movie|cinema|theater|film|amc|regal|imax)\b'),
    )) {
      return 'Movies';
    }
    if (text.contains(
      RegExp(r'\b(game|gaming|steam|playstation|xbox|nintendo)\b'),
    )) {
      return 'Games';
    }
    if (text.contains(
      RegExp(r'\b(gym|fitness|sport|yoga|pilates|workout)\b'),
    )) {
      return 'Fitness';
    }
    if (text.contains(
      RegExp(r'\b(music|spotify|apple|amazon|youtube|streaming)\b'),
    )) {
      return 'Music';
    }
    return 'Movies';
  }

  /// Gets utilities subcategory based on text analysis.
  /// This method analyzes text to suggest appropriate utilities subcategories.
  ///
  /// Parameters:
  /// - [text]: Text to analyze
  ///
  /// Returns:
  /// - [String]: Suggested utilities subcategory
  String _getUtilitiesSubcategory(String text) {
    if (text.contains(RegExp(r'\b(electric|power|energy|light|bulb)\b'))) {
      return 'Electricity';
    }
    if (text.contains(RegExp(r'\b(water|sewer|plumbing|faucet)\b'))) {
      return 'Water';
    }
    if (text.contains(
      RegExp(r'\b(internet|wifi|broadband|comcast|verizon|att)\b'),
    )) {
      return 'Internet';
    }
    if (text.contains(
      RegExp(r'\b(phone|mobile|telecom|verizon|att|tmobile)\b'),
    )) {
      return 'Phone';
    }
    return 'Electricity';
  }
}

/// Parameters for suggesting category based on transaction details.
/// This class encapsulates the data needed for category suggestion analysis.
///
/// Usage Example:
/// ```dart
/// final params = SuggestCategoryParams(
///   amount: 25.50,
///   description: 'Grocery shopping at SuperMart',
///   merchant: 'SuperMart',
/// );
/// ```
class SuggestCategoryParams {
  /// The transaction amount
  final double amount;

  /// Optional transaction description
  final String? description;

  /// Optional merchant name
  final String? merchant;

  const SuggestCategoryParams({
    required this.amount,
    this.description,
    this.merchant,
  });

  /// Creates a copy of this params with updated fields.
  /// This is useful for updating parameters while maintaining immutability.
  ///
  /// Parameters:
  /// - [amount]: Optional new amount
  /// - [description]: Optional new description
  /// - [merchant]: Optional new merchant
  ///
  /// Returns:
  /// - [SuggestCategoryParams]: Updated parameters
  SuggestCategoryParams copyWith({
    double? amount,
    String? description,
    String? merchant,
  }) {
    return SuggestCategoryParams(
      amount: amount ?? this.amount,
      description: description ?? this.description,
      merchant: merchant ?? this.merchant,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SuggestCategoryParams &&
        other.amount == amount &&
        other.description == description &&
        other.merchant == merchant;
  }

  @override
  int get hashCode {
    return Object.hash(amount, description, merchant);
  }

  @override
  String toString() {
    return 'SuggestCategoryParams(amount: $amount, description: $description, merchant: $merchant)';
  }
}
