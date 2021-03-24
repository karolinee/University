using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Messaging;
using System.Timers;


namespace zad7
{
    class Program
    {
        static int messagesBatchSend;
        static void Main(string[] args)
        {
            messagesBatchSend = 0;
            Timer timerSender = new Timer();
            timerSender.Interval = 2000;
            timerSender.Elapsed += new ElapsedEventHandler(timerSenderMethod);
            timerSender.Enabled = true;


            Timer timerReciver = new Timer();
            timerReciver.Interval = 5000;
            timerReciver.Elapsed += new ElapsedEventHandler(timerReciverMethod);
            timerReciver.Enabled = true;
            
            Console.ReadKey();

            timerSender.Stop();
            timerReciver.Stop();

            Console.ReadKey();

        }


        static void timerSenderMethod(object sender, ElapsedEventArgs e)
        {
            sendMessages(@".\private$\TestQueue");
        }

        static void timerReciverMethod(object sender, ElapsedEventArgs e)
        {
            reciveMessages(@".\private$\TestQueue");
        }
        static void reciveMessages(string queueName)
        {
            
            MessageQueue msq = new MessageQueue(queueName);
            msq.Formatter = new XmlMessageFormatter(new Type[] { typeof(string) });
            Message[] messages = msq.GetAllMessages();
            Console.WriteLine("Otrzymano wiadomości o czasie " + DateTime.Now);
            foreach(var m in messages)
            {
                Console.WriteLine(m.Body);
            }
            msq.Purge();
        }

        static void sendMessages(string queueName)
        {
            messagesBatchSend++; 

            MessageQueue msq = null;
            if (!MessageQueue.Exists(queueName))
            {
                msq = MessageQueue.Create(queueName);
            }
            else
            {
                msq = new MessageQueue(queueName);
            }

            for(int i = 0; i < 10; ++i)
            {
                msq.Send(String.Format("Batch: {0}, Czas: {1}, wiadomość nr {2}.", messagesBatchSend, DateTime.Now.ToString(), i));
            }
            
        }
    }
}
