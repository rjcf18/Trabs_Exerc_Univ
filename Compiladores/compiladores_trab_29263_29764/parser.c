/* A Bison parser, made by GNU Bison 2.7.12-4996.  */

/* Bison implementation for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.7.12-4996"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
/* Line 371 of yacc.c  */
#line 1 "vspl.y"

#include <stdio.h>
#include <stdbool.h>
#include "structs.h"
	
  int yylex (void);
  void yyerror (char const *);
  double array[26];
  int line;

/* Line 371 of yacc.c  */
#line 79 "parser.c"

# ifndef YY_NULL
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULL nullptr
#  else
#   define YY_NULL 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "parser.h".  */
#ifndef YY_YY_PARSER_H_INCLUDED
# define YY_YY_PARSER_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INT_LIT = 258,
     BOOL_LIT = 259,
     REAL_LIT = 260,
     ID = 261,
     OP = 262,
     NL = 263,
     INT = 264,
     REAL = 265,
     BOOL = 266,
     VOID = 267,
     LPAR = 268,
     RPAR = 269,
     LPARR = 270,
     RPARR = 271,
     LPARC = 272,
     RPARC = 273,
     GREATEROREQUAL = 274,
     GREATER = 275,
     DIFF = 276,
     LESS = 277,
     LESSOREQUAL = 278,
     EQUAL = 279,
     POINT = 280,
     CLASS = 281,
     MAP = 282,
     ARROBA = 283,
     RARROW = 284,
     BREAK = 285,
     RETRY = 286,
     WHILE = 287,
     DECLASSIGN = 288,
     COMMA = 289,
     DOUBLEQUOTE = 290,
     SKIP = 291,
     ENDOFSTM = 292,
     RETURN = 293,
     ELSE = 294,
     COND = 295,
     NEG = 296,
     NOT = 297,
     OR = 298,
     AND = 299,
     MOD = 300,
     DIV = 301,
     MUL = 302,
     ADD = 303,
     SUB = 304
   };
#endif
/* Tokens.  */
#define INT_LIT 258
#define BOOL_LIT 259
#define REAL_LIT 260
#define ID 261
#define OP 262
#define NL 263
#define INT 264
#define REAL 265
#define BOOL 266
#define VOID 267
#define LPAR 268
#define RPAR 269
#define LPARR 270
#define RPARR 271
#define LPARC 272
#define RPARC 273
#define GREATEROREQUAL 274
#define GREATER 275
#define DIFF 276
#define LESS 277
#define LESSOREQUAL 278
#define EQUAL 279
#define POINT 280
#define CLASS 281
#define MAP 282
#define ARROBA 283
#define RARROW 284
#define BREAK 285
#define RETRY 286
#define WHILE 287
#define DECLASSIGN 288
#define COMMA 289
#define DOUBLEQUOTE 290
#define SKIP 291
#define ENDOFSTM 292
#define RETURN 293
#define ELSE 294
#define COND 295
#define NEG 296
#define NOT 297
#define OR 298
#define AND 299
#define MOD 300
#define DIV 301
#define MUL 302
#define ADD 303
#define SUB 304



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 387 of yacc.c  */
#line 12 "vspl.y"

	char *chr;
	int inteiro;
    float real;
    double val;
    
    struct Id *id;
    struct Ids *ids;
    struct Exp *exp;
    struct SExp *sexp;
    struct Formals *formals;
    struct Formal_decl *formal_decl;
    struct Statements *statements;
    struct Statement *statement;
    struct Type *type;
    struct Single_Type *single_type;
    struct Decl *decl;
    struct Decls *decls;
    struct Prim *prim;
    struct Clauses *clauses;
    struct Op *op;
    


/* Line 387 of yacc.c  */
#line 245 "parser.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_PARSER_H_INCLUDED  */

/* Copy the second part of user declarations.  */

/* Line 390 of yacc.c  */
#line 273 "parser.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef __attribute__
/* This feature is available in gcc versions 2.5 and later.  */
# if (! defined __GNUC__ || __GNUC__ < 2 \
      || (__GNUC__ == 2 && __GNUC_MINOR__ < 5))
#  define __attribute__(Spec) /* empty */
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif


