unit fts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, ComCtrls, FileCtrl, ImgList;

Const
  KB1 = 1024;
  MB1 = 1024*KB1;
  GB1 = 1024*MB1;

type
  TCopyFile = class(TThread)
  public
    Percent    : Integer;
    Done,ToDo  : Integer;
    Start      : TDateTime;
    constructor Create(Src, Dest: string);
  private
    IName,OName : string;
  protected
    procedure Execute; override;
  end;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Memo1: TMemo;
    Button8: TButton;
    Button9: TButton;
    ListView1: TListView;
    ComboBox1: TComboBox;
    Label1: TLabel;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

constructor TCopyFile.Create(Src, Dest : string);
begin
  IName := Src;
  OName := Dest;
  Percent := 0;
  Start := Now;
  FreeOnTerminate := true;
  inherited Create(true);
  Execute; 
end;

procedure TCopyFile.Execute; 
var 
  fi,fo  : TFileStream;
  dod,did: Integer;
  cnt,max: Integer;
begin
  Start := Now;
  try
    { Открываем существующий путь }
    fo := TFileStream.Create(OName, fmOpenReadWrite);
    fo.Position:=fo.size;
  except
    { иначе создаём путь }
    fo := TFileStream.Create(OName, fmCreate);
  end;
  try
    { открываем копируемый файл }
    fi := TFileStream.Create(IName, fmOpenRead);
    try
      { синхронизируем }
      cnt:= fo.Position;
      fi.Position := cnt;
      max := fi.Size;
      ToDo := Max-cnt;
      Done := 0;
      { начинаем копирование }
      Repeat
        dod := MB1; // Block size
        if cnt+dod>max then dod := max-cnt;
        if dod>0 then did := fo.CopyFrom(fi, dod);
        cnt:=cnt+did;
        Percent := Round(Cnt/Max*100);
        Done := Done+did;
        ToDo := Max;
      until (dod=0) or (Terminated);
    finally
      fi.free;
    end;
  finally
    fo.free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 TCopyFile.Create(ExtractFilePath(Application.ExeName)+'file.dat',
             ExtractFilePath(Application.ExeName)+'file_new.txt');
end;

procedure CopyFiles(const FromFolder: string; const ToFolder: string);
var
 Fo    : TSHFileOpStruct;
 buffer: array[0..4096] of char;
 p     : pchar;
