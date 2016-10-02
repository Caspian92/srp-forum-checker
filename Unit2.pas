unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, jpeg, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Memo2: TMemo;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  token:string;
  sesid,chlng:string;

implementation

{$R *.dfm}

uses Unit1;

function parse(s,begs,ends:string):string;
var ts:string;
begin
ts:=copy(s,1,pos(ends,s)-1);
result:=copy(ts,pos(begs,ts)+length(begs),length(ts)-pos(begs,ts)-1);
end;

procedure TForm2.Button1Click(Sender: TObject);
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

    post.Add('username=' + Form1.Edit1.Text);
    post.Add('password=' + Form1.Edit2.Text);
    post.Add('recaptcha_challenge_field=' + chlng);
    post.Add('recaptcha_response_field=' + Edit1.Text);
    post.Add('sid=' + sid);
    post.Add('redirect=./ucp.php?mode=login');
    post.Add('login=����');
    post.Add('redirect=./ucp.php?mode=login');

    Form1.Memo2.Text:=idHTTP1.Post('http://samp-rp.su/ucp.php?mode=login', post);
    Form1.Enabled:=true;
    Form1.status;
    Form1.SetFocus();
    Close;
  except
    post.Free;
  end;
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
if Length(Edit1.Text) > 0 then Button1.Enabled:=true
  Else Button1.Enabled:=false;
end;

procedure TForm2.FormActivate(Sender: TObject);
var str : tmemorystream;
jpg : Tjpegimage;
begin
memo1.Text:=utf8toansi(Form1.Memo2.text);
sesid:=parse(memo1.Text,'http://www.google.com/recaptcha','" ></script>');
memo2.text:=utf8toansi(idhttp1.Get('http://www.google.com/recaptcha' + sesid));
chlng:=memo2.Text;
delete(chlng,1,pos('challenge : ',chlng)+length('challenge : '));
chlng:=copy(chlng,1,pos(',',chlng));
chlng:=copy(chlng,1,length(chlng)-2);
str:=tmemorystream.Create;
idhttp1.get('https://www.google.com/recaptcha/api/image?c='+chlng,str);
str.Position:=0;
jpg:=TJPEGImage.create;
jpg.LoadFromStream(str);
image1.Picture.Assign(jpg);
jpg.Free;
str.Free;
token:=memo1.text;
delete(token,1,pos('id="edit-captcha-token" value="',token)+length('id="edit-captcha-token" value="'));
token:=copy(token,1,pos('"',token)-1);
edit1.text:='';
Edit1.SetFocus();
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Enabled:=true;
end;

end.
