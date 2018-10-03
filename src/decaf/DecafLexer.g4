

lexer grammar DecafLexer;

@header {
package decaf;
}

options
{
  language=Java;
}

tokens
{
  TK_class
}



LCURLY : '{';
RCURLY : '}';
COLCE: '[';
COLCD: ']';

PARD: ')';
PARE: '(';

IF : 'if';
ELSE : 'else';
FOR : 'for';
VOID : 'void';
INT : 'int';
BOOLEAN : 'boolean';
BOOLEANLITERAL : 'true'|'false';
BREAK : 'break';
CALLOUT : 'callout';
CLASS : 'class';

PROGRAM : 'Program';

CONTINUE : 'continue';
RETURN : 'return';
E : '&&';
OU : '||';
ATRIB : '=';

DECR : '-=';
INC : '+=';
INTERR : '!';

EQ : '==';
NEG : '!=';
MAIOR : '>';
MAIORIGUAL : '>=';
MENOR : '<';
MENORIGUAL : '<=';
MAIS : '+';
MENOS : '-';
MULT : '*';
DIV : '/';
MOD : '%';
COMMA : ',';
COLON : ':';
SEMICOLON : ';';



WS_ : [ \t\r\n]+ -> skip;

SL_COMMENT : '//' (~'\n')* '\n' -> skip;

ID  : (LETRA|'_')(LETRA|NUM|'_')+|LETRA;
CHAR : '\'' (ESCCHAR|LETRA|NUM) '\'';
STRING : '"'(LETRA|NUM|ESCSTR)* '"';
INTLITERAL : NUM+ (~'x');
HEXLITERAL : '0''x'(LETRA|NUM)+;

fragment ESC :  '\\' ('n'|'t'|'\\'|'"');
fragment LETRA : ('a'..'z'|'A'..'Z');
fragment NUM: ('0'..'9');
fragment ESCSTR : (' '|'!'|'"'|'#'|'$'|'%'|'&'|'\\\''|'('|')'|'*'|'+'|','|'-'|'.'|'/'|':'|';'|'<'|'='|'>'|'?'|'@'|'['|']'|'^'|'_'|'´'|'`'|'{'|'|'|'}'|'~'|'\t'|'\\'|'\"');
fragment ESCCHAR : (' '|'!'|'#'|'$'|'%'|'&'|'('|')'|'*'|'+'|','|'-'|'.'|'/'|':'|';'|'<'|'='|'>'|'?'|'@'|'['|']'|'^'|'_'|'´'|'`'|'{'|'|'|'}'|'~');
