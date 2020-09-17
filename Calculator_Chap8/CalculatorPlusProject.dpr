program CalculatorPlusProject;

// Source code for Chapter 8 for the book:

// Writing an Interpreter in Object Pascal: Part 1

// This uses a custom TScanner, slightly different from the
// one described in Chapter 3. The one we use here supports
// token lookahead.

// *** Ths source is distributed under Apache 2.0 ***

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uScanner in 'uScanner.pas',
  uSyntaxAnalysis in 'uSyntaxAnalysis.pas',
  uSymbolTable in 'uSymbolTable.pas';

const
   RHODUS_VERSION = '1.0';

var sourceCode : string;
    sc : TScanner;
    sy : TSyntaxAnalysis;


procedure displayWelcome;
begin
  writeln ('Welcome to Rhodus Syntax Analysis Console, Version ', RHODUS_VERSION);
  writeln ('Data and Time: ', dateToStr (Date), ', ', timeToStr (Time));
  writeln ('Supports assignment and expression, e.g');
  writeln ('a = 3   b = a * 3.4   b+a');
  writeln ('Type quit to exit');
end;


procedure displayPrompt;
begin
  write ('>> ');
end;

begin
  sc := TScanner.Create;
  try
    sy := TSyntaxAnalysis.Create (sc);
    try
      displayWelcome;
      while True do
        begin
        displayPrompt;
        readln (sourceCode);
        if sourceCode = 'quit' then
           break;

        if sourceCode <> '' then
           begin
           sc.scanString(sourceCode);
           try
             sc.nextToken;
             sy.statement;
           except
             on e:exception do
                writeln ('Error: ' + e.Message);
           end;
           end;
        end;
      writeln ('Press any key to exit');
      readln;
    finally
      sy.Free;
    end;
  finally
    sc.Free;
  end;
end.
