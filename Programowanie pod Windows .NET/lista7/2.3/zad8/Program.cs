using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;
using System.Data;

namespace zad8
{
    class Program
    {
        static void Main(string[] args)
        {
            //tekst w konsoli wyświelta się poprawnie przy użyciu czcionnki Courier New
            Console.OutputEncoding = System.Text.Encoding.UTF8;
            List<CultureInfo> languages = new List<CultureInfo>
            {
                new CultureInfo("en-US"),
                new CultureInfo("de-DE"),
                new CultureInfo("fr-FR"),
                new CultureInfo("ru-RU"),
                new CultureInfo("ar-SA"),
                new CultureInfo("cs-CZ"),
                new CultureInfo("pl-PL")
            };

            DateTime now = DateTime.Now;

            foreach(var lang in languages)
            {
                Console.WriteLine(lang.Name);
                var months = lang.DateTimeFormat.MonthNames.Zip(lang.DateTimeFormat.AbbreviatedMonthNames, (l, s) => new { Long = l, Short = s });
                foreach (var month in months)
                    Console.WriteLine(month.Long + " " + month.Short);

                var days = lang.DateTimeFormat.DayNames.Zip(lang.DateTimeFormat.AbbreviatedDayNames, (l, s) => new { Long = l, Short = s });
                foreach (var day in days)
                    Console.WriteLine(day.Long + " " + day.Short);

                Console.WriteLine(now.ToString(lang));
                Console.WriteLine();

            }
            Console.ReadKey();
        }
    }
}
