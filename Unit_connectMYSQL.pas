unit Unit_connectMYSQL;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPClient, IdSystatUDP, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB,
  FireDAC.Comp.Client, FMX.Edit, FMX.Layouts, FMX.ListBox, FMX.TabControl;

type
  TEvalMySQLForm = class(TForm)
    IdSystatUDP1: TIdSystatUDP;
    dlgOpen: TOpenDialog;
    pnl1: TPanel;
    lbl_statusbar: TLabel;
    pnl2: TPanel;
    pnl3: TPanel;
    Label1: TLabel;
    MYSQLcon: TFDConnection;
    fdphysmysqldrvrlnk1: TFDPhysMySQLDriverLink;
    tbcMySQL: TTabControl;
    tbtm_CONNECTDATABASE: TTabItem;
    tbtm_EVALDATABASE: TTabItem;
    btn_connectDB: TButton;
    mmo_connection_params: TMemo;
    btn_LoadConnectionSettings: TButton;
    lst_tablenames: TListBox;
    edt_database: TEdit;
    btn_gettablenames: TButton;
    edt_tablename: TEdit;
    btn_fieldnames: TButton;
    lbl1: TLabel;
    lst_fieldnames: TListBox;
    tbtm_ExecuteSQL: TTabItem;
    btn_loadSQLScript: TButton;
    btn_ExecuteSQL: TButton;
    mmo_sqlScript: TMemo;
    procedure btn_LoadConnectionSettingsClick(Sender: TObject);
    procedure btn_connectDBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_gettablenamesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lst_tablenamesDblClick(Sender: TObject);
    procedure btn_fieldnamesClick(Sender: TObject);
    procedure btn_loadSQLScriptClick(Sender: TObject);
    procedure btn_ExecuteSQLClick(Sender: TObject);
  private
    { Private declarations }
    Fservername: String;
    Fdatabasename: String;
    Fusername: String;
    FPassword: String;
    FTablename: string;

    FTablenameList: TStringList;

    FFieldnameList: TStringList;

    procedure CopyGUI2Data(Sender: TObject);
    procedure CopyData2GUI(Sender: TObject);
  public
    { Public declarations }
  end;

var
  EvalMySQLForm: TEvalMySQLForm;

implementation

{$R *.fmx}

procedure TEvalMySQLForm.btn_connectDBClick(Sender: TObject);
var
  i: Integer;
begin

  with MYSQLcon do
  begin
    Close;
    with Params do
    begin
      Clear;
      for i := 0 to mmo_connection_params.Lines.Count - 1 do
      begin
        Add(mmo_connection_params.Lines[i]);
      end;
    end;
    Open;
  end;
end;

procedure TEvalMySQLForm.CopyGUI2Data(Sender: TObject);
begin
  Fdatabasename := edt_database.Text;

  FTablename := edt_tablename.Text;
end;

procedure TEvalMySQLForm.CopyData2GUI(Sender: TObject);
begin

  edt_tablename.Text := FTablename;

end;

procedure TEvalMySQLForm.btn_ExecuteSQLClick(Sender: TObject);
begin
     MYSQLcon.ExecSQL(mmo_sqlScript.Text);
end;

procedure TEvalMySQLForm.btn_fieldnamesClick(Sender: TObject);
begin
  CopyGUI2Data(nil);

  MYSQLcon.GetFieldNames(Fdatabasename, 'dbo', FTablename,  '', FFieldnameList);

  lst_fieldnames.Items.Clear;

  lst_fieldnames.Items.AddStrings(FFieldnameList);
end;

procedure TEvalMySQLForm.btn_gettablenamesClick(Sender: TObject);
begin
  CopyGUI2Data(nil);

  MYSQLcon.GetTableNames(Fdatabasename, 'dbo', '', FTablenameList);

  lst_tablenames.Items.Clear;

  lst_tablenames.Items.AddStrings(FTablenameList);
end;

procedure TEvalMySQLForm.btn_LoadConnectionSettingsClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    mmo_connection_params.Lines.Clear;

    mmo_connection_params.Lines.LoadFromFile(dlgOpen.FileName);
  end;
end;

procedure TEvalMySQLForm.btn_loadSQLScriptClick(Sender: TObject);
begin
      if dlgOpen.Execute then
  begin
   mmo_sqlScript.Lines.Clear;

    mmo_sqlScript.Lines.LoadFromFile(dlgOpen.FileName);
  end;
end;

procedure TEvalMySQLForm.FormCreate(Sender: TObject);
begin
  FTablenameList := TStringList.Create;

  FFieldnameList := TStringList.Create;

end;

procedure TEvalMySQLForm.FormShow(Sender: TObject);
begin
  lbl_statusbar.Text := ' select connection parameter ...';
end;

procedure TEvalMySQLForm.lst_tablenamesDblClick(Sender: TObject);
begin
  FTablename := lst_tablenames.Items[lst_tablenames.ItemIndex];

  CopyData2GUI(nil);
end;

end.
