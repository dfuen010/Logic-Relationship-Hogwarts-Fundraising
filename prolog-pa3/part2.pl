:- [hogwarts].
:- [part2Helper].

% Hints:
%   for NLP parser make sure you match the type of the atom: 
%      it may come in handy that print and write are two different method of printing within prolog 

/*
info(Student, Item, Cost, Volume) --> 
    student(Student),[has],[item],item(Item),[that],[costs],cost(Cost),[dollars],[and],[occupies],volume(Volume),[cubic],[feet].


student(draco_malfoy) --> [draco_malfoy].
student(daphne_greengrass) --> [daphne_greengrass].

item(c) --> [c].
item(d) --> [d].

cost(600) --> [600].
cost(400) --> [400].

volume(60) --> [60].
volume(15) --> [15].


% draco_malfoy has item c that costs 600 dollars, and occupies 60 cubic feet.
% daphne_greengrass has item d that costs 400 dollars, and occupies 15 cubic feet.
% harry_potter has item a that costs 1000 dollars, and occupies 100 cubic feet.
% ron_weasley has item x that costs 233 dollars, and occupies 13 cubic feet.
% hermione_granger has item b that costs 200 dollars, and occupies 20 cubic feet.
% hermione_granger has item c that costs 100 dollars, and occupies 30 cubic feet.
% hermione_granger has item c that costs 300 dollars, and occupies 10 cubic feet.
% slytherin house wants total volume less than 20 cubic feet and total price greater than 300 dollars.
% gryffindor house wants total price less than 600 dollars and total volume greater than 60 cubic feet.

recurse([]).
recurse([X|Xs]) :-
    info(Student, Item, Cost, Volume, X, []),
    write([Student, Item, Cost, Volume]),
    recurse(Xs).
    */

info(Student, Item, Cost, Volume) --> 
    student(Student), [has], [item], item(Item), [that], [costs], cost(Cost), [dollars], [and], [occupies], volume(Volume), [cubic, feet].

student(draco_malfoy) --> [draco_malfoy].
student(daphne_greengrass) --> [daphne_greengrass].

item(c) --> [c].
item(d) --> [d].

cost(Price) --> [Price], {number(Price)}.

volume(Volume) --> [Volume], {number(Volume)}.

recurse([]).
recurse([X|Xs]) :-
    info(Student, Item, Cost, Volume, X, Rest),
    format("Parsed: [~w, ~w, ~w, ~w], Remaining Tokens: ~w~n", [Student, Item, Cost, Volume, Rest]),
    recurse(Xs).


main :-
    current_prolog_flag(argv, [DataFile|_]),
    open(DataFile, read, Stream),
    read_file(Stream,Lines), % Lines contain all the information within line split by spaces, comma and period.
    write(Lines),
    nl,
    nl,
    nl,
    recurse(Lines),
    close(Stream).
	