parser grammar DecafParser;

@header {
package decaf;
}

options
{
  language=Java;
  tokenVocab=DecafLexer;
}

method_type: type ID;

program: CLASS PROGRAM LCURLY (declaration)* (method)* RCURLY;

declaration: (method_type (COMMA method_type)* | method_type COLCE int_literal COLCD (COMMA method_type COLCE int_literal COLCD)*) SEMICOLON;

method: (type | VOID) ID PARE(method_type(COMMA method_type)*)? PARD block;

block: LCURLY var_declaration* statement* RCURLY;

var_declaration: method_type (COMMA ID)* SEMICOLON;

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

method_call: method_name PARE (expr (COMMA expr)*)? PARD | CALLOUT PARE STRING (COMMA callout_arg(COMMA callout_arg)*)? PARD;

callout_arg: expr | STRING;

method_name: ID | ID COLCE expr COLCD;

location: ID | ID COLCE expr COLCD;

expr: location
    | method_call
    | literal
    | expr bin_op expr
    | MENOS expr
    | INTERR expr
    | PARE expr PARD;

bin_op: arith_op | rel_op | eq_op | cond_op;

arith_op: MAIS | MENOS | MULT | DIV | MOD;

rel_op: MAIOR | MAIORIGUAL | MENOR | MENORIGUAL;

eq_op: EQ | NEG;

cond_op: E|OU;

literal: int_literal | CHAR | BOOLEANLITERAL;

alpha_num: alpha | digit;

alpha: CHAR;

digit: INTLITERAL;

int_literal: INTLITERAL;

decimal_literal: digit digit*;

hex_literal: HEXLITERAL;

bool_literal: BOOLEANLITERAL;

char_literal: CHAR;

string_literal: STRING;
