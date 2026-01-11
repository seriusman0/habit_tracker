# HabitShare PWA

A full-stack Progressive Web Application (PWA) for habit tracking with social features, built with Laravel 11, Inertia.js (Vue 3), and Tailwind CSS.

## Features

-   **Habit Tracking**: Create, edit, and track daily habits.
-   **Social System**: Add friends using username/email.
-   **Granular Privacy**: Share specific habits with specific friends.
-   **Social Feed**: View habits shared with you by friends.
-   **PWA Support**: Installable on mobile devices with offline capabilities.
-   **Dark Mode**: Fully supported.

## Tech Stack

-   **Backend**: Laravel 11 (PHP 8.2+)
-   **Frontend**: Vue 3 (Composition API) + Inertia.js
-   **Styling**: Tailwind CSS
-   **Database**: MySQL / SQLite
-   **Icons**: Lucide Vue

---

## Getting Started (Local Development)

### Prerequisites

-   PHP 8.2+
-   Composer
-   Node.js & NPM
-   MySQL (Optional, SQLite is configured by default)

### Installation

1.  **Clone the Repository**

    ```bash
    git clone <repository-url>
    cd habit-share
    ```

2.  **Install Dependencies**

    ```bash
    composer install
    npm install
    ```

3.  **Environment Setup**

    ```bash
    cp .env.example .env
    php artisan key:generate
    ```

    _Ensure `DB_CONNECTION=sqlite` is set in `.env` or configure MySQL credentials._

4.  **Database Setup**
    Create the sqlite file (if using sqlite):

    ```bash
    touch database/database.sqlite
    ```

    Migrate and seed test data:

    ```bash
    php artisan migrate:fresh --seed
    ```

5.  **Run the Application**
    Start the backend server:

    ```bash
    php artisan serve
    ```

    Start the frontend dev server (in a separate terminal):

    ```bash
    npm run dev
    ```

6.  **Access**
    Open [http://localhost:8000](http://localhost:8000) in your browser.

---

## Test Accounts

The database has been seeded with two linked users for testing.

### User A (Tester) - _Logged in as this user to see the full flow._

-   **Email**: `test@example.com`
-   **Password**: `password`
-   **Initial State**:
    -   Has 1 Habit: "Morning Jog".
    -   Is Friends with "Friend User".
    -   Can see "Friend User's" habit ("Read a Book") in the **Social Feed**.

### User B (Friend)

-   **Email**: `friend@example.com`
-   **Password**: `password`

## Deployment

See [Deployment Guide](deployment_guide.md) for instructions on deploying to Shared Hosting or VPS.
