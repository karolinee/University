// C:\Users\karol\Documents\Programowanie pod Windows\1.1\zad6\zad6\bin\Debug\zad6.exe

.assembly extern mscorlib
{
	.publickeytoken = (
		b7 7a 5c 56 19 34 e0 89
	)
	.ver 4:0:0:0
}
.assembly zad6
{
	.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilationRelaxationsAttribute::.ctor(int32) = (
		01 00 08 00 00 00 00 00
	)
	.custom instance void [mscorlib]System.Runtime.CompilerServices.RuntimeCompatibilityAttribute::.ctor() = (
		01 00 01 00 54 02 16 57 72 61 70 4e 6f 6e 45 78
		63 65 70 74 69 6f 6e 54 68 72 6f 77 73 01
	)
	.custom instance void [mscorlib]System.Diagnostics.DebuggableAttribute::.ctor(valuetype [mscorlib]System.Diagnostics.DebuggableAttribute/DebuggingModes) = (
		01 00 07 01 00 00 00 00
	)
	.custom instance void [mscorlib]System.Reflection.AssemblyTitleAttribute::.ctor(string) = (
		01 00 04 7a 61 64 36 00 00
	)
	.custom instance void [mscorlib]System.Reflection.AssemblyDescriptionAttribute::.ctor(string) = (
		01 00 00 00 00
	)
	.custom instance void [mscorlib]System.Reflection.AssemblyConfigurationAttribute::.ctor(string) = (
		01 00 00 00 00
	)
	.custom instance void [mscorlib]System.Reflection.AssemblyCompanyAttribute::.ctor(string) = (
		01 00 00 00 00
	)
	.custom instance void [mscorlib]System.Reflection.AssemblyProductAttribute::.ctor(string) = (
		01 00 04 7a 61 64 36 00 00
	)
	.custom instance void [mscorlib]System.Reflection.AssemblyCopyrightAttribute::.ctor(string) = (
		01 00 12 43 6f 70 79 72 69 67 68 74 20 c2 a9 20
		20 32 30 32 30 00 00
	)
	.custom instance void [mscorlib]System.Reflection.AssemblyTrademarkAttribute::.ctor(string) = (
		01 00 00 00 00
	)
	.custom instance void [mscorlib]System.Runtime.InteropServices.ComVisibleAttribute::.ctor(bool) = (
		01 00 00 00 00
	)
	.custom instance void [mscorlib]System.Runtime.InteropServices.GuidAttribute::.ctor(string) = (
		01 00 24 35 38 30 35 33 33 36 65 2d 62 37 33 33
		2d 34 65 66 64 2d 61 61 61 36 2d 64 39 35 64 62
		37 63 64 36 37 33 62 00 00
	)
	.custom instance void [mscorlib]System.Reflection.AssemblyFileVersionAttribute::.ctor(string) = (
		01 00 07 31 2e 30 2e 30 2e 30 00 00
	)
	.custom instance void [mscorlib]System.Runtime.Versioning.TargetFrameworkAttribute::.ctor(string) = (
		01 00 1c 2e 4e 45 54 46 72 61 6d 65 77 6f 72 6b
		2c 56 65 72 73 69 6f 6e 3d 76 34 2e 37 2e 32 01
		00 54 0e 14 46 72 61 6d 65 77 6f 72 6b 44 69 73
		70 6c 61 79 4e 61 6d 65 14 2e 4e 45 54 20 46 72
		61 6d 65 77 6f 72 6b 20 34 2e 37 2e 32
	)
	.hash algorithm 0x00008004 // SHA1
	.ver 1:0:0:0
}

.module zad6.exe
// MVID: {09E70BDA-C5E2-42C4-8BE2-3CD4AE38C76F}
.imagebase 0x00400000
.file alignment 0x00000200
.stackreserve 0x00100000
.subsystem 0x0003 // WindowsCui
.corflags 0x00020003 // ILOnly, Requires32Bit, Prefers32Bit


.class private auto ansi '<Module>'
{
} // end of class <Module>

