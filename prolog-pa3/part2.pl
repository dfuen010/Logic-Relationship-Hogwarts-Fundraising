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

% gryffindor house wants total price greater than 500 dollars and total volume greater than 60 cubic feet.
% slytherin house wants total volume less than 50 cubic feet and total price greater than 600 dollars.
% Facts
attribute_value(Attribute, Comparison, Than, Value, Unit) -->
    attribute(Attribute),
    comparison(Comparison, Than),
    value(Value),
    unit(Unit).

% Rules
attribute(price) --> [price].
attribute(volume) --> [volume].


comparison(greater,than) --> [greater, than].
comparison(less,than) --> [less, than].



% value(x) --> atom_number(x,y).

value('50') --> ['50'].
value('80') --> ['80'].
value('20') --> ['20'].
value('60') --> ['60'].
value('600') --> ['600'].
value('700') --> ['700'].
value('250') --> ['250'].
value('500') --> ['500'].
% Add more values as needed.

unit(dollars) --> [dollars].
% unit(cubic,feet) --> [cubic, feet].




student(susan_bones) --> [susan_bones].
student(eli_olivander) --> [eli_olivander].
student(vince_glover) --> [vince_glover].
student(terry_boot) --> [terry_boot].

student(duncan_inglebee) --> [duncan_inglebee].
student(cho_chang) --> [cho_chang].
student(draco_malfoy) --> [draco_malfoy].
student(terence_higgs) --> [terence_higgs].

student(daphne_greengrass) --> [daphne_greengrass].
student(harry_potter) --> [harry_potter].
student(ron_weasley) --> [ron_weasley].

student(hermione_granger) --> [hermione_granger].

item(a) --> [a].
item(b) --> [b].
item(c) --> [c].
item(d) --> [d].

item(v) --> [v].
item(w) --> [w].

item(x) --> [x].
item(y) --> [y].
item(z) --> [z].
item(u) --> [u].

cost('400') --> ['400'].
cost('260') --> ['260'].
cost('490') --> ['490'].
cost('350') --> ['350'].

cost('125') --> ['125'].
cost('235') --> ['235'].
cost('600') --> ['600'].
cost('1200') --> ['1200'].

cost('400') --> ['400'].
cost('1000') --> ['1000'].
cost('233') --> ['233'].

cost('200') --> ['200'].
cost('100') --> ['100'].
cost('300') --> ['300'].


volume('10') --> ['10'].
volume('15') --> ['15'].
volume('35') --> ['35'].
volume('50') --> ['50'].

volume('26') --> ['26'].
volume('34') --> ['34'].
volume('60') --> ['60'].


volume('15') --> ['15'].
volume('100') --> ['100'].
volume('13') --> ['13'].


volume('20') --> ['20'].
volume('30') --> ['30'].
volume('10') --> ['10'].

house(gryffindor) --> [gryffindor].
house(slytherin) --> [slytherin].
house(ravenclaw) --> [ravenclaw].
house(hufflepuff) --> [hufflepuff].


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
    % parse(Student, Item, Cost, Volume, X, []),
    %write([Student, Item, Cost, Volume]), nl,

    %parse(House, Attribute1, Comparison1, Than, Value1, Unit1, Attribute2, Comparison2, Than, Value2, Unit2, X, []),
    %write([House, Attribute1, Comparison1, Than, Value1, Unit1, Attribute2, Comparison2, Than, Value2, Unit2]), nl,
    recurseStudent(Xs).



main :- 
    current_prolog_flag(argv, [DataFile|_]),
    open(DataFile, read, Stream),
    read_file(Stream,Lines), %Lines contain all the information within line split by spaces, comma and period.
    write(Lines),
    nl,
    recurseStudent(Lines),
    close(Stream).