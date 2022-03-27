abstract class AppStates {}

class AppInitialState extends AppStates {}

class CreateDatabaseState extends AppStates {}

class GetDataFromDatabase extends AppStates {}

class InsertRecordToDatabase extends AppStates {}

class DeleteRecordFromDatabase extends AppStates {}

class UpdateRecordFromDatabase extends AppStates {}

class ChangeCurrentIndex extends AppStates {}

class CheckEmptyTextFields extends AppStates {}
