Add-Type -TypeDefinition @"
using System;
using System.ComponentModel;
using System.Runtime.InteropServices;

public static class ScreenReaderFixUntil
{
  public static bool IsScreenReaderActive()
  {
    IntPtr ptr = IntPtr.Zero;
    try
    {
      ptr = Marshal.AllocHGlobal(Marshal.SizeOf(typeof(int)));
      int hr = Interop.SystemParametersInfo(
        Interop.SPI_GETSCREENREADER,
        sizeof(int),
        ptr,
        0);

      if (hr == 0)
      {
        throw new Win32Exception(Marshal.GetLastWin32Error());
      }

      return Marshal.ReadInt32(ptr) != 0;
    }
    finally
    {
      if (ptr != IntPtr.Zero)
      {
        Marshal.FreeHGlobal(ptr);
      }
    }
  }

  public static void SetScreenReaderActiveStatus(bool isActive)
  {
    int hr = Interop.SystemParametersInfo(
      Interop.SPI_SETSCREENREADER,
      (uint)(isActive ? 1 : 0),
      IntPtr.Zero,
      Interop.SPI_SENDCHANGE
    );

    if (hr == 0)
    {
      throw new Win32Exception(Marshal.GetLastWin32Error());
    }
  }

  private static class Interop
  {
    public const int SPI_SENDCHANGE       = 0x0002;
    public const int SPI_GETSCREENREADER  = 0x0046;
    public const int SPI_SETSCREENREADER  = 0x0047;

    [DllImport("user32", SetLastError = true, CharSet = CharSet.Unicode)]
    public static extern int SystemParametersInfo(
      uint uiAction,
      uint uiParam,
      IntPtr pvParam,
      uint fWinIni
    );
  }
}
"@
if ([ScreenReaderFixUntil]::IsScreenReaderActive()) {
   [ScreenReaderFixUntil]::SetScreenReaderActiveStatus($false);
}

