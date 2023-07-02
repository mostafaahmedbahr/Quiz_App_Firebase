abstract class StudentQuizStates{}

class StudentQuizInitState extends StudentQuizStates{}

class GetAllQuizLoadingState extends StudentQuizStates{}
class GetAllQuizSuccessState extends StudentQuizStates{}
class GetAllQuizErrorState extends StudentQuizStates{}

class ScoreStudentAnswersLoadingState extends StudentQuizStates{}
class ScoreStudentAnswersSuccessState extends StudentQuizStates{}
class ScoreStudentAnswersErrorState extends StudentQuizStates{}

class StoreStudentScoreLoadingState extends StudentQuizStates{}
class StoreStudentScoreSuccessState extends StudentQuizStates{}
class StoreStudentScoreErrorState extends StudentQuizStates{}