:- [hogwarts].
:- [part2Helper].

/*
 Hints:
 for NLP parser make sure you match the type of the atom: 
 it may come in handy that print and write are two different method of printing within prolog 

 Currently uses example3.txt as input and part2Result3.txt as output

 run with 
    swipl -s part2.pl  -t main --quiet -- example3.txt  > part2Result3.txt


susan_bones has item x that costs 400 dollars, and occupies 10 cubic feet.
eli_olivander has item y that costs 260 dollars, and occupies 15 cubic feet.
vince_glover has item z that costs 490 dollars, and occupies 35 cubic feet.
terry_boot has item u that costs 350 dollars, and occupies 50 cubic feet.

duncan_inglebee has item v that costs 125 dollars, and occupies 26 cubic feet.
cho_chang has item w that costs 235 dollars, and occupies 34 cubic feet.
draco_malfoy has item c that costs 600 dollars, and occupies 60 cubic feet.
terence_higgs has item c that costs 1200 dollars, and occupies 60 cubic feet.

daphne_greengrass has item d that costs 400 dollars, and occupies 15 cubic feet.
harry_potter has item a that costs 1000 dollars, and occupies 100 cubic feet.
ron_weasley has item d that costs 233 dollars, and occupies 13 cubic feet.

hermione_granger has item b that costs 200 dollars, and occupies 20 cubic feet.
hermione_granger has item c that costs 100 dollars, and occupies 30 cubic feet.
hermione_granger has item c that costs 300 dollars, and occupies 10 cubic feet.

gryffindor house wants total price greater than 500 dollars and total volume greater than 60 cubic feet.
slytherin house wants total volume less than 50 cubic feet and total price greater than 600 dollars.
ravenclaw house wants total volume greater than 80 cubic feet and total price greater than 700 dollars.
hufflepuff house wants total volume less than 20 cubic feet and total price greater than 250 dollars.

*/

parse(Student, Item, Cost, Volume) --> 
    student(Student),[has],[item],item(Item),[that],[costs],cost(Cost),[dollars],[''],[and],[occupies],volume(Volume),[cubic,feet],[''].

parse(House, Attribute1, Comparison1, Than, Value1, Unit1, Attribute2, Comparison2, Than, Value2, Unit2) -->
    house(House),[house],[wants],[total],attribute_value(Attribute1, Comparison1, Than, Value1, Unit1),[and],[total],
    attribute_value(Attribute2, Comparison2, Than, Value2, Unit2),[''].

attribute_value(Attribute, Comparison, Than, Value, Unit) -->
    attribute(Attribute),
    comparison(Comparison, Than),
    value(Value),
    unit(Unit).

attribute(price) --> [price].
attribute(volume) --> [volume].

comparison(greater,than) --> [greater, than].
comparison(less,than) --> [less, than].

% value(x) --> atom_number(x,y).
value(V) --> [V].

unit(dollars) --> [dollars].
unit([cubic,feet]) --> [cubic, feet].


student(S) --> [S].
item(I) --> [I].
cost(C) --> [C].
volume(V) --> [V].
house(H) --> [H].

/* This receives the whole paragraph, and goes through and prints line by line */
recurseStudent([]).
recurseStudent([X|Xs]) :-
% Needs to parse correct one
    (
        parse(Student, Item, Cost, Volume, X, []) -> write([Student, Item, Cost, Volume]), nl
        ;
        parse(House, Attribute1, Comparison1, Than, Value1, Unit1, Attribute2, Comparison2, Than, Value2, Unit2, X, []),
        write([House, Attribute1, Comparison1, Than, Value1, Unit1, Attribute2, Comparison2, Than, Value2, Unit2]), nl
    ),
    recurseStudent(Xs).

main :- 
    current_prolog_flag(argv, [DataFile|_]),
    open(DataFile, read, Stream),
    read_file(Stream,Lines), %Lines contain all the information within line split by spaces, comma and period.
    write(Lines),
    nl,
    recurseStudent(Lines),
    close(Stream).