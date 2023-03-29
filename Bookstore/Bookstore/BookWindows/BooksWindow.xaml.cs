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
    /// Interaction logic for BooksWindow.xaml
    /// </summary>
    public partial class BooksWindow : Window
    {
        BookstoreDataSet bookstoreDataSet = new BookstoreDataSet();
        BookstoreDataSetTableAdapters.BooksTableViewTableAdapter booksTableViewTableAdapter = new BookstoreDataSetTableAdapters.BooksTableViewTableAdapter();

        public BooksWindow()
        {
            InitializeComponent();
            FillBooks();
        }

        public void FillBooks()
        {
            booksTableViewTableAdapter.Fill(bookstoreDataSet.BooksTableView);
            this.DataContext = bookstoreDataSet.BooksTableView;
        }

        private void Add_Click(object sender, RoutedEventArgs e)
        {
            AddBookWindow addBookWindow = new AddBookWindow();
            addBookWindow.Show();
        }
        private void Update_Click(object sender, RoutedEventArgs e)
        {
            UpdateBookWindow updateBookWindow = new UpdateBookWindow();
            updateBookWindow.Show();
        }
        private void Refresh_Click(object sender, RoutedEventArgs e)
        {
            FillBooks();
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
                    SqlDataAdapter adapter = new SqlDataAdapter("DeleteBook", conn);
                    conn.Open();
                    adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    adapter.SelectCommand.Parameters.Add("@ProductID", SqlDbType.SmallInt).Value = Convert.ToInt16(content.ToString());
                    adapter.SelectCommand.ExecuteNonQuery();
                    conn.Close();
                    FillBooks();
                    MessageBox.Show("Book deleted successfully!");
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
            FillBooks();
        }
    }
}
