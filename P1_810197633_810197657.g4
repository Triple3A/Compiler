grammar P1_810197633_810197657;

s : prog ;

prog :
    class_ prog
    | ;

class_ : classDec LBrace classScope RBrace ;

classDec : class__ Name {System.out.print("ClassDec:"+$Name.getText());} parent {System.out.println("");};

classScope :
    varDec SemiColon classScope
    | method classScope
    | ;

method : methodDec LBrace scope RBrace ;

assignment :
    name chain Assignment term {System.out.println("Operator:=");}
    | This name chain Assignment term {System.out.println("Operator:=");} ;

listIndex :
    LBracket index RBracket;

index :
    mathExpression
    | name chain
    | Number;

expression :
    mathExpression
    | boolExpression
    | Str;

scope :
    singleScope scope
    | LBrace scope RBrace
    | ;

print_ : print__ LParenthesis term RParenthesis ;

body :
    LBrace scope RBrace
    | singleScope ;

singleScope :
    varDec SemiColon
    | print_ SemiColon
    | for_
    | foreach_
    | if_
    | assignment SemiColon
    | comment singleScope
    | {System.out.println("MethodCall");} methodCall SemiColon
    | return__ return_ SemiColon
    | continue__ SemiColon
    | break__ SemiColon ;


return_ :
    term
    | ;

if_ : ifDec body else_ ;

else_ :
    else__ elseRest
    | ;

elseRest :
    body
    | if_ ;

parent :
    extends__ Name {System.out.print(","+$Name.getText());}
    | ;

varDec : Name {System.out.println("VarDec:"+$Name.getText());} Colon varType;

methodDec : def__ methodType Name {System.out.println($Name.getText());} LParenthesis inputs RParenthesis ;

methodType :
    type {System.out.print("MethodDec:");}
    | {System.out.print("ConstructorDec:");} ;

inputs :
    argumentDec multiArgDec
    | ;

argumentDec: Name Colon varType;

multiArgDec :
    Comma argumentDec multiArgDec
    | ;

multiVarDec :
    Comma varDec multiVarDec
    | ;

foreach_ : foreachDec body ;

foreachDec : foreach__ LParenthesis name chain in__ nameOrList RParenthesis;

nameOrList :
    name chain
    | This name chain
    | list ;

list :
    member multiMember
    | Number Hashtag varType
    | ;

member :
    argumentDec
    | varType ;

multiMember :
    Comma member multiMember
    | ;

assignment_ :
    assignment
    | ;

boolExpression_ :
    boolExpression
    | ;

for_ : forDec body ;

forDec : for__ LParenthesis assignment_ SemiColon boolExpression_ SemiColon assignment_ RParenthesis;

varType :
    type_
    | void__
    | list__ LParenthesis list RParenthesis
    | func__ Lt varType multiType_ Arrow varType Gt ;

multiType_ :
    Comma varType multiType_
    | ;

type_ :
    bool__
    | string__
    | int__
    | name;

ifDec : if__ LParenthesis boolExpression RParenthesis ;

type :
    bool__
    | string__
    | int__
    | void__ ;

comment : Comment ;

methodCall :
    name Dot name chain
    | new__ name chain
    | This name chain ;

chain :
    Dot name chain
    | LParenthesis methodInput RParenthesis chain
    | listIndex chain
    | ;

methodInput :
    term multiTerm
    | ;

multiTerm :
    Comma term multiTerm
    | ;


not :
    Not {System.out.println("Operator:!");}
    | ;

mathExpression : t (Plus t {System.out.println("Operator:+");} | Minus t {System.out.println("Operator:-");})* ;
t : atom (Multiply atom {System.out.println("Operator:*");} | Divide atom {System.out.println("Operator:/");} | Remain atom {System.out.println("Operator:%");})* ;
atom : back mathTerm front | LParenthesis mathExpression RParenthesis ;

boolExpression : b (Or b {System.out.println("Operator:||");})* ;
b : b_ (And b_{System.out.println("Operator:&&");})* ;
b_ : b__ (Equal b__{System.out.println("Operator:==");} | NotEqual b__{System.out.println("Operator:!=");})* ;
b__ : b___ (Lt b___ {System.out.println("Operator:<");} | Gt b___ {System.out.println("Operator:>");})* ;
b___ : not boolTerm | not LParenthesis boolExpression RParenthesis ;


back :
    PlusPlus {System.out.println("Operator:++");}
    | MinusMinus {System.out.println("Operator:--");}
    | Minus {System.out.println("Operator:-");}
    | ;

front
    : PlusPlus {System.out.println("Operator:++");}
    | MinusMinus {System.out.println("Operator:--");}
    | ;

mathTerm :
    This name chain
    | name chain
    | methodCall
    | Number;

boolTerm :
    This name chain
    | name chain
    | mathExpression
    | methodCall
    | Number;

term :
    methodCall
    | This name chain
    | LBracket term multiTerm RBracket
    | Number
    | expression
    | new__ name chain ;

return__ : Return {System.out.println("Return");} ;
continue__ : {System.out.println("Control:continue");} Continue ;
break__ : {System.out.println("Control:break");} Break ;
print__ : Print {System.out.println("Built-in:print");} ;
func__ : Func ;
new__ : New ;
class__ : Class ;
for__ : For {System.out.println("Loop:for");} ;
foreach__ : Foreach {System.out.println("Loop:foreach");} ;
def__ : Def ;
else__ : Else {System.out.println("Conditional:else");};
in__ : In ;
list__ : List ;
if__ : If {System.out.println("Conditional:if");};
int__ : Int ;
string__ : String ;
void__ : Void ;
bool__ : Bool ;
extends__ : Extends ;
name : Name ;


Return : 'return' ;
Continue : 'continue' ;
Break : 'break' ;
Hashtag : '#' ;
Func : 'func' ;
New : 'new' ;
PlusPlus : '++' ;
MinusMinus : '--' ;
Plus : '+' ;
Minus : '-' ;
Multiply : '*' ;
Divide : '/' ;
Remain : '%' ;
Not : '!' ;
Equal : '==' ;
NotEqual : '!=' ;
And : '&&' ;
Or : '||' ;
Assignment : '=' ;
This : 'this.' ;
Lt : '<' ;
Gt : '>' ;
Arrow : '->' ;
Comment : '//' ~('\n')* '\n' ;
Dot : '.' ;
LBracket : '[' ;
RBracket : ']' ;
LBrace : '{' ;
RBrace : '}' ;
LParenthesis : '(' ;
RParenthesis : ')' ;
For : 'for' ;
Foreach : 'foreach' ;
Def : 'def' ;
Else : 'else' ;
In : 'in' ;
List : 'list' ;
Str : '"' ~('"')* '"' ;
String : 'string' ;
Bool : 'bool' ;
Int : 'int' ;
Void : 'void' ;
If : 'if' ;
Number : [1-9][0-9]* | [0] ;
Class : 'class' ;
Print : 'print' ;
Extends : 'extends' ;
Colon : ':' ;
Comma : ',' ;
SemiColon
    : ';'
    ;
Name : [A-Za-z_][A-Za-z_0-9]* ;
WS
    : [ \n\t\r]+ -> skip
    ;
