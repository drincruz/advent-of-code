-module(day03).
-export([start/0]).

-define(UPPER_ALPHABET, "ABCDEFGHIJKLMNOPQRSTUVWXYZ").
-define(LOWER_ALPHABET, string:lowercase(?UPPER_ALPHABET)).
-define(LOWER_ALPHABET_VALUES, lists:seq(1, 26)).
-define(UPPER_ALPHABET_VALUES, lists:seq(27, 52)).

% Read in the input file into a list.
read_file() ->
  {ok, Data} = file:read_file("data.txt"),
  string:tokens(binary_to_list(Data), "\n").

% Split a string into halves, return halves in a tuple.
half_string(S) ->
  Half = length(S) div 2,
  Left = string:substr(S, 1, Half),
  Right = string:substr(S, Half + 1, length(S)),
  {Left, Right}.

% Map a list to create the string parts.
map_halves_list(List) ->
  lists:map(fun half_string/1, List).

% Map a list with ordsets to get a set of the characters in the strings.
strings_to_ordsets(List) ->
  lists:map(
    fun({Left, Right}) ->
      {ordsets:from_list(Left), ordsets:from_list(Right)}
    end,
    List
  ).

% Map function to find the intersection of two sets.
find_intersections({LeftSet, RightSet}) ->
  ordsets:intersection(LeftSet, RightSet).

% Map the list with the intersections.
map_sets_list(List) ->
  lists:map(fun find_intersections/1, List).

% Generate a map of the upper/lower alphabet charlists to integer values.
% - Lower maps to 1..26 respectively
% - Upper maps to 27..52 respectively
get_alphabet_map() ->
  Upper = lists:zip(?UPPER_ALPHABET, ?UPPER_ALPHABET_VALUES),
  Lower = lists:zip(?LOWER_ALPHABET, ?LOWER_ALPHABET_VALUES),
  UpperLower = lists:append(Upper, Lower),
  maps:from_list(UpperLower).

% Get the alphabet values from the alphabet map.
map_alphabet_values(List) ->
  Alphabet = get_alphabet_map(),
  lists:map(fun (SubList) ->
    lists:map(fun (Ch) -> maps:get(Ch, Alphabet, 0) end, SubList)
  end, List).

% Take the list and sum the integers.
map_sums(List) ->
  lists:map(fun (SubList) -> lists:sum(SubList) end, List).

% Start the process.
start() ->
  GetList = read_file(),
  Halves = map_halves_list(GetList),
  OrdSets = strings_to_ordsets(Halves),
  Intersections = map_sets_list(OrdSets),
  AlphabetVals = map_alphabet_values(Intersections),
  Sums = map_sums(AlphabetVals),
  lists:sum(Sums).
