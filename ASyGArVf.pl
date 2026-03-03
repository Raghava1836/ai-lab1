% ==========================================
% MONKEY BANANA PROBLEM
% Goal-Based Agent Representation in Prolog
% ==========================================

% ------------------------------------------
% STATE REPRESENTATION
% state(MonkeyPosition, MonkeyHeight, BoxPosition, HasBanana)
% ------------------------------------------

% ------------------------------------------
% INITIAL STATE
% Monkey at door, on floor
% Box at window
% Monkey does not have banana
% ------------------------------------------
initial_state(state(at_door, on_floor, at_window, has_not)).

% ------------------------------------------
% GOAL STATE
% Monkey has banana
% ------------------------------------------
goal_state(state(_, _, _, has)).

% ------------------------------------------
% POSSIBLE LOCATIONS
% ------------------------------------------
location(at_door).
location(at_window).
location(middle).

% ------------------------------------------
% ACTION RULES
% ------------------------------------------

% 1. WALK
% Monkey walks from one location to another
move(state(X, on_floor, B, H),
     walk(X, Y),
     state(Y, on_floor, B, H)) :-
    location(Y),
    X \= Y.

% 2. PUSH
% Monkey pushes box when at same position and on floor
move(state(X, on_floor, X, H),
     push(X, Y),
     state(Y, on_floor, Y, H)) :-
    location(Y),
    X \= Y.

% 3. CLIMB
% Monkey climbs onto box
move(state(X, on_floor, X, H),
     climb,
     state(X, on_box, X, H)).

% 4. GRASP
% Monkey grasps banana when box is at middle and monkey on box
move(state(middle, on_box, middle, has_not),
     grasp,
     state(middle, on_box, middle, has)).

% ------------------------------------------
% GOAL-BASED SEARCH
% ------------------------------------------

% If goal reached
solve(State, []) :-
    goal_state(State).

% Recursive rule
solve(State, [Action | Rest]) :-
    move(State, Action, NewState),
    solve(NewState, Rest).