.class private auto ansi beforefieldinit zad6.AssigmentList
	extends [mscorlib]System.Object
{
	.custom instance void [mscorlib]System.Reflection.DefaultMemberAttribute::.ctor(string) = (
		01 00 04 49 74 65 6d 00 00
	)
	// Methods
	.method public hidebysig specialname 
		instance string get_Item (
			int32 i
		) cil managed 
	{
		// Method begins at RVA 0x2050
		// Code size 43 (0x2b)
		.maxstack 2
		.locals init (
			[0] int32,
			[1] int32,
			[2] string
		)

		IL_0000: nop
		IL_0001: ldarg.1
		IL_0002: stloc.1
		IL_0003: ldloc.1
		IL_0004: stloc.0
		IL_0005: ldloc.0
		IL_0006: ldc.i4.1
		IL_0007: beq.s IL_0011

		IL_0009: br.s IL_000b

		IL_000b: ldloc.0
		IL_000c: ldc.i4.2
		IL_000d: beq.s IL_0019

		IL_000f: br.s IL_0021

		IL_0011: ldstr "Zadanie A"
		IL_0016: stloc.2
		IL_0017: br.s IL_0029

		IL_0019: ldstr "Zadanie B"
		IL_001e: stloc.2
		IL_001f: br.s IL_0029

		IL_0021: ldstr "Zadanie X"
		IL_0026: stloc.2
		IL_0027: br.s IL_0029

		IL_0029: ldloc.2
		IL_002a: ret
	} // end of method AssigmentList::get_Item

	.method public hidebysig specialname rtspecialname 
		instance void .ctor () cil managed 
	{
		// Method begins at RVA 0x2087
		// Code size 8 (0x8)
		.maxstack 8

		IL_0000: ldarg.0
		IL_0001: call instance void [mscorlib]System.Object::.ctor()
		IL_0006: nop
		IL_0007: ret
	} // end of method AssigmentList::.ctor

	// Properties
	.property instance string Item(
		int32 i
	)
	{
		.get instance string zad6.AssigmentList::get_Item(int32)
	}

} // end of class zad6.AssigmentList

.class private auto ansi beforefieldinit zad6.Parent
	extends [mscorlib]System.Object
{
	// Methods
	.method public hidebysig 
		instance void ChildStarted () cil managed 
	{
		// Method begins at RVA 0x2090
		// Code size 13 (0xd)
		.maxstack 8

		IL_0000: nop
		IL_0001: ldstr "Rodzic zauważa że dziecko zaczęło zadanie"
		IL_0006: call void [mscorlib]System.Console::WriteLine(string)
		IL_000b: nop
		IL_000c: ret
	} // end of method Parent::ChildStarted

	.method public hidebysig 
		instance void ChildFinished () cil managed 
	{
		// Method begins at RVA 0x209e
		// Code size 13 (0xd)
		.maxstack 8

		IL_0000: nop
		IL_0001: ldstr "Rodzic zauważa że dziecko skończyło zadanie"
		IL_0006: call void [mscorlib]System.Console::WriteLine(string)
		IL_000b: nop
		IL_000c: ret
	} // end of method Parent::ChildFinished

	.method public hidebysig specialname rtspecialname 
		instance void .ctor () cil managed 
	{
		// Method begins at RVA 0x20ac
		// Code size 8 (0x8)
		.maxstack 8

		IL_0000: ldarg.0
		IL_0001: call instance void [mscorlib]System.Object::.ctor()
		IL_0006: nop
		IL_0007: ret
	} // end of method Parent::.ctor

} // end of class zad6.Parent

.class private auto ansi sealed zad6.AssigmentReaction
	extends [mscorlib]System.MulticastDelegate
{
	// Methods
	.method public hidebysig specialname rtspecialname 
		instance void .ctor (
			object 'object',
			native int 'method'
		) runtime managed 
	{
	} // end of method AssigmentReaction::.ctor

	.method public hidebysig newslot virtual 
		instance void Invoke () runtime managed 
	{
	} // end of method AssigmentReaction::Invoke

	.method public hidebysig newslot virtual 
		instance class [mscorlib]System.IAsyncResult BeginInvoke (
			class [mscorlib]System.AsyncCallback callback,
			object 'object'
		) runtime managed 
	{
	} // end of method AssigmentReaction::BeginInvoke

	.method public hidebysig newslot virtual 
		instance void EndInvoke (
			class [mscorlib]System.IAsyncResult result
		) runtime managed 
	{
	} // end of method AssigmentReaction::EndInvoke

} // end of class zad6.AssigmentReaction

