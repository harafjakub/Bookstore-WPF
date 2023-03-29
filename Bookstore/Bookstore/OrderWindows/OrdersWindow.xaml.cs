using Bookstore.BookstoreDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
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

namespace Bookstore
{
    public partial class OrdersWindow : Window
    {
        BookstoreDataSet bookstoreDataSet = new BookstoreDataSet();
        BookstoreDataSetTableAdapters.OrdersTableAdapter ordersTableAdapter = new BookstoreDataSetTableAdapters.OrdersTableAdapter();
        public OrdersWindow()
        {
            InitializeComponent();
            FillOrders();
        }

        public void FillOrders()
        {
            ordersTableAdapter.Fill(bookstoreDataSet.Orders);
            this.DataContext = bookstoreDataSet.Orders.DefaultView;
        }

        private void Add_Click(object sender, RoutedEventArgs e)
        {
            AddOrderWindow addOrderWindow = new AddOrderWindow();
            addOrderWindow.Show();
        }
        private void Update_Click(object sender, RoutedEventArgs e)
        {
            UpdateOrderWindow updateOrderWindow = new UpdateOrderWindow();
            updateOrderWindow.Show();
        }
        private void Refresh_Click(object sender, RoutedEventArgs e)
        {
            FillOrders();
        }
        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var cellInfo = dataGrid.SelectedCells[0];
                var content = (cellInfo.Column.GetCellContent(cellInfo.Item) as TextBlock).Text;
                if (content != null)
                {
                    SqlConnection conn = new SqlConnection(@Menu.connectionString);
                    SqlDataAdapter adapter = new SqlDataAdapter("DeleteOrder", conn);
                    conn.Open();
                    adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    adapter.SelectCommand.Parameters.Add("@OrderID", SqlDbType.SmallInt).Value = Convert.ToInt16(content.ToString());
                    adapter.SelectCommand.ExecuteNonQuery();
                    conn.Close();
                    FillOrders();
                    MessageBox.Show("Order deleted successfully!");
                }
            }
            catch (System.Exception exception)
            {
                MessageBox.Show(exception.Message);
            }
        }
        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            Menu menuWindow = new Menu();
            menuWindow.Show();
            this.Close();
        }
        private void Window_Activated(object sender, EventArgs e)
        {
            FillOrders();
        }
    }
}
