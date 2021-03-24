
// C:\Users\karol\Documents\Programowanie pod Windows\1.1\zad6\zad6.exe
// zad6, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// Global type: <Module>
// Entry point: zad6.Program.Main
// Architecture: AnyCPU (32-bit preferred)
// Runtime: v4.0.30319
// Hash algorithm: SHA1

using System;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Versioning;

[assembly: CompilationRelaxations(8)]
[assembly: TargetFramework(".NETFramework,Version=v4.7.2", FrameworkDisplayName = ".NET Framework 4.7.2")]
[assembly: RuntimeCompatibility(WrapNonExceptionThrows = true)]
[assembly: Debuggable(DebuggableAttribute.DebuggingModes.Default | DebuggableAttribute.DebuggingModes.DisableOptimizations | DebuggableAttribute.DebuggingModes.IgnoreSymbolStoreSequencePoints | DebuggableAttribute.DebuggingModes.EnableEditAndContinue)]
[assembly: AssemblyTitle("zad6")]
[assembly: AssemblyDescription("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("")]
[assembly: AssemblyProduct("zad6")]
[assembly: AssemblyCopyright("Copyright ©  2020")]
[assembly: AssemblyTrademark("")]
[assembly: ComVisible(false)]
[assembly: Guid("5805336e-b733-4efd-aaa6-d95db7cd673b")]
[assembly: AssemblyFileVersion("1.0.0.0")]
[assembly: AssemblyVersion("1.0.0.0")]
namespace zad6
{
	internal class AssigmentList
	{
		public string this[int i]
		{
			get
			{
				switch (i)
				{
				case 1:
					return "Zadanie A";
				case 2:
					return "Zadanie B";
				default:
					return "Zadanie X";
				}
			}
		}
	}
	internal class Parent
	{
		public void ChildStarted()
		{
			Console.WriteLine("Rodzic zauwaĹĽa ĹĽe dziecko zaczÄ™Ĺ‚o zadanie");
		}

		public void ChildFinished()
		{
			Console.WriteLine("Rodzic zauwaĹĽa ĹĽe dziecko skoĹ„czyĹ‚o zadanie");
		}
	}
	internal delegate void AssigmentReaction();
	internal class Program
	{
		private static void Main(string[] args)
		{
			Student student = new Student();
			Parent @object = new Parent();
			Teacher object2 = new Teacher();
			student.AssigmentStarted += @object.ChildStarted;
			student.AssigmentFinished += @object.ChildFinished;
			student.AssigmentFinished += object2.MarkFinished;
			for (int i = 0; i < 3; i++)
			{
				student.Work();
			}
			Console.ReadKey();
		}
	}
	internal class Student
	{
		private int tasktodo = 1;

		private readonly AssigmentList assigments = new AssigmentList();

		public event AssigmentReaction AssigmentStarted;

		public event AssigmentReaction AssigmentInProgress;

		public event AssigmentReaction AssigmentFinished;

		public void Work()
		{
			Console.WriteLine("UczeĹ„ rozpoczÄ…Ĺ‚ zadanie " + assigments[tasktodo]);
			this.AssigmentStarted?.Invoke();
			Console.WriteLine("UczeĹ„ pracuje");
			this.AssigmentInProgress?.Invoke();
			Console.WriteLine("Uczen skoĹ„czyĹ‚ pracÄ™");
			this.AssigmentFinished?.Invoke();
			tasktodo++;
		}
	}
	internal class Teacher
	{
		private static Random rnd = new Random();

		public void MarkFinished()
		{
			Console.WriteLine("Nauczyciel ocenil pracÄ™ na " + rnd.Next(1, 6).ToString());
		}
	}
}
