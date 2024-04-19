% Quicksort base case: an empty list is already sorted.
quicksort([], []).

% Quicksort main rule:
quicksort([X|Xs], Sorted) :-
    % Partition the list into Lows and Highs based on X.
    partition(Xs, X, Lows, Highs),
    
    % Recursively quicksort Lows and Highs.
    quicksort(Lows, SortedLows),
    quicksort(Highs, SortedHighs),
    
    % Combine SortedLows, X, and SortedHighs to get the final Sorted list.
    append(SortedLows, [X|SortedHighs], Sorted).

% Partition base case: an empty list results in two empty lists.
partition([], _, [], []).

% Partition rule: Element [Name1, Dist1] goes to Lows if Dist1 <= Dist2, otherwise to Highs.
partition([[Name1, Dist1]|Ys], [Name2, Dist2], [[Name1, Dist1]|Lows], Highs) :-
    Dist1 =< Dist2,
    partition(Ys, [Name2, Dist2], Lows, Highs).

% Partition rule: Element [Name1, Dist1] goes to Highs if Dist1 > Dist2, otherwise to Lows.
partition([[Name1, Dist1]|Ys], [Name2, Dist2], Lows, [[Name1, Dist1]|Highs]) :-
    Dist1 > Dist2,
    partition(Ys, [Name2, Dist2], Lows, Highs).



