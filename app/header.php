<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hexalab</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="icon" href="media/logo.ico" type="image/x-icon">
</head>
    <header class="site-header">
        <div class="header-inner container">
            <!-- Logo -->
            <div class="logo">
                <a href="./index.php">
                    <img src="media/logo.ico" alt="Site Logo">
                </a>
            </div>

            <!-- Search bar -->
            <form class="search-bar" role="search" aria-label="Site search">
                <input
                    type="search"
                    name="query"
                    placeholder="Search..."
                    aria-label="Search input"
                    class="search-input">
                <button type="submit" class="search-button" aria-label="Submit search">
                    <svg width="20" height="20" aria-hidden="true" viewBox="0 0 24 24">
                        <circle cx="10" cy="10" r="7" stroke="currentColor" fill="none" stroke-width="2" />
                        <line x1="15" y1="15" x2="22" y2="22" stroke="currentColor" stroke-width="2" />
                    </svg>
                </button>
            </form>

            <!-- Notification / Avatar -->
            <div class="user-widget">
                <div class="hexagon">
                    <img src="https://placehold.co/132x144" alt="User avatar">
                </div>
            </div>
        </div>
    </header>


</html>