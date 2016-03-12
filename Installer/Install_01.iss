; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "ED - Intelligent Boardcomputer Extension"
#define MyAppShortName "ED-IBE"
#define MyAppVersion GetStringFileInfo("..\ED-IBE\bin\Release\ED-IBE.exe", "FileVersion")
#define MyAppVersion_s Copy(MyAppVersion, 1, Len(MyAppVersion)-2)
#define MyAppPublisher "Duke Jones"
#define MyAppURL "https://github.com/Duke-Jones/ED-IBE"
#define MyAppExeName "ED-IBE.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{4408F8B2-35C2-418D-9765-92FD85C35BE9}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion_s}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\ED-IBE
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=.\Package
OutputBaseFilename={#MyAppShortName}_{#MyAppVersion_s}
SetupIconFile=..\ED-IBE\RegulatedNoise.ico
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64 ia64
ChangesEnvironment=yes
DirExistsWarning=no


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; OnlyBelowVersion: 0,6.1

[Files]
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "..\ED-IBE\bin\Release\ED-IBE.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\libzmq.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\MySql.Data.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\Newtonsoft.Json.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\ED-IBE.exe.config"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\ED-IBE.pdb"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\Tesseract.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\Tesseract.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\clrzmq.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\clrzmq.pdb"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\clrzmq.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\EdClasses.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\EdClasses.pdb"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\x64\liblept168.dll"; DestDir: "{app}\x64\"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\x64\libtesseract302.dll"; DestDir: "{app}\x64\"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\x86\liblept168.dll"; DestDir: "{app}\x86\"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\x86\libtesseract302.dll"; DestDir: "{app}\x86\"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\Json\Bin\Net45\Newtonsoft.Json.dll"; DestDir: "{app}\Json\Bin\Net45\"; Flags: ignoreversion
Source: "..\RNDatabase\Database\COPYING"; DestDir: "{app}\Database\"; Flags: ignoreversion
Source: "..\RNDatabase\Database\README"; DestDir: "{app}\Database\"; Flags: ignoreversion
Source: "..\RNDatabase\Database\bin\*"; DestDir: "{app}\Database\bin\"; Flags: ignoreversion
Source: "..\RNDatabase\Database\share\*"; DestDir: "{app}\Database\share\"; Flags: ignoreversion createallsubdirs recursesubdirs
;data path
Source: "..\ED-IBE\bin\Release\Calibration Examples\*"; DestDir: "{code:GetDataBasepath}\Calibration Examples"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\tessdata\*"; DestDir: "{code:GetDataBasepath}\tessdata"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\Data\*"; DestDir: "{code:GetDataBasepath}\Data"; Flags: ignoreversion
Source: "..\ED-IBE\bin\Release\Brainerous\*"; DestDir: "{code:GetDataBasepath}\Brainerous"; Flags: ignoreversion createallsubdirs recursesubdirs
Source: "..\RNDatabase\Database\script\create.cmd"; DestDir: "{code:GetDataBasepath}\Database\script\"; Flags: ignoreversion
Source: "..\RNDatabase\Database\script\create_Elite_DB.sql"; DestDir: "{code:GetDataBasepath}\Database\script\"; Flags: ignoreversion
Source: "..\RNDatabase\Database\script\start_server.cmd"; DestDir: "{code:GetDataBasepath}\Database\script\"; Flags: ignoreversion
;ini files
Source: "..\ED-IBE\bin\Release\ED-IBE.ini"; DestDir: "{code:GetDataBasepath}"; Flags: ignoreversion onlyifdoesntexist
Source: "..\RNDatabase\Database\Elite.ini"; DestDir: "{code:GetDataBasepath}\Database\"; Flags: ignoreversion onlyifdoesntexist

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"

[Dirs]
Name: "{app}\Json"
Name: "{app}\Json\Bin"
Name: "{app}\Json\Bin\Net45"
Name: "{app}\x64"
Name: "{app}\x86"
Name: "{app}\Database"
Name: "{app}\Database\bin"
Name: "{app}\Database\share"
Name: "{app}\Database\share\english"
Name: "{code:GetDataBasepath}\Logs"
Name: "{code:GetDataBasepath}\OCR Correction Images"
Name: "{code:GetDataBasepath}"
Name: "{app}"; Flags: uninsalwaysuninstall

[Registry]
Root: "HKLM"; Subkey: "Software\ED-IBE\"; ValueType: expandsz; ValueName: "Program"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "Software\ED-IBE\"; ValueType: expandsz; ValueName: "Data"; ValueData: "{code:GetDataBasepath}"; Flags: uninsdeletevalue

[INI]
;Database
Filename: "{code:GetDataBasepath}\Database\Elite.ini"; Section: "mysqld"; Key: "basedir"; String: """{code:ToUnixPath|{app}\Database\}"""
Filename: "{code:GetDataBasepath}\Database\Elite.ini"; Section: "mysqld"; Key: "datadir"; String: """{code:ToUnixPath|{code:GetDataBasepath}\Database\data\}"""
Filename: "{code:GetDataBasepath}\Database\Elite.ini"; Section: "mysqld"; Key: "lc-messages-dir"; String: """{code:ToUnixPath|{app}\Database\share}"""

;ProgramSettings
Filename: "{code:GetDataBasepath}\ED-IBE.ini"; Section: "DB_Server"; Key: "Commandline"; String: """{app}\Database\bin\mysqld.exe"""
Filename: "{code:GetDataBasepath}\ED-IBE.ini"; Section: "DB_Server"; Key: "CommandArgs"; String: "--defaults-file=""{code:GetDataBasepath}\Database\Elite.ini"" --console"
Filename: "{code:GetDataBasepath}\ED-IBE.ini"; Section: "DB_Server"; Key: "WorkingDirectory"; String: """{app}\Database"""

[Types]
Name: "EmptyList"; Description: "EmptyList"; Flags: iscustom

[CustomMessages]
datapath_form_Caption=DataPath: Select Destination Location
datapath_form_Description1=Where should the {#emit SetupSetting("AppName")} data structure be installed ?
datapath_form_Info1=Setup will install the {#emit SetupSetting("AppName")} data structure into following folder.%n%nTo continue, click Next. If you would like to select a different folder, click Browse%n(be sure to have writing rights in this folder!!!)
datapath_form_Info2=If you want to re-create the database (all contained data will be lost)%ncheck for confirmation the box below:
datapath_form_CheckBoxLabel=Delete all existing data and re-create the database

existing_form_Caption=Intelligent Boardcomputer Extension - Database
existing_form_Description1=...existing ED-IBE database was found
existing_form_Info1=Setup will use the existing database in :
existing_form_Info2=If you want to re-create the database (all contained data will be lost)%ncheck for confirmation the box below:
existing_form_CheckBoxLabel=Delete all existing data and re-create the database

[Code]
var
  
  Page_DataPath:         TInputDirWizardPage;
  Page_DataPathExisting: TWizardPage;

  cbDeleteOldData:       TCheckBox;
  strNewDatabasePath:    String;
  DatabasePath: TEdit;  

(*****************************************************************************)
(* replaces all '\' with '/' *)
(*****************************************************************************)
function ToUnixPath(Param: String): String;
var 
  temp: String;
begin
  temp   := ExpandConstant(Param);
  StringChangeEx(temp, '\', '/', True);
  Result := temp;
end;
  
(*****************************************************************************)
(* returns the actual database path *)
(*****************************************************************************)
function GetDataBasepath(Dummy: string): String;
var 
  DataPath: String;
begin
  Log('strNewDatabasePath : <' + strNewDatabasePath + '>');

  if strNewDatabasePath = '' then
  begin
     if not RegQueryStringValue(HKLM, ExpandConstant('Software\ED-IBE\'), 'Data', DataPath) then
     begin
       // value not found
       DataPath := ExpandConstant('{localappdata}\ED-IBE');
     end else if DataPath = '' then
     begin
       // value not set
       DataPath := ExpandConstant('{localappdata}\ED-IBE');
     end;
  end else
  begin
	   DataPath := strNewDatabasePath;
  end;

  Result := DataPath;
end;

(*****************************************************************************)
(* creates the "DataBase Is Existing"-page *)
(*****************************************************************************)
function Database_Existing_Page(PreviousPageId: Integer): Integer;
var
  InfoLabel1: TLabel;
  InfoLabel2: TLabel;

begin
  Page_DataPathExisting := CreateCustomPage(
            PreviousPageId,
            ExpandConstant('{cm:existing_form_Caption}'),
            ExpandConstant('{cm:existing_form_Description1}'));

  InfoLabel1 := TLabel.Create(Page_DataPathExisting);
  with InfoLabel1 do
  begin
    Parent := Page_DataPathExisting.Surface;
    WordWrap := false;
    Left := ScaleX(16);
    Top := ScaleY(0);
    Width := ScaleX(350);
    Height := ScaleY(20);
    Caption := ExpandConstant('{cm:existing_form_Info1}');
  end;
 
  DatabasePath := TEdit.Create(Page_DataPathExisting);
  with DatabasePath do
  begin
    Parent := Page_DataPathExisting.Surface;
    Left := ScaleX(16);
    Top := ScaleY(24);
    Width := ScaleX(350);
    Height := ScaleY(22);
    TabOrder := 1;
    ReadOnly := true;
  end;

  InfoLabel2 := TLabel.Create(Page_DataPathExisting);
  with InfoLabel2 do
  begin
    Parent := Page_DataPathExisting.Surface;
    WordWrap := false;
    Left := ScaleX(16);
    Top := ScaleY(70);
    Width := ScaleX(350);
    Height := ScaleY(40);
    Caption := ExpandConstant('{cm:existing_form_Info2}');
  end;

  cbDeleteOldData := TCheckBox.Create(Page_DataPathExisting)
  with cbDeleteOldData do
  begin
    Parent := Page_DataPathExisting.Surface;
    AllowGrayed := False;
    Caption := ExpandConstant('{cm:existing_form_CheckBoxLabel}');
    Left := ScaleX(16);
    Top := ScaleY(110);
    Width := ScaleX(350);
    Height := ScaleY(17);
    TabOrder := 0;
  end;

  Result := Page_DataPathExisting.ID;
end;


(*****************************************************************************)
(* creates the DataPath-page *)
(*****************************************************************************)
function DataPath_Page(PreviousPageId: Integer): Integer;
var
  InfoLabel1: TLabel;
  InfoLabel2: TLabel;
  DatabasePath: TEdit;
  DataPath: String;

begin

  Page_DataPath := CreateInputDirPage(
                   PreviousPageId,
                   ExpandConstant('{cm:datapath_form_Caption}'),
                   ExpandConstant('{cm:datapath_form_Description1}'), 
                   ExpandConstant('{cm:datapath_form_Info1}'),
                   false, '');

  // Add item (with an empty caption)
  Page_DataPath.Add('');

  // Set initial path 
  Page_DataPath.Values[0] := GetDataBasepath('');

  Result := Page_DataPath.ID;
end;

(*****************************************************************************)
(* checks if the db is already existing from a previous installation *)
(*****************************************************************************)
function DBIsExisting: boolean;
var
   testPath: String;   
begin
   testPath := ExpandConstant(GetDataBasepath('') + '\Database\data\ibdata1');
   Log('Testpath : <' + testPath + '>');
   Result := FileExists(testPath);
end;

(*****************************************************************************)
(* call of InitializeWizard *)
(*****************************************************************************)
procedure InitializeWizard();
begin
    Database_Existing_Page(wpSelectComponents);
    DataPath_Page(wpSelectComponents);
end;

(*****************************************************************************)
(* event : CurStepChanged, used for starting the database script *)
(*****************************************************************************)
procedure CurStepChanged(CurStep: TSetupStep);
var 
  ResultCode: Integer;
  BasePath: String;
  CommandLine: String;

begin

    if CurStep=ssPostInstall then 
    begin
      if (not DBIsExisting()) or (cbDeleteOldData.Checked) then
         begin
            BasePath := ExpandConstant(GetDataBasepath('') + '\Database');
            CommandLine := '/C ""' + BasePath + '\script\create.cmd"' + ExpandConstant(' /forceinstall "' + BasePath + '" "{app}\Database" {#MyAppVersion} > "' + BasePath + '\install.log" 2>&1"');

            Log('CommandLine : <' + CommandLine + '>');

            Exec('cmd.exe', 
                  CommandLine, 
                  BasePath, 
                  SW_HIDE, 
                  ewWaitUntilTerminated, 
                  ResultCode);
      end;
    end;

end;


(*****************************************************************************)
(* event : ShouldSkipPage *)
(*****************************************************************************)
function ShouldSkipPage(CurrentPage: integer): boolean;
begin
   case CurrentPage of
   Page_DataPathExisting.ID:
   begin
      Result := not DBIsExisting();
   end else
      Result := false;
   end;
end;

(*****************************************************************************)
(* event : NextButtonClick *)
(*****************************************************************************)
function NextButtonClick(CurPageID: integer): boolean;
begin

   case CurPageID of
      Page_DataPath.ID:
      begin
         Log('Datapath : <' + Page_DataPath.Values[0] + '>');      
         strNewDatabasePath := Page_DataPath.Values[0];
         DatabasePath.Text := Page_DataPath.Values[0];
      end;
   end;

   Result := true;

end;

(*****************************************************************************)
(* event : UpdateReadyMemo *)
(*****************************************************************************)
function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  s: string;
  
begin
    if MemoUserInfoInfo <> '' then
    begin
      s := s + MemoUserInfoInfo;
      s := s + NewLine + NewLine;
    end

    if MemoDirInfo <> '' then
    begin
      s := s + MemoDirInfo;
      s := s + NewLine + NewLine;
    end

    s := s + 'Destination location (data):' + NewLine +
              Space + GetDataBasepath('') + NewLine;

    if not DBIsExisting() then
    begin
      s := s + Space + 'A new MySQL database will be created.';
      s := s + NewLine + NewLine;

    end else if (not cbDeleteOldData.Checked) then
    begin
      s := s + Space + 'Existing MySQL database will kept unchanged';
      s := s + NewLine + NewLine;

    end else
    begin
      s := s + Space + 'Existing MySQL database will be re-created. All data will be lost.';
      s := s + NewLine + NewLine;
    end;

    if MemoTypeInfo <> '' then
    begin
      s := s + MemoTypeInfo;
      s := s + NewLine + NewLine;
    end

    if MemoComponentsInfo <> '' then
    begin
      s := s + MemoComponentsInfo;
      s := s + NewLine + NewLine;
    end

    if MemoGroupInfo <> '' then
    begin
      s := s + MemoGroupInfo;
      s := s + NewLine + NewLine;
    end

    if MemoTasksInfo <> '' then
    begin
      s := s + MemoTasksInfo;
      s := s + NewLine + NewLine;
    end


    Result := s
end;

