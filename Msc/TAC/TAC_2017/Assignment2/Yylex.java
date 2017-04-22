/* The following code was generated by JFlex 1.6.1 */

import java_cup.runtime.Symbol;


/**
 * This class is a scanner generated by 
 * <a href="http://www.jflex.de/">JFlex</a> 1.6.1
 * from the specification file <tt>irLexer.jflex</tt>
 */
class Yylex implements java_cup.runtime.Scanner {

  /** This character denotes the end of file */
  public static final int YYEOF = -1;

  /** initial size of the lookahead buffer */
  private static final int ZZ_BUFFERSIZE = 16384;

  /** lexical states */
  public static final int YYINITIAL = 0;

  /**
   * ZZ_LEXSTATE[l] is the state in the DFA for the lexical state l
   * ZZ_LEXSTATE[l+1] is the state in the DFA for the lexical state l
   *                  at the beginning of a line
   * l is of the form l = 2*k, k a non negative integer
   */
  private static final int ZZ_LEXSTATE[] = { 
     0, 0
  };

  /** 
   * Translates characters to character classes
   */
  private static final String ZZ_CMAP_PACKED = 
    "\11\0\1\45\1\43\1\44\1\44\1\44\22\0\1\45\2\0\1\42"+
    "\4\0\1\27\1\30\2\0\1\34\1\36\2\0\12\37\1\33\1\0"+
    "\1\35\3\0\1\40\32\41\1\31\1\0\1\32\1\0\1\21\1\0"+
    "\1\12\1\16\1\4\1\10\1\17\1\1\1\14\1\41\1\6\1\26"+
    "\1\41\1\15\1\22\1\3\1\7\1\24\1\23\1\13\1\20\1\5"+
    "\1\2\1\11\2\41\1\25\1\41\12\0\1\44\u1fa2\0\1\44\1\44"+
    "\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\udfe6\0";

  /** 
   * Translates characters to character classes
   */
  private static final char [] ZZ_CMAP = zzUnpackCMap(ZZ_CMAP_PACKED);

  /** 
   * Translates DFA states to action switch labels.
   */
  private static final int [] ZZ_ACTION = zzUnpackAction();

  private static final String ZZ_ACTION_PACKED_0 =
    "\1\0\15\1\1\2\1\3\1\4\1\5\1\6\1\7"+
    "\2\1\1\10\1\1\1\11\1\12\6\0\1\13\1\0"+
    "\1\14\6\0\1\15\4\0\1\16\1\17\1\20\1\0"+
    "\1\21\3\0\1\22\16\0\1\23\1\24\4\0\1\25"+
    "\3\0\1\26\1\0\1\27\1\30\13\0\1\31\1\0"+
    "\1\32\1\0\1\33\3\0\1\34\2\0\1\35\1\0"+
    "\1\36\1\0\1\37\1\40\2\0\1\41\1\42\1\0"+
    "\1\43\7\0\1\44\1\45\2\0\1\46\2\0\1\47"+
    "\1\50\11\0\1\51\2\0\1\52\1\53\2\0\1\54"+
    "\1\0\1\55\1\0\1\56\1\57\1\60\1\61\1\62"+
    "\1\63\1\64";