.class private auto ansi beforefieldinit zad6.Program
	extends [mscorlib]System.Object
{
	// Methods
	.method private hidebysig static 
		void Main (
			string[] args
		) cil managed 
	{
		// Method begins at RVA 0x20b8
		// Code size 110 (0x6e)
		.maxstack 3
		.entrypoint
		.locals init (
			[0] class zad6.Student s,
			[1] class zad6.Parent p,
			[2] class zad6.Teacher t,
			[3] int32 i,
			[4] bool
		)

		IL_0000: nop
		IL_0001: newobj instance void zad6.Student::.ctor()
		IL_0006: stloc.0
		IL_0007: newobj instance void zad6.Parent::.ctor()
		IL_000c: stloc.1
		IL_000d: newobj instance void zad6.Teacher::.ctor()
		IL_0012: stloc.2
		IL_0013: ldloc.0
		IL_0014: ldloc.1
		IL_0015: ldftn instance void zad6.Parent::ChildStarted()
		IL_001b: newobj instance void zad6.AssigmentReaction::.ctor(object, native int)
		IL_0020: callvirt instance void zad6.Student::add_AssigmentStarted(class zad6.AssigmentReaction)
		IL_0025: nop
		IL_0026: ldloc.0
		IL_0027: ldloc.1
		IL_0028: ldftn instance void zad6.Parent::ChildFinished()
		IL_002e: newobj instance void zad6.AssigmentReaction::.ctor(object, native int)
		IL_0033: callvirt instance void zad6.Student::add_AssigmentFinished(class zad6.AssigmentReaction)
		IL_0038: nop
		IL_0039: ldloc.0
		IL_003a: ldloc.2
		IL_003b: ldftn instance void zad6.Teacher::MarkFinished()
		IL_0041: newobj instance void zad6.AssigmentReaction::.ctor(object, native int)
		IL_0046: callvirt instance void zad6.Student::add_AssigmentFinished(class zad6.AssigmentReaction)
		IL_004b: nop
		IL_004c: ldc.i4.0
		IL_004d: stloc.3
		IL_004e: br.s IL_005d
		// loop start (head: IL_005d)
			IL_0050: nop
			IL_0051: ldloc.0
			IL_0052: callvirt instance void zad6.Student::Work()
			IL_0057: nop
			IL_0058: nop
			IL_0059: ldloc.3
			IL_005a: ldc.i4.1
			IL_005b: add
			IL_005c: stloc.3

			IL_005d: ldloc.3
			IL_005e: ldc.i4.3
			IL_005f: clt
			IL_0061: stloc.s 4
			IL_0063: ldloc.s 4
			IL_0065: brtrue.s IL_0050
		// end loop

		IL_0067: call valuetype [mscorlib]System.ConsoleKeyInfo [mscorlib]System.Console::ReadKey()
		IL_006c: pop
		IL_006d: ret
	} // end of method Program::Main

	.method public hidebysig specialname rtspecialname 
		instance void .ctor () cil managed 
	{
		// Method begins at RVA 0x2132
		// Code size 8 (0x8)
		.maxstack 8

		IL_0000: ldarg.0
		IL_0001: call instance void [mscorlib]System.Object::.ctor()
		IL_0006: nop
		IL_0007: ret
	} // end of method Program::.ctor

} // end of class zad6.Program

