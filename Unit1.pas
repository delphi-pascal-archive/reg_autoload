unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ComCtrls, Buttons, ExtCtrls, Registry, AppEvnts;

type
  TForm1 = class(TForm)
    SG: TStringGrid;
    LB: TListBox;
    procedure FormPaint(Sender: TObject);
    procedure SGKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  sg: TstringGrid;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
 SG.ColWidths[0]:=200;
 SG.ColWidths[1]:=480;
 SG.ColWidths[2]:=150;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
 regini:TreginiFile;
 i:byte;
begin
 SG.Cols[0].Clear;SG.Cols[1].Clear;SG.Cols[2].Clear;
 SG.RowCount:=2;
 SG.Cols[0].Add('Имя файла');
 SG.Cols[1].Add('Путь к файлу');
 SG.Cols[2].Add('Путь в реестре');
  try
   //HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
   regini:=TreginiFile.create();
   regini.rootkey:=HKEY_LOCAL_MACHINE;
   regini.openkey('Software\Microsoft\Windows\CurrentVersion\Run',false);
   regini.GetValueNames(LB.Items);
   regini.closekey;
   regini.openkey('Software\Microsoft\Windows\CurrentVersion',false);
   if LB.Items.Count>0
   then
    for i:=0 to (LB.Items.Count-1) do
     begin
      SG.RowCount:=SG.RowCount+1;
      SG.Cols[0].Add(LB.Items.Strings[i]);
      SG.Cols[1].Add(regini.ReadString('Run',LB.Items.Strings[i],''));
      SG.Cols[2].Add('HKEY_LM\Run');
     end;
   regini.closekey;
   //HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
   regini.rootkey:=HKEY_CURRENT_USER;
   regini.openkey('Software\Microsoft\Windows\CurrentVersion\Run',false);
   regini.GetValueNames(LB.Items);
   regini.closekey;
   regini.openkey('Software\Microsoft\Windows\CurrentVersion',false);
   if LB.Items.Count>0
   then
    for i:=0 to (LB.Items.Count-1) do
     begin
      SG.RowCount:=SG.RowCount+1;
      SG.Cols[0].Add(LB.Items.Strings[i]);
      SG.Cols[1].Add(regini.ReadString('Run',LB.Items.Strings[i],''));
      SG.Cols[2].Add('HKEY_CU\Run');
     end;
    regini.closekey;
   //HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
   regini.rootkey:=HKEY_USERS;
   regini.openkey('.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run',false);
   regini.GetValueNames(LB.Items);
   regini.closekey;
   regini.openkey('.Default\SOFTWARE\Microsoft\Windows\CurrentVersion',false);
   if LB.Items.Count>0
   then
    for i:=0 to (LB.Items.Count-1) do
     begin
      SG.RowCount:=SG.RowCount+1;
      SG.Cols[0].Add(LB.Items.Strings[i]);
      SG.Cols[1].Add(regini.ReadString('Run',LB.Items.Strings[i],''));
      SG.Cols[2].Add('HKEY_Users\Run');
     end;
    regini.closekey;
   //HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
   regini:=TreginiFile.create();
   regini.rootkey:=HKEY_LOCAL_MACHINE;
   regini.openkey('Software\Microsoft\Windows\CurrentVersion\RunOnce',false);
   regini.GetValueNames(LB.Items);
   regini.closekey;
   regini.openkey('Software\Microsoft\Windows\CurrentVersion',false);
   if LB.Items.Count>0
   then
    for i:=0 to (LB.Items.Count-1) do
     begin
      SG.RowCount:=SG.RowCount+1;
      SG.Cols[0].Add(LB.Items.Strings[i]);
      SG.Cols[1].Add(regini.ReadString('RunOnce',LB.Items.Strings[i],''));
      SG.Cols[2].Add('HKEY_LM\RunOnce');
     end;
    regini.closekey;
   //HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
   regini.rootkey:=HKEY_CURRENT_USER;
   regini.openkey('Software\Microsoft\Windows\CurrentVersion\RunOnce',false);
   regini.GetValueNames(LB.Items);
   regini.closekey;
   regini.openkey('Software\Microsoft\Windows\CurrentVersion',false);
   if LB.Items.Count>0
   then
    for i:=0 to (LB.Items.Count-1) do
     begin
      SG.RowCount:=SG.RowCount+1;
      SG.Cols[0].Add(LB.Items.Strings[i]);
      SG.Cols[1].Add(regini.ReadString('RunOnce',LB.Items.Strings[i],''));
      SG.Cols[2].Add('HKEY_CU\RunOnce');
     end;
    regini.closekey;
   //HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
   regini.rootkey:=HKEY_USERS;
   regini.openkey('.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce',false);
   regini.GetValueNames(LB.Items);
   regini.closekey;
   regini.openkey('.Default\SOFTWARE\Microsoft\Windows\CurrentVersion',false);
   if LB.Items.Count>0
   then
    for i:=0 to (LB.Items.Count-1) do
     begin
      SG.RowCount:=SG.RowCount+1;
      SG.Cols[0].Add(LB.Items.Strings[i]);
      SG.Cols[1].Add(regini.ReadString('RunOnce',LB.Items.Strings[i],''));
      SG.Cols[2].Add('HKEY_Users\RunOnce');
     end;
    regini.closekey;
   //HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows
   if paramcount>0
   then
    begin
     regini.rootkey:=HKEY_CURRENT_USER;
     regini.openkey('Software\Microsoft\Windows NT\CurrentVersion',false);
     if regini.ReadString('Windows','load','')<>''
     then
      begin
       SG.RowCount:=SG.RowCount+1;
       SG.Cols[0].Add('load');
       SG.Cols[1].Add(regini.ReadString('Windows','load',''));
       SG.Cols[2].Add('HKEY_CU\load');
      end;
     regini.CloseKey;
    //HKEY_USERS\.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\Windows
    regini.rootkey:=HKEY_USERS;
    regini.openkey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion',false);
    if regini.ReadString('Windows','load','')<>''
    then
     begin
      SG.RowCount:=SG.RowCount+1;
      SG.Cols[0].Add('load');
      SG.Cols[1].Add(regini.ReadString('Windows','load',''));
      SG.Cols[2].Add('HKEY_Users\load');
     end;
    regini.CloseKey;
   end;
   if SG.RowCount>1
   then SG.RowCount:=SG.RowCount-1;
  finally
   regini.free;
  end;
