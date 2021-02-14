using System;
using System.Diagnostics;
using System.Windows.Forms;
using MultipleROBLOX.Properties;

namespace MultipleROBLOX
{
	class ProcessIcon : IDisposable
	{
		NotifyIcon NI;

		public ProcessIcon()
		{
			NI = new NotifyIcon();
		}

		public void Display()
		{
			NI.ContextMenuStrip = new ContextMenu().Create();
			NI.Icon = Resources.ProgramIcon;
			NI.Text = "Multiple ROBLOX";
			NI.Visible = true;
		}

		public void Dispose()
		{
			NI.Dispose();
		}
	}
}