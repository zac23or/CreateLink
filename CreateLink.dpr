program CreateLink;


uses SysUtils, Windows, ShlObj, ComObj, ActiveX;

procedure CreateLink_(const PathObj, PathLink, IconPath, Param: string);
var
  IObject: IUnknown;
  SLink: IShellLink;
  PFile: IPersistFile;
begin
  IObject:=CreateComObject(CLSID_ShellLink);
  SLink:=IObject as IShellLink;
  PFile:=IObject as IPersistFile;

  with SLink do
  begin
    SetArguments(PChar(Param));
    SetPath(PChar(PathObj));
    SetIconLocation(Pchar(IconPath), 0);
  end;
  PFile.Save(PWideChar(WideString(PathLink)), FALSE);
end;

var ClassName: String;
    Cmd: String;
    i : Integer;
begin
  try
    CoInitialize(nil);
     for i := 3 to ParamCount do
     begin
       Cmd := Cmd + Format(' "%s"', [ParamStr(i)]);
     end;
    CreateLink_(ParamStr(1), ParamStr(2),  ParamStr(3),  cmd);
    CoUninitialize();
  Except
    On E : Exception do begin
      ClassName := E.ClassName;
      MessageBox(0, PChar(E.Message), PAnsiChar(ClassName),
        MB_ICONEXCLAMATION);
    end;
  end;
end.
 