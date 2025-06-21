% Knowledge base representing the decision tree

% Rule to determine the water source based on user inputs
predict_water_source(Rainfall, SandyAquifer, BeachDistance, RiverDistance, LakeDistance, Source) :-
    ( LakeDistance < 10 -> Source = lake ;
      RiverDistance < 8 -> Source = river ;
      Rainfall >= 200 -> Source = rain ;
      Rainfall < 150, SandyAquifer = yes ->
        ( BeachDistance < 5 ->
            ( RiverDistance < 20 -> Source = river ; Source = rain )
        ; Source = groundwater
        )
    ; Rainfall >= 150 ->
        ( LakeDistance < 14 -> Source = lake ; Source = rain )
    ; Source = river
    ).

% Function to get user input safely
get_number(Prompt, Number) :-
    write(Prompt), write(": "),
    read(Number),
    (number(Number) -> true ; write("Invalid input! Please enter a number."), nl, get_number(Prompt, Number)).

get_yes_no(Prompt, Answer) :-
    write(Prompt), write(" (yes/no): "),
    read(Reply),
    ( (Reply == yes ; Reply == no) -> Answer = Reply ; 
      write("Invalid input! Please type 'yes' or 'no'."), nl, get_yes_no(Prompt, Answer) ).

% Interactive function to take inputs from user
start :-
    write("=== Welcome to the Water Source Predictor ==="), nl,
    
    get_number("Enter Rainfall (mm)", Rainfall),
    get_yes_no("Is there a sandy aquifer?", SandyAquifer),
    get_number("Enter Beach Distance (km)", BeachDistance),
    get_number("Enter River Distance (km)", RiverDistance),
    get_number("Enter Lake Distance (km)", LakeDistance),

    % Predicting the water source
    predict_water_source(Rainfall, SandyAquifer, BeachDistance, RiverDistance, LakeDistance, Source),
    
    nl, write("Recommended Water Source: "), write(Source), nl,
    write("=== Thank you for using the system! ==="), nl.
