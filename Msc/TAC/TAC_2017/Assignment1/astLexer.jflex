import java_cup.runtime.Symbol;

%%

%cup

%char
%line

%{
  private Symbol token(int id, Object value) {
    return new Symbol(id, yychar, yyline, value);
  }

  private Symbol token(int id) {
    return token(id, yytext());
  }
%}

%eofval{
  return token(sym.EOF);
%eofval}

%%

// reserved words
id			     { return token(sym.ID); }
fun          { return token(sym.FUN); }
body         { return token(sym.BODY); }
arg          { return token(sym.ARG); }
var          { return token(sym.VAR); }
assign       { return token(sym.ASSIGN); }
while        { return token(sym.WHILE); }
if           { return token(sym.IF); }
print        { return token(sym.PRINT); }
bool         { return token(sym.BOOL); }
int          { return token(sym.INT); }
int_literal  { return token(sym.INTLIT); }
real_literal { return token(sym.REALLIT); }
real         { return token(sym.REAL); }
true         { return token(sym.TRUE); }
false        { return token(sym.FALSE); }
toreal       { return token(sym.TOREAL); }
local        { return token(sym.LOCAL); }
eq           { return token(sym.EQ); }
ne           { return token(sym.NEQ); }
lt           { return token(sym.LT); }
le           { return token(sym.LE); }
gt           { return token(sym.GT); }
ge           { return token(sym.GE); }
times        { return token(sym.TIMES); }
minus        { return token(sym.MINUS); }
plus         { return token(sym.PLUS); }
div          { return token(sym.DIV); }
mod          { return token(sym.MOD); }
not          { return token(sym.NOT); }
inv          { return token(sym.INV); }
or           { return token(sym.OR); }
and          { return token(sym.AND); }
call         { return token(sym.CALL); }
nil          { return token(sym.NIL); }


// separators
"("			{ return token(sym.OPPAR); }
")"			{ return token(sym.CLPAR); }
"["			{ return token(sym.OPBRACKET); }
"]"			{ return token(sym.CLBRACKET); }
":"     { return token(sym.COLON); }

// literals
\"[_a-zA-Z][_a-zA-Z0-9]*\"	{ return token(sym.NAME, new String(yytext())); }
[0-9]+			                { return token(sym.INT_LITERAL, new Integer(yytext()));}
[0-9]+\.[0-9]+              { return token(sym.REAL_LITERAL, new Double(yytext()));}

// comments, whitespace, etc.
#.*			    { /* ignore comments */ }
[\ \n\t]+		{ /* and whitespace */ }
.	          {
	             System.err.println("unrecognised character: '" + yytext() + "'");
		           return token(sym.ERROR);
	          }
