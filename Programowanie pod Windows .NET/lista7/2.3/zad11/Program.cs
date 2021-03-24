using Microsoft.CSharp;
using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace zad11
{
    class Program
    {
        static void Main(string[] args)
        {
            StringBuilder sbCode = new StringBuilder();
            sbCode.Append("using System;\n");
            sbCode.Append("namespace zad11 { \n");
            sbCode.Append("class Fun { \n");

            Console.WriteLine("Wpisz kod funkcji (pamiętaj o public i zakończ podwójnym enterem, funckja nie może przyjmować argumetnów)");
            string input;
            while ((input = Console.ReadLine()) != "" && input != null)
            {
                sbCode.Append(input + "\n");
            }
            sbCode.Append("} \n } \n");
            
            CSharpCodeProvider codeProvider = new CSharpCodeProvider();
            ICodeCompiler icc = codeProvider.CreateCompiler();

            CompilerParameters parameters = new CompilerParameters()
            {
                GenerateExecutable = false,
                GenerateInMemory = true
            };
            

            CompilerResults results = icc.CompileAssemblyFromSource(parameters, sbCode.ToString());

            if (results.Errors.HasErrors)
            {
                StringBuilder sb = new StringBuilder();
                foreach (CompilerError ce in results.Errors)
                {
                    sb.AppendLine(String.Format("Line {0}, error numer {1}: {2}", ce.Line, ce.ErrorNumber, ce.ErrorText));
                }
                Console.WriteLine(sb.ToString());
            }
            else
            {
               try
                {
                    Assembly assembly = results.CompiledAssembly;

                    Type classType = assembly.GetType("zad11.Fun");
                    var classInstance = Activator.CreateInstance(classType);

                    Console.WriteLine("Podaj nazwę funckcji");

                    MethodInfo fun = classType.GetMethod(Console.ReadLine());
                    var output = fun.Invoke(classInstance, null);
                    
                }
                catch(Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            }

           
            Console.ReadKey();
        }
    }
}
