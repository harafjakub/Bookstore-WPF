using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Bookstore
{
    /// <summary>
    /// Interaction logic for AddOrderWindow.xaml
    /// </summary>
    public partial class AddOrderWindow : Window
    {
        public AddOrderWindow()
        {
            InitializeComponent();
        }
        private void NumberValidationTextBox(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^0-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }
        private void Add_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SqlConnection conn = new SqlConnection(@Menu.connectionString);
                SqlDataAdapter adapter = new SqlDataAdapter("InsertIntoOrders", conn);
                conn.Open();
                adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                adapter.SelectCommand.Parameters.Add("@ClientID", SqlDbType.SmallInt).Value = ClientID.Text;
                adapter.SelectCommand.Parameters.Add("@ProductID", SqlDbType.SmallInt).Value = ProductID.Text;
                adapter.SelectCommand.Parameters.Add("@OrderDate", SqlDbType.Date).Value = OrderDate.Text;
                adapter.SelectCommand.Parameters.Add("@DeliveryDate", SqlDbType.Date).Value = DeliveryDate.Text;
                adapter.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar, (50)).Value = Status.Text;
                adapter.SelectCommand.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Order added successfully!");
            }
            catch (System.Exception exception)
            {
                MessageBox.Show(exception.Message);
            }
        }
        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
