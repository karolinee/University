using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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

namespace zad1
{
    /// <summary>
    /// Logika interakcji dla klasy MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click_Akceptuj(object sender, RoutedEventArgs e)
        {
            string checkBoxText = "";
            if (CheckBox_Dzienne.IsChecked == true) checkBoxText += CheckBox_Dzienne.Content;
            if (CheckBox_Uzupelniajace.IsChecked == true)
            {
                checkBoxText += " ";
                checkBoxText += CheckBox_Uzupelniajace.Content;
            }
            MessageBox.Show(TextBox_Name.Text + "\n" + TextBox_Adres.Text + "\n" + ComboBox_Cykl.Text + "\n" + checkBoxText);
        }

        private void Button_Click_Anuluj(object sender, RoutedEventArgs e)
        {
            App.Current.Shutdown();
        }
    }

}
