@ECHO OFF
SET mod-dir=%cd%
SET patch-dir=%cd%\Patch
SET patch-app=%patch-dir%\UnityEX.exe
CD %mod-dir%\..\..\..\..\common\Shortest Trip to Earth\Data
ECHO Exporting Game Data...
FOR %%a in (*.unity3D) do "%patch-app%" exportbundle "%%a" -p "%cd%" >nul
IF EXIST "data.unity3d" (
  RENAME data.unity3d data.unity3d.backup
)
ECHO Patching...
FOR %%a in (*.assets) do "%patch-app%" import "%%a" -p "%patch-dir%" >nul
ECHO More Patching...
FOR /l %%i in (0,1) do IF EXIST level%%i "%patch-app%" import "level%%i" -p "%patch-dir%" >nul
CD ..\AssetBundles
ECHO Importing patched Base Game...
FOR %%a in (base.ab) do "%patch-app%" import "%%a" -mb_new -ncomp -f "%patch-dir%" >nul
ECHO Importing patched DLC - The Old Enemies...
FOR %%a in (dlc2.ab) do "%patch-app%" import "%%a" -mb_new -f "%patch-dir%" >nul
ECHO Importing patched DLC - Supporters Pack...
FOR %%a in (sdlc.ab) do "%patch-app%" import "%%a" -mb_new -f "%patch-dir%" >nul
CD %mod-dir%
