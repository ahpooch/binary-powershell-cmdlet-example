# Binary Cmdlet first actions

## Init

Initiating new binary cmdlet

```Powershell
dotnet new classlib
```

Changing `<TargetFramework>net9.0</TargetFramework>` 
      to `<TargetFramework>netstandart2.0</TargetFramework>` in `binary-powershell-cmdlet-example.csproj`

Nullable cannot be used with C# 7.3 so removing
`<Nullable>enable</Nullable>` from `binary-powershell-cmdlet-example.csproj`
Implicit  using cannot be used with C# 7.3 so removing
`<ImplicitUsings>enable</ImplicitUsings>` from `binary-powershell-cmdlet-example.csproj`

Adding PowershellStandard.Library

```Powershell
dotnet add package PowershellStandard.Library --version 5.1.1
```

Remove Class1.cs

```Powershell
Remove-Item .\Class1.cs
```

Using slightly changed [simplified C# example](https://learn.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-binary-module?view=powershell-7.5) to create `BinaryCmdlets.cs`.

```Powershell
$content = @"
using System.Management.Automation;           // Windows PowerShell namespace.

namespace BinaryPowershellCmdletExample
{
  [Cmdlet(VerbsDiagnostic.Test,"BinaryModuleCmdlet1")]
  public class TestBinaryModuleCmdlet1Command : Cmdlet
  {
    protected override void BeginProcessing()
    {
      WriteObject("BinaryModuleCmdlet1 exported by the BinaryPowershellCmdletExample module.");
    }
  }

  [Cmdlet(VerbsDiagnostic.Test, "BinaryModuleCmdlet2")]
  public class TestBinaryModuleCmdlet2Command : Cmdlet
  {
      protected override void BeginProcessing()
      {
          WriteObject("BinaryModuleCmdlet2 exported by the BinaryPowershellCmdletExample module.");
      }
  }

  [Cmdlet(VerbsDiagnostic.Test, "BinaryModuleCmdlet3")]
  public class TestBinaryModuleCmdlet3Command : Cmdlet
  {
      protected override void BeginProcessing()
      {
          WriteObject("BinaryModuleCmdlet3 exported by the BinaryPowershellCmdletExample module.");
      }
  }
}
"@

New-Item -ItemType File -Path .\BinaryCmdlets.cs -Value $content
# Check that BinaryCmdlets.cs has CRLF End of Line sequence after creation
```

Restoring dependencies

```Powershell
dotnet restore
```

Building module

```Powershell
dotnet build --configuration Release
# or
dotnet build --configuration Release --no-restore
```

Publishing module to Release

```Powershell
dotnet publish --configuration Release
# or
dotnet publish --configuration Release --no-restore
```

```Powershell
Import-Module .\bin\Release\netstandard2.0\binary-powershell-cmdlet-example.dll -PassThru

# Output:
#
# ModuleType Version    PreRelease Name                                ExportedCommands
# ---------- -------    ---------- ----                                ----------------
# Binary     1.0.0.0               binary-powershell-cmdlet-example    {Test-BinaryModuleCmdlet1, Test-BinaryModuleCmdlet2, Test-BinaryModuleCmdlet3}
```