/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(N) (N)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (YYID (0))
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  2
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   254

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  50
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  17
/* YYNRULES -- Number of rules.  */
#define YYNRULES  91
/* YYNRULES -- Number of states.  */
#define YYNSTATES  184

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   304

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     4,     7,     8,    10,    13,    18,    23,
      30,    37,    42,    43,    46,    49,    54,    56,    60,    62,
      65,    67,    69,    71,    73,    75,    77,    79,    81,    83,
      85,    87,    89,    91,    93,    97,   101,   103,   105,   107,
     109,   113,   118,   122,   123,   125,   129,   133,   137,   141,
     144,   148,   152,   156,   160,   164,   168,   172,   176,   180,
     184,   188,   191,   195,   200,   205,   210,   212,   214,   216,
     218,   222,   230,   240,   242,   246,   251,   252,   255,   257,
     259,   264,   270,   274,   277,   280,   283,   288,   293,   297,
     301,   307
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      51,     0,    -1,    -1,    51,    52,    -1,    -1,     8,    -1,
      53,    52,    -1,    56,    24,    59,    37,    -1,    56,    35,
      59,    37,    -1,    56,    35,    59,    33,    61,    37,    -1,
      56,    35,    59,    24,    61,    37,    -1,    56,    24,    61,
      37,    -1,    -1,    55,    54,    -1,    56,    37,    -1,    56,
      35,    59,    37,    -1,    57,    -1,    57,    34,    56,    -1,
       6,    -1,     7,    58,    -1,    48,    -1,    49,    -1,    46,
      -1,    47,    -1,    45,    -1,    44,    -1,    43,    -1,    42,
      -1,    22,    -1,    23,    -1,    21,    -1,    20,    -1,    19,
      -1,    60,    -1,    13,    59,    14,    -1,    60,    34,    59,
      -1,     9,    -1,    10,    -1,    11,    -1,    12,    -1,    59,
      29,    59,    -1,    15,    61,    16,    59,    -1,    17,    54,
      18,    -1,    -1,    62,    -1,    62,    34,    61,    -1,    13,
      61,    14,    -1,    62,    43,    62,    -1,    62,    44,    62,
      -1,    42,    62,    -1,    62,    22,    62,    -1,    62,    23,
      62,    -1,    62,    24,    62,    -1,    62,    21,    62,    -1,
      62,    19,    62,    -1,    62,    20,    62,    -1,    62,    48,
      62,    -1,    62,    49,    62,    -1,    62,    47,    62,    -1,
      62,    46,    62,    -1,    62,    45,    62,    -1,    49,    62,
      -1,    62,    25,     6,    -1,    62,    15,    61,    16,    -1,
      62,    13,    61,    14,    -1,    28,    13,    61,    14,    -1,
       6,    -1,     3,    -1,     5,    -1,     4,    -1,    15,    61,
      16,    -1,    27,    13,    54,    14,    15,    64,    16,    -1,
      27,    13,    54,    14,    29,    59,    15,    64,    16,    -1,
       6,    -1,    63,    25,     6,    -1,    63,    15,    61,    16,
      -1,    -1,    65,    64,    -1,     8,    -1,    53,    -1,    63,
      33,    61,    37,    -1,    63,    13,    61,    14,    37,    -1,
      38,    61,    37,    -1,    30,    37,    -1,    36,    37,    -1,
      31,    37,    -1,    40,    15,    66,    16,    -1,    32,    15,
      66,    16,    -1,    15,    64,    16,    -1,    61,    29,    64,
      -1,    61,    29,    64,    43,    66,    -1,    61,    29,    64,
      43,    39,    29,    64,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    77,    77,    78,    83,    84,    85,    90,    95,   100,
     105,   110,   118,   119,   123,   128,   135,   136,   139,   144,
     152,   153,   154,   155,   156,   157,   158,   159,   160,   161,
     162,   163,   164,   168,   173,   178,   187,   193,   198,   203,
     208,   213,   218,   227,   228,   229,   230,   236,   241,   246,
     252,   257,   262,   267,   272,   277,   283,   288,   293,   298,
     303,   308,   314,   319,   324,   329,   334,   340,   345,   350,
     355,   360,   365,   376,   380,   384,   391,   392,   400,   405,
     410,   415,   420,   425,   430,   435,   440,   445,   450,   459,
     464,   469
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "INT_LIT", "BOOL_LIT", "REAL_LIT", "ID",
  "OP", "NL", "INT", "REAL", "BOOL", "VOID", "LPAR", "RPAR", "LPARR",
  "RPARR", "LPARC", "RPARC", "GREATEROREQUAL", "GREATER", "DIFF", "LESS",
  "LESSOREQUAL", "EQUAL", "POINT", "CLASS", "MAP", "ARROBA", "RARROW",
  "BREAK", "RETRY", "WHILE", "DECLASSIGN", "COMMA", "DOUBLEQUOTE", "SKIP",
  "ENDOFSTM", "RETURN", "ELSE", "COND", "NEG", "NOT", "OR", "AND", "MOD",
  "DIV", "MUL", "ADD", "SUB", "$accept", "input", "decls", "decl",
  "formals", "formal_decl", "ids", "id", "op", "type", "single_type",
  "exp", "sexp", "prim", "stats", "stat", "clauses", YY_NULL
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    50,    51,    51,    52,    52,    52,    53,    53,    53,
      53,    53,    54,    54,    55,    55,    56,    56,    57,    57,
      58,    58,    58,    58,    58,    58,    58,    58,    58,    58,
      58,    58,    58,    59,    59,    59,    60,    60,    60,    60,
      60,    60,    60,    61,    61,    61,    61,    62,    62,    62,
      62,    62,    62,    62,    62,    62,    62,    62,    62,    62,
      62,    62,    62,    62,    62,    62,    62,    62,    62,    62,
      62,    62,    62,    63,    63,    63,    64,    64,    65,    65,
      65,    65,    65,    65,    65,    65,    65,    65,    65,    66,
      66,    66
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     2,     0,     1,     2,     4,     4,     6,
       6,     4,     0,     2,     2,     4,     1,     3,     1,     2,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     3,     3,     1,     1,     1,     1,
       3,     4,     3,     0,     1,     3,     3,     3,     3,     2,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     2,     3,     4,     4,     4,     1,     1,     1,     1,
       3,     7,     9,     1,     3,     4,     0,     2,     1,     1,
       4,     5,     3,     2,     2,     2,     4,     4,     3,     3,
       5,     7
};

