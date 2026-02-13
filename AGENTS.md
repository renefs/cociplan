# AI Agent Instructions for Cociplan

This document provides context and guidelines for AI coding assistants working on the Cociplan project.

## Project Overview

**Cociplan** is a web application for managing recipes, products, and automatically generating weekly lunch/dinner menus. It consists of:

- **Backend**: Django 4.2 REST API
- **Frontend**: React 18 + TypeScript + Vite

## Tech Stack

### Backend

| Technology            | Version | Purpose              |
| --------------------- | ------- | -------------------- |
| Python                | 3.10+   | Runtime              |
| Django                | 4.2     | Web framework        |
| Django REST Framework | 3.14    | API development      |
| uv                    | latest  | Package management   |
| drf-yasg              | 1.21+   | OpenAPI/Swagger docs |
| Pillow                | 9.5     | Image processing     |
| OpenAI                | 1.35+   | AI menu generation   |

### Frontend

| Technology  | Version | Purpose              |
| ----------- | ------- | -------------------- |
| React       | 18      | UI library           |
| TypeScript  | latest  | Type safety          |
| Vite        | latest  | Build tool           |
| Mantine     | 7       | UI components        |
| React Query | latest  | Server state         |
| Axios       | latest  | HTTP client          |
| TipTap      | 2.0+    | Rich text editor     |
| i18next     | latest  | Internationalization |

## Project Structure

```
cociplan/
├── backend/                    # Django backend
│   ├── cociplan/              # Django project settings
│   │   ├── settings.py        # Main configuration
│   │   └── urls.py            # Root URL routing
│   ├── menus/                 # Main app
│   │   ├── models/            # Database models
│   │   │   ├── recipes.py     # Recipe, RecipeType, MealType
│   │   │   ├── products.py    # Product model
│   │   │   ├── ingredients.py # Ingredient model
│   │   │   ├── daily_menus.py # DailyMenu model
│   │   │   └── weekly_menus.py# WeeklyMenu model
│   │   ├── serializers/       # DRF serializers
│   │   ├── views.py           # API ViewSets
│   │   ├── urls.py            # API routes
│   │   └── utils/             # Helper functions
│   ├── initialize_data/       # Data seeding utilities
│   └── manage.py              # Django CLI
├── client/                     # React frontend
│   ├── src/
│   │   ├── api/               # API client (Axios)
│   │   ├── components/        # Reusable UI components
│   │   ├── pages/             # Page components
│   │   │   ├── recipes/       # Recipe CRUD pages
│   │   │   ├── products/      # Product pages
│   │   │   ├── menus/         # Menu management
│   │   │   └── home/          # Dashboard
│   │   ├── hooks/             # Custom React hooks
│   │   │   ├── recipes/       # Recipe-related hooks
│   │   │   ├── products/      # Product hooks
│   │   │   ├── daily-menus/   # Daily menu hooks
│   │   │   └── weekly-menus/  # Weekly menu hooks
│   │   ├── types/             # TypeScript definitions
│   │   ├── locales/           # i18n translations (en, es)
│   │   └── utils/             # Helper utilities
│   ├── package.json
│   └── vite.config.ts
├── pyproject.toml              # Python dependencies (uv)
├── uv.lock                     # Lockfile
├── docker-compose.yml          # Container orchestration
├── Dockerfile                  # Backend container
└── docker.client.Dockerfile    # Frontend container
```

## Domain Models

### Recipe

The core entity with these key fields:

```python
- name: str (unique)
- meal: MealType (LUNCH, DINNER, BOTH)
- meal_temp: MealTempType (WARM, COLD)
- type: RecipeType (MEAT_SASUAGE, FISH, VEGETABLES, LEGUMES, EGGS, PASTA, RICE, etc.)
- difficulty: Decimal (1-5)
- preference: Decimal (1-5)
- preparation_time: int (minutes)
- servings: int
- is_oven_recipe: bool
- is_side_plate: bool
- days_of_week: DaysOfWeekType (WEEK_DAYS, WEEKENDS, ALL)
- season_spring/summer/autumn/winter: bool
- notes: JSONField (TipTap content)
- instructions: JSONField (TipTap content)
- sides: ManyToMany (self-referential)
```

### Product

Ingredients/products used in recipes.

### Ingredient

Links products to recipes with quantities.

### DailyMenu

A single day's meal plan with lunch and dinner recipes.

### WeeklyMenu

Collection of 7 DailyMenus with a start date.

## API Endpoints

Base URL: `/api/v1/`

| Endpoint              | Methods | Description        |
| --------------------- | ------- | ------------------ |
| `/products/`          | CRUD    | Product management |
| `/products-no-limit/` | GET     | No pagination      |
| `/ingredients/`       | CRUD    | Ingredients        |
| `/recipes/`           | CRUD    | Recipe management  |
| `/recipes-no-limit/`  | GET     | No pagination      |
| `/recipes-images/`    | CRUD    | Recipe images      |
| `/sides-no-limit/`    | GET     | Side dishes        |
| `/daily-menus/`       | CRUD    | Daily menus        |
| `/weekly-menus/`      | CRUD    | Weekly menus       |

