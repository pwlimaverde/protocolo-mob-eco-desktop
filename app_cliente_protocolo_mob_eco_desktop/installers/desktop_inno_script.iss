; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "SistemaProtocoloMobEco"
#define MyAppVersion "0.0.1"
#define MyAppPublisher "Pwlimaverde"
#define MyAppURL "https://github.com/pwlimaverde"
#define MyAppExeName "app_cliente_protocolo_mob_eco_desktop.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A7D58C0E-D819-4BA7-BD70-BCA506F03B13}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\installers
OutputBaseFilename=protocolo_mob_eco_desktop
SetupIconFile=C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\windows\runner\resources\app_icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\build\windows\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\build\windows\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\build\windows\runner\Release\objectbox.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\build\windows\runner\Release\objectbox_flutter_libs_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\build\windows\runner\Release\pdfium.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\build\windows\runner\Release\printing_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\PROJETOS\FLUTTER\APPS\protocolo_mob_eco_desktop\app_cliente_protocolo_mob_eco_desktop\build\windows\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

