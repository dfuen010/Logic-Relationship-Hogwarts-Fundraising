:- [part2Helper].

get(Subject, Adjective) --> 
    subject(Subject),[is],adjective(Adjective).

subject(that) --> [that].
subject(he) --> [he].
subject(she) --> [she].
subject(it) --> [it].

adjective(good) --> [good].
adjective(tall) --> [tall].
adjective(where) --> [where].


recurse([]).
recurse([X|Xs]) :-
    get(Subject, Adjective, X, []),
    write([Subject, Adjective]),
    recurse(Xs).

main :- 
    current_prolog_flag(argv, [DataFile|_]),
    open(DataFile, read, Stream),
    read_file(Stream,Lines), %Lines contain all the information within line split by spaces, comma and period.
    recurse(Lines),
    %write(Adjective),
    close(Stream).