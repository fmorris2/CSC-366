%%%% file: nflkb.pro
%%%% line: some knowledge about the nfl

%%Facts

% team(N) :: N is the name of an NFL team
team(dolphins).
team(bills).
team(patriots).
team(jets).
team(broncos).
team(raiders).
team(chiefs).
team(chargers).
team(ravens).
team(steelers).
team(bengals).
team(browns).
team(titans).
team(jaguars).
team(texans).
team(colts).
team(eagles).
team(cowboys).
team(redskins).
team(giants).
team(seahawks).
team(cardinals).
team(rams).
team('49ers').
team(lions).
team(vikings).
team(packers).
team(bears).
team(falcons).
team(panthers).
team(buccaneers).
team(saints).

% divison(N, teams[t1, T2, ...]) :: A divison named N has a list of teams associated with it
division('AFC East', teams([dolphins, bills, patriots, jets])).
division('AFC West', teams([broncos, raiders, chiefs, chargers])).
division('AFC North', teams([ravens, steelers, bengals, browns])).
division('AFC South', teams([titans, jaguars, texans, colts])).
division('NFC East', teams([eagles, cowboys, redskins, giants])).
division('NFC West', teams([seahawks, cardinals, rams, '49ers'])).
division('NFC North', teams([lions, vikings, packers, bears])).
division('NFC South', teams([falcons, panthers, buccaneers, saints])).

% elite_player(N,P,T) :: N is the name of an elite player of position P on team T
elite_player('Ndamukong Suh', dt, dolphins).
elite_player('LeSean McCoy', hb, bills).
elite_player('Tom Brady', qb, patriots).
elite_player('Muhammad Wilkerson', de, jets).
elite_player('Aqib Talib', cb, broncos).
elite_player('Khalil Mack', de, raiders).
elite_player('Travis Kelce', te, chiefs).
elite_player('Philip Rivers', qb, chargers).
elite_player('Terrell Suggs', olb, ravens).
elite_player('Antonio Brown', wr, steelers).
elite_player('Geno Atkins', dt, bengals).
elite_player('Joe Thomas', lt, browns).
elite_player('Jurrell Casey', dt, titans).
elite_player('Jalen Ramsey', cb, jaguars).
elite_player('JJ Watt', de, texans).
elite_player('Andrew Luck', qb, colts).
elite_player('Malcolm Jenkins', s, eagles).
elite_player('Tyron Smith', lt, cowboys).
elite_player('Trent Williams', lt, redskins).
elite_player('Odell Beckham Jr', wr, giants).
elite_player('Kam Chancellor', s, seahawks).
elite_player('David Johnson', hb, cardinals).
elite_player('Aaron Donald', dt, rams).
elite_player('Joe Staley', lt, '49ers').
elite_player('Matthew Stafford', qb, lions).
elite_player('Xavier Rhodes', cb, vikings).
elite_player('Aaron Rodgers', qb, packers).
elite_player('Pernell McPhee', olb, bears).
elite_player('Julio Jones', wr, falcons).
elite_player('Luke Kuechly', mlb, panthers).
elite_player('Mike Evans', wr, buccaneers).
elite_player('Drew Brees', qb, saints).

%% Rules ...

%teams :: all those items listed are NFL teams
teams :- team(Name),write(Name),nl,fail.
teams.

%in_division(DN, TN) :: Team with name TN is in Division with name DN
in_division(DN, TN) :-
	division(DN, teams(TL)),
	member(TN,TL),
	!.

%nfc_team(N) :: N is a team in the NFC
nfc_team(N) :- 
	in_division('NFC North', N), !;
	in_division('NFC South', N), !;
	in_division('NFC West', N), !;
	in_division('NFC East', N), !.

%afc_team(N) :: N is a team in the AFC
afc_team(N) :- 
	in_division('AFC North', N), !;
	in_division('AFC South', N), !;
	in_division('AFC West', N), !;
	in_division('AFC East', N), !.

%nfc_teams :: all those items listed are NFC teams
nfc_teams :- team(N),nfc_team(N),write(N),nl,fail.
nfc_teams.

%afc_teams :: all those items listed are AFC teams
afc_teams :- team(N),afc_team(N),write(N),nl,fail.
afc_teams.

%elite_players :: all those items listed are elite NFL players
elite_players :- elite_player(N,_,_),write(N),nl,fail.
elite_players.

%elite_nfc_players :: all those items listed are elite NFL players in the NFC
elite_nfc_players :- elite_player(N,_,T),nfc_team(T),write(N),nl,fail.
elite_nfc_players.

%elite_afc_players :: all those items listed are elite NFL players in the AFC
elite_afc_players :- elite_player(N,_,T),afc_team(T),write(N),nl,fail.
elite_afc_players.
