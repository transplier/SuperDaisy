{
   Daisy 1.1
   Copyright (C) 2000-2005 Greg Leedberg

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

    The full license can be found in the included file license.txt.

    Any questions regarding what you may do with the software can be sent to
    Greg Leedberg, at greg@leedberg.com.

    The full, unedited source follows. 
}

{ DAISY v1.1

  DAISY v1.0
  12-27-1999
   5-10-2000 }

program Daisy;
uses crt,dos;

type WordPtr = ^UWord;

     UWord = record
               UserWord : string[15];
               Next : WordPtr;
             end;

     ExpIn = ^ExpField;

     ExpField = record
                  FLabel : string;
                  FileName : string[12];
                  Next : ExpIn;
                end;

     Database = array[0..20] of string;
     Database2 = array[0..20] of integer;
     ScreenLines = array[1..24] of string;

const PossibleMax = 10;

var debug : boolean;
    TimeFrame : integer;
    DaisyName,UserName : string[15];
    LastScreen : ScreenLines;
    SentCount : integer;
    CurDir : string;
    BufferSize : integer;
    Memory : WordPtr;
    InColor, OutColor : integer;
    DefFile,MemFile : string[12];
    LearnMode : boolean;
    LastError : integer;
    TimeRun : integer;
    LastSubs : WordPtr;
    Connect : boolean;
    PlugsPresent : boolean;

(*********************************************************)
procedure Writer(TextString : string);

var loop : integer;

begin
  for loop := 1 to length(TextString) do
    begin
      if (random(80) = 0) AND
          (TextString[loop] <> ' ') AND
          (TextString[loop] <> '!') AND
          (TextString[loop] <> '?') AND
          (TextString[loop] <> '.') AND
          (TextString[loop] <> ',') then
        begin
          write(chr(random(26)+97));
          delay(300);
          write(chr(8));
          delay(200);
        end;
      write(TextString[loop]);
      delay(20 * (random(5)+1));
    end;
  writeln;
end;

(***********************************************************)
{ Center centers text on the screen }
procedure Center(textstring : string;  { String to print }
                 width : integer;      { Width of screen/window }
                 line : integer);      { Line to write on }

begin
  gotoxy(((width DIV 2) - (length(textstring) DIV 2)), line);
  write(textstring)
end;

(*********************************************************)
function FileExist(FileName : string) : BOOLEAN;

var LoadFile : text;
    Overflow : integer;

begin
  {$I-}
  assign(LoadFile,FileName);
  reset(LoadFile);
  LastError := IOResult;
  close(LoadFile);
  {$I+}

  OVerFLow := IOResult;
  if LastError = 0 then FileExist := TRUE
  else FileExist := FALSE;

end;

(*********************************************************)
{ GetKey waits for the user to hit a key, and returns the key pressed }
function GetKey : CHAR;

var temp : CHAR;                       { Key pressed }

begin
  repeat
    if KeyPressed then temp := readkey
    else temp := #14;
  until temp <> #14;
  GetKey := temp;
end;

(*********************************************************)
{ CursorOn turns on the DOS cursor }
procedure CursorOn; Assembler;

ASM
  mov ax, $0100
  mov cx, $0506
  int $10
end;

(*********************************************************)
{ CursorOff turns off the DOS cursor }
procedure CursorOff; Assembler;

ASM
  mov ax, $0100
  mov cx, $2607
  int $10
end;

