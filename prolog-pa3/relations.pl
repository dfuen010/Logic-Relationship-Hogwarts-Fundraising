:- [hogwarts].

studentOf(Student, Teacher) :-
    teacherOf(Teacher, Student).

classmates(StudentOne, StudentTwo) :-
    forall(
        teacherOf(Teacher, StudentOne),
        (teacherOf(Teacher, StudentTwo), StudentOne \= StudentTwo)
    ).


liveFarAway(StudentOne, StudentTwo):- 
    houseOf(HouseOne, StudentOne),
    houseOf(HouseTwo, StudentTwo),
    farLocation(HouseOne, HouseTwo),
    HouseOne \= HouseTwo.


isSeniorOf(PersonA, PersonB) :-
    directSeniorOf(PersonA, PersonB),
    PersonA \= PersonB.
    

isSeniorOf(PersonA, PersonB) :-
    directSeniorOf(PersonA, Intermediate),
    isSeniorOf(Intermediate, PersonB),
    PersonA \= PersonB.


listSeniors(Person, Seniors) :-
    findall(Senior, isSeniorOf(Senior, Person), Seniors).


isJuniorOf(Junior, Senior) :-
    isSeniorOf(Senior, Junior).


listJuniors(Person, Juniors) :-
    findall(Junior, isJuniorOf(Junior, Person), Juniors).


oldestStudent(Person, House) :-
    birthYear(Person, BirthYear),
    houseOf(House, Person),
    \+ (birthYear(OtherPerson, OtherYear), houseOf(House, OtherPerson), OtherYear < BirthYear).


% youngestStudent relation definition
youngestStudent(Person, House) :-
    birthYear(Person, BirthYear),
    houseOf(House, Person),
    \+ (birthYear(OtherPerson, OtherYear), houseOf(House, OtherPerson), OtherYear > BirthYear).


% oldestQuidditchStudent relation definition
oldestQuidditchStudent(Team, Student) :-
    quidditchTeamOf(Team, Student),
    birthYear(Student, BirthYear),
    \+ (quidditchTeamOf(Team, OtherPlayer), birthYear(OtherPlayer, OtherYear), OtherYear < BirthYear).


% youngestQuidditchStudent relation definition
youngestQuidditchStudent(Team, Student) :-
    quidditchTeamOf(Team, Student),
    birthYear(Student, BirthYear),
    \+ (quidditchTeamOf(Team, OtherPlayer), birthYear(OtherPlayer, OtherYear), OtherYear > BirthYear).


rival(StudentOne, StudentTwo) :-
    houseOf(HouseOne, StudentOne),
    houseOf(HouseTwo, StudentTwo),
    StudentOne \= StudentTwo,
    HouseOne \= HouseTwo.


farRival(StudentOne, StudentTwo) :-
    rival(StudentOne, StudentTwo),
    liveFarAway(StudentOne, StudentTwo).
