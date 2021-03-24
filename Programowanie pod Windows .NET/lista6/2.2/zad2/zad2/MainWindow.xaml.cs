using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace zad2
{
    /// <summary>
    /// Logika interakcji dla klasy MainWindow.xaml
    /// </summary>
    /// 
    public delegate void ButtonToProgressBar();
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            var model = new MainWindowModel();
            this.DataContext = model;
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string buttonContent = (sender as Button).Content.ToString();
            MessageBox.Show("Naciśnięto przycisk "+ buttonContent);
        }

        public class MainWindowModel
        {
            public List<Person> People
            {
                get
                {
                    return new List<Person>()
                    {
                        new Person() { Name = "Jan", Surname = "Kowalski", Age = 20},
                        new Person() { Name = "Adam", Surname = "Mazur",  Age = 4},
                        new Person() { Name = "Damian", Surname = "Nowak", Age = 40 },
                    };
                }
            }
        }
        public class Person
        {
            public string Name { get; set; }
            public string Surname { get; set; }

            public int Age { get; set; }

        }
    }
}