API docs available at:

- Swagger UI: `/swagger/`
- ReDoc: `/redoc/`

## Development Commands

### Backend

```bash
# Install dependencies
uv sync

# Run migrations
uv run python backend/manage.py migrate

# Start dev server
uv run python backend/manage.py runserver

# Run tests
uv run python backend/manage.py test

# Linting & formatting
uv run flake8
uv run black .
uv run isort .
uv run mypy .
```

### Frontend

```bash
cd client

# Install dependencies
npm install

# Start dev server
npm start

# Run tests
npm test

# Linting
npm run lint
```

## Code Conventions

### Backend (Python/Django)

1. **Models**: Use type hints for model fields
2. **Serializers**: Follow DRF conventions, use `djangorestframework-camel-case` for automatic case conversion
3. **Views**: Use ViewSets with DefaultRouter
4. **Formatting**: Black (line length default), isort for imports
5. **Type checking**: mypy with django-stubs

### Frontend (TypeScript/React)

1. **Components**: Functional components with hooks
2. **State**: React Query for server state
3. **Forms**: Mantine form components
4. **Styling**: Mantine UI components (avoid custom CSS when possible)
5. **API calls**: Use hooks from `src/hooks/` that wrap React Query
6. **Types**: Define in `src/types/` with `.d.ts` extensions
7. **Localization**: All user-facing strings via i18next

### Naming Conventions

| Context               | Convention  | Example          |
| --------------------- | ----------- | ---------------- |
| Python files          | snake_case  | `daily_menus.py` |
| Python classes        | PascalCase  | `RecipeType`     |
| Python variables      | snake_case  | `meal_temp`      |
| TypeScript files      | kebab-case  | `daily-menus.ts` |
| React components      | PascalCase  | `RecipeForm.tsx` |
| TypeScript interfaces | IPascalCase | `IRecipe`        |
| API fields (backend)  | snake_case  | `meal_temp`      |
| API fields (frontend) | camelCase   | `mealTemp`       |

Note: The `djangorestframework-camel-case` middleware automatically converts between snake_case (backend) and camelCase (frontend).

## Git Workflow

- Use **git flow** branching strategy
- Main branches: `main`, `develop`
- Feature branches: `feature/*`
- Commit messages: Follow guidelines in `.github/copilot-commit-message-instructions.md`
  - Subject: Max 50 chars, imperative mood, capitalized, no period
  - Body: Explain what and why, use bullet points

## Environment Variables

Key variables (see `.env.ci.sample` for full list):

```
DEBUG=false
SECRET_KEY=<required>
ALLOWED_HOSTS=localhost,127.0.0.1
DATABASE_TYPE=sqlite|mysql|postgresql
OPENAI_API_KEY=<optional>
CORS_ALLOWED_ORIGINS=http://localhost:3000
```

## Testing

### Backend

- Framework: Django test framework
- Test files: `tests.py` in each app
- Run: `uv run python backend/manage.py test`

### Frontend

- Framework: Vitest + Testing Library
- Mock API: MSW (Mock Service Worker)
- Run: `npm test`

## Common Tasks

### Adding a new API endpoint

1. Create/update model in `backend/menus/models/`
2. Create serializer in `backend/menus/serializers/`
3. Create ViewSet in `backend/menus/views.py`
4. Register route in `backend/menus/urls.py`
5. Run migrations if model changed

### Adding a new frontend page

1. Create page component in `client/src/pages/<feature>/`
2. Add route in `client/src/routes.ts`
3. Create hooks in `client/src/hooks/<feature>/`
4. Define types in `client/src/types/`
5. Add translations in `client/src/locales/`

### Adding translations

1. Add keys to `client/src/locales/en/translation.json`
2. Add translations to `client/src/locales/es/translation.json`
3. Use in components: `const { t } = useTranslation(); t('key')`

## CI/CD

GitHub Actions workflows in `.github/workflows/`:

- `django.yml`: Backend tests with Python 3.10
- `react.yml`: Frontend tests with Node 22
- `docker-build-publish-*.yml`: Docker image builds

## Important Notes

1. **API Case Conversion**: Backend uses snake_case, frontend uses camelCase - conversion is automatic
2. **Rich Text**: Notes and instructions use TipTap JSON format
3. **Images**: Stored in `media/user/` directory
4. **Seasons**: Recipes can be tagged for multiple seasons
5. **Sides**: Recipes can have other recipes as side dishes (self-referential)
6. **Pagination**: Standard endpoints are paginated, `-no-limit` variants return all
