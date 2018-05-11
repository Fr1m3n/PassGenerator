unit gen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    codeword: TEdit;
    genButton: TButton;
    Output: TMemo;
    custom: TEdit;
    check: TCheckBox;
    procedure codewordClick(Sender: TObject);
    procedure genButtonClick(Sender: TObject);
    procedure checkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  i, key, size_key: integer;

implementation

uses choice;

{$R *.dfm}

function checkword(s: string): boolean;
var
  i: integer;
  b: boolean;
begin
  b := true;
  for i := 1 to length(s) do begin
    if not((s[i] in ['a'..'z']) or (s[i] in ['A'..'Z']) or (s[i] in ['0'..'9']))  then b := false;
  end;
  result := b;
end;

function checkkey(s: string): boolean;
var
  i: integer;
  b: boolean;
begin
  b := true;
  for i := 1 to length(s) do begin
    if not((s[i] in ['0'..'9'])) then b := false;
  end;
  result := b;
end;

function revert(s: string): string;
var
  i, k: integer;
  res: string;
begin
  k := length(s);
  res := '';
  for i := 1 to k do begin
    res := res + s[k - i + 1];
  end;
  revert := res;
end;

function generate_key(size: integer): integer;
var
  i, key: integer;
begin
  key := random(4) + 1;
  for i := 1 to size - 1 do
    key := key * 10 + (random(4) + 1);
  result := key;
end;

procedure TForm2.codewordClick(Sender: TObject);
begin
//  (Sender as TEdit).Text := '';

end;



procedure TForm2.genButtonClick(Sender: TObject);
var
  i, sum: integer;
  console_output, keystr, pass, code: string;
  c: char;
begin
  sum := 1;
  if (codeword.text <> '') and (checkword(codeword.Text)) then begin
  code := codeword.Text;
  if custom.Text = '' then begin
    size_key := 4;
    key := generate_key(size_key);
  end else begin
    if checkkey(custom.Text) then begin
      key := strtoint(custom.text);
      size_key := length(custom.text);
    end else begin
      console_output := '[' + timetostr(time) + '] - Введён не корректный ключ.';
      output.Lines.Add(console_output);
      console_output := '[' + timetostr(time) + '] - Генерируется пароль с случайным ключём.';
      output.Lines.Add(console_output);
      size_key := 4;
      key := generate_key(size_key);
    end;
  end;
  keystr := inttostr(key);
  console_output := '[' + timetostr(time) + '] - Ваш ключ: ' + keystr;
  output.Lines.Add(console_output);
  pass := code;
  for i := 1 to size_key do begin
  //output.Lines.Add(pass);
    //inc(sum, strtoint(keystr[i]));
    case keystr[i] of
      '1': begin
        pass := revert(pass);
      end;
      '2': begin
        pass := pass + pass;
      end;
      '3': begin
        delete(pass, length(pass), 1)
      end;
      '4': begin
        c := pass[length(pass)];
        delete(pass, length(pass), 1);
        if (c = 'z') then
          c := 'a'
        else
          if (c = 'Z') then
            c := 'A'
          else
            if (c = '9') then
              c := '1'
            else
              c := chr(ord(c) + 1);
        insert(c, pass, length(pass));
        //pass[sum mod length(pass) + 1] := 'c';
      end;
    end;
  end;
  console_output := '[' + timetostr(time) + '] - Ваш пароль: ' + pass;
  output.Lines.Add(console_output);
  end else begin
    console_output := '[' + timetostr(time) + '] - Поле с кодовым словом пустое или заполнено не корректно.';
    output.Lines.Add(console_output);
  end;
  output.Lines.Add('--------------------------------');
end;

procedure TForm2.checkClick(Sender: TObject);
begin
  if check.State = cbUnchecked then begin
    custom.Enabled := false;
    custom.Text := '';
  end
  else
    custom.Enabled := true;
end;

end.
