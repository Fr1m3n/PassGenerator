unit choice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gen;

type
  TForm1 = class(TForm)
    gen: TButton;
    restore: TButton;
    procedure genClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.genClick(Sender: TObject);
begin
  form2.show;
  form1.Visible := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   randomize;
end;

end.
