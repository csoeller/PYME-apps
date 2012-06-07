import wx
import sys
if len(sys.argv) < 2:
    txt = "(no argument given)"
else:
    txt = sys.argv[1]

app = wx.PySimpleApp()
frame = wx.Frame(None, wx.ID_ANY, "Hello World")
d= wx.MessageDialog( frame, txt,"We were called with the URL:", wx.OK)
d.ShowModal()
d.Destroy()