.class private auto ansi beforefieldinit zad6.Student
	extends [mscorlib]System.Object
{
	// Fields
	.field private int32 tasktodo
	.field private initonly class zad6.AssigmentList assigments
	.field private class zad6.AssigmentReaction AssigmentStarted
	.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
		01 00 00 00
	)
	.custom instance void [mscorlib]System.Diagnostics.DebuggerBrowsableAttribute::.ctor(valuetype [mscorlib]System.Diagnostics.DebuggerBrowsableState) = (
		01 00 00 00 00 00 00 00
	)
	.field private class zad6.AssigmentReaction AssigmentInProgress
	.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
		01 00 00 00
	)
	.custom instance void [mscorlib]System.Diagnostics.DebuggerBrowsableAttribute::.ctor(valuetype [mscorlib]System.Diagnostics.DebuggerBrowsableState) = (
		01 00 00 00 00 00 00 00
	)
	.field private class zad6.AssigmentReaction AssigmentFinished
	.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
		01 00 00 00
	)
	.custom instance void [mscorlib]System.Diagnostics.DebuggerBrowsableAttribute::.ctor(valuetype [mscorlib]System.Diagnostics.DebuggerBrowsableState) = (
		01 00 00 00 00 00 00 00
	)

	// Methods
	.method public hidebysig 
		instance void Work () cil managed 
	{
		// Method begins at RVA 0x213c
		// Code size 125 (0x7d)
		.maxstack 3

		IL_0000: nop
		IL_0001: ldstr "Uczeń rozpoczął zadanie "
		IL_0006: ldarg.0
		IL_0007: ldfld class zad6.AssigmentList zad6.Student::assigments
		IL_000c: ldarg.0
		IL_000d: ldfld int32 zad6.Student::tasktodo
		IL_0012: callvirt instance string zad6.AssigmentList::get_Item(int32)
		IL_0017: call string [mscorlib]System.String::Concat(string, string)
		IL_001c: call void [mscorlib]System.Console::WriteLine(string)
		IL_0021: nop
		IL_0022: ldarg.0
		IL_0023: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentStarted
		IL_0028: dup
		IL_0029: brtrue.s IL_002e

		IL_002b: pop
		IL_002c: br.s IL_0034

		IL_002e: callvirt instance void zad6.AssigmentReaction::Invoke()
		IL_0033: nop

		IL_0034: ldstr "Uczeń pracuje"
		IL_0039: call void [mscorlib]System.Console::WriteLine(string)
		IL_003e: nop
		IL_003f: ldarg.0
		IL_0040: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentInProgress
		IL_0045: dup
		IL_0046: brtrue.s IL_004b

		IL_0048: pop
		IL_0049: br.s IL_0051

		IL_004b: callvirt instance void zad6.AssigmentReaction::Invoke()
		IL_0050: nop

		IL_0051: ldstr "Uczen skończył pracę"
		IL_0056: call void [mscorlib]System.Console::WriteLine(string)
		IL_005b: nop
		IL_005c: ldarg.0
		IL_005d: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentFinished
		IL_0062: dup
		IL_0063: brtrue.s IL_0068

		IL_0065: pop
		IL_0066: br.s IL_006e

		IL_0068: callvirt instance void zad6.AssigmentReaction::Invoke()
		IL_006d: nop

		IL_006e: ldarg.0
		IL_006f: ldarg.0
		IL_0070: ldfld int32 zad6.Student::tasktodo
		IL_0075: ldc.i4.1
		IL_0076: add
		IL_0077: stfld int32 zad6.Student::tasktodo
		IL_007c: ret
	} // end of method Student::Work

	.method public hidebysig specialname 
		instance void add_AssigmentStarted (
			class zad6.AssigmentReaction 'value'
		) cil managed 
	{
		.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x21c8
		// Code size 41 (0x29)
		.maxstack 3
		.locals init (
			[0] class zad6.AssigmentReaction,
			[1] class zad6.AssigmentReaction,
			[2] class zad6.AssigmentReaction
		)

		IL_0000: ldarg.0
		IL_0001: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentStarted
		IL_0006: stloc.0
		// loop start (head: IL_0007)
			IL_0007: ldloc.0
			IL_0008: stloc.1
			IL_0009: ldloc.1
			IL_000a: ldarg.1
			IL_000b: call class [mscorlib]System.Delegate [mscorlib]System.Delegate::Combine(class [mscorlib]System.Delegate, class [mscorlib]System.Delegate)
			IL_0010: castclass zad6.AssigmentReaction
			IL_0015: stloc.2
			IL_0016: ldarg.0
			IL_0017: ldflda class zad6.AssigmentReaction zad6.Student::AssigmentStarted
			IL_001c: ldloc.2
			IL_001d: ldloc.1
			IL_001e: call !!0 [mscorlib]System.Threading.Interlocked::CompareExchange<class zad6.AssigmentReaction>(!!0&, !!0, !!0)
			IL_0023: stloc.0
			IL_0024: ldloc.0
			IL_0025: ldloc.1
			IL_0026: bne.un.s IL_0007
		// end loop
		IL_0028: ret
	} // end of method Student::add_AssigmentStarted

	.method public hidebysig specialname 
		instance void remove_AssigmentStarted (
			class zad6.AssigmentReaction 'value'
		) cil managed 
	{
		.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x2200
		// Code size 41 (0x29)
		.maxstack 3
		.locals init (
			[0] class zad6.AssigmentReaction,
			[1] class zad6.AssigmentReaction,
			[2] class zad6.AssigmentReaction
		)

		IL_0000: ldarg.0
		IL_0001: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentStarted
		IL_0006: stloc.0
		// loop start (head: IL_0007)
			IL_0007: ldloc.0
			IL_0008: stloc.1
			IL_0009: ldloc.1
			IL_000a: ldarg.1
			IL_000b: call class [mscorlib]System.Delegate [mscorlib]System.Delegate::Remove(class [mscorlib]System.Delegate, class [mscorlib]System.Delegate)
			IL_0010: castclass zad6.AssigmentReaction
			IL_0015: stloc.2
			IL_0016: ldarg.0
			IL_0017: ldflda class zad6.AssigmentReaction zad6.Student::AssigmentStarted
			IL_001c: ldloc.2
			IL_001d: ldloc.1
			IL_001e: call !!0 [mscorlib]System.Threading.Interlocked::CompareExchange<class zad6.AssigmentReaction>(!!0&, !!0, !!0)
			IL_0023: stloc.0
			IL_0024: ldloc.0
			IL_0025: ldloc.1
			IL_0026: bne.un.s IL_0007
		// end loop
		IL_0028: ret
	} // end of method Student::remove_AssigmentStarted

	.method public hidebysig specialname 
		instance void add_AssigmentInProgress (
			class zad6.AssigmentReaction 'value'
		) cil managed 
	{
		.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x2238
		// Code size 41 (0x29)
		.maxstack 3
		.locals init (
			[0] class zad6.AssigmentReaction,
			[1] class zad6.AssigmentReaction,
			[2] class zad6.AssigmentReaction
		)

		IL_0000: ldarg.0
		IL_0001: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentInProgress
		IL_0006: stloc.0
		// loop start (head: IL_0007)
			IL_0007: ldloc.0
			IL_0008: stloc.1
			IL_0009: ldloc.1
			IL_000a: ldarg.1
			IL_000b: call class [mscorlib]System.Delegate [mscorlib]System.Delegate::Combine(class [mscorlib]System.Delegate, class [mscorlib]System.Delegate)
			IL_0010: castclass zad6.AssigmentReaction
			IL_0015: stloc.2
			IL_0016: ldarg.0
			IL_0017: ldflda class zad6.AssigmentReaction zad6.Student::AssigmentInProgress
			IL_001c: ldloc.2
			IL_001d: ldloc.1
			IL_001e: call !!0 [mscorlib]System.Threading.Interlocked::CompareExchange<class zad6.AssigmentReaction>(!!0&, !!0, !!0)
			IL_0023: stloc.0
			IL_0024: ldloc.0
			IL_0025: ldloc.1
			IL_0026: bne.un.s IL_0007
		// end loop
		IL_0028: ret
	} // end of method Student::add_AssigmentInProgress

	.method public hidebysig specialname 
		instance void remove_AssigmentInProgress (
			class zad6.AssigmentReaction 'value'
		) cil managed 
	{
		.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x2270
		// Code size 41 (0x29)
		.maxstack 3
		.locals init (
			[0] class zad6.AssigmentReaction,
			[1] class zad6.AssigmentReaction,
			[2] class zad6.AssigmentReaction
		)

		IL_0000: ldarg.0
		IL_0001: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentInProgress
		IL_0006: stloc.0
		// loop start (head: IL_0007)
			IL_0007: ldloc.0
			IL_0008: stloc.1
			IL_0009: ldloc.1
			IL_000a: ldarg.1
			IL_000b: call class [mscorlib]System.Delegate [mscorlib]System.Delegate::Remove(class [mscorlib]System.Delegate, class [mscorlib]System.Delegate)
			IL_0010: castclass zad6.AssigmentReaction
			IL_0015: stloc.2
			IL_0016: ldarg.0
			IL_0017: ldflda class zad6.AssigmentReaction zad6.Student::AssigmentInProgress
			IL_001c: ldloc.2
			IL_001d: ldloc.1
			IL_001e: call !!0 [mscorlib]System.Threading.Interlocked::CompareExchange<class zad6.AssigmentReaction>(!!0&, !!0, !!0)
			IL_0023: stloc.0
			IL_0024: ldloc.0
			IL_0025: ldloc.1
			IL_0026: bne.un.s IL_0007
		// end loop
		IL_0028: ret
	} // end of method Student::remove_AssigmentInProgress

	.method public hidebysig specialname 
		instance void add_AssigmentFinished (
			class zad6.AssigmentReaction 'value'
		) cil managed 
	{
		.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x22a8
		// Code size 41 (0x29)
		.maxstack 3
		.locals init (
			[0] class zad6.AssigmentReaction,
			[1] class zad6.AssigmentReaction,
			[2] class zad6.AssigmentReaction
		)

		IL_0000: ldarg.0
		IL_0001: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentFinished
		IL_0006: stloc.0
		// loop start (head: IL_0007)
			IL_0007: ldloc.0
			IL_0008: stloc.1
			IL_0009: ldloc.1
			IL_000a: ldarg.1
			IL_000b: call class [mscorlib]System.Delegate [mscorlib]System.Delegate::Combine(class [mscorlib]System.Delegate, class [mscorlib]System.Delegate)
			IL_0010: castclass zad6.AssigmentReaction
			IL_0015: stloc.2
			IL_0016: ldarg.0
			IL_0017: ldflda class zad6.AssigmentReaction zad6.Student::AssigmentFinished
			IL_001c: ldloc.2
			IL_001d: ldloc.1
			IL_001e: call !!0 [mscorlib]System.Threading.Interlocked::CompareExchange<class zad6.AssigmentReaction>(!!0&, !!0, !!0)
			IL_0023: stloc.0
			IL_0024: ldloc.0
			IL_0025: ldloc.1
			IL_0026: bne.un.s IL_0007
		// end loop
		IL_0028: ret
	} // end of method Student::add_AssigmentFinished

	.method public hidebysig specialname 
		instance void remove_AssigmentFinished (
			class zad6.AssigmentReaction 'value'
		) cil managed 
	{
		.custom instance void [mscorlib]System.Runtime.CompilerServices.CompilerGeneratedAttribute::.ctor() = (
			01 00 00 00
		)
		// Method begins at RVA 0x22e0
		// Code size 41 (0x29)
		.maxstack 3
		.locals init (
			[0] class zad6.AssigmentReaction,
			[1] class zad6.AssigmentReaction,
			[2] class zad6.AssigmentReaction
		)

		IL_0000: ldarg.0
		IL_0001: ldfld class zad6.AssigmentReaction zad6.Student::AssigmentFinished
		IL_0006: stloc.0
		// loop start (head: IL_0007)
			IL_0007: ldloc.0
			IL_0008: stloc.1
			IL_0009: ldloc.1
			IL_000a: ldarg.1
			IL_000b: call class [mscorlib]System.Delegate [mscorlib]System.Delegate::Remove(class [mscorlib]System.Delegate, class [mscorlib]System.Delegate)
			IL_0010: castclass zad6.AssigmentReaction
			IL_0015: stloc.2
			IL_0016: ldarg.0
			IL_0017: ldflda class zad6.AssigmentReaction zad6.Student::AssigmentFinished
			IL_001c: ldloc.2
			IL_001d: ldloc.1
			IL_001e: call !!0 [mscorlib]System.Threading.Interlocked::CompareExchange<class zad6.AssigmentReaction>(!!0&, !!0, !!0)
			IL_0023: stloc.0
			IL_0024: ldloc.0
			IL_0025: ldloc.1
			IL_0026: bne.un.s IL_0007
		// end loop
		IL_0028: ret
	} // end of method Student::remove_AssigmentFinished

	.method public hidebysig specialname rtspecialname 
		instance void .ctor () cil managed 
	{
		// Method begins at RVA 0x2315
		// Code size 26 (0x1a)
		.maxstack 8

		IL_0000: ldarg.0
		IL_0001: ldc.i4.1
		IL_0002: stfld int32 zad6.Student::tasktodo
		IL_0007: ldarg.0
		IL_0008: newobj instance void zad6.AssigmentList::.ctor()
		IL_000d: stfld class zad6.AssigmentList zad6.Student::assigments
		IL_0012: ldarg.0
		IL_0013: call instance void [mscorlib]System.Object::.ctor()
		IL_0018: nop
		IL_0019: ret
	} // end of method Student::.ctor

	// Events
	.event zad6.AssigmentReaction AssigmentStarted
	{
		.addon instance void zad6.Student::add_AssigmentStarted(class zad6.AssigmentReaction)
		.removeon instance void zad6.Student::remove_AssigmentStarted(class zad6.AssigmentReaction)
	}

	.event zad6.AssigmentReaction AssigmentInProgress
	{
		.addon instance void zad6.Student::add_AssigmentInProgress(class zad6.AssigmentReaction)
		.removeon instance void zad6.Student::remove_AssigmentInProgress(class zad6.AssigmentReaction)
	}

	.event zad6.AssigmentReaction AssigmentFinished
	{
		.addon instance void zad6.Student::add_AssigmentFinished(class zad6.AssigmentReaction)
		.removeon instance void zad6.Student::remove_AssigmentFinished(class zad6.AssigmentReaction)
	}


} // end of class zad6.Student

