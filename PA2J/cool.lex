//----------------------------------------------------------------------------
// Lexical analysis part of cool compiler
//============================================================
// Ryan (Weiran) Zhao 
// Started: 2 days before Tue,Jan 21th 2014 10:56:33 AM EST
// Last Modified: Tue,Jan 21th 2014 10:58:39 AM EST
//-----------
//References:
//-----------
// [1] http://www.cs.princeton.edu/~appel/modern/java/JLex/current/sample.lex
//      examples on how to handle comments
//----------------------------------------------------------------------------
/*
 *  The scanner definition for COOL.
 */

import java_cup.runtime.Symbol;

%%

%{

/*  Stuff enclosed in %{ %} is copied verbatim to the lexer class
 *  definition, all the extra variables/functions you want to use in the
 *  lexer actions should go here.  Don't remove or modify anything that
 *  was there initially.  */

    // Max size of string constants
    static int MAX_STR_CONST = 1025;

    // For assembling string constants
    StringBuffer string_buf = new StringBuffer();

    private int curr_lineno = 1;
    int get_curr_lineno() {
	return curr_lineno;
    }

    private AbstractSymbol filename;

    void set_filename(String fname) {
	filename = AbstractTable.stringtable.addString(fname);
    }

    AbstractSymbol curr_filename() {
	return filename;
    }
%}

%init{

/*  Stuff enclosed in %init{ %init} is copied verbatim to the lexer
 *  class constructor, all the extra initialization you want to do should
 *  go here.  Don't remove or modify anything that was there initially. */

    // empty for now
%init}

%eofval{

/*  Stuff enclosed in %eofval{ %eofval} specifies java code that is
 *  executed when end-of-file is reached.  If you use multiple lexical
 *  states and want to do something special if an EOF is encountered in
 *  one of those states, place your code in the switch statement.
 *  Ultimately, you should return the EOF symbol, or your lexer won't
 *  work.  */

    switch(yy_lexical_state) {
    case YYINITIAL:
	/* nothing special to do in the initial state */
	break;
	/* If necessary, add code for other states here, e.g:
	   case COMMENT:
	   ...
	   break;
	*/
    }
    return new Symbol(TokenConstants.EOF);
%eofval}

%class CoolLexer
%cup

digit = [0-9]
letter = [a-zA-Z]
WS = [\t \n\r\f\v]+
a= [aA]
b= [bB]
c= [cC]
d= [dD]
e= [eE]
f= [fF]
g= [gG]
h= [hH]
i= [iI]
j= [jJ]
k= [kK]
l= [lL]
m= [mM]
n= [nN]
o= [oO]
p= [pP]
q= [qQ]
r= [rR]
s= [sS]
t= [tT]
u= [uU]
v= [vV]
w= [wW]
x= [xX]
y= [yY]
z= [zZ]
%%
<YYINITIAL>{c}{l}{a}{s}{s}
{   /* class */
    return new Symbol(TokenConstants.CLASS); }

<YYINITIAL>{i}{n}
{   /* in */
    return new Symbol(TokenConstants.IN); }

<YYINITIAL>{i}{n}{h}{e}{r}{i}{t}{s}
{   /* inherits */
    return new Symbol(TokenConstants.INHERITS); }

<YYINITIAL>{i}{s}{v}{o}{i}{d}
{   /* isvoid */
    return new Symbol(TokenConstants.ISVOID); }

<YYINITIAL>{l}{e}{t}
{   /* let */
    return new Symbol(TokenConstants.LET); }

<YYINITIAL>{n}{e}{w}
{   /* new */
    return new Symbol(TokenConstants.NEW); }

<YYINITIAL>{o}{f}
{   /* of */
    return new Symbol(TokenConstants.OF); }

<YYINITIAL>{n}{o}{t}
{   /* not */
    return new Symbol(TokenConstants.NOT); }

<YYINITIAL>{l}{o}{o}{p}
{   /* loop */
    return new Symbol(TokenConstants.LOOP); }

<YYINITIAL>{p}{o}{o}{l}
{   /* pool */
    return new Symbol(TokenConstants.POOL); }

<YYINITIAL>{c}{a}{s}{e}
{   /* case */
    return new Symbol(TokenConstants.CASE); }

<YYINITIAL>{e}{s}{a}{c}
{   /* esac */
    return new Symbol(TokenConstants.ESAC); }

<YYINITIAL>{i}{f}
{   /* if */
    return new Symbol(TokenConstants.IF); }

<YYINITIAL>{t}{h}{e}{n}
{   /* then */
    return new Symbol(TokenConstants.THEN); }

<YYINITIAL>{e}{l}{s}{e}
{   /* else */
    return new Symbol(TokenConstants.ELSE); }

<YYINITIAL>{f}{i}
{   /* fi */
    return new Symbol(TokenConstants.FI); }

<YYINITIAL>{w}{h}{i}{l}{e}
{   /* while */
    return new Symbol(TokenConstants.WHILE); }

<YYINITIAL>"=>"	
{   /* ==> */
    return new Symbol(TokenConstants.DARROW); }

<YYINITIAL>"<-"	
{   /* assign */
    return new Symbol(TokenConstants.ASSIGN); }

<YYINITIAL>"<="	
{   /* less than or equal */
    return new Symbol(TokenConstants.LE); }

<YYINITIAL>"+"
{    /* plus */
    return new Symbol(TokenConstants.PLUS); }

<YYINITIAL>"-"
{    /* minus */
    return new Symbol(TokenConstants.MINUS); }

<YYINITIAL>"*"
{    /* multiply */
    return new Symbol(TokenConstants.MULT); }

<YYINITIAL>"/"
{    /* divide */
    return new Symbol(TokenConstants.DIV); }

<YYINITIAL>"("
{    /* left parenthesis */
    return new Symbol(TokenConstants.LPAREN); }

<YYINITIAL>")"
{    /* right parenthesis*/
    return new Symbol(TokenConstants.RPAREN); }

<YYINITIAL>"{"
{    /* left brace */
    return new Symbol(TokenConstants.LBRACE); }

<YYINITIAL>"}"
{    /* right brace*/
    return new Symbol(TokenConstants.RBRACE); }

<YYINITIAL>"."
{    /* dot */
    return new Symbol(TokenConstants.DOT); }

<YYINITIAL>":"
{    /* colon */
    return new Symbol(TokenConstants.COLON); }

<YYINITIAL>","
{    /* comma */
    return new Symbol(TokenConstants.COMMA); }

<YYINITIAL>";"
{    /* semi colon */
    return new Symbol(TokenConstants.SEMI); }

<YYINITIAL>"="
{    /* equal */
    return new Symbol(TokenConstants.EQ); }

<YYINITIAL>"~"
{    /* negate */
    return new Symbol(TokenConstants.NEG); }

<YYINITIAL>"<"
{    /* less than */
    return new Symbol(TokenConstants.LT); }

<YYINITIAL>"@"
{    /* at */
    return new Symbol(TokenConstants.AT); }

<YYINITIAL>{WS}
{    /*do nothing*/
    System.out.println("White Space of: "+yytext()); }


<YYINITIAL>. 
{ /* This rule should be the very last
     in your lexical specification and
     will match match everything not
     matched by other lexical rules. */
    System.err.println("LEXER BUG - UNMATCHED: " + yytext()); 
    /*return new Symbol(TokenConstants.ERROR);*/ }