  private static int [] zzUnpackAction() {
    int [] result = new int[160];
    int offset = 0;
    offset = zzUnpackAction(ZZ_ACTION_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAction(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /** 
   * Translates a state to a row index in the transition table
   */
  private static final int [] ZZ_ROWMAP = zzUnpackRowMap();

  private static final String ZZ_ROWMAP_PACKED_0 =
    "\0\0\0\46\0\114\0\162\0\230\0\276\0\344\0\u010a"+
    "\0\u0130\0\u0156\0\u017c\0\u01a2\0\u01c8\0\u01ee\0\46\0\46"+
    "\0\46\0\46\0\46\0\46\0\u0214\0\u023a\0\u023a\0\u0260"+
    "\0\u0286\0\u02ac\0\u02d2\0\u02f8\0\u031e\0\u0344\0\u036a\0\u0390"+
    "\0\u03b6\0\u03dc\0\46\0\u0402\0\u0428\0\u044e\0\u0474\0\u049a"+
    "\0\u04c0\0\u04e6\0\u050c\0\u0532\0\u0558\0\u057e\0\46\0\u05a4"+
    "\0\u05ca\0\u05f0\0\46\0\u0616\0\u063c\0\u0662\0\46\0\u0688"+
    "\0\u06ae\0\u06d4\0\u06fa\0\u0720\0\u0746\0\u076c\0\u0792\0\u07b8"+
    "\0\u07de\0\u0804\0\u082a\0\u0850\0\u0876\0\46\0\46\0\u089c"+
    "\0\u08c2\0\u08e8\0\u090e\0\46\0\u0934\0\u095a\0\u0980\0\46"+
    "\0\u09a6\0\46\0\46\0\u09cc\0\u09f2\0\u0a18\0\u0a3e\0\u0a64"+
    "\0\u0a8a\0\u0ab0\0\u0ad6\0\u0afc\0\u0b22\0\u0b48\0\46\0\u0b6e"+
    "\0\46\0\u0b94\0\46\0\u0bba\0\u0be0\0\u0c06\0\46\0\u0c2c"+
    "\0\u0c52\0\46\0\u0c78\0\46\0\u0c9e\0\46\0\46\0\u0cc4"+
    "\0\u0cea\0\46\0\46\0\u0d10\0\46\0\u0d36\0\u0d5c\0\u0d82"+
    "\0\u0da8\0\u0dce\0\u0df4\0\u0e1a\0\46\0\46\0\u0e40\0\u0e66"+
    "\0\46\0\u0e8c\0\u0eb2\0\46\0\46\0\u0ed8\0\u0efe\0\u0f24"+
    "\0\u0f4a\0\u0f70\0\u0f96\0\u0fbc\0\u0fe2\0\u1008\0\46\0\u102e"+
    "\0\u1054\0\46\0\46\0\u107a\0\u10a0\0\46\0\u10c6\0\46"+
    "\0\u10ec\0\46\0\46\0\46\0\46\0\46\0\46\0\46";

  private static int [] zzUnpackRowMap() {
    int [] result = new int[160];
    int offset = 0;
    offset = zzUnpackRowMap(ZZ_ROWMAP_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackRowMap(String packed, int offset, int [] result) {
    int i = 0;  /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int high = packed.charAt(i++) << 16;
      result[j++] = high | packed.charAt(i++);
    }
    return j;
  }

  /** 
   * The transition table of the DFA
   */
  private static final int [] ZZ_TRANS = zzUnpackTrans();

  private static final String ZZ_TRANS_PACKED_0 =
    "\1\2\1\3\1\2\1\4\1\5\1\6\1\7\2\2"+
    "\1\10\1\11\1\12\1\2\1\13\1\14\3\2\1\15"+
    "\3\2\1\16\1\17\1\20\1\21\1\22\1\23\1\24"+
    "\1\25\1\26\1\27\1\30\1\2\1\31\1\32\1\0"+
    "\1\32\50\0\1\33\7\0\1\34\42\0\1\35\50\0"+
    "\1\36\13\0\1\37\32\0\1\40\23\0\1\41\11\0"+
    "\1\42\4\0\1\43\10\0\1\44\33\0\1\45\2\0"+
    "\1\46\46\0\1\47\51\0\1\50\35\0\1\51\27\0"+
    "\1\52\15\0\1\53\11\0\1\54\33\0\1\55\40\0"+
    "\1\56\101\0\1\57\46\0\1\27\7\0\26\60\12\0"+
    "\1\60\4\0\43\31\2\0\1\31\43\0\1\32\1\0"+
    "\1\32\3\0\1\61\57\0\1\62\35\0\1\63\55\0"+
    "\1\64\32\0\1\65\45\0\1\66\102\0\1\41\13\0"+
    "\1\67\43\0\1\70\1\71\1\0\1\72\1\0\1\73"+
    "\1\74\1\75\1\76\1\77\1\100\1\0\1\101\1\102"+
    "\1\0\1\103\1\0\1\104\27\0\1\105\52\0\1\106"+
    "\46\0\1\107\36\0\1\110\44\0\1\111\100\0\1\52"+
    "\15\0\1\112\62\0\1\113\31\0\1\114\57\0\1\115"+
    "\24\0\26\60\10\0\1\60\1\0\1\60\10\0\1\116"+
    "\61\0\1\117\42\0\1\120\52\0\1\121\42\0\1\122"+
    "\45\0\1\123\35\0\1\124\2\0\1\125\36\0\1\126"+
    "\50\0\1\127\51\0\1\130\43\0\1\131\4\0\1\132"+
    "\2\0\1\133\44\0\1\134\43\0\1\135\2\0\1\136"+
    "\32\0\1\137\7\0\1\140\1\0\1\141\1\142\50\0"+
    "\1\143\24\0\1\144\45\0\1\145\56\0\1\146\42\0"+
    "\1\147\37\0\1\150\55\0\1\151\50\0\1\152\43\0"+
    "\1\153\56\0\1\154\26\0\1\155\57\0\1\156\52\0"+
    "\1\157\45\0\1\160\36\0\1\161\41\0\1\162\45\0"+
    "\1\163\51\0\1\164\40\0\1\165\44\0\1\166\43\0"+
    "\1\167\45\0\1\170\47\0\1\171\43\0\1\172\47\0"+
    "\1\173\43\0\1\174\56\0\1\175\44\0\1\176\36\0"+
    "\1\177\52\0\1\200\47\0\1\201\36\0\1\202\45\0"+
    "\1\203\64\0\1\204\35\0\1\205\32\0\1\206\55\0"+
    "\1\207\42\0\1\210\40\0\1\211\55\0\1\212\42\0"+
    "\1\213\50\0\1\214\42\0\1\215\41\0\1\216\45\0"+
    "\1\217\45\0\1\220\51\0\1\221\55\0\1\222\36\0"+
    "\1\223\50\0\1\224\45\0\1\225\42\0\1\226\50\0"+
    "\1\227\42\0\1\230\50\0\1\231\37\0\1\232\45\0"+
    "\1\233\43\0\1\234\61\0\1\235\31\0\1\236\61\0"+
    "\1\237\45\0\1\240\26\0";

  private static int [] zzUnpackTrans() {
    int [] result = new int[4370];
    int offset = 0;
    offset = zzUnpackTrans(ZZ_TRANS_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackTrans(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      value--;
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /* error codes */
  private static final int ZZ_UNKNOWN_ERROR = 0;
  private static final int ZZ_NO_MATCH = 1;
  private static final int ZZ_PUSHBACK_2BIG = 2;

  /* error messages for the codes above */
  private static final String ZZ_ERROR_MSG[] = {
    "Unknown internal scanner error",
    "Error: could not match input",
    "Error: pushback value was too large"
  };

  /**
   * ZZ_ATTRIBUTE[aState] contains the attributes of state <code>aState</code>
   */
  private static final int [] ZZ_ATTRIBUTE = zzUnpackAttribute();

  private static final String ZZ_ATTRIBUTE_PACKED_0 =
    "\1\0\1\11\14\1\6\11\6\1\6\0\1\1\1\0"+
    "\1\11\6\0\1\1\4\0\1\11\2\1\1\0\1\11"+
    "\3\0\1\11\16\0\2\11\4\0\1\11\3\0\1\11"+
    "\1\0\2\11\13\0\1\11\1\0\1\11\1\0\1\11"+
    "\3\0\1\11\2\0\1\11\1\0\1\11\1\0\2\11"+
    "\2\0\2\11\1\0\1\11\7\0\2\11\2\0\1\11"+
    "\2\0\2\11\11\0\1\11\2\0\2\11\2\0\1\11"+
    "\1\0\1\11\1\0\7\11";

  private static int [] zzUnpackAttribute() {
    int [] result = new int[160];
    int offset = 0;
    offset = zzUnpackAttribute(ZZ_ATTRIBUTE_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAttribute(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }

  /** the input device */
  private java.io.Reader zzReader;

  /** the current state of the DFA */
  private int zzState;

  /** the current lexical state */
  private int zzLexicalState = YYINITIAL;

  /** this buffer contains the current text to be matched and is
      the source of the yytext() string */
  private char zzBuffer[] = new char[ZZ_BUFFERSIZE];

  /** the textposition at the last accepting state */
  private int zzMarkedPos;

  /** the current text position in the buffer */
  private int zzCurrentPos;

  /** startRead marks the beginning of the yytext() string in the buffer */
  private int zzStartRead;

  /** endRead marks the last character in the buffer, that has been read
      from input */
  private int zzEndRead;

  /** number of newlines encountered up to the start of the matched text */
  private int yyline;

  /** the number of characters up to the start of the matched text */
  private int yychar;

  /**
   * the number of characters from the last newline up to the start of the 
   * matched text
   */
  private int yycolumn;

  /** 
   * zzAtBOL == true <=> the scanner is currently at the beginning of a line
   */
  private boolean zzAtBOL = true;

  /** zzAtEOF == true <=> the scanner is at the EOF */
  private boolean zzAtEOF;

  /** denotes if the user-EOF-code has already been executed */
  private boolean zzEOFDone;
  
  /** 
   * The number of occupied positions in zzBuffer beyond zzEndRead.
   * When a lead/high surrogate has been read from the input stream
   * into the final zzBuffer position, this will have a value of 1;
   * otherwise, it will have a value of 0.
   */
  private int zzFinalHighSurrogate = 0;

  /* user code: */
  private Symbol token(int id, Object value) {
    return new Symbol(id, yychar, yyline, value);
  }

  private Symbol token(int id) {
    return token(id, yytext());
  }


  /**
   * Creates a new scanner
   *
   * @param   in  the java.io.Reader to read input from.
   */
  Yylex(java.io.Reader in) {
    this.zzReader = in;
  }


  /** 
   * Unpacks the compressed character translation table.
   *
   * @param packed   the packed character translation table
   * @return         the unpacked character translation table
   */
  private static char [] zzUnpackCMap(String packed) {
    char [] map = new char[0x110000];
    int i = 0;  /* index in packed string  */
    int j = 0;  /* index in unpacked array */
    while (i < 154) {
      int  count = packed.charAt(i++);
      char value = packed.charAt(i++);
      do map[j++] = value; while (--count > 0);
    }
    return map;
  }


  /**
   * Refills the input buffer.
   *
   * @return      <code>false</code>, iff there was new input.
   * 
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  private boolean zzRefill() throws java.io.IOException {

    /* first: make room (if you can) */
    if (zzStartRead > 0) {
      zzEndRead += zzFinalHighSurrogate;
      zzFinalHighSurrogate = 0;
      System.arraycopy(zzBuffer, zzStartRead,
                       zzBuffer, 0,
                       zzEndRead-zzStartRead);

      /* translate stored positions */
      zzEndRead-= zzStartRead;
      zzCurrentPos-= zzStartRead;
      zzMarkedPos-= zzStartRead;
      zzStartRead = 0;
    }

    /* is the buffer big enough? */
    if (zzCurrentPos >= zzBuffer.length - zzFinalHighSurrogate) {
      /* if not: blow it up */
      char newBuffer[] = new char[zzBuffer.length*2];
      System.arraycopy(zzBuffer, 0, newBuffer, 0, zzBuffer.length);
      zzBuffer = newBuffer;
      zzEndRead += zzFinalHighSurrogate;
      zzFinalHighSurrogate = 0;
    }

    /* fill the buffer with new input */
    int requested = zzBuffer.length - zzEndRead;
    int numRead = zzReader.read(zzBuffer, zzEndRead, requested);

    /* not supposed to occur according to specification of java.io.Reader */
    if (numRead == 0) {
      throw new java.io.IOException("Reader returned 0 characters. See JFlex examples for workaround.");
    }
    if (numRead > 0) {
      zzEndRead += numRead;
      /* If numRead == requested, we might have requested to few chars to
         encode a full Unicode character. We assume that a Reader would
         otherwise never return half characters. */
      if (numRead == requested) {
        if (Character.isHighSurrogate(zzBuffer[zzEndRead - 1])) {
          --zzEndRead;
          zzFinalHighSurrogate = 1;
        }
      }
      /* potentially more input available */
      return false;
    }

    /* numRead < 0 ==> end of stream */
    return true;
  }

    
  /**
   * Closes the input stream.
   */
  public final void yyclose() throws java.io.IOException {
    zzAtEOF = true;            /* indicate end of file */
    zzEndRead = zzStartRead;  /* invalidate buffer    */

    if (zzReader != null)
      zzReader.close();
  }


  /**
   * Resets the scanner to read from a new input stream.
   * Does not close the old reader.
   *
   * All internal variables are reset, the old input stream 
   * <b>cannot</b> be reused (internal buffer is discarded and lost).
   * Lexical state is set to <tt>ZZ_INITIAL</tt>.
   *
   * Internal scan buffer is resized down to its initial length, if it has grown.
   *
   * @param reader   the new input stream 
   */
  public final void yyreset(java.io.Reader reader) {
    zzReader = reader;
    zzAtBOL  = true;
    zzAtEOF  = false;
    zzEOFDone = false;
    zzEndRead = zzStartRead = 0;
    zzCurrentPos = zzMarkedPos = 0;
    zzFinalHighSurrogate = 0;
    yyline = yychar = yycolumn = 0;
    zzLexicalState = YYINITIAL;
    if (zzBuffer.length > ZZ_BUFFERSIZE)
      zzBuffer = new char[ZZ_BUFFERSIZE];
  }


  /**
   * Returns the current lexical state.
   */
  public final int yystate() {
    return zzLexicalState;
  }


  /**
   * Enters a new lexical state
   *
   * @param newState the new lexical state
   */
  public final void yybegin(int newState) {
    zzLexicalState = newState;
  }


  /**
   * Returns the text matched by the current regular expression.
   */
  public final String yytext() {
    return new String( zzBuffer, zzStartRead, zzMarkedPos-zzStartRead );
  }


  /**
   * Returns the character at position <tt>pos</tt> from the 
   * matched text. 
   * 
   * It is equivalent to yytext().charAt(pos), but faster
   *
   * @param pos the position of the character to fetch. 
   *            A value from 0 to yylength()-1.
   *
   * @return the character at position pos
   */
  public final char yycharat(int pos) {
    return zzBuffer[zzStartRead+pos];
  }


  /**
   * Returns the length of the matched text region.
   */
  public final int yylength() {
    return zzMarkedPos-zzStartRead;
  }


  /**
   * Reports an error that occured while scanning.
   *
   * In a wellformed scanner (no or only correct usage of 
   * yypushback(int) and a match-all fallback rule) this method 
   * will only be called with things that "Can't Possibly Happen".
   * If this method is called, something is seriously wrong
   * (e.g. a JFlex bug producing a faulty scanner etc.).
   *
   * Usual syntax/scanner level error handling should be done
   * in error fallback rules.
   *
   * @param   errorCode  the code of the errormessage to display
   */
  private void zzScanError(int errorCode) {
    String message;
    try {
      message = ZZ_ERROR_MSG[errorCode];
    }
    catch (ArrayIndexOutOfBoundsException e) {
      message = ZZ_ERROR_MSG[ZZ_UNKNOWN_ERROR];
    }

    throw new Error(message);
  } 


  /**
   * Pushes the specified amount of characters back into the input stream.
   *
   * They will be read again by then next call of the scanning method
   *
   * @param number  the number of characters to be read again.
   *                This number must not be greater than yylength()!
   */
  public void yypushback(int number)  {
    if ( number > yylength() )
      zzScanError(ZZ_PUSHBACK_2BIG);

    zzMarkedPos -= number;
  }


  /**
   * Contains user EOF-code, which will be executed exactly once,
   * when the end of file is reached
   */
  private void zzDoEOF() throws java.io.IOException {
    if (!zzEOFDone) {
      zzEOFDone = true;
      yyclose();
    }
  }


  /**
   * Resumes scanning until the next regular expression is matched,
   * the end of input is encountered or an I/O-Error occurs.
   *
   * @return      the next token
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  public java_cup.runtime.Symbol next_token() throws java.io.IOException {
    int zzInput;
    int zzAction;

    // cached fields:
    int zzCurrentPosL;
    int zzMarkedPosL;
    int zzEndReadL = zzEndRead;
    char [] zzBufferL = zzBuffer;
    char [] zzCMapL = ZZ_CMAP;

    int [] zzTransL = ZZ_TRANS;
    int [] zzRowMapL = ZZ_ROWMAP;
    int [] zzAttrL = ZZ_ATTRIBUTE;

    while (true) {
      zzMarkedPosL = zzMarkedPos;

      yychar+= zzMarkedPosL-zzStartRead;

      boolean zzR = false;
      int zzCh;
      int zzCharCount;
      for (zzCurrentPosL = zzStartRead  ;
           zzCurrentPosL < zzMarkedPosL ;
           zzCurrentPosL += zzCharCount ) {
        zzCh = Character.codePointAt(zzBufferL, zzCurrentPosL, zzMarkedPosL);
        zzCharCount = Character.charCount(zzCh);
        switch (zzCh) {
        case '\u000B':
        case '\u000C':
        case '\u0085':
        case '\u2028':
        case '\u2029':
          yyline++;
          zzR = false;
          break;
        case '\r':
          yyline++;
          zzR = true;
          break;
        case '\n':
          if (zzR)
            zzR = false;
          else {
            yyline++;
          }
          break;
        default:
          zzR = false;
        }
      }

      if (zzR) {
        // peek one character ahead if it is \n (if we have counted one line too much)
        boolean zzPeek;
        if (zzMarkedPosL < zzEndReadL)
          zzPeek = zzBufferL[zzMarkedPosL] == '\n';
        else if (zzAtEOF)
          zzPeek = false;
        else {
          boolean eof = zzRefill();
          zzEndReadL = zzEndRead;
          zzMarkedPosL = zzMarkedPos;
          zzBufferL = zzBuffer;
          if (eof) 
            zzPeek = false;
          else 
            zzPeek = zzBufferL[zzMarkedPosL] == '\n';
        }
        if (zzPeek) yyline--;
      }
      zzAction = -1;

      zzCurrentPosL = zzCurrentPos = zzStartRead = zzMarkedPosL;
  
      zzState = ZZ_LEXSTATE[zzLexicalState];

      // set up zzAction for empty match case:
      int zzAttributes = zzAttrL[zzState];
      if ( (zzAttributes & 1) == 1 ) {
        zzAction = zzState;
      }


      zzForAction: {
        while (true) {
    
          if (zzCurrentPosL < zzEndReadL) {
            zzInput = Character.codePointAt(zzBufferL, zzCurrentPosL, zzEndReadL);
            zzCurrentPosL += Character.charCount(zzInput);
          }
          else if (zzAtEOF) {
            zzInput = YYEOF;
            break zzForAction;
          }
          else {
            // store back cached positions
            zzCurrentPos  = zzCurrentPosL;
            zzMarkedPos   = zzMarkedPosL;
            boolean eof = zzRefill();
            // get translated positions and possibly new buffer
            zzCurrentPosL  = zzCurrentPos;
            zzMarkedPosL   = zzMarkedPos;
            zzBufferL      = zzBuffer;
            zzEndReadL     = zzEndRead;
            if (eof) {
              zzInput = YYEOF;
              break zzForAction;
            }
            else {
              zzInput = Character.codePointAt(zzBufferL, zzCurrentPosL, zzEndReadL);
              zzCurrentPosL += Character.charCount(zzInput);
            }
          }
          int zzNext = zzTransL[ zzRowMapL[zzState] + zzCMapL[zzInput] ];
          if (zzNext == -1) break zzForAction;
          zzState = zzNext;

          zzAttributes = zzAttrL[zzState];
          if ( (zzAttributes & 1) == 1 ) {
            zzAction = zzState;
            zzMarkedPosL = zzCurrentPosL;
            if ( (zzAttributes & 8) == 8 ) break zzForAction;
          }

        }
      }

      // store back cached position
      zzMarkedPos = zzMarkedPosL;

      if (zzInput == YYEOF && zzStartRead == zzCurrentPos) {
        zzAtEOF = true;
            zzDoEOF();
          {   return token(sym.EOF);
 }
      }
      else {
        switch (zzAction < 0 ? zzAction : ZZ_ACTION[zzAction]) {
          case 1: 
            { System.err.println("unrecognised character: '" + yytext() + "'");
		           return token(sym.ERROR);
            }
          case 53: break;
          case 2: 
            { return token(sym.OPPAR);
            }
          case 54: break;
          case 3: 
            { return token(sym.CLPAR);
            }
          case 55: break;
          case 4: 
            { return token(sym.OPBRACKET);
            }
          case 56: break;
          case 5: 
            { return token(sym.CLBRACKET);
            }
          case 57: break;
          case 6: 
            { return token(sym.COLON);
            }
          case 58: break;
          case 7: 
            { return token(sym.COMMA);
            }
          case 59: break;
          case 8: 
            { return token(sym.INT_LITERAL, new Integer(yytext()));
            }
          case 60: break;
          case 9: 
            { /* ignore comments */
            }
          case 61: break;
          case 10: 
            { /* and whitespace */
            }
          case 62: break;
          case 11: 
            { return token(sym.TEMP, new String(yytext()));
            }
          case 63: break;
          case 12: 
            { return token(sym.ID);
            }
          case 64: break;
          case 13: 
            { return token(sym.LABEL, new String(yytext().substring(0, 1)+'$'+
                        yytext().substring(1, yytext().length())));
            }
          case 65: break;
          case 14: 
            { return token(sym.ARROW);
            }
          case 66: break;
          case 15: 
            { return token(sym.NAME, new String(yytext().replace("@", "")));
            }
          case 67: break;
          case 16: 
            { return token(sym.FUN);
            }
          case 68: break;
          case 17: 
            { return token(sym.NOT);
            }
          case 69: break;
          case 18: 
            { return token(sym.INT);
            }
          case 70: break;
          case 19: 
            { return token(sym.VAR);
            }
          case 71: break;
          case 20: 
            { return token(sym.ARG);
            }
          case 72: break;
          case 21: 
            { return token(sym.MOD);
            }
          case 73: break;
          case 22: 
            { return token(sym.PCALL);
            }
          case 74: break;
          case 23: 
            { return token(sym.TRUE);
            }
          case 75: break;
          case 24: 
            { return token(sym.INEQ);
            }
          case 76: break;
          case 25: 
            { return token(sym.ILT);
            }
          case 77: break;
          case 26: 
            { return token(sym.ILE);
            }
          case 78: break;
          case 27: 
            { return token(sym.IEQ);
            }
          case 79: break;
          case 28: 
            { return token(sym.VOID);
            }
          case 80: break;
          case 29: 
            { return token(sym.BOOL);
            }
          case 81: break;
          case 30: 
            { return token(sym.JUMP);
            }
          case 82: break;
          case 31: 
            { return token(sym.FALSE);
            }
          case 83: break;
          case 32: 
            { return token(sym.CJUMP);
            }
          case 84: break;
          case 33: 
            { return token(sym.IINV);
            }
          case 85: break;
          case 34: 
            { return token(sym.IDIV);
            }
          case 86: break;
          case 35: 
            { return token(sym.IADD);
            }
          case 87: break;
          case 36: 
            { return token(sym.ISUB);
            }
          case 88: break;
          case 37: 
            { return token(sym.IMUL);
            }
          case 89: break;
          case 38: 
            { return token(sym.LOCAL);
            }
          case 90: break;
          case 39: 
            { return token(sym.ICOPY);
            }
          case 91: break;
          case 40: 
            { return token(sym.ICALL);
            }
          case 92: break;
          case 41: 
            { return token(sym.PRETURN);
            }
          case 93: break;
          case 42: 
            { return token(sym.IVALUE);
            }
          case 94: break;
          case 43: 
            { return token(sym.IALOAD);
            }
          case 95: break;
          case 44: 
            { return token(sym.IGLOAD);
            }
          case 96: break;
          case 45: 
            { return token(sym.ILLOAD);
            }
          case 97: break;
          case 46: 
            { return token(sym.IPRINT);
            }
          case 98: break;
          case 47: 
            { return token(sym.BPRINT);
            }
          case 99: break;
          case 48: 
            { return token(sym.FUNCTION);
            }
          case 100: break;
          case 49: 
            { return token(sym.IASTORE);
            }
          case 101: break;
          case 50: 
            { return token(sym.IRETURN);
            }
          case 102: break;
          case 51: 
            { return token(sym.IGSTORE);
            }
          case 103: break;
          case 52: 
            { return token(sym.ILSTORE);
            }
          case 104: break;
          default:
            zzScanError(ZZ_NO_MATCH);
        }
      }
    }
  }


}