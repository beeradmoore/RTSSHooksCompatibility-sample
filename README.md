# RTSSHooksCompatibility Sample
This repo is to show how its possible to disable RivaTuner Statistics Server (RTSS) from hooking your C# application by embedding a native static library that exports `RTSSHooksCompatibility` data. Currently with .NET you need to also enable NativeAOT to accomplish this.

> [!IMPORTANT]  
> Do NOT do anything I do here unless you have a very important reason to disable RTSS hooking.

While the sample here is using a MonoGame I made this sample for use in [DLSS Swapper](https://github.com/beeradmoore/dlss-swapper), a WinUI3/WindowsAppSDK application. In general I do not recommend disabling RTSS for your games as it can report useful information to your end users and you should only do this if you have specific reasons to disable RTSS hooking.

See my blog post [here](https://beeradmoore.com/disabling-rtss-for-dotnet-apps/) for how I came about all the source in this repo.

### Build the static library
See `RTSSHooksCompatibility` folder.

Run `build.cmd` to build `RTSSHooksCompatibility.obj`. This requires VS2022 with the C++ module installed. If your install location is different to standard you may need to update the `PATH` in this file.

`RTSSHooksCompatibility.c` is the C source file which contains just the export.


### Build the sample game
See `MyAwesomeGame` folder.

Assuming required MonoGame tools and .NET SDKs are installed you should be able to run `publish.cmd` which will produce two outputs in a folder called `publish`. One which will have RTSS enabled out of the box, one that explicitly disables it.

The changes in this project out of the standard MonoGame OpenGL template are as follows.

Changing 
```xml
    <TargetFramework>net6.0</TargetFramework>
```
to 
```xml
    <TargetFramework>net8.0</TargetFramework>
    <PublishAot>true</PublishAot>
```

and adding 
```xml
<ItemGroup Condition="'$(Configuration)' == 'Release_RTSS_Disabled'">
  <NativeLibrary Include="../../RTSSHooksCompatibility/RTSSHooksCompatibility.obj" />
</ItemGroup>
```

> [!NOTE] 
> `Condition="'$(Configuration)' == 'Release_RTSS_Disabled'"` is not needed. I added that part so I can export with and without `RTSSHooksCompatibility.obj`.


#### Why is this using the standard MonoGame OpenGL Template?
More info can be found on [pirota-pirozou/MonoGameNativeAOTTest](https://github.com/pirota-pirozou/MonoGameNativeAOTTest). My understanding is that the DirectX version of MonoGame uses WinForms and WinForms does not support NativeAOT.