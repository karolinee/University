using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Threading.Tasks;
using zad6Klasa;

namespace zad6Server
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Serwer");

            int port = 13000;
            TcpListener socket = new TcpListener(IPAddress.Parse("127.0.0.1"),port);
            socket.Start();
            TcpClient client = socket.AcceptTcpClient();
            NetworkStream ns = client.GetStream();

           
            BinaryFormatter bf = new BinaryFormatter();
            Class c = (Class)bf.Deserialize(ns);

            ns.Close();
            client.Close();

            Console.WriteLine("Dane zostały odebrane i zdeserializowane");

            File.WriteAllText(@"..\..\File.txt", c.ToString());
            
            Console.WriteLine("Dane zostały zapisane");

            Console.ReadKey();

        }


    }
}
