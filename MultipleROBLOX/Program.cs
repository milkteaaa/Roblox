using System;
using System.Windows.Forms;

namespace MultipleROBLOX
{
	static class Program
	{
		[STAThread]
		static void Main()
		{
			Application.EnableVisualStyles();
			Application.SetCompatibleTextRenderingDefault(false);

			using (ProcessIcon PI = new ProcessIcon())
			{
				PI.Display();
				Application.Run();
			}
		}
	}
}
