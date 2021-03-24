using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace zad1
{
    class Program
    {
        static void Main()
        {
            string path = @"..\..\..\dane.xlsx";
            string connectionString = String.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 12.0 Xml;HDR=YES'", path);
            try
            {
                
                OleDbConnection conn = new OleDbConnection(connectionString);
                conn.Open();
                OleDbDataAdapter adapter = new OleDbDataAdapter("SELECT * FROM [studenci$]", conn);
                DataSet dataSet = new DataSet("dane");
                adapter.Fill(dataSet);

                DataTable t = dataSet.Tables[0];

                foreach(DataColumn c in t.Columns)
                {
                    Console.Write("{0,-15}", c.ColumnName);
                }
                Console.WriteLine();
                foreach (DataRow r in t.Rows)
                {
                    foreach (DataColumn c in t.Columns)
                        Console.Write("{0, -15}", r[c.ColumnName]);
                    Console.WriteLine();
                }


                conn.Close();
            }
            catch(Exception e)
            {
                Console.WriteLine(e.Message);
            }

            Console.ReadKey();
        }
    }
}