/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       2,     0,     1,    18,     0,     5,     3,     4,     0,    16,
      32,    31,    30,    28,    29,    27,    26,    25,    24,    22,
      23,    20,    21,    19,     6,    43,     0,     0,    67,    69,
      68,    66,    36,    37,    38,    39,    43,    43,    12,     0,
       0,     0,     0,     0,    33,     0,    44,     0,    43,     0,
      17,     0,     0,    43,    43,     0,     0,    12,     0,    12,
      43,    49,    61,     0,     7,     0,    11,    43,    43,     0,
       0,     0,     0,     0,     0,     0,    43,     0,     0,     0,
       0,     0,     0,     0,     0,    43,    43,     8,    34,    46,
       0,    70,    42,    13,     0,    14,     0,     0,    40,    35,
       0,     0,    54,    55,    53,    50,    51,    52,    62,    45,
      47,    48,    60,    59,    58,    56,    57,     0,     0,     0,
      70,    41,     0,     0,    65,    64,    63,    10,     9,    15,
      76,     0,    73,    78,    76,     0,     0,     0,     0,    43,
       0,    79,     0,     0,    76,     0,     0,    83,    85,    43,
      84,     0,    43,    43,    43,     0,    43,    71,    77,    76,
      88,     0,     0,    82,     0,     0,     0,    74,     0,     0,
      76,    87,    86,     0,    75,    80,    72,    89,    81,    43,
       0,    90,    76,    91
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,     6,   141,    56,    57,     8,     9,    23,    51,
      44,   161,    46,   142,   143,   144,   162
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -150
static const yytype_int16 yypact[] =
{
    -150,   113,  -150,  -150,   205,  -150,  -150,   132,    -3,   -12,
    -150,  -150,  -150,  -150,  -150,  -150,  -150,  -150,  -150,  -150,
    -150,  -150,  -150,  -150,  -150,    68,    91,    85,  -150,  -150,
    -150,  -150,  -150,  -150,  -150,  -150,    68,   131,    85,    13,
      37,    10,    10,    11,    35,    38,   162,    91,   131,    25,
    -150,    -9,    80,   131,   131,    66,    87,    85,   -31,    85,
     131,    40,    40,    91,  -150,    91,  -150,   131,   131,    10,
      10,    10,    10,    10,    10,    92,   131,    10,    10,    10,
      10,    10,    10,    10,    93,   131,   131,  -150,  -150,  -150,
      99,    91,  -150,  -150,    91,  -150,   102,   104,    98,    98,
     108,   114,   154,   154,   154,   154,   154,   154,  -150,  -150,
      40,    40,    40,    40,    40,    40,    40,    91,    95,   105,
    -150,    98,    39,    -5,  -150,  -150,  -150,  -150,  -150,  -150,
     206,    91,    12,  -150,   206,   106,   110,   126,   111,   131,
     130,  -150,    -6,   133,   206,     2,   134,  -150,  -150,   131,
    -150,   135,   131,   131,   131,   145,   131,  -150,  -150,   206,
    -150,   139,   155,  -150,   158,   156,   160,  -150,   141,   172,
     206,  -150,  -150,   152,  -150,  -150,  -150,   147,  -150,    84,
     163,  -150,   206,  -150
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -150,  -150,   184,    56,    27,  -150,     7,  -150,  -150,   -24,
    -150,   -25,    83,  -150,  -126,  -150,  -149
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -19
static const yytype_int16 yytable[] =
{
      45,    43,    49,   164,    94,    88,    95,   153,   146,   154,
     130,    52,    55,    28,    29,    30,    31,   159,   158,   155,
      63,    25,    27,    84,   131,    54,    59,   156,    52,    90,
     181,    63,    26,   169,    50,    97,   -18,    39,    40,    98,
      63,    99,   100,   101,   177,    58,   -18,   -18,    64,    85,
      60,   109,    41,    67,    63,    68,   183,     7,    86,    42,
     118,   119,    87,     7,    58,    75,    58,   121,    63,    65,
     122,    28,    29,    30,    31,    66,   129,    32,    33,    34,
      35,    36,    91,    37,    93,    38,    96,    28,    29,    30,
      31,     3,     4,   121,    89,    39,    40,    53,   108,    54,
      32,    33,    34,    35,    47,    92,    48,   145,    38,   117,
      41,    39,    40,     2,   151,   120,   123,    42,   124,     3,
       4,     5,   125,   180,    61,    62,    41,    63,   165,   166,
     126,   168,   127,    42,    28,    29,    30,    31,     3,     4,
       5,   149,   128,   147,    53,   152,    54,   148,   150,   157,
     160,   167,   102,   103,   104,   105,   106,   107,    39,    40,
     110,   111,   112,   113,   114,   115,   116,    67,   170,    68,
     173,   171,   163,    41,   172,    67,   174,    68,   175,    75,
      42,    69,    70,    71,    72,    73,    74,    75,   176,   178,
     179,    24,   182,     0,     0,     0,    76,    77,    78,    79,
      80,    81,    82,    83,     0,    77,    78,    79,    80,    81,
      82,    83,   132,     4,   133,     0,     0,     0,     0,     0,
       0,   134,     0,     0,    10,    11,    12,    13,    14,     0,
       0,     0,     0,     0,     0,     0,   135,   136,   137,     0,
       0,     0,   138,     0,   139,     0,   140,    15,    16,    17,
      18,    19,    20,    21,    22
};

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-150)))

