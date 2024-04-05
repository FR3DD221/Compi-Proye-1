/* JFlex example: partial Java language lexer specification */
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


plus = "+"
minus = "-"
product = "*"
division = "/"
power = "^"
modulus = "%"

mathOp = plus | minus | product | division | modulus | power

areEquals = "=="
gratherThan = ">"
lessThan = "<"
gratherEQThan = ">="
lessEQThan = "<="
diff = "!="

boolsMathOp = lessThan | gratherThan | areEquals | gratherEQThan | lessEQThan | diff

equal = "="
unaryPlus = "++"
unaryMinus = "--"
sep = ":"
endLine = ";"
delimeterBlock = "_"
dot = "\."

parentS = "("
parentE = ")"

digit = [0-9]
digitNoZero = [1-9]

intNum = {digit}|{digitNoZero} {digit}+
floatNum = {intNum} {dot} {intNum}+

letter = [a-zA-Z]
chainLetters = [a-zA-Z]+
charInt = {letter} | {intNum}

id = {letter} ({letters} | {numbers})*

int = "int"
bool = "boolean"
float = "float"
char = "char"
string = "string"
main = "main"
func = "funtion"

types = {int} | {bool} | {float} | {char} | {string}

if = "if"
else = "else"

true = "true"
false = "false"
boolN = {true} | {false}

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

%state STRING

%%

/* keywords */
<YYINITIAL> "abstract"           { return symbol(sym.ABSTRACT); }
<YYINITIAL> "boolean"            { return symbol(sym.BOOLEAN); }
<YYINITIAL> "break"              { return symbol(sym.BREAK); }

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

/* error fallback */
[^]                              { throw new Error("Illegal character <"+
                                                    yytext()+">"); }
