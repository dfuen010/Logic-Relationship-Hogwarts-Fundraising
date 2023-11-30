:- [hogwarts].
:- [part2Helper].

/*
 Hints:
 for NLP parser make sure you match the type of the atom: 
 it may come in handy that print and write are two different method of printing within prolog 

 Currently uses example3.txt as input and part2Result3.txt as output

 run with 
    swipl -s part2.pl  -t main --quiet -- example3.txt  > part2Result3.txt

 draco_malfoy has item c that costs 600 dollars and occupies 60 cubic feet
 daphne_greengrass has item d that costs 400 dollars and occupies 15 cubic feet
*/

get(Student, Item, Cost, Volume) --> 
    student(Student),[has],[item],item(Item),[that],[costs],cost(Cost),[dollars],[''],[and],[occupies],volume(Volume),[cubic],[feet],[''].

student(draco_malfoy) --> [draco_malfoy].
student(daphne_greengrass) --> [daphne_greengrass].

item(c) --> [c].
item(d) --> [d].

cost('600') --> ['600'].
cost('400') --> ['400'].

volume('60') --> ['60'].
volume('15') --> ['15'].

recurse([]).
recurse([X|Xs]) :-
    get(Student, Item, Cost, Volume, X, []),
    write([Student, Item, Cost, Volume]), nl,
    recurse(Xs).


main :- 
    current_prolog_flag(argv, [DataFile|_]),
    open(DataFile, read, Stream),
    read_file(Stream,Lines), %Lines contain all the information within line split by spaces, comma and period.
    write(Lines),
    nl,
    recurse(Lines),
    close(Stream).