#define yytable_value_is_error(Yytable_value) \
  YYID (0)

static const yytype_int16 yycheck[] =
{
      25,    25,    26,   152,    35,    14,    37,    13,   134,    15,
      15,    36,    37,     3,     4,     5,     6,    15,   144,    25,
      29,    24,    34,    48,    29,    15,    13,    33,    53,    54,
     179,    29,    35,   159,    27,    60,    24,    27,    28,    63,
      29,    65,    67,    68,   170,    38,    34,    35,    37,    24,
      13,    76,    42,    13,    29,    15,   182,     1,    33,    49,
      85,    86,    37,     7,    57,    25,    59,    91,    29,    34,
      94,     3,     4,     5,     6,    37,    37,     9,    10,    11,
      12,    13,    16,    15,    57,    17,    59,     3,     4,     5,
       6,     6,     7,   117,    14,    27,    28,    13,     6,    15,
       9,    10,    11,    12,    13,    18,    15,   131,    17,    16,
      42,    27,    28,     0,   139,    16,    14,    49,    14,     6,
       7,     8,    14,    39,    41,    42,    42,    29,   153,   154,
      16,   156,    37,    49,     3,     4,     5,     6,     6,     7,
       8,    15,    37,    37,    13,    15,    15,    37,    37,    16,
      16,     6,    69,    70,    71,    72,    73,    74,    27,    28,
      77,    78,    79,    80,    81,    82,    83,    13,    29,    15,
      14,    16,    37,    42,    16,    13,    16,    15,    37,    25,
      49,    19,    20,    21,    22,    23,    24,    25,    16,    37,
      43,     7,    29,    -1,    -1,    -1,    34,    43,    44,    45,
      46,    47,    48,    49,    -1,    43,    44,    45,    46,    47,
      48,    49,     6,     7,     8,    -1,    -1,    -1,    -1,    -1,
      -1,    15,    -1,    -1,    19,    20,    21,    22,    23,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    30,    31,    32,    -1,
      -1,    -1,    36,    -1,    38,    -1,    40,    42,    43,    44,
      45,    46,    47,    48,    49
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    51,     0,     6,     7,     8,    52,    53,    56,    57,
      19,    20,    21,    22,    23,    42,    43,    44,    45,    46,
      47,    48,    49,    58,    52,    24,    35,    34,     3,     4,
       5,     6,     9,    10,    11,    12,    13,    15,    17,    27,
      28,    42,    49,    59,    60,    61,    62,    13,    15,    59,
      56,    59,    61,    13,    15,    61,    54,    55,    56,    13,
      13,    62,    62,    29,    37,    34,    37,    13,    15,    19,
      20,    21,    22,    23,    24,    25,    34,    43,    44,    45,
      46,    47,    48,    49,    61,    24,    33,    37,    14,    14,
      61,    16,    18,    54,    35,    37,    54,    61,    59,    59,
      61,    61,    62,    62,    62,    62,    62,    62,     6,    61,
      62,    62,    62,    62,    62,    62,    62,    16,    61,    61,
      16,    59,    59,    14,    14,    14,    16,    37,    37,    37,
      15,    29,     6,     8,    15,    30,    31,    32,    36,    38,
      40,    53,    63,    64,    65,    59,    64,    37,    37,    15,
      37,    61,    15,    13,    15,    25,    33,    16,    64,    15,
      16,    61,    66,    37,    66,    61,    61,     6,    61,    64,
      29,    16,    16,    14,    16,    37,    16,    64,    37,    43,
      39,    66,    29,    64
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  However,
   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
   discussed.  */

#define YYFAIL		goto yyerrlab
#if defined YYFAIL
  /* This is here to suppress warnings from the GCC cpp's
     -Wunused-macros.  Normally we don't worry about that warning, but
     some users do, and we want to make it easy for users to remove
     YYFAIL uses, which will produce warnings from Bison 2.5.  */
#endif

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))

/* Error token number */
#define YYTERROR	1
#define YYERRCODE	256


/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */
#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULL, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULL;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - Assume YYFAIL is not used.  It's too flawed to consider.  See
       <http://lists.gnu.org/archive/html/bison-patches/2009-12/msg00024.html>
       for details.  YYERROR is fine as it does not invoke this
       function.
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULL, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YYUSE (yytype);
}




/* The lookahead symbol.  */
int yychar;


#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval YY_INITIAL_VALUE(yyval_default);

/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 3:
/* Line 1787 of yacc.c  */
#line 78 "vspl.y"
    {print_((yyvsp[(2) - (2)].decls));printf("Producao: program\n");}
    break;

  case 4:
/* Line 1787 of yacc.c  */
#line 83 "vspl.y"
    {(yyval.decls) = NULL;}
    break;

  case 5:
/* Line 1787 of yacc.c  */
#line 84 "vspl.y"
    {(yyval.decls) = NULL;}
    break;

  case 6:
/* Line 1787 of yacc.c  */
#line 85 "vspl.y"
    {(yyval.decls) = new_decls((yyvsp[(1) - (2)].decl), (yyvsp[(2) - (2)].decls));printf("Producao: decls\n");}
    break;

  case 7:
/* Line 1787 of yacc.c  */
#line 91 "vspl.y"
    {
                (yyval.decl) = new_decl((yyvsp[(1) - (4)].ids), (yyvsp[(3) - (4)].type), NULL, DECL_1);
                printf("Producao: decl : ids = type ;\n");
            }
    break;

  case 8:
/* Line 1787 of yacc.c  */
#line 96 "vspl.y"
    {
                (yyval.decl) = new_decl((yyvsp[(1) - (4)].ids), (yyvsp[(3) - (4)].type), NULL, DECL_2);
                printf("Producao: decl : ids : type ;\n");
            }
    break;

  case 9:
/* Line 1787 of yacc.c  */
#line 101 "vspl.y"
    {
                (yyval.decl) = new_decl((yyvsp[(1) - (6)].ids), (yyvsp[(3) - (6)].type), (yyvsp[(5) - (6)].exp), DECL_3);
                printf("Producao: decl : ids : type := exp ;\n");
            }
    break;

  case 10:
/* Line 1787 of yacc.c  */
#line 106 "vspl.y"
    {
                (yyval.decl) = new_decl((yyvsp[(1) - (6)].ids), (yyvsp[(3) - (6)].type), (yyvsp[(5) - (6)].exp), DECL_4);
                printf("Producao: decl : ids : type = exp ;\n");
            }
    break;

  case 11:
/* Line 1787 of yacc.c  */
#line 111 "vspl.y"
    {
                (yyval.decl) = new_decl((yyvsp[(1) - (4)].ids), NULL, (yyvsp[(3) - (4)].exp), DECL_5);
                printf("Producao: decl : ids = exp ;\n");
            }
    break;

  case 12:
/* Line 1787 of yacc.c  */
#line 118 "vspl.y"
    {(yyval.formals) = NULL;}
    break;

  case 13:
/* Line 1787 of yacc.c  */
#line 119 "vspl.y"
    {(yyval.formals) = new_formals((yyvsp[(1) - (2)].formal_decl), (yyvsp[(2) - (2)].formals));printf("Producao: formals\n");}
    break;

  case 14:
/* Line 1787 of yacc.c  */
#line 124 "vspl.y"
    {
                (yyval.formal_decl) = new_formal_decl((yyvsp[(1) - (2)].ids), NULL, FORMAL_DECL_1);
                printf("Producao: formal_decl : ids ;\n");
            }
    break;

  case 15:
/* Line 1787 of yacc.c  */
#line 129 "vspl.y"
    {
                (yyval.formal_decl) = new_formal_decl((yyvsp[(1) - (4)].ids), (yyvsp[(3) - (4)].type), FORMAL_DECL_2);
                printf("Producao: formal_decl : ids : type ;\n");
            }
    break;

  case 16:
/* Line 1787 of yacc.c  */
#line 135 "vspl.y"
    {(yyval.ids)= new_ids((yyvsp[(1) - (1)].id), NULL, IDS_1);}
    break;

  case 17:
/* Line 1787 of yacc.c  */
#line 136 "vspl.y"
    {(yyval.ids)= new_ids((yyvsp[(1) - (3)].id), (yyvsp[(3) - (3)].ids), IDS_2);}
    break;

  case 18:
/* Line 1787 of yacc.c  */
#line 140 "vspl.y"
    {
                (yyval.id) = new_id((yyvsp[(1) - (1)].chr));
                printf("Producao: id : %s\n", (yyvsp[(1) - (1)].chr));
            }
    break;

  case 19:
/* Line 1787 of yacc.c  */
#line 145 "vspl.y"
    {
                (yyval.id) = new_id_op((yyvsp[(1) - (2)].chr), (yyvsp[(2) - (2)].inteiro));
                printf("Producao: id : OP op\n");
            }
    break;

  case 20:
/* Line 1787 of yacc.c  */
#line 152 "vspl.y"
    {(yyval.inteiro) = ADD_;}
    break;

  case 21:
/* Line 1787 of yacc.c  */
#line 153 "vspl.y"
    {(yyval.inteiro) = SUB_;}
    break;

  case 22:
/* Line 1787 of yacc.c  */
#line 154 "vspl.y"
    {(yyval.inteiro) = DIV_;}
    break;

  case 23:
/* Line 1787 of yacc.c  */
#line 155 "vspl.y"
    {(yyval.inteiro) = MUL_;}
    break;

  case 24:
/* Line 1787 of yacc.c  */
#line 156 "vspl.y"
    {(yyval.inteiro) = MOD_;}
    break;

  case 25:
/* Line 1787 of yacc.c  */
#line 157 "vspl.y"
    {(yyval.inteiro) = AND_;}
    break;

  case 26:
/* Line 1787 of yacc.c  */
#line 158 "vspl.y"
    {(yyval.inteiro) = OR_;}
    break;

  case 27:
/* Line 1787 of yacc.c  */
#line 159 "vspl.y"
    {(yyval.inteiro) = NOT_;}
    break;

  case 28:
/* Line 1787 of yacc.c  */
#line 160 "vspl.y"
    {(yyval.inteiro) = LESS_;}
    break;

  case 29:
/* Line 1787 of yacc.c  */
#line 161 "vspl.y"
    {(yyval.inteiro) = LESSOREQUAL_;}
    break;

  case 30:
/* Line 1787 of yacc.c  */
#line 162 "vspl.y"
    {(yyval.inteiro) = DIFF_;}
    break;

  case 31:
/* Line 1787 of yacc.c  */
#line 163 "vspl.y"
    {(yyval.inteiro) = GREATER_;}
    break;

  case 32:
/* Line 1787 of yacc.c  */
#line 164 "vspl.y"
    {(yyval.inteiro) = GREATEROREQUAL_;}
    break;

  case 33:
/* Line 1787 of yacc.c  */
#line 169 "vspl.y"
    {
                (yyval.type) = new_type((yyvsp[(1) - (1)].single_type), NULL, TYPE_1);
                printf("Producao: type\n");
            }
    break;

  case 34:
/* Line 1787 of yacc.c  */
#line 174 "vspl.y"
    {
                (yyval.type) = new_type(NULL, (yyvsp[(2) - (3)].type), TYPE_2);
                printf("Producao: type\n");
            }
    break;

  case 35:
/* Line 1787 of yacc.c  */
#line 179 "vspl.y"
    {
                (yyval.type) = new_type((yyvsp[(1) - (3)].single_type), (yyvsp[(3) - (3)].type), TYPE_3);
                printf("Producao: type\n");
            }
    break;

  case 36:
/* Line 1787 of yacc.c  */
#line 188 "vspl.y"
    {
                (yyval.single_type) = new_single_type(NULL, NULL, NULL,NULL, INT_);
                printf("Producao: single_type : INT\n");
            }
    break;

  case 37:
/* Line 1787 of yacc.c  */
#line 194 "vspl.y"
    {
                (yyval.single_type) = new_single_type(NULL, NULL, NULL,NULL, REAL_);
                printf("Producao: single_type : REAL\n");
            }
    break;

  case 38:
/* Line 1787 of yacc.c  */
#line 199 "vspl.y"
    {
                (yyval.single_type) = new_single_type(NULL, NULL, NULL,NULL, BOOL_);
                printf("Producao: single_type : BOOL\n");
            }
    break;

  case 39:
/* Line 1787 of yacc.c  */
#line 204 "vspl.y"
    {
                (yyval.single_type) = new_single_type(NULL, NULL, NULL,NULL, VOID_);
                printf("Producao: single_type : VOID\n");
            }
    break;

  case 40:
/* Line 1787 of yacc.c  */
#line 209 "vspl.y"
    {
                (yyval.single_type) = new_single_type((yyvsp[(1) - (3)].type), (yyvsp[(3) - (3)].type), NULL, NULL, FUNCTIONAL_TYPE_);
                printf("Producao: single_type : type -> type\n");
            }
    break;

  case 41:
/* Line 1787 of yacc.c  */
#line 214 "vspl.y"
    {
                (yyval.single_type) = new_single_type((yyvsp[(4) - (4)].type), NULL, (yyvsp[(2) - (4)].exp), NULL, ARRAY_);
                printf("Producao: single_type : [ exp ] type\n");
            }
    break;

  case 42:
/* Line 1787 of yacc.c  */
#line 219 "vspl.y"
    {
                (yyval.single_type) = new_single_type(NULL, NULL, NULL, (yyvsp[(2) - (3)].formals), AGREGADO_);
                printf("Producao: single_type : { formals } \n");
            }
    break;

  case 43:
/* Line 1787 of yacc.c  */
#line 227 "vspl.y"
    {(yyval.exp) = NULL;}
    break;

  case 44:
/* Line 1787 of yacc.c  */
#line 228 "vspl.y"
    {(yyval.exp) = new_exp((yyvsp[(1) - (1)].sexp), NULL, STRUCT_EXP_1);printf("Producao: exp : sexp\n");}
    break;

  case 45:
/* Line 1787 of yacc.c  */
#line 229 "vspl.y"
    {(yyval.exp) = new_exp((yyvsp[(1) - (3)].sexp), (yyvsp[(3) - (3)].exp), STRUCT_EXP_2);printf("Producao: exp : sexp , exp\n");}
    break;

  case 46:
/* Line 1787 of yacc.c  */
#line 230 "vspl.y"
    {(yyval.exp) = new_exp(NULL, (yyvsp[(2) - (3)].exp), STRUCT_EXP_3);printf("Producao: exp : ( exp )\n");}
    break;

  case 47:
/* Line 1787 of yacc.c  */
#line 237 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_OR, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp OR sexp\n");
            }
    break;

  case 48:
/* Line 1787 of yacc.c  */
#line 242 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_AND, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp: sexp AND sexp\n");
            }
    break;

  case 49:
/* Line 1787 of yacc.c  */
#line 247 "vspl.y"
    {
                (yyval.sexp) = new_sexp_sinop(OP_NOT, (yyvsp[(2) - (2)].sexp));
                printf("Producao: sexp: NOT sexp\n");
            }
    break;

  case 50:
/* Line 1787 of yacc.c  */
#line 253 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_LESS, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp LESS sexp\n");
            }
    break;

  case 51:
/* Line 1787 of yacc.c  */
#line 258 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_LESSOREQUAL, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp =< sexp\n");
            }
    break;

  case 52:
/* Line 1787 of yacc.c  */
#line 263 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_EQUAL, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp = sexp\n");
            }
    break;

  case 53:
/* Line 1787 of yacc.c  */
#line 268 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_DIFF, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp != sexp\n");
            }
    break;

  case 54:
/* Line 1787 of yacc.c  */
#line 273 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_GREATEROREQUAL, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp >= sexp\n");
            }
    break;

  case 55:
/* Line 1787 of yacc.c  */
#line 278 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_GREATER, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexpt > sexp\n");
            }
    break;

  case 56:
/* Line 1787 of yacc.c  */
#line 284 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_ADD, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp + sexp\n");
            }
    break;

  case 57:
/* Line 1787 of yacc.c  */
#line 289 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_SUB, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp - sexp\n");
            }
    break;

  case 58:
/* Line 1787 of yacc.c  */
#line 294 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_MUL, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp * sexp\n");
            }
    break;

  case 59:
/* Line 1787 of yacc.c  */
#line 299 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_DIV, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp / sexp\n");
            }
    break;

  case 60:
/* Line 1787 of yacc.c  */
#line 304 "vspl.y"
    {
                (yyval.sexp) = new_sexp_binop((yyvsp[(1) - (3)].sexp), OP_MOD, (yyvsp[(3) - (3)].sexp));
                printf("Producao: sexp : sexp mod sexp\n");
            }
    break;

  case 61:
/* Line 1787 of yacc.c  */
#line 309 "vspl.y"
    {
                (yyval.sexp) = new_sexp_sinop(OP_SUB, (yyvsp[(2) - (2)].sexp));
                printf("Producao: sexp : -sexp\n");
            }
    break;

  case 62:
/* Line 1787 of yacc.c  */
#line 315 "vspl.y"
    {
                (yyval.sexp) = new_sexp_qualified_name((yyvsp[(1) - (3)].sexp), (yyvsp[(3) - (3)].chr));
                printf("Producao: sexp : sexp.ID\n");
            }
    break;

  case 63:
/* Line 1787 of yacc.c  */
#line 320 "vspl.y"
    {
                (yyval.sexp) = new_sexp_sexp_2((yyvsp[(1) - (4)].sexp), (yyvsp[(3) - (4)].exp), STRUCT_ARRAY_REF);
                printf("Producao: sexp : sexp [ exp ]\n");
            }
    break;

  case 64:
/* Line 1787 of yacc.c  */
#line 325 "vspl.y"
    {
                (yyval.sexp) = new_sexp_sexp_2((yyvsp[(1) - (4)].sexp), (yyvsp[(3) - (4)].exp), STRUCT_APLICACAO_FUNCIONAL);
                printf("Producao: sexp : sexp ( exp ) aplicacao funcional\n");
            }
    break;

  case 65:
/* Line 1787 of yacc.c  */
#line 330 "vspl.y"
    {
                (yyval.sexp) = new_sexp_recursive_call((yyvsp[(3) - (4)].exp));
                printf("Producao: sexp : @ [ exp ]\n");
            }
    break;

  case 66:
/* Line 1787 of yacc.c  */
#line 335 "vspl.y"
    {
                (yyval.sexp) = new_sexp_id((yyvsp[(1) - (1)].chr));
                char *a = (yyvsp[(1) - (1)].chr);printf("Producao: sexp : ID = %s\n", a);
            }
    break;

  case 67:
/* Line 1787 of yacc.c  */
#line 341 "vspl.y"
    {
                (yyval.sexp) = new_sexp_literal((yyvsp[(1) - (1)].inteiro), LITERAL_INT);
                printf("Producao: sexp : INT_LIT\n");
            }
    break;

  case 68:
/* Line 1787 of yacc.c  */
#line 346 "vspl.y"
    {
                (yyval.sexp) = new_sexp_literal((yyvsp[(1) - (1)].real), LITERAL_REAL);
                printf("Producao: sexp : REAL_LIT\n");
            }
    break;

  case 69:
/* Line 1787 of yacc.c  */
#line 351 "vspl.y"
    {
                (yyval.sexp) = new_sexp_literal((yyvsp[(1) - (1)].inteiro), LITERAL_BOOL);
                printf("Producao: sexp : BOOL_LIT\n");
            }
    break;

  case 70:
/* Line 1787 of yacc.c  */
#line 356 "vspl.y"
    {
                (yyval.sexp) = new_sexp_literal_array((yyvsp[(2) - (3)].exp));
                printf("Producao: sexp : [ exp ]\n");
            }
    break;

  case 71:
/* Line 1787 of yacc.c  */
#line 361 "vspl.y"
    {
                (yyval.sexp) = new_sexp_map((yyvsp[(3) - (7)].formals), NULL, (yyvsp[(6) - (7)].statements), STRUCT_MAP);
                printf("Producao: sexp : MAP ( formals ) [ stats ] \n");
            }
    break;

  case 72:
/* Line 1787 of yacc.c  */
#line 366 "vspl.y"
    {
                (yyval.sexp) = new_sexp_map((yyvsp[(3) - (9)].formals), (yyvsp[(6) - (9)].type), (yyvsp[(8) - (9)].statements), STRUCT_MAP_TYPE);
                printf("Producao: sexp : MAP ( formals ) -> type [ stats ]\n");
            }
    break;

  case 73:
/* Line 1787 of yacc.c  */
#line 377 "vspl.y"
    {
                (yyval.prim) = new_prim((yyvsp[(1) - (1)].chr), NULL, NULL, PRIM_1);
            }
    break;

  case 74:
/* Line 1787 of yacc.c  */
#line 381 "vspl.y"
    {
                (yyval.prim) = new_prim((yyvsp[(3) - (3)].chr), (yyvsp[(1) - (3)].prim), NULL, PRIM_2);
            }
    break;

  case 75:
/* Line 1787 of yacc.c  */
#line 385 "vspl.y"
    {
                (yyval.prim) = new_prim(NULL, (yyvsp[(1) - (4)].prim), (yyvsp[(3) - (4)].exp), PRIM_3);
            }
    break;

  case 76:
/* Line 1787 of yacc.c  */
#line 391 "vspl.y"
    {(yyval.statements)=NULL;}
    break;

  case 77:
/* Line 1787 of yacc.c  */
#line 393 "vspl.y"
    {
            //$$ = new_stats($1, $2);
            printf("Producao: stats\n");
        }
    break;

  case 78:
/* Line 1787 of yacc.c  */
#line 401 "vspl.y"
    {
                (yyval.statement)=NULL;line++;
                printf("\nline: %d\n\n", line);
            }
    break;

  case 79:
/* Line 1787 of yacc.c  */
#line 406 "vspl.y"
    {
                (yyval.statement) = new_stat((yyvsp[(1) - (1)].decl), NULL, NULL, NULL, NULL, DECL_);
                printf("Producao: stat : decl\n");
            }
    break;

  case 80:
/* Line 1787 of yacc.c  */
#line 411 "vspl.y"
    {
                (yyval.statement) = new_stat(NULL, (yyvsp[(1) - (4)].prim), (yyvsp[(3) - (4)].exp), NULL, NULL, AFECTACAO_);
                printf("Producao: stat : prim := exp ;\n");
            }
    break;

  case 81:
/* Line 1787 of yacc.c  */
#line 416 "vspl.y"
    {
                (yyval.statement) = new_stat(NULL, (yyvsp[(1) - (5)].prim), (yyvsp[(3) - (5)].exp), NULL, NULL, CALL_);
                printf("Producao: stat : prim ( exp ) ;\n");
            }
    break;

  case 82:
/* Line 1787 of yacc.c  */
#line 421 "vspl.y"
    {
                (yyval.statement)= new_stat(NULL, NULL, (yyvsp[(2) - (3)].exp), NULL, NULL, RETURN_);
                printf("Producao: stat : ^ exp ;\n");
            }
    break;

  case 83:
/* Line 1787 of yacc.c  */
#line 426 "vspl.y"
    {
                (yyval.statement)= new_stat(NULL, NULL, NULL, NULL, NULL, BREAK_);
                printf("Producao: stat : break;\n");
            }
    break;

  case 84:
/* Line 1787 of yacc.c  */
#line 431 "vspl.y"
    {
                (yyval.statement)= new_stat(NULL, NULL, NULL, NULL, NULL, SKIP_);
                printf("Producao: stat : skip;\n");
            }
    break;

  case 85:
/* Line 1787 of yacc.c  */
#line 436 "vspl.y"
    {
                (yyval.statement)= new_stat(NULL, NULL, NULL, NULL, NULL, RETRY_);
                printf("Producao: stat : retry;\n");
            }
    break;

  case 86:
/* Line 1787 of yacc.c  */
#line 441 "vspl.y"
    {
                (yyval.statement)= new_stat(NULL, NULL, NULL, (yyvsp[(3) - (4)].clauses), NULL, COND_);
                printf("Producao: stat : ? [ clauses ]\n");
            }
    break;

  case 87:
/* Line 1787 of yacc.c  */
#line 446 "vspl.y"
    {
                (yyval.statement)= new_stat(NULL, NULL, NULL, (yyvsp[(3) - (4)].clauses), NULL, WHILE_);
                printf("Producao: stat : while [ clauses ]\n");
            }
    break;

  case 88:
/* Line 1787 of yacc.c  */
#line 451 "vspl.y"
    {
                (yyval.statement)= new_stat(NULL, NULL, NULL, NULL, NULL, AGRUPAMENTO_);
                printf("Producao: stat : [ stats ]\n");
            }
    break;

  case 89:
/* Line 1787 of yacc.c  */
#line 460 "vspl.y"
    {
                (yyval.clauses) = new_clauses((yyvsp[(1) - (3)].exp), (yyvsp[(3) - (3)].statements), NULL, NULL, CLAUSES_1);
                printf("Producao: clauses : exp -> stats\n");
            }
    break;

  case 90:
/* Line 1787 of yacc.c  */
#line 465 "vspl.y"
    {
                (yyval.clauses) = new_clauses((yyvsp[(1) - (5)].exp), (yyvsp[(3) - (5)].statements), NULL, (yyvsp[(5) - (5)].clauses), CLAUSES_2);
                printf("Producao: clauses : exp -> stats | clauses \n");
            }
    break;

  case 91:
/* Line 1787 of yacc.c  */
#line 470 "vspl.y"
    {
                (yyval.clauses) = new_clauses((yyvsp[(1) - (7)].exp), (yyvsp[(3) - (7)].statements), (yyvsp[(7) - (7)].statements), NULL, CLAUSES_3);
                printf("Producao: clauses : exp -> stats | ELSE -> stats \n");
            }
    break;


/* Line 1787 of yacc.c  */
#line 2357 "parser.c"
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


/* Line 2050 of yacc.c  */
#line 518 "vspl.y"

/* Called by yyparse on error.  */
void print_(Decls *decls)
{
    printf("NICE!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
}

void yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}

int main (void)
{
    line = 1;
    return yyparse();
}
