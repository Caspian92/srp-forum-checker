unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, IdCookieManager;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    IdHTTP1: TIdHTTP;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    IdCookieManager1: TIdCookieManager;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure status;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2;

procedure check;
begin
  if ((Length(Form1.Edit1.Text) > 0)and(Length(Form1.Edit2.Text) > 0))
    then Form1.Button1.Enabled:=true
    else Form1.Button1.Enabled:=false;
end;

function parse(s,begs,ends:string):string;
var ts:string;
begin
ts:=copy(s,1,pos(ends,s)-1);
result:=copy(ts,pos(begs,ts)+length(begs),length(ts)-pos(begs,ts)-1);
end;

procedure TForm1.Status;
var time : string;
begin
time := TimeToStr(GetTime);
if (Pos('ucp.php?mode=logout', memo2.Text) > 0) then
  begin
    Memo1.Lines.Add('[' + time + '] ����������� ������ �������!');
    Memo1.Lines.Add('[' + time + '] Login: ' + lowercase(Edit1.Text));
    Memo1.Lines.Add('[' + time + '] Paswword: ' + Edit2.Text);
    Memo1.Lines.Add('[' + time + '] Status: �� �������.');
    Memo1.Lines.Add('[' + time + '] ----------------------------------------');
    IdCookieManager1.CookieCollection.Clear;
  end
Else
  begin
    if (Pos('��� �������������', memo2.Text) > 0) then
      begin
        Memo1.Lines.Add('[' + time + '] ����������� ���������!');
        Memo1.Lines.Add('[' + time + '] ������� ��������� �����.');
        Memo1.Lines.Add('[' + time + '] ----------------------------------------');
        IdCookieManager1.CookieCollection.Clear;
      end
    else
      begin
        if (Pos('��� ������ ������ �� �����.', memo2.text) > 0) then
          begin
            Memo1.Lines.Add('[' + time + '] ����������� ������ �������!');
            Memo1.Lines.Add('[' + time + '] Login: ' + lowercase(Edit1.Text));
            Memo1.Lines.Add('[' + time + '] Paswword: ' + Edit2.Text);
            Memo1.Lines.Add('[' + time + '] Status: �������.');
            Memo1.Lines.Add('[' + time + '] Reason: ' + parse(Memo2.Text,'�������: <strong>','</strong><br /><br /><em>������'));
            Memo1.Lines.Add('[' + time + '] ----------------------------------------');
            IdCookieManager1.CookieCollection.Clear;
          end
        else
          begin
            if (Pos('�� ����� �������� ������. ', Memo2.Text) > 0) then
              begin
                Memo1.Lines.Add('[' + time + '] ����������� ���������!');
                Memo1.Lines.Add('[' + time + '] �� ����� �������� ������.');
                Memo1.Lines.Add('[' + time + '] ----------------------------------------');
                IdCookieManager1.CookieCollection.Clear;
              end
            else
              begin
                Memo1.Lines.Add('[' + time + '] ����������� ���������!');
                Memo1.Lines.Add('[' + time + '] �� ����� �������� �����.');
                Memo1.Lines.Add('[' + time + '] ----------------------------------------');
                IdCookieManager1.CookieCollection.Clear;
              end;
          end;
      end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  post : TStringList;
  sid : String;
  Start: Integer;
begin
  post:=TStringList.Create;
  try
    sid:=utf8toansi(idHTTP1.Get('http://samp-rp.su/ucp.php?mode=login'));
    Start:=Pos('name="sid" value="' , sid)+18;
    sid:=Copy(sid, Start, 32);

    post.Add('username=' + Edit1.Text);
    post.Add('password=' + Edit2.Text);
    post.Add('sid=' + sid);
    post.Add('redirect=index.php');
    post.Add('login=����');
    post.Add('redirect=./ucp.php?mode=login');

    memo2.Text:=idHTTP1.Post('http://samp-rp.su/ucp.php?mode=login', post);

    if (Pos('��� �������������', memo2.Text) > 0) then
      begin
        Form2.Show;
        Form1.Enabled:=false;
      end
     else status;
  except
    post.Free;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.Checked then
  Edit2.PasswordChar:=#0
  Else Edit2.PasswordChar:=#42;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
check;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
check;
end;

end.
