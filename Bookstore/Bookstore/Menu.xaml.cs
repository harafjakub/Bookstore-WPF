using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Bookstore
{
    /// <summary>
    /// Interaction logic for Menu.xaml
    /// </summary>
    public partial class Menu : Window
    {
        public static string connectionString = "Data Source=DESKTOP-OTPQJBS;Initial Catalog=Bookstore;User ID=sa;Password=";
        public Menu()
        {
            InitializeComponent();
            if (!CheckDatabaseExists(@"Data Source=DESKTOP-OTPQJBS;User ID=sa;Password=", "Bookstore"))
            {
                infoLabel.Content = "You are not connected to the database!";
                BooksButton.IsEnabled = false;
                GamesButton.IsEnabled = false;
                OrdersButton.IsEnabled = false;
                ClientsButton.IsEnabled = false;
                ProductsButton.IsEnabled = false;
            }
        }
        public static bool CheckDatabaseExists(string connectionString, string databaseName)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                using (var command = new SqlCommand($"SELECT db_id('{databaseName}')", connection))
                {
                    connection.Open();
                    return (command.ExecuteScalar() != DBNull.Value);
                }
            }
        }

        private void Books_Click(object sender, RoutedEventArgs e)
        {
            
            BooksWindow booksWindow = new BooksWindow();
            booksWindow.Show();
            this.Close();
        }

        private void Games_Click(object sender, RoutedEventArgs e)
        { 
            GamesWindow gamesWindow = new GamesWindow();
            gamesWindow.Show();
            this.Close();
        }

        private void Products_Click(object sender, RoutedEventArgs e)
        {
            ProductsWindow productsWindow = new ProductsWindow();
            productsWindow.Show();
            this.Close();
        }

        private void Orders_Click(object sender, RoutedEventArgs e)
        {
            OrdersWindow ordersWindow = new OrdersWindow();
            ordersWindow.Show();
            this.Close();
        }

        private void Clients_Click(object sender, RoutedEventArgs e)
        {
            ClientsWindow clientsWindow = new ClientsWindow();
            clientsWindow.Show();
            this.Close();
        }
        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Application.Current.Shutdown();
        }
    }
}
