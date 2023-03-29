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
    /// Interaction logic for AddGameWindow.xaml
    /// </summary>
    public partial class AddGameWindow : Window
    {
        public AddGameWindow()
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
                SqlDataAdapter adapter = new SqlDataAdapter("InsertIntoGames", conn);
                conn.Open();
                adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                adapter.SelectCommand.Parameters.Add("@PEGI", SqlDbType.SmallInt).Value = PEGI.Text;
                adapter.SelectCommand.Parameters.Add("@Platform", SqlDbType.VarChar, (50)).Value = Platform.Text;
                adapter.SelectCommand.Parameters.Add("@DubbingLanguage", SqlDbType.Text).Value = DubbingLanguage.Text;
                adapter.SelectCommand.Parameters.Add("@SubtitleLanguage", SqlDbType.Text).Value = SubtitleLanguage.Text;
                adapter.SelectCommand.Parameters.Add("@Singleplayer", SqlDbType.VarChar, (5)).Value = Singleplayer.Text;
                adapter.SelectCommand.Parameters.Add("@Multiplayer", SqlDbType.VarChar, (5)).Value = Multiplayer.Text;
                adapter.SelectCommand.Parameters.Add("@Title", SqlDbType.VarChar, (70)).Value = Title.Text;
                adapter.SelectCommand.Parameters.Add("@Author", SqlDbType.VarChar, (70)).Value = Author.Text;
                adapter.SelectCommand.Parameters.Add("@Publisher", SqlDbType.VarChar, (70)).Value = Publisher.Text;
                adapter.SelectCommand.Parameters.Add("@Genre", SqlDbType.Text).Value = Genre.Text;
                adapter.SelectCommand.Parameters.Add("@ReleaseDate", SqlDbType.Date).Value = ReleaseDate.Text;
                adapter.SelectCommand.Parameters.Add("@AddedDate", SqlDbType.Date).Value = AddedDate.Text;
                adapter.SelectCommand.Parameters.Add("@Price", SqlDbType.Float).Value = Price.Text;
                adapter.SelectCommand.Parameters.Add("@Rating", SqlDbType.Float).Value = Rating.Text;
                adapter.SelectCommand.Parameters.Add("@SoldQuantity", SqlDbType.SmallInt).Value = SoldQuantity.Text;
                adapter.SelectCommand.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Game added successfully!");
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