begin
  FillChar(Buffer, sizeof(Buffer), #0);
  p := @buffer;
  StrECopy(p, PChar(FromFolder)); //директория, которую мы хотим скопировать
  FillChar(Fo, sizeof(Fo), #0);
  Fo.Wnd    := Application.Handle;
  Fo.wFunc  := FO_COPY;
  Fo.pFrom  := @Buffer;
  Fo.pTo    := PChar(ToFolder); //куда будет скопирована директория
  Fo.fFlags := 0;
  if ((SHFileOperation(Fo) <> 0) or
     (Fo.fAnyOperationsAborted <> false))
  then ShowMessage('File copy process cancelled.')
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
 CopyFiles('c:\tmp','d:\tmp');
end;


// Следующие флаги так же можно использовать для удаления,
// перемещения и переименования группы файлов.
// TO_COPY, FO_DELETE, FO_MOVE, FO_RENAME
// Замечание: Буфер, который содержит имена файлов для
// копирования должен заканчиваться двумя нулями


procedure TForm1.Button3Click(Sender: TObject);
var
 Fo    : TSHFileOpStruct;
 buffer: array[0..4096] of char;
 p     : pchar;
begin
 FillChar(Buffer, sizeof(Buffer), #0);
 p:= @buffer;
 p:= StrECopy(p, '1.ZIP')+1;
 p:= StrECopy(p, '2.ZIP')+1;
 p:= StrECopy(p, '3.ZIP')+1;
 StrECopy(p, '4.ZIP');
 FillChar(Fo, sizeof(Fo), #0);
 Fo.Wnd    := Handle;
 Fo.wFunc  := FO_COPY;
 Fo.pFrom  := @Buffer;
 Fo.pTo    := 'D:\';
 Fo.fFlags := 0;
 if ((SHFileOperation(Fo) <> 0) or
      (Fo.fAnyOperationsAborted <> false))
 then ShowMessage('Cancelled.');
end;

function MyRemoveDir(sDir : string) : Boolean; 
var 
 iIndex    : Integer;
 SearchRec : TSearchRec;
 sFileName : String;
begin
 Result := False;
 sDir   := sDir + '\*.*';
 iIndex := FindFirst(sDir, faAnyFile, SearchRec);
 while iIndex = 0 do
  begin
   sFileName := ExtractFileDir(sDir)+'\'+SearchRec.Name;
   if SearchRec.Attr = faDirectory
   then
    begin
     if (SearchRec.Name <> '' )  and
       (SearchRec.Name <> '.')  and
       (SearchRec.Name <> '..')
     then MyRemoveDir(sFileName);
    end
   else
    begin
     if SearchRec.Attr <> faArchive
     then FileSetAttr(sFileName, faArchive);
     if not DeleteFile(sFileName)
     then ShowMessage('Could NOT delete ' + sFileName);
    end;
   iIndex := FindNext(SearchRec);
  end;
 FindClose(SearchRec);
 RemoveDir(ExtractFileDir(sDir));
 Result:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 if not MyRemoveDir('mydir')
 then ShowMessage('Can not delete dir!');
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  Buffer: PChar;
  Stream: TFileStream;
  Size:   LongInt;
begin
  Stream := TFileStream.Create('file.dat', fmOpenRead);
  try
    Size := Stream.Size;
    GetMem(Buffer, Size);
    try
      Stream.Read(Buffer[0], Size);
      Memo1.Lines.Text := Buffer;
    finally
      FreeMem(Buffer);
    end;
  finally
    Stream.Free;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
 Dir: string;
begin
 Dir:='C:\APPS\SALES\LOCAL';
 ForceDirectories(Dir);
 if DirectoryExists(Dir)
 then Form1.Caption:=Dir + ' was created'
end;

procedure TForm1.Button7Click(Sender: TObject);
var
 FreeBytesAvailableToCaller: TLargeInteger;
 FreeSize: TLargeInteger;
 TotalSize: TLargeInteger;
 i: longbool;
begin
 i:=GetDiskFreeSpaceEx( 'c:', FreeBytesAvailableToCaller,
                                      Totalsize, @FreeSize);
end;

procedure TForm1.Button8Click(Sender: TObject);
var
 Buffer: string;
 Stream: TFileStream;
begin
  Stream := TFileStream.Create('file.dat', fmOpenRead);
  try
    SetLength(buffer, Stream.Size);
    Stream.Read(Buffer[1], Stream.Size);
    Memo1.Lines.Text := Buffer;
  finally
    Stream.Free;
  end;
end;

procedure FileOperation (const source, dest: string;
op, flags: Integer);
var
 shf: TSHFileOpStruct;
 s1, s2: string;
begin
 FillChar (shf, SizeOf (shf), #0);
 s1:= source + #0#0;
 s2:= dest + #0#0;
 shf.Wnd:=     0;
 shf.wFunc:=  op;
 shf.pFrom:=  PCHAR (s1);
 shf.pTo:=    PCHAR (s2);
 shf.fFlags:= flags;
 SHFileOperation (shf);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
 // Отправляем файл в корзину
 // FileOperation(filename, '', FO_DELETE, FOF_ALLOWUNDO + FOF_NOCONFIRMATION);
 // Перемещаем файл в другую директорию
 // FileOperation(sourcefile, destination, FO_MOVE, FOF_ALLOWUNDO + FOF_NOCONFIRMATION);
 // Копируем файл в другую директорию
 FileOperation('file.dat', 'file_dt.dat', FO_COPY, FOF_ALLOWUNDO + FOF_NOCONFIRMATION);
end;

procedure UpdateFiles;
var
 sr: TSearchRec;
 li: TListItem;
 fi: TSHFileInfo;
 ext: string;
 IconIndex: word;
 ic: TIcon;
begin
 Form1.ListView1.Items.BeginUpdate;
 Form1.ListView1.Items.Clear;
 //
 if FindFirst(Form1.DirectoryListBox1.Directory+'\*.*', faAnyFile, sr)=0
 then
  repeat
   if sr.Attr and faDirectory<>0
   then Continue;
   li:=Form1.ListView1.Items.Add;
   li.Caption:=sr.name;
   ext:=LowerCase(ExtractFileExt(li.Caption));
   ShGetFileInfo(PChar('*'+ext), 0, fi, SizeOf(fi),
       SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_TYPENAME);
   li.ImageIndex:=fi.iIcon;
   if sr.Size<1024
   then li.SubItems.Add(IntToStr(sr.Size)+' - Byte')
   else
    if sr.Size<1024*1024
    then li.SubItems.Add(IntToStr(round(sr.Size / 1024))+' - KByte')
    else li.SubItems.Add(IntToStr(round(sr.Size / (1024*1024)))+' - MByte');
   li.SubItems.Add(fi.szTypeName);
  until FindNext(sr)<>0;
 FindClose(sr);
 //
 Form1.ListView1.Items.EndUpdate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 fi: TSHFileInfo;
 lc: TListColumn;
begin
 DriveComboBox1.DirList:=DirectoryListBox1;
 with ListView1 do
  begin
   SmallImages := TImageList.CreateSize(16,16);
   SmallImages.Handle := ShGetFileInfo('*.*', 0, fi,
                SizeOf(fi), SHGFI_SMALLICON or SHGFI_ICON
                                       or SHGFI_SYSICONINDEX);
   //
   LargeImages := TImageList.Create(nil);
   LargeImages.Handle := ShGetFileInfo('*.*', 0, fi,
                SizeOf(fi), SHGFI_LARGEICON or SHGFI_ICON
                                       or SHGFI_SYSICONINDEX);
   //
   lc:=Columns.Add;
   lc.Caption:='Name';
   lc.Width:=170;
   lc:=Columns.Add;
   lc.Caption:='Size';
   lc.Width:=100;   
   //
   ComboBox1.Items.Add('Icons');
   ComboBox1.Items.Add('List');
   ComboBox1.Items.Add('Table');
   ComboBox1.Items.Add('SmallIcons');
   ComboBox1.ItemIndex := 0;
 end;
 UpdateFiles;
end;


procedure TForm1.ComboBox1Click(Sender: TObject);
begin
 case ComboBox1.ItemIndex of
  0: ListView1.ViewStyle:=vsIcon;
  1: ListView1.ViewStyle:=vsList;
  2: ListView1.ViewStyle:=vsReport;
  else ListView1.ViewStyle:=vsSmallIcon;
 end;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
 UpdateFiles;
end;

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
 UpdateFiles;
end;

end.
