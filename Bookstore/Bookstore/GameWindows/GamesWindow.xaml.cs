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
    /// Interaction logic for GamesWindow.xaml
    /// </summary>
    public partial class GamesWindow : Window
    {
        BookstoreDataSet bookstoreDataSet = new BookstoreDataSet();
        BookstoreDataSetTableAdapters.GamesTableViewTableAdapter gamesTableViewTableAdapter = new BookstoreDataSetTableAdapters.GamesTableViewTableAdapter();

        public GamesWindow()
        {
            InitializeComponent();
            FillGames();
        }

        public void FillGames()
        {
            gamesTableViewTableAdapter.Fill(bookstoreDataSet.GamesTableView);
            this.DataContext = bookstoreDataSet.GamesTableView;
        }
        private void Add_Click(object sender, RoutedEventArgs e)
        {
            AddGameWindow addGameWindow = new AddGameWindow();
            addGameWindow.Show();
        }
        private void Update_Click(object sender, RoutedEventArgs e)
        {
            UpdateGameWindow updateGameWindow = new UpdateGameWindow();
            updateGameWindow.Show();
        }
        private void Refresh_Click(object sender, RoutedEventArgs e)
        {
            FillGames();
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
                    SqlDataAdapter adapter = new SqlDataAdapter("DeleteGame", conn);
                    conn.Open();
                    adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    adapter.SelectCommand.Parameters.Add("@ProductID", SqlDbType.SmallInt).Value = Convert.ToInt16(content.ToString());
                    adapter.SelectCommand.ExecuteNonQuery();
                    conn.Close();
                    FillGames();
                    MessageBox.Show("Game deleted successfully!");
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
            FillGames();
        }
    }
}
