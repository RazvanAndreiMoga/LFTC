
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     MAIN = 258,
     READ = 259,
     WRITE = 260,
     IF = 261,
     ELSE = 262,
     WHILE = 263,
     FOR = 264,
     IN = 265,
     RANGE = 266,
     INTEGER = 267,
     STRING = 268,
     CHAR = 269,
     READ_SYMBOL = 270,
     WRITE_SYMBOL = 271,
     SEMICOLON = 272,
     COLON = 273,
     COMMA = 274,
     OPEN_ROUND_BRACKET = 275,
     CLOSED_ROUND_BRACKET = 276,
     OPEN_SQUARE_BRACKET = 277,
     CLOSED_SQUARE_BRACKET = 278,
     OPEN_CURLY_BRACKET = 279,
     CLOSED_CURLY_BRACKET = 280,
     PLUS = 281,
     MINUS = 282,
     MULTIPLICATION = 283,
     DIVISION = 284,
     MODULO = 285,
     ASSIGNMENT = 286,
     GT = 287,
     GTE = 288,
     LT = 289,
     LTE = 290,
     EQ = 291,
     NOT_EQ = 292,
     INT_CONSTANT = 293,
     STRING_CONSTANT = 294,
     CHAR_CONSTANT = 295,
     IDENTIFIER = 296
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


