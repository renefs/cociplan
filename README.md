# Cociplan

A web application to manage recipes, products, and automatically generate weekly lunch/dinner menus.

![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg)
![Python](https://img.shields.io/badge/python-3.10+-blue.svg)
![Django](https://img.shields.io/badge/django-4.2-green.svg)
![React](https://img.shields.io/badge/react-18-blue.svg)

## Features

- **Recipe Management**: Create, edit, and organize recipes with ingredients, instructions, difficulty levels, and preparation times
- **Product Catalog**: Maintain a catalog of products/ingredients used in recipes
- **Weekly Menu Generation**: Automatically generate balanced weekly menus for lunch and dinner
- **Daily Menu Planning**: Plan meals for each day with lunch and dinner options
- **Side Dishes**: Associate side dishes with main recipes
- **Seasonal Recipes**: Tag recipes by season (spring, summer, autumn, winter)
- **Recipe Types**: Categorize recipes (meat, fish, vegetables, legumes, pasta, rice, etc.)
- **Meal Temperature**: Classify recipes as warm or cold meals
- **OpenAI Integration**: AI-powered menu generation suggestions
- **Multi-language Support**: Available in English and Spanish
- **Responsive UI**: Modern interface built with Mantine UI components
- **API Documentation**: Swagger/OpenAPI documentation

## Tech Stack

### Backend

- **Python 3.10+**
- **Django 4.2** - Web framework
- **Django REST Framework** - API development
- **Poetry** - Dependency management
- **MariaDB/MySQL/SQLite** - Database options
- **Gunicorn** - WSGI HTTP Server
- **Sentry** - Error tracking

### Frontend

- **React 18** - UI library
- **TypeScript** - Type safety
- **Vite** - Build tool
- **Mantine 7** - UI component library
- **React Query** - Server state management
- **React Router 6** - Routing
- **i18next** - Internationalization
- **Axios** - HTTP client
- **TipTap** - Rich text editor
- **Chart.js** - Data visualization

### DevOps

- **Docker & Docker Compose** - Containerization
- **Nginx** - Reverse proxy
- **GitHub Actions** - CI/CD (optional)

## Prerequisites

- Python 3.10 or higher
- Node.js 22 or higher
- Poetry (Python package manager)
- Docker & Docker Compose (for production deployment)

## Getting Started

### Development Setup

#### Backend

1. Clone the repository:

   ```bash
   git clone https://github.com/renefs/cociplan.git
   cd cociplan
   ```

2. Install Python dependencies:

   ```bash
   poetry install
   ```

3. Create environment configuration:

   ```bash
   cp .env.ci.sample .env
   # Edit .env with your settings
   ```

4. Run database migrations:

   ```bash
   cd backend
   poetry run python manage.py migrate
   ```

5. Create a superuser (optional):

   ```bash
   poetry run python manage.py createsuperuser
   ```

6. Start the development server:
   ```bash
   poetry run python manage.py runserver
   ```

The backend API will be available at `http://localhost:8000`.

#### Frontend

1. Navigate to the client directory:

   ```bash
   cd client
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Create environment configuration:

   ```bash
   cp .env.local.example .env.local
   # Edit .env.local with your settings
   ```

4. Start the development server:
   ```bash
   npm start
   ```

The frontend will be available at `http://localhost:5173`.

### Production Deployment (Docker)

1. Create production environment file:

   ```bash
   cp .env.ci.sample .env.prod
   # Edit .env.prod with production settings
   ```

2. Build and start containers:

   ```bash
   docker-compose up -d --build
   ```

3. Run migrations:
   ```bash
   docker-compose exec backend python manage.py migrate
   ```

The application will be available at `http://localhost:8080`.

## Environment Variables

| Variable               | Description                                     | Default                 |
| ---------------------- | ----------------------------------------------- | ----------------------- |
| `DEBUG`                | Enable debug mode                               | `false`                 |
| `SECRET_KEY`           | Django secret key                               | _required_              |
| `ALLOWED_HOSTS`        | Comma-separated list of allowed hosts           | `localhost,127.0.0.1`   |
| `DATABASE_TYPE`        | Database type (`sqlite`, `mysql`, `postgresql`) | `sqlite`                |
| `DATABASE_SQLITE_PATH` | Path to SQLite database file                    | `./data/db.sqlite3`     |
| `MEDIA_ROOT`           | Path to uploaded media files                    | `./media/`              |
| `TIME_ZONE`            | Application timezone                            | `UTC`                   |
| `ENABLE_SENTRY`        | Enable Sentry error tracking                    | `false`                 |
| `SENTRY_DSN`           | Sentry DSN for error tracking                   | -                       |
| `CORS_ALLOWED_ORIGINS` | Allowed CORS origins                            | `http://localhost:3000` |
| `OPENAI_API_KEY`       | OpenAI API key for AI features                  | -                       |
| `PAGE_SIZE`            | API pagination size                             | `5` (dev) / `20` (prod) |

## API Documentation

Once the backend is running, API documentation is available at:

- **Swagger UI**: `http://localhost:8000/swagger/`
- **ReDoc**: `http://localhost:8000/redoc/`
- **OpenAPI Schema**: `http://localhost:8000/swagger.json`

## Project Structure

```
cociplan/
├── backend/                 # Django backend
│   ├── cociplan/           # Main Django project
│   ├── menus/              # Menus app (recipes, products, menus)
│   ├── initialize_data/    # Data initialization utilities
│   └── config/             # Configuration files
├── client/                  # React frontend
│   ├── src/
│   │   ├── api/           # API client
│   │   ├── components/    # Reusable components
│   │   ├── pages/         # Page components
│   │   ├── hooks/         # Custom hooks
│   │   ├── locales/       # i18n translations
│   │   └── types/         # TypeScript types
│   └── public/            # Static assets
├── data/                    # SQLite database (development)
├── media/                   # User uploaded files
├── nginx/                   # Nginx configuration
├── docker-compose.yml       # Docker Compose configuration
├── Dockerfile              # Backend Dockerfile
└── docker.client.Dockerfile # Frontend Dockerfile
```

## Development

### Running Tests

**Backend:**

```bash
cd backend
poetry run pytest
```

**Frontend:**

```bash
cd client
npm test
```

### Code Quality

**Backend:**

```bash
# Linting
poetry run flake8

# Type checking
poetry run mypy .

# Formatting
poetry run black .
poetry run isort .
```

**Frontend:**

```bash
# Linting
npm run lint

# Formatting
npm run prettier:fix
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Author

**Rene Fernandez** - [renefernandez@duck.com](mailto:renefernandez@duck.com)
