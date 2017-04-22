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
function     { return token(sym.FUNCTION); }
id           { return token(sym.ID);}
fun          { return token(sym.FUN); }
var          { return token(sym.VAR); }
arg          { return token(sym.ARG); }
local        { return token(sym.LOCAL); }
int          { return token(sym.INT); }
bool         { return token(sym.BOOL); }
/*real         { return token(sym.REAL); }*/
void         { return token(sym.VOID); }
true         { return token(sym.TRUE); }
false        { return token(sym.FALSE); }

// instructions
i_add      { return token(sym.IADD); }
i_sub      { return token(sym.ISUB); }
i_mul      { return token(sym.IMUL); }
i_div      { return token(sym.IDIV); }
i_eq       { return token(sym.IEQ); }
i_lt       { return token(sym.ILT); }
i_ne       { return token(sym.INEQ); }
i_le       { return token(sym.ILE); }
i_inv      { return token(sym.IINV); }
i_copy     { return token(sym.ICOPY); }
i_value    { return token(sym.IVALUE); }
i_aload    { return token(sym.IALOAD); }
i_lload    { return token(sym.ILLOAD); }
i_gload    { return token(sym.IGLOAD); }
i_astore   { return token(sym.IASTORE); }
i_lstore   { return token(sym.ILSTORE); }
i_gstore   { return token(sym.IGSTORE); }
i_call     { return token(sym.ICALL); }
i_return   { return token(sym.IRETURN); }
i_print    { return token(sym.IPRINT); }
b_print    { return token(sym.BPRINT); }
mod        { return token(sym.MOD); }
not        { return token(sym.NOT); }
jump       { return token(sym.JUMP); }
cjump      { return token(sym.CJUMP); }
call       { return token(sym.PCALL); }
"return"   { return token(sym.PRETURN); }



// separators
"("			{ return token(sym.OPPAR); }
")"			{ return token(sym.CLPAR); }
"["			{ return token(sym.OPBRACKET); }
"]"			{ return token(sym.CLBRACKET); }
":"     { return token(sym.COLON); }
","     { return token(sym.COMMA); }
"<-"    { return token(sym.ARROW); }



// literals
"t"[0-9]+  	{ return token(sym.TEMP, new String(yytext())); } // temporaries

"l"[0-9]+  	{ return token(sym.LABEL, new String(yytext().substring(0, 1)+'$'+
                        yytext().substring(1, yytext().length()))); } // labels

\@[_a-zA-Z][_a-zA-Z0-9]*   { return token(sym.NAME, new String(yytext().replace("@", ""))); }
-?[0-9]+			               { return token(sym.INT_LITERAL, new Integer(yytext()));}
/*-?[0-9]+\.[0-9]+              { return token(sym.REAL_LITERAL, new Double(yytext()));}*/

// comments, whitespace, etc.
#.*			    { /* ignore comments */ }
[\ \n\t]+		{ /* and whitespace */ }
.	          {
	             System.err.println("unrecognised character: '" + yytext() + "'");
		           return token(sym.ERROR);
	          }
