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
    public partial class ClientsWindow : Window
    {
        BookstoreDataSet bookstoreDataSet = new BookstoreDataSet();
        BookstoreDataSetTableAdapters.ClientsTableAdapter clientsTableAdapter = new BookstoreDataSetTableAdapters.ClientsTableAdapter();
        public ClientsWindow()
        {
            InitializeComponent();
            FillClients();
        }
        public void FillClients()
        {
            clientsTableAdapter.Fill(bookstoreDataSet.Clients);
            this.DataContext = bookstoreDataSet.Clients.DefaultView;
        }
        private void Add_Click(object sender, RoutedEventArgs e)
        {
            AddClientWindow addClientWindow = new AddClientWindow();
            addClientWindow.Show();
        }
        private void Update_Click(object sender, RoutedEventArgs e)
        {
            UpdateClientWindow updateClientWindow = new UpdateClientWindow();
            updateClientWindow.Show();
        }
        private void Refresh_Click(object sender, RoutedEventArgs e)
        {
            FillClients();
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
                    SqlDataAdapter adapter = new SqlDataAdapter("DeleteClient", conn);
                    conn.Open();
                    adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    adapter.SelectCommand.Parameters.Add("@ClientID", SqlDbType.SmallInt).Value = Convert.ToInt16(content.ToString());
                    adapter.SelectCommand.ExecuteNonQuery();
                    conn.Close();
                    FillClients();
                    MessageBox.Show("Client deleted successfully!");
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
            FillClients();
        }
    }
}
