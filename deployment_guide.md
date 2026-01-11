# Deployment Guide: HabitShare

This guide outlines the steps to deploy the HabitShare PWA to a production environment (Shared Hosting or VPS).

## 1. Prepare Local Environment

### Build Assets

Run the production build command to generate optimized CSS and JS files.

```bash
npm run build
```

This creates a `public/build` directory.

### Export Database

1.  Open your local database manager (e.g., TablePlus, phpMyAdmin).
2.  Export the `habit_share_db` database to a `.sql` file.

## 2. Server Setup (Shared Hosting/cPanel)

### File Structure

Typically, you want to separate your Laravel core files from the public-facing files for security.

1.  **Core Files**: Create a folder named `habit-share-core` outside of `public_html` (e.g., in `/home/user/habit-share-core`).
2.  **Public Files**: usage the contents of your local `public` folder.

### Uploading Files

1.  **Upload Core**: Zip everything in your project **EXCEPT** `node_modules` and `public`. Upload and extract to `habit-share-core`.
2.  **Upload Public**: Zip the contents of your local `public` folder. Upload and extract to `public_html` (or your subdomain folder).

### Configuration (`index.php`)

Edit `public_html/index.php` to point to the correct paths:

```php
// Find these lines and update the paths
require __DIR__.'/../habit-share-core/vendor/autoload.php';
$app = require __DIR__.'/../habit-share-core/bootstrap/app.php';
```

### Environment (.env)

1.  Copy `.env.example` to `.env` in `habit-share-core`.
2.  Update settings:

    ```ini
    APP_NAME=HabitShare
    APP_ENV=production
    APP_DEBUG=false
    APP_URL=https://your-domain.com

    DB_DATABASE=your_hosting_db_name
    DB_USERNAME=your_hosting_db_user
    DB_PASSWORD=your_hosting_db_password
    ```

3.  Generate Key (if you have SSH access): `php artisan key:generate`. If not, copy the `APP_KEY` from your local `.env`.

## 3. Database Migration

1.  Create a new MySQL database on your hosting.
2.  Import the `.sql` file you exported earlier via phpMyAdmin.

## 4. HTTPS (Critical for PWA)

PWA features (Service Workers, Manifest installation) **REQUIRE** HTTPS.

1.  Ensure an SSL certificate is installed (Let's Encrypt is usually free on cPanel).
2.  Force HTTPS in `app/Providers/AppServiceProvider.php` (Optional but recommended if middleware doesn't handle it):
    ```php
    public function boot(): void
    {
        if($this->app->environment('production')) {
            \URL::forceScheme('https');
        }
    }
    ```

## 5. Storage Link

Creating the symlink for storage is essential for user uploads (if any) and logs.

- **SSH**: Run `php artisan storage:link`.
- **No SSH**: You may need a PHP script to create the symlink:
  ```php
  <?php
  symlink('/home/user/habit-share-core/storage/app/public', '/home/user/public_html/storage');
  echo "Symlink Created";
  ?>
  ```

## 6. Manifest & Icons

Ensure your `public/manifest.json` and icons (`icon-192x192.png`, etc.) are correctly uploaded to the `public_html` root so the browser can find them.
