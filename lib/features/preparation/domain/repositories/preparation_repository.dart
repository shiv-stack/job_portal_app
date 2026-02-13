import '../entities/preparation_content.dart';

abstract class PreparationRepository {
  Future<List<PreparationContent>> getContentByCategory(String categoryId);
}
