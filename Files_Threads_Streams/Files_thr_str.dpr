program Files_thr_str;

uses
  Forms,
  fts in 'fts.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
