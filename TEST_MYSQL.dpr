program TEST_MYSQL;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit_connectMYSQL in 'Unit_connectMYSQL.pas' {EvalMySQLForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TEvalMySQLForm, EvalMySQLForm);
  Application.Run;
end.
