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
using System.Data;
using Oracle.DataAccess.Client;

namespace APOTEK
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        string lalala;
        string cs;
        OracleConnection oc;
        menu m;
        public MainWindow()
        {
            InitializeComponent();
        }

        private void login_Click(object sender, RoutedEventArgs e)
        {
            bool buka = false;
            cs = "Data Source = " + data.Text + "; User ID = " + username.Text + "; Password = " + password.Text;
            oc = new OracleConnection(cs);
            try
            {
                oc.Open();
                buka = true;
                oc.Close();
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
                oc.Close();
            }
            if (buka == true)
            {
                m = new menu(cs);
                m.ShowDialog();
            }
        }
    }
}