(***********************************************************)
{ Repeating returns a string of repeating characters }
function Repeating(Character : CHAR;          { Character to repeat }
                   Times : INTEGER) : STRING; { # of times to repeat }

var loop : INTEGER;                    { Loop control variable }
    temp : STRING;                     { Temporarily holds string }

begin
  temp := '';
  for loop := 1 to Times do temp := temp + Character;
  Repeating := temp
end;

(***********************************************************)
{ PopUpWin draws a boxed window to the screen. }
procedure PopUpWin(X1,                  { Upper left corner X }
                   Y1,                  { Upper left corner Y }
                   X2,                  { Lower right corner X }
                   Y2,                  { Lower right corner Y }
                   ForeCol,             { Color for border }
                   BackCol : INTEGER;   { Background of window }
                   Title : string;      { Window title }
                   Shadow : boolean);   { Whether to shadow or not }

var loop : INTEGER;                     { Loop control variable }

begin
  textcolor(ForeCol); textbackground(BackCol);
  gotoxy(X1,Y1); write('É');
  for loop := (X1+1)  to (X2-2) do
    begin
      gotoxy(loop,Y1);
      write('Í');
    end;
 write('»');
{  for loop := (Y1+1) to Y2 do
    begin
      gotoxy(X1,loop);
      write('º',Repeating(' ',(X2-X1 - 2)),'º');
    end;}
  window(X1,Y1,X2+2,Y2+1);
  textcolor(8); textbackground(0);
  writeln;
  if SHadow then
    begin
      for loop := 1 to (Y2 - Y1) do
        writeln(Repeating(' ',(X2 - X1)),'±±');
      gotoxy(3,WhereY);write(Repeating('±',(X2 - X1)));
    end;

  window(X1,Y1,X2,Y2);
  textcolor(ForeCol); textbackground(BackCol);
  gotoxY(1,1);
  writeln('É',Repeating('Í',(X2 - X1 - 2)),'»');

  for loop := (Y1 + 1) to (Y2 - 1) do
      writeln('º',Repeating(' ',(X2-X1 - 2)),'º');
  write('È',Repeating('Í',(X2 - X1 - 2)),'¼');
  center(Title,(X2-X1)+1,1);
  window(X1+1,Y1+1,X2-2,Y2-1)
end;

(*********************************************************)
{ FillIn fills in the screen over where a window was }
procedure FillIn(x1,                   { Upper left corner X }
                 y1,                   { Upper left corner Y }
                 x2,                   { Lower right corner X }
                 y2 : integer;
                 FillChar : char;
                 ForeCol,
                 BackCol : integer);        { Lower right corner Y }

var loop : integer;                    { Loop control variable }

begin
  textcolor(ForeCol); textbackground(BackCol);
  for loop := y1 to y2 do
    begin
      gotoxy(x1,loop);
      write(Repeating(FillChar,(x2 - x1)));
    end;
end;

(***************************************************************)
{ ToUpper converts a string to uppercase }
function ToUpper(TextString : string) : string;  { Original string }

var loop2 : integer;                   { Loop control variable }

begin
  for loop2 := 1 to length(TextString) do
    TextString[loop2] := upcase(TextString[loop2]);
  ToUpper := TextString;
end;

(****************************************************************)
{ ToStr converts an integer to a string }
function ToStr(OldInt : integer) : String;  { Number to convert }

var TempStr : string[6];                       { Temporary string }

begin
  str(OldInt,TempStr);
  ToStr := TempStr;
end;

(*********************************************************)
procedure FatalError(FileName : string);

begin
  PopUpWin(10,5,70,19,15,4,'ERROR!',FALSE);
  center('An error occurred when trying to process the file:',60,2);
  center(ToUpper(FileName),60,4);
  center('The error encountered was error #'+ToStr(LastError)+'.',60,6);
  case LastError of
  2: begin
       center('This means that the file could not be found.',60,8);
       center('Verify that the file has been created, ',60,9);
       center('and exists in the current directory.',60,10);
     end;
  217: begin
         center('This means that you tried to give a new file',60,8);
         center('the same name as a file which already exists.',60,9);
         center('Try giving the new file a different name.',60,10);
       end;
  218: begin
         center('This means that you tried to delete the currently',60,8);
         center('loaded memory file.  Unload this file by loading',60,9);
         center('a different file, and then try deleting it.',60,10);
       end;
  219: begin
         center('This means that you tried to delete the default',60,8);
         center('memory file.  Select a different file to be the',60,9);
         center('default, and then try deleting this file.',60,10);
       end;
  220: begin
         center('This means that the default memory file is',60,8);
         center('missing.  Continuing will guide you in the',60,9);
         center('process of correcting this problem.',60,10);
       end;
  else
    begin
      center('The nature of this error is unknown.',60,8);
      center('E-mail ggl@cisunix.unh.edu',60,9);
    end;
  end;
  center('Press <ENTER> to continue...',60,13);
  readln;
end;


(*********************************************************)
procedure ExitWin;

begin
  window(2,2,79,23);
end;

(***************************************************************)
function ToLower(TextString : string) : string;

var loop2 : integer;

begin
  for loop2 := 1 to length(TextString) do
    if (ord(TextString[loop2]) > 64) AND (ord(TextString[loop2]) < 91) then
      TextString[loop2] := chr(ord(TextString[loop2])+32);
  ToLower := TextString;
end;
(****************************************************************)
function Date : string;

var y,
    mo,
    d,
    dw : word;
    TempFile : text;
    Temp : string;

begin
  assign(TempFile,CurDir+'temp');
  rewrite(TempFile);
  getdate(y,mo,d,dw);
  writeln(TempFile,mo,'/',d,'/',y);
  close(TempFile);
  reset(TempFile);
  readln(TempFile,Temp);
  Date := Temp;
  close(TempFile);
  erase(TempFile);
end;

(****************************************************************)
function Time : string;

var h,
    m,
    s,
    ss : word;
    Temp : string;
    TempFile : text;

begin
  assign(TempFile,CurDir+'temp');
  rewrite(TempFile);
  gettime(h,m,s,ss);
  write(TempFile,h,':');
  if m < 10 then write(TempFile,'0');
  writeln(TempFile,m );
  close(TempFile);
  reset(TempFile);
  readln(TempFile,Temp);
  close(TempFile);
  erase(TempFile);
  Time := Temp;
end;

(****************************************************************)
function TooLong(var FirstSec : integer) : boolean;

var h,
    m,
    s,
    ss : word;
    s2 : string;
    Temp : string;
    s3,
    code : integer;
    Temp2 : boolean;

begin
  Temp2 := FALSE;
  gettime(h,m,s,ss);
  str(s,s2);
  val(s2,s3,code);
  if FirstSec = 100 then FirstSec := s3
  else
    begin
      if s3 - FirstSec < 0 then s3 := s3 + 60;
      if s3 - FirstSec >= TimeFrame then Temp2 := TRUE;
    end;
  TooLong := Temp2;

end;


(*********************************************************************)
procedure OpenTrans(var TransFile : text);

begin
  if not FileExist('DAISY.TXT') then
    begin
      assign(TransFile,'DAISY.TXT');
      rewrite(TransFile);
      close(TRansFile);
    end;

  assign(TransFile,'DAISY.TXT');
  append(TransFile);
  writeln(TransFile);
  writeln(TransFile,'***Transcript of ',Date,'... starting at ',Time);
  writeln(TransFile,'***Talking to: ',UserName);
end;

(*********************************************************************)
procedure CloseTrans(var TransFile : text);

begin
  writeln(TransFile,'');
  close(TransFile);
end;

(*********************************************************************)
{ Loads MEM.BFB into memory.  Tested to work up to 60.61K }
procedure LoadMemory;

var LoadFile : text;
    Ptr,Back : WordPtr;
    LearnTemp : integer;
    EmptyFile : boolean;

begin
  LearnMode := TRUE;
  Memory := NIL;
  assign(LoadFile,CurDir+MemFile);
  reset(LoadFile);
  readln(LoadFile,DaisyName);
  readln(LoadFile,LearnTemp);
  case LearnTemp of
  1: LearnMode := TRUE;
  0: LearnMode := FALSE;
  end;

  EmptyFile := FALSE;
  if eof(LoadFile) then EmptyFile := TRUE;

  while (not eof(LoadFile)) AND (MemAvail > 255) do
    begin
      if Memory = NIL then
        begin
          new(Memory);
          readln(LoadFile,Memory^.UserWord);
          Memory^.Next := NIL;
        end
      else
        begin
          Ptr := Memory;
          while Ptr^.Next <> NIL do Ptr := Ptr^.Next;
          Back := Ptr;
          new(Ptr);
          Back^.Next := Ptr;
          readln(LoadFile,Ptr^.UserWord);
          Ptr^.Next := NIL;
        end;
    end;

   if Memory <> NIL then
     begin
       Ptr := Memory;
       while Ptr^.Next <> NIL do Ptr := Ptr^.Next;
       if (Ptr^.UserWord <> '***') AND NOT EmptyFile then
         begin
           Back := Ptr;
           new(ptr);
           Back^.Next := Ptr;
           Ptr^.UserWord := '***';
           Ptr^.Next := NIL;
           LearnMode := FALSE;
         end;
     end;
  close(LoadFile);
end;

(*********************************************************************)
procedure SaveMemory;

var Ptr : WordPTr;
    OutFile : text;

begin
  assign(OutFile,CurDir+MemFile);
  rewrite(OutFile);
  writeln(OutFile,DaisyName);
  case LEarnMode of
  TRUE: writeln(OutFile,'1');
  FALSE: writeln(OutFile,'0');
  end;

  PTr := Memory;
  while Ptr <> NIL do
    begin
      writeln(OutFile,Ptr^.UserWord);
      Ptr := Ptr^.Next;
    end;
  close(OutFile);
end;

(*********************************************************************)
function Clean(TextString : string) : string;

var loop : integer;
    Temp : string;

begin
  Temp := '';
  for loop := 1 to length(TextString) do
    if NOT (TextString[loop] IN [';',
                                 '!',
                                 '(',
                                 ')',
                                 '/',
                                 '\',
                                 ':',
                                 '"',
                                 ',',
                                 '.',
                                 '?']) then
      Temp := Temp + TextString[loop];
  Clean := Temp;
end;


(*********************************************************************)
function Terminator(TextEnd : string) : boolean;

var LoadFile : text;
    Check : string;

begin
  Terminator := FALSE;
  assign(LoadFile,CurDir+'term.bfb');
  reset(LoadFile);
  repeat
    readln(LoadFile,Check);
  until eof(LoadFile) OR (Check = TextEnd);
  close(LoadFile);
  if Check = TextEnd then Terminator := TRUE;
end;


(*********************************************************************)
procedure ReturnPattern(    LastWord : string;
                        var Word1,
                            Word2,
                            Word3 : string);

var NumPatterns,
    Target,
    loop : integer;
    LoadFile : text;
    Temp : string;
    Ptr : WordPtr;

begin
  NumPatterns := 0;
  Ptr := Memory;
  while Ptr <> NIL do
    begin
      Temp := Ptr^.UserWord;
      Ptr := Ptr^.Next;
      if Temp = LastWord then NumPatterns := NumPatterns + 1;
    end;
{  repeat}
    Ptr := Memory;
    Target := random(NumPatterns) + 1;
    loop := 0;
    repeat
      Temp := Ptr^.UserWord;
      Ptr := Ptr^.Next;
      if Temp = LastWord then loop := loop+1;
    until loop = Target;
    Word1 := Ptr^.UserWord;
    Ptr := Ptr^.Next;
{  until Word1 <> '***';}
  Word2 := '***';
  Word3 := '***';
  if Word1 <> '***' then
    begin
      Word2 := Ptr^.UserWord;
      Ptr := Ptr^.Next;
      if Word2 <> '***' then
        begin
          Word3 := Ptr^.UserWord;
          Ptr := Ptr^.Next;
        end;
    end;
end;

(*********************************************************************)
procedure EraseList(var First : WordPtr);

var Ptr,
    Back : WordPtr;

begin
  Ptr := First;
  while Ptr <> NIL do
    begin
      Back := Ptr;
      Ptr := Ptr^.Next;
      dispose(Back);
    end;
  First := NIL;
end;

(*********************************************************************)
function VocabCount(Exact : BOOLEAN) : integer;

var OutFile : text;
    x,
    y,
    Total : integer;
    Temp : string;
    Exists : boolean;
    Back,Ptr : WordPtr;

begin
  write('Counting vocab...');
  x := wherex-17; y := wherey;
  if not Exact then
    begin
      if Memory = NIL then Total := 0
      else Total := 1;
    end
  else
    begin
      SaveMEmory;
      EraseList(Memory);
      assign(OutFile,CurDir+MemFile);
      reset(OutFile);
      readln(OutFile,temp);
      readln(OutFile,temp);
      Memory := NIL;
      while (not eof(OutFile)) AND (not KeyPressed) do
        begin
          readln(OutFile,temp);
          Exists := FALSE;

          Ptr := Memory;
          Back := PTr;
          while Ptr <> NIL do
            begin
              if ToUpper(Clean(Temp)) = ToUpper(clean(Ptr^.UserWord)) then Exists := TRUE;
              Back := Ptr;
              Ptr := PTr^.Next;
            end;

          if (not exists) AND (Temp <> '***') then
            begin
              if Memory = NIL then
                begin
                  new(Memory);
                  Memory^.UserWord := TEmp;
                  Memory^.Next := NIL
                end
              else
                begin
                  new(Ptr);
                  Back^.Next := Ptr;
                  Ptr^.UserWord := Temp;
                  Ptr^.Next := NIL;
                end;
              end
         end;
       close(OUtFile);

       Total := 0;
       Ptr := Memory;
       while  Ptr <> NIL do
         begin
           Ptr := Ptr^.Next;
           Total := Total + 1;
         end;
     end;
  EraseList(Memory);
  LoadMemory;
  gotoxy(x,y); write('                 ');gotoxy(x,y);
  VocabCount := Total;
end;

(*********************************************************************)
function Response : string;

var LoadFile : text;
    loop : integer;
    LastWord,
    TempResponse,
    Temp,
    Word1,
    Word2,
    Word3 : string;
    Terminate : boolean;
    count: integer;
    VoidWord : string;
    Ptr : WordPTr;

begin
  if Memory <> NIL then
    begin
      TempResponse := '';
      if SentCount = -1 then
        begin
          Ptr := Memory;
          sentcount := 0;
          while Ptr <> NIL do
            begin
              Temp := Ptr^.UserWord;
              Ptr := Ptr^.Next;
              if Temp = '***' then sentCount := sentCount + 1;
            end;
        end;
      Ptr := Memory;

      loop := random(sentCount) + 1;
      Count := 1;
      while Count <> loop do
        begin
          temp := Ptr^.UserWord;
          Ptr := Ptr^.Next;
          if Temp = '***' then Count := Count + 1;
        end;
      Word1 := Ptr^.UserWord;
      Ptr := Ptr^.Next;
      Word2 := Ptr^.UserWord;
      Ptr := Ptr^.Next;
      Word3 := Ptr^.UserWord;
      Ptr := Ptr^.Next;

      if Word2 = '***' then
        begin
          Word3 := Word1;
          Word1 := '';
          Word2 := '';
        end;
      if Word3 = '***' then
        begin
          Word3 := Word2;
          Word2 := Word1;
          Word1 := '';
        end;
      TempResponse := TempResponse + Word1 + ' ' + Word2 + ' ' + Word3;

      repeat
        VoidWord := Word2;
        Terminate := FALSE;
        LastWord := Word3;
        ReturnPattern(LastWord,Word1,Word2,Word3);
        if (TempResponse[1] <> #14) AND
           (Word1 = VoidWord) or
           (Word2 = LastWord) OR
           (Word3 = Word1) then
             TempResponse := #14 + TempResponse;
        if Word1 = '***' then Word1 := '';
        if Word2 = '***' then Word2 := '';
        if Word3 = '***' then Word3 := '';
        TempResponse := TempResponse + ' ' + Word1 + ' '+Word2 + ' '+Word3;

        if Terminator(Word2+' '+Word3) OR (Word3 = '') then Terminate := TRUE;
        Count := Count + 1;

      until Terminate = TRUE;

      Response := TempResponse;
    end
  else Response := '';
end;

(*********************************************************************)
procedure CreateBuffer;

var OutFile : text;
    loop,
    loop2 : integer;
    x,y: integer;

begin
  x := wherex; y:= wherey;
  assign(OutFile,CurDir+'buffer.bfb');
  rewrite(OutFile);
  gotoxy(x,y);
  write('Initializing... [          ]');
  for loop := 1 to BufferSize do
    begin
      writeln(OutFile,Response);
      gotoxy(x+17,y);
      for loop2 := 1 to round((loop/BufferSize)*10) do write('*');
    end;
  close(OutFile);
  gotoxy(x,y);
  write('                            ');
  gotoxy(x,y);
end;


(******************************************************************)
function Speed : real;

var Seconds : integer;
    temp : string;
    x,y,count : integer;

begin
  write('Clocking speed...');
  x := wherex - 17;
  y := wherey;
  count := 0;
  Seconds := 100;
  repeat
    temp := response;
    count := count + 1;
  until TooLong(seconds);
  Speed := count / TimeFrame;
  gotoxy(x,y);
  clreol;
  gotoxy(x,y);
end;


(******************************************************************)
procedure RestoreScreen;

var loop : integer;

begin
  ExitWin;
  textbackground(0);
  clrscr;
  textcolor(7);
  for loop := 1 to 24 do
    if LastScreen[loop] <> '' then
      begin
        if ToUpper(copy(LastScreen[loop],1,pos('>',LastScreen[loop])-1)) = ToUpper(UserName) then textcolor(InColor)
        else textcolor(OutColor);
        writeln(LastScreen[loop]);
      end;
end;


(*********************************************************************)
procedure Options;

var Nothing : char;
    Choice : integer;

(*-------------------------------------------------------------------*)
procedure ChangeTime;

begin
  PopUpWin(30,13,70,16,1,2,'MAX TIME',TRUE);
  writeln('Current thinking time: ',TimeFrame,' seconds.');
  write('Change to: ');
  readln(TimeFrame);
  ExitWin;
  FillIn(29,12,72,17,' ',1,0);
end;

(*-------------------------------------------------------------------*)
procedure ChangeBuff;

begin
  PopUpWin(40,13,70,18,1,2,'BUFFER',TRUE);
  writeln('Current buffer size: ',BufferSize);
  write('Change to: ');
  readln(BufferSize);
  CreateBuffer;
  ExitWin;
  FillIn(39,12,72,19,' ',1,0);
end;

(*-------------------------------------------------------------------*)
procedure ChangeInColor;

begin
  PopUpWin(40,13,70,16,1,2,'INPUT COLOR',TRUE);
  write('Change to (1-15): ');
  readln(InColor);
  ExitWin;
  FillIn(39,12,72,17,' ',1,0);
end;

(*-------------------------------------------------------------------*)
procedure ChangeOutColor;

begin
  PopUpWin(40,13,70,16,1,2,'OUTPUT COLOR',TRUE);
  write('Change to (1-15): ');
  readln(OutColor);
  ExitWin;
  FillIn(39,12,72,17,' ',1,0);
end;

(*-------------------------------------------------------------------*)
procedure CorrectSpell;

var OldWord,
    NewWord : string;
    Ptr,
    Back : WordPtr;
    UserIn : char;

begin
  PopUpWin(20,11,70,16,1,2,'CORRECT SPELLING',TRUE);
  write('Incorrect word: ');
  readln(OldWord);
  write('Should be: ');
  readln(NewWord);
  OldWord := ToLower(OldWord);
  NewWord := ToLower(NewWord);

  Ptr := Memory;
  Back := NIL;
  while Ptr <> NIL do
    begin
      if (Ptr^.UserWord = OldWord) OR
         ((copy(Ptr^.UserWord,1,length(Ptr^.UserWord)-1) = OldWord)
          AND (Ptr^.UserWord[length(Ptr^.UserWord)] IN ['!','?','.'])) then
        begin
          clrscr;
          textcolor(1);
          writeln('Change in this context? (Y/N)');
          textcolor(0);
          if Back <> NIL then
            center('...'+Back^.UserWord+' '+Ptr^.UserWord+' '+Ptr^.Next^.UserWord+'...',49,3)
         else
            center('...'+Ptr^.UserWord+' '+Ptr^.Next^.UserWord+'...',49,3);
          gotoxy(31,1);
          readln(UserIn);
          if upcase(UserIn) = 'Y' then
            if copy(Ptr^.UserWord,1,length(Ptr^.UserWord)-1) = OldWord then
              Ptr^.UserWord := NewWord + Ptr^.UserWord[length(Ptr^.UserWord)]
            else Ptr^.UserWord := NewWord;
        end;
      Back := Ptr;
      Ptr := Ptr^.Next;
    end;
  ExitWin;
  FillIn(19,10,72,17,' ',1,0);
end;

(*-------------------------------------------------------------------*)
begin
  Choice := 1;
  repeat
  CursorOff;
  PopUpWin(17,6,63,15,15,3,'OPTIONS',TRUE);
  repeat
    textcolor(1); textbackground(3);
    center('Correct spelling',46,2);
    center('Max thinking time',46,3);
    center('Buffer size',46,4);
    center('Color of Daisy''s text',46,5);
    center('Color of your text',46,6);
    center('Exit Options',46,8);
    textcolor(10); textbackground(1);
    case Choice of
    1: center('Correct spelling',46,2);
    2: center('Max thinking time',46,3);
    3: center('Buffer size',46,4);
    4: center('Color of Daisy''s text',46,5);
    5: center('Color of your text',46,6);
    6: center('Exit Options',46,8);
    end;
    Nothing := GetKey;
    if Nothing = #0 then
      begin
        Nothing := GetKEy;
        if Nothing = #72 then Choice := Choice - 1;
        if Nothing = #80 then CHoice := Choice + 1;
      end;
    if Choice = 0 then Choice := 1;
    if Choice = 7 then Choice := 6;
  until Nothing = #13;
  CursorOn;
  ExitWin;
  case Choice of
  1: CorrectSpell;
  2: ChangeTime;
  3: ChangeBuff;
  4: ChangeOutColor;
  5: ChangeInColor;
  end;
  until Choice = 6;
  RestoreScreen;
end;

(*********************************************************************)
procedure CreateNew(FileName, BotName : string);

var OutFile : text;

begin
  assign(OutFile,CurDir+FileName);
  rewrite(OutFile);
  writeln(OutFile,BotName);
  writeln(OutFile,'1');
  close(OutFile);
end;

(*********************************************************************)
procedure NewFile(var TransFile : text);

var FileName : string[12];
    BotName : string[15];

begin
  PopUpWin(25,12,73,16,1,2,'NEW FILE',TRUE);
  write('File name for new file: ');
  readln(FileName);
  if pos('.',FileName) = 0 then FileName := FileName + '.DSY';
  if FileExist(FileName) then
    begin
      LastError := 217;
      FatalError(FileName)
    end
  else
    begin
      write('Name for bot (<ENTER> for DAISY): ');
      readln(BotName);
      if BotName = '' then BotName := 'Daisy';
      CreateNew(FileName,BotName);
      write('Do you wish to LOAD this file now? (Y/N) ');
      readln(BotName);
      if upcase(BotName[1]) = 'Y' then
        begin
          CloseTrans(TransFile);
          SaveMemory;
          EraseList(Memory);
          MemFile := ToUpper(FileName);
          LoadMemory;
          CreateBuffer;
          OpenTrans(TransFile);
        end;
    end;
  ExitWin;
  FillIn(24,11,75,17,' ',1,0);
end;

(*********************************************************************)
procedure Load(var TransFile : text);

var FileName : string[12];
    DirInfo : searchrec;
    count : integer;

begin
  PopUpWin(3,3,24,20,15,1,'DIRECTORY LIST',TRUE);
  textcolor(14);
  FindFirst('*.DSY', Archive, DirInfo); { Same as DIR *.PAS }
  count := 1;
  while DosError = 0 do
    begin
      center(DirInfo.Name,18,count);
      count := count + 1;
      FindNext(DirInfo);
    end;
  ExitWin;

  PopUpWin(38,13,72,16,1,2,'LOAD FILE',TRUE);
  write('File name to load: ');
  readln(FileName);
  if pos('.',FileName) = 0 then FileName := FileName + '.DSY';
  if FileExist(FileName) then
    begin
      CloseTrans(TransFile);
      MemFile := ToUpper(FileName);
      LoadMemory;
{      CreateBuffer;}
      OpenTrans(TransFile);
      ExitWin;
    end
  else
    begin
      ExitWin;
      FatalError(FileName);
      ExitWin;
    end;
  FillIn(37,12,74,17,' ',1,0);
  FillIn(2,2,26,21,' ',1,0);
end;

(*********************************************************************)
procedure DefaultFile;

var FileName : string[12];
    Dirinfo : searchrec;
    count : integer;

begin
  PopUpWin(3,3,24,20,15,1,'DIRECTORY LIST',TRUE);
  textcolor(14);
  FindFirst('*.DSY', Archive, DirInfo); { Same as DIR *.PAS }
  count := 1;
  while DosError = 0 do
    begin
      center(DirInfo.Name,18,count);
      count := count + 1;
      FindNext(DirInfo);
    end;
  ExitWin;

  PopUpWin(37,13,73,16,1,2,'DEFAULT FILE',TRUE);
  write('Default memory file: ');
  readln(FileName);
  if pos('.',FileName) = 0 then FileName := FileName + '.DSY';
  if FileExist(FileName) then
    begin
      DefFile := ToUpper(FileName);
      ExitWin;
    end
  else
    begin
      ExitWin;
      FatalError(FileName);
      ExitWin;
    end;
  FillIn(39,12,72,17,' ',1,0);
  FillIn(2,2,26,21,' ',1,0);
end;

(*********************************************************************)
procedure DeleteFile;

var FileName : string[12];
    Dirinfo : searchrec;
    count : integer;
    DelFile : text;

begin
  PopUpWin(3,3,24,20,15,1,'DIRECTORY LIST',TRUE);
  textcolor(14);
  FindFirst('*.DSY', Archive, DirInfo); { Same as DIR *.PAS }
  count := 1;
  while DosError = 0 do
    begin
      center(DirInfo.Name,18,count);
      count := count + 1;
      FindNext(DirInfo);
    end;
  ExitWin;

  PopUpWin(40,13,71,16,1,2,'DELETE FILE',TRUE);
  write('File to delete: ');
  readln(FileName);
  if pos('.',FileName) = 0 then FileName := FileName + '.DSY';
  if NOT FileExist(FileName) then
    begin
      ExitWin;
      FatalError(FileName);
      ExitWin;
    end
  else if ToUpper(FileName) = ToUpper(MemFile) then
    begin
      LastError := 218;
      ExitWin;
      FatalError(FileName);
      ExitWin;
    end
  else if ToUpper(FileName) = ToUpper(DefFile) then
    begin
      LastError := 219;
      ExitWin;
      FatalError(FileName);
      ExitWin;
    end
  else
    begin
      assign(DelFile,FileName);
      erase(DelFile);
      ExitWin;
    end;
  FillIn(39,12,72,17,' ',1,0);
  FillIn(2,2,26,21,' ',1,0);

end;

(*********************************************************************)
procedure People(var TransFile : text);

var Nothing : char;
    Choice : integer;

begin
  Choice := 1;
  repeat
    RestoreScreen;
    textcolor(InColor);
    write(ToUpper(UserName) + '>');
    PopUpWin(17,4,63,17,15,3,'FILES',TRUE);

  CursorOff;
  repeat
    textcolor(0); textbackground(3);
    center('Default file: '+DefFile,46,1);
    center('Currently loaded: '+MemFile,46,2);
    case LearnMode of
    TRUE: center('Learn mode for current file: ON',46,3);
    FALSE: center('Learn mode for current file: OFF',46,3);
    end;
    textcolor(1);
    center('Create a new file',46,5);
    center('Load a file',46,6);
    center('Set the default file',46,7);
    center('Toggle learn mode',46,8);
    center('Delete a file',46,9);
    center('Exit Files Menu',46,11);
    textcolor(10); textbackground(1);
    case Choice of
    1: center('Create a new file',46,5);
    2: center('Load a file',46,6);
    3: center('Set the default file',46,7);
    4: center('Toggle learn mode',46,8);
    5: center('Delete a file',46,9);
    6: center('Exit Files Menu',46,11);
    end;
    Nothing := GetKey;
    if Nothing = #0 then
      begin
        Nothing := GetKEy;
        if Nothing = #72 then Choice := Choice - 1;
        if Nothing = #80 then CHoice := Choice + 1;
      end;
    if Choice = 0 then Choice := 1;
    if Choice = 7 then Choice := 6;
  until Nothing = #13;
  CursorOn;
  ExitWin;
  case Choice of
  1: NewFile(TransFile);
  2: Load(TransFile);
  3: DefaultFile;
  4: begin
       case LearnMode of
       TRUE: LEarnMode := FALSE;
       FALSE: LEarnMode := TRUE;
       end;
     end;
  5: DeleteFile;
  end;
  until Choice = 6;
  RestoreScreen;
end;

(*********************************************************************)
procedure Expansion;

var PlugFile, Title,PlugEXE : string;
    InFile : text;
    X1,Y1,X2,Y2,FC,BC : integer;
    First,Ptr,Back : ExpIn;
    DirInfo: SearchRec;
    Nothing : Char;

begin
  SaveMemory;
  FindFirst('*.DFD', Archive, DirInfo); { Same as DIR *.PAS }
  X1 := 0;
  First := NIL;
  while DosError = 0 do
   begin
     X1 := X1 + 1;
     if First = NIL then
       begin
         new(First);
         First^.FileName := DirInfo.Name;
         assign(Infile,First^.FileName);
         reset(Infile);
         readln(Infile,First^.FLabel);
         readln(Infile,First^.FLabel);
         readln(Infile,First^.FLabel);
         readln(Infile,First^.FLabel);
         readln(Infile,First^.FLabel);
         readln(Infile,First^.FLabel);
         readln(Infile,First^.FLabel);
         close(Infile);
         First^.Next := NIL;
       end
     else
       begin
         new(Ptr);
         Ptr^.FileName := DirInfo.Name;
         assign(Infile,Ptr^.FileName);
         reset(Infile);
         readln(Infile,Ptr^.FLabel);
         readln(Infile,Ptr^.FLabel);
         readln(Infile,Ptr^.FLabel);
         readln(Infile,Ptr^.FLabel);
         readln(Infile,Ptr^.FLabel);
         readln(Infile,Ptr^.FLabel);
         readln(Infile,Ptr^.FLabel);
         close(Infile);

         Ptr^.Next := NIL;
         Back := First;
         while Back^.Next <> NIL do Back := Back^.Next;
         Back^.Next := Ptr;
       end;
     FindNext(DirInfo);
   end;

  PopUpWin(17,10-(x1 DIV 2),63,13 + (x1 DIV 2),15,3,'PLUG IN',TRUE);
  Y1 := 1;
  CursorOff;
  repeat
    textcolor(1); textbackground(3); clrscr;
    Ptr := First;
    X2 := 1;
    while Ptr <> NIL do
      begin
        center(Ptr^.FLabel,46,X2);
        X2 := X2 + 1;
        Ptr := Ptr^.Next;
      end;
    textcolor(10); textbackground(1);
    Y2 := 1;
    Ptr := First;
    while Y2 < Y1 do
      begin
        Ptr := PTr^.next;
        Y2 := Y2 + 1;
      end;
    center(Ptr^.FLabel,46,Y1);

    Nothing := GetKey;
    if Nothing = #0 then
      begin
        Nothing := GetKEy;
        if Nothing = #72 then Y1 := Y1 - 1;
        if Nothing = #80 then Y1 := Y1 + 1;
      end;
    if Y1 = 0 then Y1 := 1;
    if Y1 = (X1+1) then Y1 := X1;
  until Nothing = #13;
  CursorOn;

  Ptr := First;
  Y2 := 1;
  while Y2 < Y1 do
    begin
      Ptr := PTr^.Next;
      Y2 := Y2 + 1;
    end;
  PlugFile := Ptr^.FileName;

  Ptr := First;
  while Ptr <> NIL do
    begin
      First := Ptr;
      Ptr := Ptr^.Next;
      dispose(First);
    end;
  RestoreScreen;
  assign(InFile,PlugFile);
  reset(InFile);
  readln(InFile,X1);
  readln(InFile,Y1);
  readln(InFile,X2);
  readln(InFile,Y2);
  readln(InFile,FC);
  readln(InFile,BC);
  readln(InFile,Title);
  readln(InFile,PlugEXE);

  PopUpWin(X1,Y1,X2,Y2,FC,BC,Title,TRUE);

  First := NIL;
  while not eof(InFile) do
    begin
      if First = NIL then
        begin
          new(First);
          readln(InFile,First^.FLabel);
          First^.Next := NIL;
        end
      else
        begin
          new(Ptr);
          readln(InFile,Ptr^.FLabel);
          Ptr^.Next := NIL;
          Back := First;
          while Back^.Next <> NIL do Back := Back^.Next;
          Back^.Next := Ptr;
        end;
    end;

  close(InFile);
  assign(InFile,'plug.in');
  rewrite(InFile);
  Ptr := First;
  while Ptr <> NIL do
    begin
      write(Ptr^.FLabel);
      readln(Ptr^.FLabel);
      writeln(InFile,Ptr^.FLabel);
      Ptr := Ptr^.Next;
    end;
  close(INFile);
  Ptr := First;
  while Ptr <> NIL do
    begin
      First := Ptr;
      Ptr := Ptr^.Next;
      dispose(First);
    end;
  swapvectors;
  exec(PlugExe,'');
  swapvectors;
  assign(InFile,'plug.out');
  reset(INFile);
  while not eof(InFile) do
    begin
      readln(InFile,PlugFile);
      writeln(PlugFile);
    end;
  close(InFile);
  erase(InFile);
  assign(InFile,'plug.in');
  erase(InFile);
  readln;
  RestoreScreen;
  LoadMemory;
end;

(*********************************************************************)
function Percent(var TextString : string) : integer;

var AllFile : text;
    Total,
    Count : integer;
    Temp : string;
    Ptr : WordPTr;

begin
  Count := 0; Total := 0;
  Ptr := Memory;
  while Ptr <> NIL do
    begin
      Temp := Ptr^.USerWord;
      Ptr := Ptr^.Next;
      if Clean(ToUpper(Temp)) = Clean(ToUpper(TextString)) then Count := Count + 1;
      Total := Total + 1;
      if Temp = '***' then Total := Total - 1;
    end;
  Percent := ROUND((Count/Total)*100);
end;

(*********************************************************************)
procedure parse(var InString : string;
                var First : WordPtr);


var TempWord : string;
    loop : integer;
    Ptr,
    TempPtr : WordPtr;

begin
  First := NIL;
  if InString = '' then First := NIL
  else
    begin
      InString := InString + ' ';
      TempWord := '';
      for loop := 1 to length(InString) do
        begin
          if InString[loop] <> ' ' then
            TempWord := TempWord + InString[loop]
          else if TempWord <> '' then
            begin
              if Clean(ToUpper(TempWord)) = ToUpper(UserName) then TempWord := #3+ToLower(DaisyName);
{          if (Who = Daisy) AND (Clean(ToUpper(TempWord)) = 'DAISY') then TempWord := UserName;}

              if First = NIL then
                begin
                  new(First);
                  First^.UserWord := TempWord;
                  First^.Next := NIL;
                end
              else
                begin
                  new(Ptr);
                  Ptr^.UserWord := TempWord;
                  Ptr^.Next := NIL;
                  TempPtr := First;
                  while TempPtr^.Next <> NIL do TempPtr := TempPtr^.Next;
                  TempPtr^.Next := Ptr;
                end;
              TempWord := '';
            end;
        end;
    end;
end;

(*********************************************************************)
procedure Learn(var First : WordPtr);

var Back,Ptr,Ptr2 : WordPtr;
    SaveFile1,
    SaveFile2 : text;
    Exists : boolean;
    Temp : string;
    loop : integer;

begin
  Ptr := Memory;
  Back := Ptr;
  while Ptr <> NIL do
    begin
      Back := Ptr;
      Ptr := Ptr^.Next;
    end;

  Ptr2 := First;
  while Ptr2 <> NIL do
    begin
      if Back = NIL then
        begin
          new(Ptr);
          Memory := Ptr;
          Memory^.UserWord := Ptr2^.UserWord;
          Memory^.Next := NIL;
          Back := Memory;
        end
      else
        begin
          new(Ptr);
          Ptr^.UserWord := Ptr2^.UserWord;
          Ptr^.Next := NIL;
          Back^.Next := Ptr;
          Back := Ptr;
        end;
      Ptr2 := Ptr2^.Next;
    end;
  new(Ptr);
  Ptr^.UserWord := '***';
  Ptr^.Next := NIL;
  Back^.Next := Ptr;
end;
(*********************************************************************)
procedure CreateTermFile;

var LoadFile,
    OutFile : text;
    Lines : array[1..3] of string;
    Current,
    loop : integer;
    Temp,
    TempEnd : string;
    Ptr : WordPtr;

begin
  Lines[1] := '';
  Lines[2] := '';
  Lines[3] := '';
  Current := 0;
  assign(OutFile,CurDir+'term.bfb');
  Ptr := Memory;
  rewrite(OutFile);
  while Ptr <> NIL do
    begin
      Temp := Ptr^.UserWord;
      Ptr := Ptr^.Next;
      if Temp = '***' then
        begin
          TempEnd := '';
          if Current > 1 then
            begin
              for loop := (Current-1)  to Current do TempEnd := TempEnd + ' '+Lines[loop];
              TempEnd := copy(Tempend,2,length(TempEnd)-1);
            end
          else TempEnd := Lines[1];
          writeln(OutFile,TempEnd);
          Current := 0;
        end
      else if Current = 3 then
        begin
          Lines[1] := Lines[2];
          Lines[2] := Lines[3];
          Lines[3] := Temp;
        end
      else
        begin
          Lines[Current+1] := Temp;
          Current := Current + 1;
        end;
    end;
    close(OutFile);
end;

(*********************************************************************)
function GetBuffer(count : integer) : string;

var LoadFile : text;
    loop : integer;
    temp : string;

begin
  assign(LoadFile,CurDir+'buffer.bfb');
  reset(LoadFile);
  for loop := 1 to count do readln(LoadFile,temp);
  close(LoadFile);
  GetBuffer := #2 + temp;
end;

(*********************************************************************)
function BestResponse(First : WordPtr) : string;

var KeyWord,
    First2,
    Ptr,
    Ptr2,
    Back : WordPtr;
    Possible : Database;
    Matches : Database2;
    Created,
    loop,
    loop2 : integer;
    Keep : boolean;
    LowestPercent: integer;
    Count : integer;
    ErrorCount : integer;
    Temp : string;
    Second : integer;
    TotalSent : integer;

begin
  LowestPercent := 101;
  TotalSent := 0;
  Ptr := First;
  { Find percent for keywords }
  while Ptr <> NIL do
    begin
      Temp := Ptr^.UserWord;
      if Percent(Temp) < LowestPercent then
        LowestPercent := Percent(Temp);
      Ptr := Ptr^.Next;
    end;

  KeyWord := NIL;

  if Debug then write('New keyword sentence: (',100-LowestPercent,'% new) ');

  if (LastSubs <> NIL) AND Connect then
    begin
      Ptr := LastSubs;
      while Ptr <> NIL do
        begin
          if DEbug then write(Ptr^.UserWord+' ');
          if KeyWord = NIL then
            begin
              new(KeyWord);
              KeyWord^.UserWord := Ptr^.UserWord;
              KeyWord^.Next := NIL;
            end
          else
            begin
              new(Ptr2);
              Ptr2^.UserWord := Ptr^.UserWord;
              Ptr2^.Next := NIL;
              Back := KEyWord;
              while Back^.Next <> NIL do Back := Back^.Next;
              Back^.Next := Ptr2;
            end;
          Ptr := Ptr^.Next;
        end;
    end;
  EraseList(LastSubs);

  Ptr := First;

  while Ptr <> NIL do
    begin
      Temp := Ptr^.UserWord;
      if Percent(Temp) = LowestPercent then
        begin
{          if Clean(ToUpper(Temp)) = 'DAISY' then Temp := UserName;}
          if Debug then write(Temp + ' ');

          { Add keyword to LastSubs list }
          if LastSubs = NIL then
            begin
              new(LastSubs);
              LastSubs^.UserWord := Ptr^.UserWord;
              LastSubs^.Next := NIL;
            end
          else
            begin
              new(ptr2);
              Ptr2^.UserWord := Ptr^.UserWord;
              Ptr2^.Next := NIL;
              Back := LastSubs;
              while Back^.Next <> NIL do Back := Back^.Next;
              Back^.Next := Ptr2;
            end;

          { Add keyword to current keywords list }
          if KeyWord = NIL then
            begin
              new(KeyWord);
              KeyWord^.UserWord := Ptr^.UserWord;
              KeyWord^.Next := NIL;
              Ptr2 := KeyWord;
            end
          else
            begin
              new(ptr2);
              Ptr2^.UserWord := Ptr^.UserWord;
              Ptr2^.Next := NIL;
              Back := KeyWord;
              while Back^.Next <> NIL do Back := Back^.Next;
              Back^.Next := Ptr2;
            end;
        end;
      Ptr := Ptr^.Next;
    end;
  if Debug then writeln;
  Created := 1;
  Second := 100;

  if (Keyword = NIL) AND (First = NIL) then
    BestResponse := Response
  else
    begin
      repeat
        Keep := FALSE;
        ErrorCount := 0;
        repeat
          if TotalSent > (BufferSize-1) then Possible[0] := Response
          else Possible[0] := GetBuffer(TotalSent+1);
          TotalSent := TotalSent + 1;
          parse(Possible[0],First2);
          Ptr := KeyWord;
          Count := 0;
          while Ptr <> NIL do
            begin
              Ptr2 := First2;
              while Ptr2 <> NIL do
                begin
                  if Clean(Ptr2^.UserWord) = Clean(Ptr^.UserWord) then Count := Count + 1;
                  Ptr2 := Ptr2^.Next;
                end;
              Ptr := Ptr^.Next;
            end;
          EraseList(First2);
          ErrorCount := ErrorCount + 1;
        until (Count > 0) OR (TooLong(Second));

        Possible[Created] := Possible[0];

        { This is an attempt to curb the very stupid run-on sentences }
        if (length(Possible[Created]) > 70) AND
           (Possible[Created,1] <> #14) then Possible[Created] := #14 + Possible[Created];

        Matches[Created] := Count;

        Created := Created + 1;
      until (Created-1 = PossibleMax) OR (TooLong(Second));
      EraseList(KeyWord);
      Created := Created - 1;
      Count := 1;
      for loop := 1 to Created do
        if Matches[loop] >= Matches[Count] then Count := loop;

      if Possible[Count,1] = #14 then
        for loop := 1 to Matches[Count] do
          for loop2 := 1 to Created do
            if (Matches[loop2] = loop) AND (Possible[loop2,1] <> #14)  then
              Count := loop2;

      if Debug then
        begin
          writeln('Total # of sentences generated: ',TotalSent);
          for loop := 1 to Created do writeln(ToStr(loop)+': ('+ToStr(Matches[loop])+') '+Possible[loop]);
          writeln('Best = ',Count);
        end;

      if Possible[Count,1] = #14 then Possible[Count] := copy(Possible[Count],2,length(Possible[Count])-1);
        while Possible[Count,length(Possible[Count])] = ' ' do
          Possible[Count] := copy(Possible[Count],1,length(Possible[Count])-1);
      BestResponse := Possible[Count];
    end;
end;


(******************************************************************)
procedure CleanUp;

var LoadFile : text;

begin
  assign(LoadFile,CurDir+'buffer.bfb');
  erase(LoadFile);
  assign(LoadFile,CurDir+'term.bfb');
  erase(LoadFile);
end;

(******************************************************************)
function GetText : string;

var TempText1,
    TempText2 : string;
    TempChar : char;
    loop,
    Start,
    Loc : integer;

begin
  TempText1 := ''; TempText2 := '';
  Start := wherex - 1;
  Loc := 1;
  repeat
    gotoxy(Start+Loc,wherey);
    TempChar := GetKey;
    if TempChar = #27 then
      begin
        TempText1 := '%%%ESC%%%';
        TempText2 := '';
        TempChar := #13;
      end;
    if TempChar = #0 then
      begin
        TempChar := GetKEy;
        if TempChar = #59 then
          begin
            TempText1 := '%%%F1%%%';
            TempText2 := '';
            TempChar := #13;
          end;
        if TempChar = #60 then
          begin
            TempText1 := '%%%F2%%%';
            TempText2 := '';
            TempChar := #13;
          end;
        if TempChar = #61 then
          begin
            TempText1 := '%%%F3%%%';
            TempText2 := '';
            TempChar := #13;
          end;
        if TempChar =#62 then
          begin
            TempText1 := '%%%F4%%%';
            TempText2 := '';
            TempChar := #13;
          end;
        if (TempChar = #63) AND
           PlugsPresent then
          begin
            TempText1 := '%%%F5%%%';
            TempText2 := '';
            TempChar := #13;
          end;
        if TempChar = #79 then
          begin
            Loc := length(TempText1+TempText2)+1;
            TempText1 := TempText1 + TempText2;
            TempText2 := '';
          end;
        if TempChar = #71 then
          begin
            Loc := 1;
            TempText2 := TempText1 + TempText2;
            TempText1 := '';
          end;

        if (TempChar = #83) AND (Loc <= length(TempText1+TempText2)) then
          begin
            for loop := 1 to length(TempText2) do write(' ');
            TempText2 := copy(TempText2,2,length(TempText2)-1);
            gotoxy(Start+Loc,wherey);
            write(TempText2);
          end;
        if (TempChar = #75) AND (Loc > 1) then
          begin
            Loc := Loc - 1;
            TempText2 := TempText1[Loc] + TempText2;
            TempText1 := copy(TempText1,1,length(TempText1)-1);
            if wherex > 1 then gotoxy(WhereX-1,WhereY)
            else gotoxy(80,wherey-1);
          end;
        if (TempChar = #77) AND (Loc <= length(TempText1 + TempText2)) then
          begin
            Loc := Loc + 1;
            TempText1 := TempText1 + TempText2[1];
            TempText2 := copy(TempText2,2,length(TempText2));
            gotoxy(Wherex+1,WhereY);
          end;
      end
    else if (TempChar = #8) then
      begin
        if Loc > 1 then
          begin
            TempText1 := copy(TempText1,1,length(TempText1)-1);
            gotoxy(WhereX-1,WhereY);
            write(' ');
            gotoxy(WhereX-1,WhereY);
            write(TempText2+' ');
            Loc := Loc - 1;
          end
      end
    else if TempChar = #13 then
      begin
      end
    else
      begin
        TempText1 := TempText1 + TempChar;
        gotoxy(Start+loc,wherey);
        write(TempChar,TempText2);
        Loc := Loc +1;
      end;
  until TempChar = #13;
  if copy(TempText1,1,3) <> '%%%' then writeln;
  GetText := TempText1 + TempText2;
end;

(************************************************************************)
procedure DrawActive;

begin
  window(1,1,80,25);
  textbackground(7);
  clrscr;
  gotoxy(1,1);
  textcolor(0);
  write('  DAISY v1.1                                          Created by Greg Leedberg ');
  case PlugsPresent of
  FALSE:  begin
            gotoxy(1,24);
            textcolor(1);
            write('  F1             F2             F3             F4                     ESC');
            gotoxy(1,25);
            textcolor(0);
            write('  Restart        Options        Files          About                  Exit');
          end;
  TRUE: begin
          gotoxy(1,24);
          textcolor(1);
          write('  F1            F2            F3            F4           F5             ESC');
          gotoxy(1,25);
          textcolor(0);
          write('  Restart       Options       Files         About        Plug-Ins       Exit');
         end;
   end;

  window(2,2,79,23);
  textcolor(7); textbackground(0);
  clrscr;
end;

(******************************************************************)
procedure About;
var X : char;

begin
  CursorOff;
  PopUpWin(15,5,65,12,15,3,'ABOUT',TRUE);
  textcolor(1);
  writeln('                  DAISY v1.1');
  writeln('           A Greg Leedberg Creation');
  writeln;
  textcolor(0);
  writeln('Memory available = ',memavail,' bytes.');
  writeln('Vocabulary size: ',VocabCount(TRUE),' words.');
  write('Average speed = ',Speed :1:2,' sentences per second.');
  X := GetKey;
  CursorOn;
  RestoreScreen;
end;

(******************************************************************)
procedure AddToScreen(TextString : string);

var loop : integer;

begin
  if copy(TextSTring,length(UserName)+3,3) <> '%%%' then
    begin
      loop := 1;
      while (LastScreen[loop] <> '') AND (loop < 25) do loop := loop + 1;
      if loop = 25 then
        begin
          for loop := 1 to 23 do LastScreen[loop] := LastScreen[loop+1];
          LastScreen[24] := TextString;
        end
      else LastScreen[loop] := TextString;
    end;
end;

(******************************************************************)
{ Okay "touches up" a string for the screen and transcript file. }
function Okay(TextString : string) : string;

var loop : integer;
    TempString : string;

begin
  TextString := ToLower(TextString);
  while (pos(ToLower(DaisyName),TextString) > 0) AND (TextString[pos(ToLower(DaisyName),TextString)-1]<>#3) do
      TextString :=
        copy(TextString,1,pos(ToLower(DaisyName),TextString)-1)+
        ToLower(UserName)+
        copy(TextString,pos(ToLower(DaisyName),TextString)+length(DaisyName),length(TextString));

  TempString := '';
  for loop := 1 to length(TextString) do
    if (TextString[loop] <> #14) AND
       (TextString[loop] <> #2) AND
       (TextString[loop] <> #3) then
      TempString := TempString + TextString[loop];
  while TempString[1] = ' ' do
    TempString := copy(TempString,2,length(TempString)-1);

  Okay := TempString;
end;

(*********************************************************************)
procedure LinkMode;

var LinkDir : string;
    LinkFile : text;
    temp,LinkExe : string;
    DaisyString,InString : string;
    First : WordPtr;

begin
  TimeFrame := 3;
  SentCount := -1;
  First := NIL;
  BufferSize := 50;
  CurDir := '';
  writeln;
  write('Enter path to link to: ');
  readln(LinkDir);
  if LinkDir[length(LinkDir)] <> '\' then LinkDir := LinkDir + '\';
  LoadMemory;
  PopUpWin(20,5,60,8,14,4,'INIT',TRUE);
  CursorOff;
  CreateTermFile;
  CreateBuffer;
  CursorOn;
  if VocabCount(FALSE) > 0 then
    begin
      ExitWin;
      textbackground(0); clrscr;
      DaisyString := Okay(Response);
    end
  else
    begin
      ExitWin;
      textbackground(0); clrscr;
    end;

  assign(LinkFile,LinkDir+'udlp.nfo');
  reset(LinkFile);
  readln(LinkFile,temp);      { UDLP version }
  readln(LinkFile,temp);      { UDLP revision }
  readln(LinkFile,LinkExe);   { Executable }
  readln(LinkFile,UserName);  { Bot name }
  close(LinkFile);
  assign(LinkFile,'udlp.nfo');
  repeat
    write(ToUpper(DaisyName),'> ');
    writer(DaisyString);
    rewrite(LinkFile);
    writeln(LinkFile,'1');
    writeln(LinkFile,'0');
    writeln(LinkFile,'---');
    writeln(LinkFile,DaisyName);
    writeln(LinkFile,'1');
    writeln(LinkFile,DaisyString);
    writeln(LinkFile,LinkDir);
    close(LinkFile);
    write('Linking...');
    swapvectors;
    exec(LinkDir+LinkExe,'');
    swapvectors;
    reset(LinkFile);
    readln(LinkFile,temp);  { UDLP Version }
    readln(LinkFile,temp);  { UDLP revision }
    readln(LinkFile,temp);  { Executable }
    readln(LinkFile,temp);  { Bot name }
    readln(LinkFile,temp);  { Chat status }
    readln(LinkFile,InString);  { Response }
    close(LinkFile);
    if NOT (InString[length(InString)] IN ['!','.','?']) then
      InString := InString + '.';
    parse(InString,First);
    learn(First);
    CreateTermFile;
    write(ToUpper(UserName),'> ');
    writer(InString);
    DaisyString :=  Okay(ToLower(BestResponse(First)));
    EraseList(First);
  until KeyPressed;
  rewrite(LinkFile);
  writeln(LinkFile,'2');
  writeln(LinkFile,'0');
  writeln(LinkFile,'DAISY2.EXE');
  writeln(LinkFile,DaisyName);
  writeln(LinkFile,'0');
  close(LinkFile);
end;

(******************************************************************)
procedure PlugIn;

var LoadFile,LoadFile2 : text;
    InString,Temp : string;
    First : WordPtr;
    Version : integer;

begin
  assign(LoadFile,'udlp.nfo');
  reset(LoadFile);
  readln(LoadFile,Version);      { Version}
  readln(LoadFile,temp);      { Revision }
  readln(LoadFile,temp);      { Executable }
  readln(LoadFile,UserName);  { Other bot name }
  readln(LoadFile,temp);      { 1 }
  if Version = 1 then readln(LoadFile,InString);  { Text to respond to }
  if Version = 1 then readln(LoadFile,CurDir);
  close(LoadFile);

  if Version > 1 then
    begin
      CurDir := '';
      assign(LoadFile,'chat.msg');
      reset(LoadFile);
      readln(LoadFile,UserName);
      readln(LoadFile,InString);
      close(LoadFile);
    end;

  assign(LoadFile2,CurDir+'setup.dat');
  reset(LoadFile2);
  readln(LoadFile2,InColor);
  readln(LoadFile2,OutColor);
  readln(LoadFile2,MemFile);
  readln(LoadFile2,BufferSize);
  readln(LoadFile2,TimeFrame);
  close(LoadFile2);
  LoadMemory;
  TimeFrame := 3;
  SentCount := -1;
  First := NIL;
  BufferSize := 0;
  if InString = '' then InString := Okay(Response)
  else
    begin
      if NOT (InString[length(InString)] IN ['!','.','?']) then
        InString := InString + '.';
      parse(InString,First);
      CreateTermFile;
      InString :=  Okay(ToLower(BestResponse(First)));
    end;
  if Version = 1 then
    begin
      rewrite(LoadFile);
      writeln(LoadFile,'1');
      writeln(LoadFile,'0');
      writeln(LoadFile,'---');
      writeln(LoadFile,'---');
      writeln(LoadFile,'0');
      writeln(LoadFile,InString);
      close(LoadFile);
    end
  else
    begin
      rewrite(LoadFile);
      writeln(LoadFile,InString);
      close(LoadFile);
    end;
  EraseList(Memory);
end;

(******************************************************************)
procedure DaisyChat(var InString : string);

var First : WordPtr;
    TransFile : text;
    loop : integer;
    DirInfo : searchrec;

begin
  LastSubs := NIL;
  CurDir := '';

  FindFirst('*.DFD', Archive, DirInfo);
  if DosError = 0 then PlugsPresent := TRUE
  else PlugsPresent := FALSE;

  { If the default file is missing, chaos breaks out }
  while NOT FileExist(MemFile) do
    begin
      LastError := 220;
      FatalError(MemFile);
      clrscr;
      center('This error was probably caused by deleting the default',60,1);
      center('memory file from DOS or Windows.  To prevent this in the',60,2);
      center('future, ALWAYS delete memory files from within DAISY,',60,3);
      center('using the Files menu.',60,4);
      center('Press <ENTER> to continue...',60,6);
      readln;
      clrscr;
      center('The default file is currently',60,1);
      center('defined as: '+DefFile,60,2);
      center('The error can be fixed by either selecting another file',60,4);
      center('to be the default, or by creating a new, empty file by',60,5);
      center('that name.',60,6);
      center('Type CHANGE to select a new default file, or type NEW to',60,8);
      center('create a file.',60,9);
      gotoxy(25,11);
      write('> ');
      readln(InString);
      if upcase(InString) = 'CHANGE' then
        begin
          clrscr;
          write('Change default file to (must already exist!): ');
          readln(DefFile);
          MemFile := DefFile;
        end
      else if upcase(InString) = 'NEW' then
        begin
          clrscr;
          write('Bot name for new file: ');
          readln(InString);
          CreateNew(MemFile,InString);
        end;
    end;

  LoadMemory;
  for loop := 1 to 24 do LastScreen[loop] := '';
  SentCount := -1;
  First := NIL;
  DrawActive;
  if TimeRun = 1 then
    begin
      TimeRun := 0;
      PopUpWin(13,5,67,15,14,3,'FIRST TIME',TRUE);
      textcolor(15);
      center('This is your first time using DAISY v1.1!',54,1);
      center('First of all, welcome to the world of Daisy, I',54,2);
      center('hope you enjoy talking to her as much as I enojyed',54,3);
      center('creating her.  A note, however, is that you should',54,4);
      center('definitely read MANUAL.TXT, as it includes',54,5);
      center('important information on using Daisy, which will',54,6);
      center('help you get the most out of your Daisy experience.',54,7);
      center('Have fun!',54,9);
      CursorOff;
      InString[1] := GetKey;
      CursorOn;
      RestoreScreen;
      clrscr;
    end;
  PopUpWin(20,5,60,8,15,3,'LOG IN',TRUE);
  write('Enter your name: ');
  readln(UserName);
  ExitWin;
  textbackground(0);
  clrscr;
  textcolor(15);
  OpenTrans(TransFile);
  PopUpWin(20,5,60,8,14,4,'INIT',TRUE);
  CursorOff;
  CreateTermFile;
  CreateBuffer;
  CursorOn;
  if VocabCount(FALSE) > 0 then
    begin
      ExitWin;
      textbackground(0); clrscr;
      InString := Okay(Response);
      textcolor(OutColor);
      write(ToUpper(DaisyName),'> ');
      writer(InString);
      writeln(TransFile,ToUpper(DaisyName),'> ',InString);
      AddToScreen(ToUpper(DaisyName)+'> '+InString);
    end
  else
    begin
      ExitWin;
      textbackground(0); clrscr;
    end;
  repeat
    SentCount := -1;
    textcolor(InColor);
    write(ToUpper(UserName),'> ');
    InString := ToLower(GetText);
    AddToScreen(ToUpper(UserName)+'> '+InString);
    writeln(TransFile,ToUpper(UserName),'> ',InString);
    if InString = '%%%f2%%%' then Options
    else if InString = '%%%f3%%%' then People(TransFile)
    else if InString = '%%%f4%%%' then About
    else if (InString = '%%%f5%%%') AND
            PlugsPresent then Expansion
    else if InString = '/debug' then
      begin
        if Debug then Debug := FALSE
        else Debug := TRUE;
      end
    else if InString = '/find%' then
      begin
        write('Find what word? ');
        readln(InString);
        writeln(Percent(InString),'%');
      end
    else if copy(InString,1,3) = '%%%' then
      begin
      end
    else
      begin
        textcolor(OutColor);
        write(ToUpper(DaisyName),'> ');

{        if InString = '' then InString := Okay(Response)
        else
          begin}
            if (NOT (InString[length(InString)] IN ['!','.','?']))
               AND (InString <> '') then
              InString := InString + '.';
            parse(InString,First);
            if LearnMode AND (First <> NIL) then learn(First);
            if Memory <> NIL THen
              begin
                CreateTermFile;
                InString :=  Okay(ToLower(BestResponse(First)));
              end;
            EraseList(First);
{          end;}
        writer(InString);
        AddToScreen(ToUpper(DaisyName)+'> '+InString);
        writeln(TransFile,ToUpper(DaisyName),'> ',InString);
      end
    until (InString = '%%%f1%%%') OR (InString = '%%%esc%%%');
    if InString <> '%%%esc%%%' then InString := '';
    CloseTrans(TransFile);
    CleanUp;
    SaveMemory;
    EraseList(Memory);
{    DrawActive(FALSE);}
end;
(********************************************************************)
procedure run;

var UserIn : string;
    LoadFile:text;

begin
  debug := FALSE;
  Connect := TRUE;
  assign(LoadFile,'udlp.nfo');
  reset(LoadFile);
  readln(LoadFile,UserIn);
  readln(LoadFile,UserIn);
  readln(LoadFile,UserIn);
  readln(LoadFile,UserIn);
  readln(LoadFile,UserIn);
  close(LoadFile);

  if (UserIn = '1') OR (FileExist('chat.msg')) then PlugIn
  else
    begin
      assign(LoadFile,'setup.dat');
      reset(LoadFile);
      readln(LoadFile,InColor);
      readln(LoadFile,OutCOlor);
      readln(LoadFile,MemFile);
      readln(LoadFile,BufferSize);
      readln(LoadFile,TimeFrame);
      readln(LoadFile,TimeRun);
      DefFile := MemFile;
      close(LoadFile);

      CurDir := '';

      repeat
        DaisyChat(UserIn);
      until ToUpper(UserIn) = '%%%ESC%%%';

      assign(LoadFile,DefFile);
      reset(LoadFile);
      readln(LoadFile,DaisyName);
      close(LoadFile);

      assign(LoadFile,'udlp.nfo');
      rewrite(LoadFile);
      writeln(LoadFile,'2');
      writeln(LoadFile,'0');
      writeln(LoadFile,'DAISY.EXE');
      writeln(LoadFile,DaisyName);
      writeln(LoadFile,'0');
      close(LoadFile);

      assign(LoadFile,'setup.dat');
      rewrite(LoadFile);
      writeln(LoadFile,InColor);
      writeln(LoadFile,OutColor);
      writeln(LoadFile,DefFile);
      writeln(LoadFile,BufferSize);
      writeln(LoadFile,TimeFrame);
      writeln(LoadFile,'0');
      close(LoadFile);
      window(1,1,80,25);
      textbackground(0); clrscr;
   end;
end;

(***********************************************************************)
begin
  randomize;
  run;
end.