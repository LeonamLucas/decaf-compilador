parser grammar DecafParser;

@header {
package decaf;
}

options
{
  language=Java;
  tokenVocab=DecafLexer;
}



program: CLASS PROGRAM LCURLY field_decl* method_decl* RCURLY EOF;

field_decl: type id (COMMA type id)* SEMICOLON;

method_decl: (type|VOID) ID PARE (type ID (COMMA type ID)*)? PARD block;

block: LCURLY var_decl* statement* RCURLY;

var_decl: type ID (COMMA ID)* SEMICOLON;

type: INT | BOOLEAN;

statement: location assign_op expr SEMICOLON
    | method_call SEMICOLON
    | IF PARE expr PARD block (ELSE block)?
    | FOR ID ATRIB expr COMMA expr block
    | RETURN expr? SEMICOLON
    | BREAK SEMICOLON
    | CONTINUE SEMICOLON
    | block ;

assign_op: ATRIB | DECR | INC;

method_call: ID PARE (expr (COMMA expr)*)? PARD | CALLOUT PARE STRING (COMMA callout_arg(COMMA callout_arg)*)? PARD;

location: ID | ID COLCE expr COLCD;

expr: location
    | method_call
    | literal
    | expr bin_op expr
    | MENOS expr
    | INTERR expr
    | PARE expr PARD;

callout_arg: expr | STRING;

bin_op: arith_op | rel_op | eq_op | cond_op;

arith_op: MAIS | MENOS | MULT | DIV | MOD;

rel_op: MAIOR | MAIORIGUAL | MENOR | MENORIGUAL;

eq_op: EQ | NEG;

cond_op: E|OU;

literal: int_literal | CHAR | BOOLEANLITERAL;

int_literal: INTLITERAL | HEXLITERAL;

id: ID | ID COLCE? int_literal COLCD?;


