using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
    public partial class AddClientWindow : Window
    {
        public AddClientWindow()
        {
            InitializeComponent();
        }

        private void Add_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SqlConnection conn = new SqlConnection(@Menu.connectionString);
                SqlDataAdapter adapter = new SqlDataAdapter("InsertIntoClients", conn);
                conn.Open();
                adapter.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;
                adapter.SelectCommand.Parameters.Add("@Name", SqlDbType.VarChar, (50)).Value = Name.Text;
                adapter.SelectCommand.Parameters.Add("@Surname", SqlDbType.VarChar, (50)).Value = Surname.Text;
                adapter.SelectCommand.Parameters.Add("@DateOfBirth", SqlDbType.Date).Value = DateOfBirth.Text;
                adapter.SelectCommand.Parameters.Add("@Gender", SqlDbType.VarChar, (20)).Value = Gender.Text;
                adapter.SelectCommand.Parameters.Add("@PhoneNumber", SqlDbType.VarChar, (9)).Value = PhoneNumber.Text;
                adapter.SelectCommand.Parameters.Add("@Email", SqlDbType.VarChar, (50)).Value = Email.Text;
                adapter.SelectCommand.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Client added successfully!");
            }
            catch(System.Exception exception)
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
