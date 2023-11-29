
:- [hogwarts].

studentOf(Student, Teacher) :-
    teacherOf(Teacher, Student).

classmates(StudentOne, StudentTwo):- 
    studentOf(Teacher, StudentOne),
    studentOf(Teacher, StudentTwo),
    StudentOne \= StudentTwo.


% liveFarAway(StudentOne, StudentTwo):- fail.
liveFarAway(StudentOne, StudentTwo):- 
    houseOf(HouseOne, StudentOne),
    houseOf(HouseTwo, StudentTwo),
    farLocation(HouseOne, HouseTwo),
    HouseOne \= HouseTwo.


% isSeniorOf(PersonA, PersonB):- fa
isSeniorOf(PersonA, PersonB) :-
    directSeniorOf(PersonA, PersonB),
    PersonA \= PersonB.
    
isSeniorOf(PersonA, PersonB) :-
    directSeniorOf(PersonA, Intermediate),
    isSeniorOf(Intermediate, PersonB),
    PersonA \= PersonB.



% listSeniors(Person, Seniors):- fail.
listSeniors(Person, Seniors) :-
    findall(Senior, isSeniorOf(Senior, Person), Seniors).





% listJuniors(Person, Juniors):- fail.
isJuniorOf(Junior, Senior) :-
    isSeniorOf(Senior, Junior).

listJuniors(Person, Juniors) :-
    findall(Junior, isJuniorOf(Junior, Person), Juniors).


% make sure they are a student in the house first
% Define the oldestStudent/2 predicate
oldestStudent(Person, House) :-
    houseOf(House, Student),
    birthYear(Student, BirthYear),
    % \+ is 'not provable' operator. It succeeds if its argument is not provable (and fails if its argument is provable).
    \+ (houseOf(_, AnotherStudent), birthYear(AnotherStudent, AnotherBirthYear), AnotherBirthYear > BirthYear),
    Person = Student.



youngestStudent(Person, House) :-
    houseOf(House, Student),
    birthYear(Student, BirthYear),
    \+ (houseOf(_, AnotherStudent), birthYear(AnotherStudent, AnotherBirthYear), AnotherBirthYear < BirthYear),
    Person = Student.


oldestQuidditchStudent(Team, Student):- fail.


youngestQuidditchStudent(Team, Student):- fail.
% youngestQuidditchStudent(Team, Student) :-

rival(StudentOne, StudentTwo) :-
    houseOf(HouseOne, StudentOne),
    houseOf(HouseTwo, StudentTwo),
    StudentOne \= StudentTwo,
    HouseOne \= HouseTwo.


farRival(StudentOne, StudentTwo) :-
    rival(StudentOne, StudentTwo),
    liveFarAway(StudentOne, StudentTwo).
