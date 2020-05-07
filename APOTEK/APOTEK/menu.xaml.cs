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
using System.Windows.Shapes;
using System.Data;
using Oracle.DataAccess.Client;

namespace APOTEK
{
    /// <summary>
    /// Interaction logic for menu.xaml
    /// </summary>
    public partial class menu : Window
    {
        master m;
        transaksi t;
        report r;
        public menu(string penyambung)
        {
            InitializeComponent();
        }
        string penyambung;
        private void master_Click(object sender, RoutedEventArgs e)
        {
            m = new master(penyambung);
            m.ShowDialog();
        }

        private void transaksi_Click(object sender, RoutedEventArgs e)
        {
            t = new transaksi(penyambung);
            t.ShowDialog();
        }

        private void report_Click(object sender, RoutedEventArgs e)
        {
            r = new report(penyambung);
            r.ShowDialog();
        }
    }
}
