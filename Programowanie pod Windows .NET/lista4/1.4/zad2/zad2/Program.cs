using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad2
{
    class Program
    {
        static void Main(string[] args)
        {
            Type wordType = Type.GetTypeFromProgID("Word.Application");
            dynamic w = Activator.CreateInstance(wordType);

            //w.Visible = true;
            dynamic doc = w.Documents.Add();
            doc.Content.Text = "Programowanie pod Windows";

            string path = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            string filename = Path.Combine(path, "ppw.doc");
            doc.SaveAs2(filename);
            doc.Close();
            w.Quit();
        }
    }
}
