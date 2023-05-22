%token id
%token OCT
%token DEC
%token HEX

%%
P : L
  | L P1
  ;

L : S
  ;

S : id '=' E
  | 




%%