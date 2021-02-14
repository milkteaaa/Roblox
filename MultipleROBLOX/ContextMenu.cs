using System;
using System.Threading;
using System.Windows.Forms;
using MultipleROBLOX.Properties;

namespace MultipleROBLOX
{
	class ContextMenu
	{
		public ContextMenuStrip Create()
		{
			ContextMenuStrip Menu = new ContextMenuStrip();
			ToolStripMenuItem Item;
			ToolStripSeparator Separator;

			Item = new ToolStripMenuItem();
			Item.Text = "Multiple ROBLOX";
			Item.Image = Resources.ProgramImage;
			Item.Enabled = false;
			Menu.Items.Add(Item);

			Separator = new ToolStripSeparator();
			Menu.Items.Add(Separator);

			Item = new ToolStripMenuItem();
			Item.Text = "Close";
			Item.Click += new System.EventHandler(ExitClick);
			Menu.Items.Add(Item);
			
			new Mutex(true, "ROBLOX_singletonMutex");
			return Menu;
		}

		void ExitClick(object sender, EventArgs e)
		{
			Application.Exit();
		}
	}
}