using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Threading.Tasks;
using zad6Klasa;

namespace zad6Client
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Klient");

            int port = 13000;
            TcpClient client = new TcpClient("127.0.0.1",port);

            NetworkStream ns = client.GetStream();
            

            Class c = new Class(5);
            BinaryFormatter bf = new BinaryFormatter();
            bf.Serialize(ns, c);

            ns.Flush();
            ns.Close();
            client.Close();

            Console.WriteLine("Dane zostały zserializowane i wysłane");
            Console.ReadKey();
        }
    }
}
