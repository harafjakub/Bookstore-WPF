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
    /// <summary>
    /// Interaction logic for ProductsWindow.xaml
    /// </summary>
    public partial class ProductsWindow : Window
    {
        BookstoreDataSet bookstoreDataSet = new BookstoreDataSet();
        BookstoreDataSetTableAdapters.ProductsTableAdapter productsTableAdapter = new BookstoreDataSetTableAdapters.ProductsTableAdapter();
        public ProductsWindow()
        {
            InitializeComponent();
            FillProducts();
        }

        public void FillProducts()
        {
            productsTableAdapter.Fill(bookstoreDataSet.Products);
            this.DataContext = bookstoreDataSet.Products.DefaultView;
        }

        private void Refresh_Click(object sender, RoutedEventArgs e)
        {
            FillProducts();
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
                    SqlDataAdapter adapter = new SqlDataAdapter("DeleteProduct", conn);
                    conn.Open();
                    adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    adapter.SelectCommand.Parameters.Add("@ProductID", SqlDbType.SmallInt).Value = Convert.ToInt16(content.ToString());
                    adapter.SelectCommand.ExecuteNonQuery();
                    conn.Close();
                    FillProducts();
                    MessageBox.Show("Product deleted successfully!");
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
            menuWindow.WindowStartupLocation = System.Windows.WindowStartupLocation.CenterScreen;
            menuWindow.Show();
            this.Close();
        }
    }
}
