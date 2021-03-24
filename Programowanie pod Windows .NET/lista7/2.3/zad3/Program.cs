using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Security.Cryptography;
using System.Threading;
using System.IO.Compression;
using System.Xml.Linq;

namespace zad3
{
    class Program
    {

        static void Main(string[] args)
        {
            string text = File.ReadAllText(@"..\..\TextFile.txt");
            string path = @"..\..\TextEncrypted.txt";
            using (Aes aes = Aes.Create())
            {               
                save(path, text, aes.Key, aes.IV);
                string decrypted= open(path, aes.Key, aes.IV);

                Console.WriteLine($"Tekst orygnalny: {text}");
                Console.WriteLine($"Tekst odszyfrowany: {decrypted}");
                Console.ReadKey();
            }

        }


        
        static void save(string path, string text, byte[] key, byte[] IV)
        {
            byte[] t = Encoding.ASCII.GetBytes(text);

            using (FileStream fs = File.Open(path, FileMode.OpenOrCreate))
            using (GZipStream gzs = new GZipStream(fs, CompressionMode.Compress))
            using (Aes aes = Aes.Create())
            {
                ICryptoTransform encryptor = aes.CreateEncryptor(key, IV);
                using (CryptoStream cs = new CryptoStream(gzs, encryptor, CryptoStreamMode.Write))
                {
                    cs.Write(t, 0, t.Length);
                }
            }

        }
        static string open(string path, byte[] key, byte[] IV)
        {
            string text;

            using (FileStream fs = File.Open(path, FileMode.Open))
            using (GZipStream gzs = new GZipStream(fs, CompressionMode.Decompress))
            using (Aes aes = Aes.Create())
            {
                ICryptoTransform decryptor = aes.CreateDecryptor(key, IV);
                using (CryptoStream cs = new CryptoStream(gzs, decryptor, CryptoStreamMode.Read))
                using (StreamReader sr = new StreamReader(cs))
                {                         
                    text = sr.ReadToEnd();                   
                }
            }


            return text;

        }      
    }
}
