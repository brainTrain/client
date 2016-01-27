; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Keybase"
#ifndef MyAppVersion
#define MyAppVersion "1.0.0"
#endif
; Use semantic version to name the installer,
; but we still need the x.x.x.x version because Windows.
#ifndef MySemVersion
#define MySemVersion MyAppVersion
#endif
#define MyAppPublisher "Keybase, Inc."
#define MyAppURL "http://www.keybase.io/"
#define MyExeName "keybase.exe"
#define MyGoPath GetEnv('GOPATH')
#ifndef MyGoPath
#define MyGoPath "c:\work\"
#endif
#ifndef MyExePathName
#define MyExePathName MyGoPath + "\src\github.com\keybase\client\go\keybase\" + MyExeName
#endif
#define MyGoArch GetEnv('GOARCH')
#ifndef MyGoArch
#define MyGoArch "amd64"
#endif

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{DEB2E54C-C39F-4DC8-93A7-ABE0AB91DDCA}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppCopyright=Copyright (c) 2015, Keybase
DefaultDirName={pf32}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputBaseFilename=keybase_setup_gui_{#MySemVersion}_{#MyGoArch}
SetupIconFile={#MyGoPath}\src\github.com\keybase\keybase\public\images\favicon.ico
Compression=lzma
SolidCompression=yes
UninstallDisplayIcon={app}\keybase.exe
VersionInfoVersion={#MyAppVersion}
DisableDirPage=auto
DisableProgramGroupPage=auto
ArchitecturesInstallIn64BitMode=x64 ia64
; CreateUninstallRegKey=no
; Comment this out for development
; (there doesn't seem to be a way to make it conditional)
SignTool=SignCommand


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

; Arbitrarily unpack the dokan components in $GOPATH\github.com\dokan-dev\dokany
; Arbitrarily download the Visuap Studio 2015 redistributable to $GOPATH\bin

[Files]
Source: "{#MyExePathName}"; DestDir: "{app}"; Flags: replacesameversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "..\..\desktop\release\win32-ia32\Keybase-win32-ia32\*"; DestDir: "{app}\gui"; Flags: createallsubdirs recursesubdirs replacesameversion
Source: "..\..\..\..\dokan-dev\dokany\Win32\Win7Release\dokan.sys"; DestDir: "{sys}\drivers"; Check: IsOtherArch and IsWindows7
Source: "..\..\..\..\dokan-dev\dokany\Win32\Win8Release\dokan.sys"; DestDir: "{sys}\drivers"; Check: IsOtherArch and IsWindows8
Source: "..\..\..\..\dokan-dev\dokany\Win32\Win8.1Release\dokan.sys"; DestDir: "{sys}\drivers"; Check: IsOtherArch and IsWindows8_1
Source: "..\..\..\..\dokan-dev\dokany\Win32\Win10Release\dokan.sys"; DestDir: "{sys}\drivers"; Check: IsOtherArch and IsWindows10
Source: "..\..\..\..\dokan-dev\dokany\Win32\Release\dokan.dll"; DestDir: "{sys}"; Flags: 32bit
Source: "..\..\..\..\dokan-dev\dokany\Win32\Release\dokannp.dll"; DestDir: "{sys}"; Flags: 32bit
Source: "..\..\..\..\dokan-dev\dokany\x64\Win7Release\dokan.sys"; DestDir: "{sys}\drivers"; Check: IsX64 and IsWindows7
Source: "..\..\..\..\dokan-dev\dokany\x64\Win8Release\dokan.sys"; DestDir: "{sys}\drivers"; Check: IsX64 and IsWindows8
Source: "..\..\..\..\dokan-dev\dokany\x64\Win8.1Release\dokan.sys"; DestDir: "{sys}\drivers"; Check: IsX64 and IsWindows8_1
Source: "..\..\..\..\dokan-dev\dokany\x64\Win10Release\dokan.sys"; DestDir: "{sys}\drivers"; Check: IsX64 and IsWindows10
Source: "..\..\..\..\dokan-dev\dokany\x64\Release\dokan.dll"; DestDir: "{sys}"; Flags: 64bit; Check: IsX64
Source: "..\..\..\..\dokan-dev\dokany\x64\Release\dokannp.dll"; DestDir: "{sys}"; Flags: 64bit; Check: IsX64
Source: "..\..\..\..\dokan-dev\dokany\Win32\Release\dokanctl.exe"; DestDir: "{pf32}\Dokan\DokanLibrary"
Source: "..\..\..\..\dokan-dev\dokany\Win32\Release\mounter.exe"; DestDir: "{pf32}\Dokan\DokanLibrary"
Source: "..\..\..\..\..\..\bin\vc_redist.x86.exe"; DestDir: "{tmp}"
Source: "..\..\..\kbfs\kbfsdokan\kbfsdokan.exe"; DestDir: "{app}"; Flags: replacesameversion

[Icons]
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{group}\{#MyAppName} CMD"; Filename: "cmd.exe"; WorkingDir: "{app}"; IconFilename: "{app}\{#MyExeName}"; Parameters: "/K ""set PATH=%PATH%;{app}"""
Name: "{userstartup}\Keybase UI"; Filename: "{app}\gui\Keybase.exe"
Name: "{group}\Keybase UI"; Filename: "{app}\gui\Keybase.exe"

[Registry]
Root: "HKCU"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\keybase.exe"; ValueType: string; ValueData: "{app}\keybase.exe"; Flags: uninsdeletekey

[Messages]
WelcomeLabel2=This will install [name/ver] on your computer.

[Run]
Filename: "{tmp}\vc_redist.x86.exe"; Parameters: "/quiet /Q:a /c:""msiexec /qb /i vcredist.msi"""; StatusMsg: "Installing VisualStudio 2015 RunTime..."
Filename: "{app}\{#MyExeName}"; Parameters: "ctl watchdog"; Flags: runasoriginaluser runhidden nowait
Filename: "{pf32}\Dokan\DokanLibrary\dokanctl.exe"; Parameters: "/i a"; WorkingDir: "{pf32}\Dokan\DokanLibrary"; Flags: runhidden; Description: "Install Dokan Service"
Filename: "{app}\kbfsdokan.exe"; Parameters: "k:"; Flags: nowait runasoriginaluser runhidden
Filename: "{app}\gui\Keybase.exe"; WorkingDir: "{app}\gui"; Flags: nowait runasoriginaluser

[UninstallDelete]
Type: files; Name: "{userstartup}\{#MyAppName}.vbs"

[InstallDelete]
Type: files; Name: "{userstartup}\{#MyAppName}.vbs"

[UninstallRun]
Filename: "{app}\{#MyExePathName}"; Parameters: "ctl stop"; WorkingDir: "{app}"; Flags: skipifdoesntexist
Filename: "{pf32}\Dokan\DokanLibrary\dokanctl.exe"; Parameters: "/r a"
Filename: "taskkill"; Parameters: "/f /im Keybase.exe"
Filename: "taskkill"; Parameters: "/f /im kbfsdokan.exe"

[Code]
var
  g_driverVer: String;

// Simply invoking "Keybase.exe service" at startup results in an unsightly
// extra console window, so we'll emit this bit of script instead.
// (yes, this is pascal code that generates vbscript.)
// Note that we delete it at uninstall.
function CreateStartupScript(): boolean;
var
  fileName : string;
  lines : TArrayOfString;
begin
  Result := true;
  fileName := ExpandConstant('{userstartup}\{#MyAppName}.vbs');
  SetArrayLength(lines, 5);

  lines[0] := 'Dim WinScriptHost';
  lines[1] := 'Set WinScriptHost = CreateObject("WScript.Shell")';
  lines[2] := ExpandConstant('WinScriptHost.Run Chr(34) & "{app}\{#MyExeName}" & Chr(34) & " ctl watchdog", 0');
  lines[3] := ExpandConstant('WinScriptHost.Run Chr(34) & "{app}\kbfsdokan.exe" & Chr(34) & " k:", 0');
  lines[4] := 'Set WinScriptHost = Nothing';


  Result := SaveStringsToFile(filename,lines,true);
  exit;
end;

 
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;

begin
  if  CurStep=ssPostInstall then
    begin
      CreateStartupScript();
    end
end;



procedure StopKeybaseService();
var
  ResultCode: Integer;
  CommandName: string;

begin
  // Launch Keybase ctl stop and wait for it to terminate
  CommandName := ExpandConstant('{app}\{#MyExeName}');
  Exec(CommandName, 'ctl stop', '', SW_HIDE,
    ewWaitUntilTerminated, ResultCode);
  Sleep(100);
  Exec('{pf32}\Dokan\DokanLibrary\dokanctl.exe', '/r a', '', SW_HIDE,
    ewWaitUntilTerminated, ResultCode);
  // Now kill any electron UI instances
  Exec('taskkill.exe', '/f /im Keybase.exe', '', SW_HIDE,
    ewWaitUntilTerminated, ResultCode);
  Exec('taskkill.exe', '/f /im kbfsdokan.exe', '', SW_HIDE,
    ewWaitUntilTerminated, ResultCode);
  Sleep(100);
end;

// Restart if the driver got changed
function NeedRestart(): Boolean;
var
  newVer: String;
  fileName: String;

begin
  fileName := ExpandConstant('{sys}\drivers\dokan.sys');
  GetVersionNumbersString(fileName, newVer);
  Log('Old driver ver: ' + g_driverVer);
  Log('New driver ver: ' + newVer);
  Result := (Length(g_driverVer) > 0 ) and not (CompareStr(g_driverVer, newVer) = 0)  
end;

function UninstallNeedRestart(): Boolean;
begin
  // Assume we always remove a driver
  Result := true;
end;

function PrepareToInstall(var Needs: Boolean): String;
var
    fileName: String;
begin
    StopKeybaseService();
    fileName := ExpandConstant('{sys}\drivers\dokan.sys');
    GetVersionNumbersString(fileName, g_driverVer);
end;

function IsX64: Boolean;
begin
  Result := Is64BitInstallMode and (ProcessorArchitecture = paX64);
end;


function IsIA64: Boolean;
begin
  Result := Is64BitInstallMode and (ProcessorArchitecture = paIA64);
end;


function IsOtherArch: Boolean;
begin
  Result := not IsX64 and not IsIA64;
end;


function IsWindowsXP: Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  Result := Version.NTPlatform and (Version.Major = 5) and (Version.Minor = 1);
end;
     

function IsWindows7: Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);

  Result := Version.NTPlatform and (Version.Major = 6) and (Version.Minor = 1);

end;


function IsWindows8: Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);

  Result := Version.NTPlatform and (Version.Major = 6) and (Version.Minor = 2);

end;


function IsWindows8_1: Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);

  Result := Version.NTPlatform and (Version.Major = 6) and (Version.Minor = 3);

end;


function IsWindows10: Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);

  Result := Version.NTPlatform and (Version.Major = 10);
  if result = true then
  begin
     Log('IsWindows10');
  end
  else
  begin
     Log('Not Windows10: version' + IntToStr(Version.Major));
  end;
end;
