using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
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
    /// Interaction logic for UpdateOrderWindow.xaml
    /// </summary>
    public partial class UpdateOrderWindow : Window
    {
        public UpdateOrderWindow()
        {
            InitializeComponent();
        }
        private void NumberValidationTextBox(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^0-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }
        private void Update_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SqlConnection conn = new SqlConnection(@Menu.connectionString);
                SqlDataAdapter adapter = new SqlDataAdapter("UpdateOrderByID", conn);
                conn.Open();
                adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                adapter.SelectCommand.Parameters.Add("@OrderID", SqlDbType.SmallInt).Value = OrderID.Text;
                adapter.SelectCommand.Parameters.Add("@ClientID", SqlDbType.SmallInt).Value = ClientID.Text;
                adapter.SelectCommand.Parameters.Add("@ProductID", SqlDbType.SmallInt).Value = ProductID.Text;
                adapter.SelectCommand.Parameters.Add("@OrderDate", SqlDbType.Date).Value = OrderDate.Text;
                adapter.SelectCommand.Parameters.Add("@DeliveryDate", SqlDbType.Date).Value = DeliveryDate.Text;
                adapter.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar, (50)).Value = Status.Text;
                adapter.SelectCommand.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Order updated successfully!");
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
