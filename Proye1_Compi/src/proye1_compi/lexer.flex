/* JFlex example: partial Java language lexer specification */
package proye1_compi;

import java_cup.runtime.*;

/**
 * This class is a simple example lexer.
 */
%%

%class Lexer
%unicode
%cup
%line
%column

%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

digit = [0-9]
digitNoZero = [1-9]
dot = "\."
intNum = [0]|[1-9][0-9]*
floatNum = [+-]?([0-9]*[.])?[0-9]+
true = "true"

%state STRING

%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.ABSTRACT); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN); }
<YYINITIAL> "break"              { return symbol(sym.BREAK); }


<YYINITIAL> {dot}                  { System.out.println("punto"); return symbol(sym.DOT); }
<YYINITIAL> {intNum}               { System.out.println("entero"); return symbol(sym.INTNUM); }
<YYINITIAL> {floatNum}             { System.out.println("flotante"); return symbol(sym.FLOATNUM); }
<YYINITIAL> {true}                 { System.out.println("true"); return symbol(sym.TRUE); }

/*
<YYINITIAL> {minus}              { return new Symbol(sym.minus, yycolum, yyline, yytext); }
<YYINITIAL> {product}            { return new Symbol(sym.product, yycolum, yyline, yytext); }
<YYINITIAL> {division}           { return new Symbol(sym.division, yycolum, yyline, yytext); }
<YYINITIAL> {power}              { return new Symbol(sym.power, yycolum, yyline, yytext); }
<YYINITIAL> {delimeterBlock}     { return new Symbol(sym.delimeterBlock, yycolum, yyline, yytext); }
<YYINITIAL> {modulus}            { return new Symbol(sym.modulus, yycolum, yyline, yytext); }
<YYINITIAL> {sep}                { return new Symbol(sym.sep, yycolum, yyline, yytext); }
<YYINITIAL> {int}                { return new Symbol(sym.int, yycolum, yyline, yytext); }
<YYINITIAL> {char}               { return new Symbol(sym.char, yycolum, yyline, yytext); }
<YYINITIAL> {float}              { return new Symbol(sym.float, yycolum, yyline, yytext); }
<YYINITIAL> {bool}               { return new Symbol(sym.bool, yycolum, yyline, yytext); }
<YYINITIAL> {if}                 { return new Symbol(sym.if, yycolum, yyline, yytext); }
<YYINITIAL> {func}               { return new Symbol(sym.func, yycolum, yyline, yytext); }
<YYINITIAL> {main}               { return new Symbol(sym.main, yycolum, yyline, yytext); }
<YYINITIAL> {diff}               { return new Symbol(sym.diff, yycolum, yyline, yytext); }
<YYINITIAL> {else}               { return new Symbol(sym.else, yycolum, yyline, yytext); }
<YYINITIAL> {true}               { return new Symbol(sym.true, yycolum, yyline, yytext); }
<YYINITIAL> {false}              { return new Symbol(sym.false, yycolum, yyline, yytext); }
<YYINITIAL> {boolN}              { return new Symbol(sym.boolN, yycolum, yyline, yytext); }
<YYINITIAL> {mathOp}             { return new Symbol(sym.mathOp, yycolum, yyline, yytext); }
<YYINITIAL> {intN}               { return new Symbol(sym.intN, yycolum, yyline, yytext); }
*/

<YYINITIAL> {
  /* identifiers */ 
  {Identifier}                   { return symbol(sym.IDENTIFIER); }

  /* literals */
  {DecIntegerLiteral}            { return symbol(sym.INTEGER_LITERAL); }
  \"                             { string.setLength(0); yybegin(STRING); }

  /* operators */
  "="                            { return symbol(sym.EQ); }
  "=="                           { return symbol(sym.EQEQ); }
  "+"                            { return symbol(sym.PLUS); }

  /* comments */
  {Comment}                      { /* ignore */ }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); 
                                   return symbol(sym.STRING_LITERAL, 
                                   string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}