end;

procedure TForm1.SGKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var regini:TreginiFile;
begin
 if SG.Cells[0,0]=''
 then Exit;
 if(key=vk_delete) and (Application.MessageBox(pchar('Вы действительно хотите удалить запись "'+SG.Cells[0,SG.Selection.Top]+'" ?'),'Удаление',MB_OKCANCEL+MB_ICONQUESTION)=1)
 then
  begin
   try
    regini:=TreginiFile.create();
    //
    if(SG.Cells[2,SG.Selection.Top]='HKEY_LM\Run') or (SG.Cells[2,SG.Selection.Top]='HKEY_LM\RunOnce')
    then regini.rootkey:=HKEY_LOCAL_MACHINE;
    if(SG.Cells[2,SG.Selection.Top]='HKEY_CU\Run') or (SG.Cells[2,SG.Selection.Top]='HKEY_CU\RunOnce') or (SG.Cells[2,SG.Selection.Top]='HKEY_CU\load')
    then regini.rootkey:=HKEY_CURRENT_USER;
    if(SG.Cells[2,SG.Selection.Top]='HKEY_Users\Run') or (SG.Cells[2,SG.Selection.Top]='HKEY_Users\RunOnce') or (SG.Cells[2,SG.Selection.Top]='HKEY_Users\load')
    then regini.rootkey:=HKEY_USERS;
    //
    if(SG.Cells[2,SG.Selection.Top]='HKEY_LM\Run') or (SG.Cells[2,SG.Selection.Top]='HKEY_CU\Run')
    then regini.openkey('Software\Microsoft\Windows\CurrentVersion\Run',false);
    if(SG.Cells[2,SG.Selection.Top]='HKEY_LM\RunOnce') or (SG.Cells[2,SG.Selection.Top]='HKEY_CU\RunOnce')
    then regini.openkey('Software\Microsoft\Windows\CurrentVersion\RunOnce',false);
    if(SG.Cells[2,SG.Selection.Top]='HKEY_Users\Run')
    then regini.openkey('.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run',false);
    if(SG.Cells[2,SG.Selection.Top]='HKEY_Users\RunOnce')
    then regini.openkey('.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce',false);
    if(SG.Cells[2,SG.Selection.Top]='HKEY_CU\load')
    then regini.openkey('Software\Microsoft\Windows NT\CurrentVersion\Windows',false);
    if(SG.Cells[2,SG.Selection.Top]='HKEY_Users\load')
    then regini.openkey('.DEFAULT\Software\Microsoft\Windows NT\CurrentVersion\Windows',false);
    //
    regini.DeleteValue(SG.Cells[0,SG.Selection.Top]);
    regini.closekey;
   finally
    regini.free;
   end;
  Form1.FormPaint(Form1);
 end;
end;

end.

