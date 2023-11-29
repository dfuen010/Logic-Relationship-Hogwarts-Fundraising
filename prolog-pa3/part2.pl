:- [hogwarts].
:- [part2Helper].

% Hints:
%   for NLP parser make sure you match the type of the atom: 
%      it may come in handy that print and write are two different method of printing within prolog 
% susan_bones has item x that costs 400 dollars, and occupies 10 cubic feet.

name(Student, Item, Cost, Volume) --> 
    student(Student),[has],[item],item(Item),[that],[costs],cost(Cost),[dollars],[],[and],[occupies],volume(Volume),[cubic],[feet],[].

% Main 
main :-
    current_prolog_flag(argv, [DataFile|_]),
    open(DataFile, read, Stream),
    read_file(Stream,Lines), %Lines contain all the information within line split by spaces, comma and period.
    write(Lines),
    close(Stream).
	