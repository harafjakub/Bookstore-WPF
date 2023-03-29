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
using System.Diagnostics;
using System.Security.Policy;

namespace Bookstore
{
    /// <summary>
    /// Interaction logic for UpdateBookWindow.xaml
    /// </summary>
    public partial class UpdateBookWindow : Window
    {
        public UpdateBookWindow()
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
                SqlDataAdapter adapter = new SqlDataAdapter("UpdateBookByProductID", conn);
                conn.Open();
                adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                adapter.SelectCommand.Parameters.Add("@ProductID", SqlDbType.SmallInt).Value = ProductID.Text;
                adapter.SelectCommand.Parameters.Add("@Title", SqlDbType.VarChar, (70)).Value = Title.Text;
                adapter.SelectCommand.Parameters.Add("@Author", SqlDbType.VarChar, (70)).Value = Author.Text;
                adapter.SelectCommand.Parameters.Add("@Publisher", SqlDbType.VarChar, (70)).Value = Publisher.Text;
                adapter.SelectCommand.Parameters.Add("@Genre", SqlDbType.Text).Value = Genre.Text;
                adapter.SelectCommand.Parameters.Add("@ReleaseDate", SqlDbType.Date).Value = ReleaseDate.Text;
                adapter.SelectCommand.Parameters.Add("@AddedDate", SqlDbType.Date).Value = AddedDate.Text;
                adapter.SelectCommand.Parameters.Add("@Price", SqlDbType.Float).Value = Price.Text;
                adapter.SelectCommand.Parameters.Add("@Rating", SqlDbType.Float).Value = Rating.Text;
                adapter.SelectCommand.Parameters.Add("@SoldQuantity", SqlDbType.SmallInt).Value = SoldQuantity.Text;
                adapter.SelectCommand.Parameters.Add("@Pages", SqlDbType.SmallInt).Value = Pages.Text;
                adapter.SelectCommand.Parameters.Add("@OriginalLanguage", SqlDbType.VarChar, (30)).Value = OriginalLanguage.Text;
                adapter.SelectCommand.Parameters.Add("@ReleaseLanguage", SqlDbType.VarChar, (30)).Value = ReleaseLanguage.Text;
                adapter.SelectCommand.Parameters.Add("@ISBN", SqlDbType.VarChar, (13)).Value = ISBN.Text;
                adapter.SelectCommand.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Book updated successfully!");
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