.class private auto ansi beforefieldinit zad6.Teacher
	extends [mscorlib]System.Object
{
	// Fields
	.field private static class [mscorlib]System.Random rnd

	// Methods
	.method public hidebysig 
		instance void MarkFinished () cil managed 
	{
		// Method begins at RVA 0x2330
		// Code size 38 (0x26)
		.maxstack 3
		.locals init (
			[0] int32 mark
		)

		IL_0000: nop
		IL_0001: ldsfld class [mscorlib]System.Random zad6.Teacher::rnd
		IL_0006: ldc.i4.1
		IL_0007: ldc.i4.6
		IL_0008: callvirt instance int32 [mscorlib]System.Random::Next(int32, int32)
		IL_000d: stloc.0
		IL_000e: ldstr "Nauczyciel ocenil pracę na "
		IL_0013: ldloca.s 0
		IL_0015: call instance string [mscorlib]System.Int32::ToString()
		IL_001a: call string [mscorlib]System.String::Concat(string, string)
		IL_001f: call void [mscorlib]System.Console::WriteLine(string)
		IL_0024: nop
		IL_0025: ret
	} // end of method Teacher::MarkFinished

	.method public hidebysig specialname rtspecialname 
		instance void .ctor () cil managed 
	{
		// Method begins at RVA 0x2362
		// Code size 8 (0x8)
		.maxstack 8

		IL_0000: ldarg.0
		IL_0001: call instance void [mscorlib]System.Object::.ctor()
		IL_0006: nop
		IL_0007: ret
	} // end of method Teacher::.ctor

	.method private hidebysig specialname rtspecialname static 
		void .cctor () cil managed 
	{
		// Method begins at RVA 0x236b
		// Code size 11 (0xb)
		.maxstack 8

		IL_0000: newobj instance void [mscorlib]System.Random::.ctor()
		IL_0005: stsfld class [mscorlib]System.Random zad6.Teacher::rnd
		IL_000a: ret
	} // end of method Teacher::.cctor

} // end of class zad6.Teacher

