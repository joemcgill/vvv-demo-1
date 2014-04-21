# Init script for VVV Auto Bootstrap Demo 1

echo "Commencing [sitename] Setup"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS vvv_demo_1"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON vvv_demo_1.* TO wp@localhost IDENTIFIED BY 'wp';"

# Import the database from an sql file in the current directory
echo "Importing the database"
mysql -u root --password=root database_name < file.sql

# Download WordPress
if [ ! -d htdocs ]
then
	echo "Installing WordPress using WP CLI"
	mkdir htdocs
	cd htdocs
	wp core download --allow-root
	wp core config --dbname="vvv_demo_1" --dbuser=wp --dbpass=wp --dbhost="localhost" --allow-root
	wp core install --url=vvv-demo-1.dev --title="VVV Bootstrap Demo 1" --admin_user=admin --admin_password=password --admin_email=demo@example.com --allow-root
	cd ..
fi

# Other options would be to create htdocs folder from a project repo like:
# git clone git@github.com/joemcgill/vvv-demo-1 htdocs

# The Vagrant site setup script will restart Nginx for us
echo "[sitename] now installed";
