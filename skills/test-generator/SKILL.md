---
name: test-generator
description: Automated test generation assistance for unit tests, integration tests, and E2E tests. Triggers when generating tests, writing tests, creating test templates, need test examples. Keywords - generate test, create test, write test, test template, unit test, integration test, E2E test, test case, test suite, test fixture, mock, stub, test data, test examples, AAA pattern, test structure.
---

# Test Generator

## Purpose

Provides templates, patterns, and guidance for generating high-quality tests across different testing levels and frameworks. Helps you write comprehensive tests faster with best practices built-in.

## When to Use

This skill activates when:
- Writing new tests
- Generating test templates
- Need test structure examples
- Creating test fixtures or mocks
- Unsure how to test specific functionality

## Test Types & Templates

### Unit Tests

**Purpose**: Test individual functions/methods in isolation

**Python (pytest):**
```python
import pytest
from src.calculator import add, divide

class TestCalculator:
    """Test calculator operations"""

    def test_add_positive_numbers(self):
        """Test adding two positive numbers"""
        # Arrange
        a, b = 5, 3

        # Act
        result = add(a, b)

        # Assert
        assert result == 8

    def test_add_negative_numbers(self):
        """Test adding negative numbers"""
        assert add(-5, -3) == -8

    def test_divide_by_zero_raises_error(self):
        """Test division by zero raises ValueError"""
        with pytest.raises(ValueError, match="Cannot divide by zero"):
            divide(10, 0)

    @pytest.mark.parametrize("a,b,expected", [
        (10, 2, 5),
        (20, 4, 5),
        (100, 10, 10),
    ])
    def test_divide_parametrized(self, a, b, expected):
        """Test division with multiple inputs"""
        assert divide(a, b) == expected
```

**JavaScript (Jest):**
```javascript
import { add, divide } from './calculator';

describe('Calculator', () => {
  describe('add', () => {
    it('adds two positive numbers', () => {
      // Arrange
      const a = 5;
      const b = 3;

      // Act
      const result = add(a, b);

      // Assert
      expect(result).toBe(8);
    });

    it('adds negative numbers', () => {
      expect(add(-5, -3)).toBe(-8);
    });
  });

  describe('divide', () => {
    it('divides two numbers', () => {
      expect(divide(10, 2)).toBe(5);
    });

    it('throws error on division by zero', () => {
      expect(() => divide(10, 0)).toThrow('Cannot divide by zero');
    });

    it.each([
      [10, 2, 5],
      [20, 4, 5],
      [100, 10, 10],
    ])('divides %i by %i to get %i', (a, b, expected) => {
      expect(divide(a, b)).toBe(expected);
    });
  });
});
```

### Integration Tests

**Purpose**: Test multiple components working together

**API Integration Test (Node.js + Supertest):**
```javascript
import request from 'supertest';
import app from '../src/app';
import { db } from '../src/database';

describe('User API Integration Tests', () => {
  beforeAll(async () => {
    // Set up test database
    await db.connect(process.env.TEST_DATABASE_URL);
  });

  afterAll(async () => {
    // Clean up
    await db.disconnect();
  });

  beforeEach(async () => {
    // Clear data before each test
    await db.query('DELETE FROM users');
  });

  describe('POST /api/users', () => {
    it('creates a new user', async () => {
      // Arrange
      const userData = {
        email: 'test@example.com',
        name: 'Test User',
      };

      // Act
      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(201);

      // Assert
      expect(response.body).toMatchObject({
        id: expect.any(Number),
        email: userData.email,
        name: userData.name,
      });

      // Verify in database
      const user = await db.query('SELECT * FROM users WHERE email = ?', [userData.email]);
      expect(user).toBeTruthy();
    });

    it('returns 400 for invalid email', async () => {
      const response = await request(app)
        .post('/api/users')
        .send({ email: 'invalid', name: 'Test' })
        .expect(400);

      expect(response.body.error).toContain('Invalid email');
    });
  });
});
```

**Database Integration Test (Python):**
```python
import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from src.models import Base, User
from src.repositories import UserRepository

@pytest.fixture(scope="function")
def db_session():
    """Create test database session"""
    engine = create_engine("sqlite:///:memory:")
    Base.metadata.create_all(engine)
    Session = sessionmaker(bind=engine)
    session = Session()

    yield session

    session.close()

@pytest.fixture
def user_repository(db_session):
    """Create user repository with test session"""
    return UserRepository(db_session)

class TestUserRepository:
    """Test UserRepository database operations"""

    def test_create_user(self, user_repository, db_session):
        """Test creating a user in database"""
        # Arrange
        user_data = {"email": "test@example.com", "name": "Test User"}

        # Act
        user = user_repository.create(user_data)
        db_session.commit()

        # Assert
        assert user.id is not None
        assert user.email == user_data["email"]

        # Verify persistence
        retrieved = user_repository.get_by_id(user.id)
        assert retrieved.email == user_data["email"]

    def test_find_user_by_email(self, user_repository, db_session):
        """Test finding user by email"""
        # Arrange
        user_repository.create({"email": "test@example.com", "name": "Test"})
        db_session.commit()

        # Act
        user = user_repository.find_by_email("test@example.com")

        # Assert
        assert user is not None
        assert user.name == "Test"
```

### E2E Tests

**Purpose**: Test complete user workflows

**Playwright (JavaScript):**
```javascript
import { test, expect } from '@playwright/test';

test.describe('User Registration Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('http://localhost:3000');
  });

  test('complete user registration', async ({ page }) => {
    // Navigate to registration page
    await page.click('text=Sign Up');
    await expect(page).toHaveURL(/.*register/);

    // Fill registration form
    await page.fill('input[name="email"]', 'newuser@example.com');
    await page.fill('input[name="password"]', 'SecurePass123!');
    await page.fill('input[name="confirmPassword"]', 'SecurePass123!');

    // Submit form
    await page.click('button[type="submit"]');

    // Wait for success message
    await expect(page.locator('text=Registration successful')).toBeVisible();

    // Verify redirect to dashboard
    await expect(page).toHaveURL(/.*dashboard/);

    // Verify user is logged in
    await expect(page.locator('text=Welcome, newuser@example.com')).toBeVisible();
  });

  test('shows validation errors for invalid input', async ({ page }) => {
    await page.click('text=Sign Up');

    // Try to submit empty form
    await page.click('button[type="submit"]');

    // Check for validation errors
    await expect(page.locator('text=Email is required')).toBeVisible();
    await expect(page.locator('text=Password is required')).toBeVisible();
  });

  test('prevents registration with existing email', async ({ page }) => {
    await page.click('text=Sign Up');

    // Use existing email
    await page.fill('input[name="email"]', 'existing@example.com');
    await page.fill('input[name="password"]', 'SecurePass123!');
    await page.fill('input[name="confirmPassword"]', 'SecurePass123!');

    await page.click('button[type="submit"]');

    // Check for error message
    await expect(page.locator('text=Email already exists')).toBeVisible();
  });
});
```

## Mocking & Stubbing

### Mocking External APIs

**Python (unittest.mock):**
```python
from unittest.mock import Mock, patch
import pytest
from src.weather_service import WeatherService

class TestWeatherService:
    """Test WeatherService with mocked API calls"""

    @patch('requests.get')
    def test_get_weather_success(self, mock_get):
        """Test successful weather API call"""
        # Arrange
        mock_response = Mock()
        mock_response.json.return_value = {
            'temperature': 72,
            'condition': 'Sunny'
        }
        mock_response.status_code = 200
        mock_get.return_value = mock_response

        service = WeatherService(api_key="test_key")

        # Act
        weather = service.get_weather("New York")

        # Assert
        assert weather['temperature'] == 72
        assert weather['condition'] == 'Sunny'
        mock_get.assert_called_once_with(
            "https://api.weather.com/forecast",
            params={'city': 'New York', 'api_key': 'test_key'}
        )

    @patch('requests.get')
    def test_get_weather_api_error(self, mock_get):
        """Test handling of API errors"""
        # Arrange
        mock_get.side_effect = requests.RequestException("API unavailable")
        service = WeatherService(api_key="test_key")

        # Act & Assert
        with pytest.raises(WeatherServiceError):
            service.get_weather("New York")
```

**JavaScript (Jest):**
```javascript
import axios from 'axios';
import WeatherService from './weatherService';

jest.mock('axios');

describe('WeatherService', () => {
  let service;

  beforeEach(() => {
    service = new WeatherService('test_key');
    jest.clearAllMocks();
  });

  it('fetches weather successfully', async () => {
    // Arrange
    const mockWeather = {
      temperature: 72,
      condition: 'Sunny',
    };
    axios.get.mockResolvedValue({ data: mockWeather });

    // Act
    const weather = await service.getWeather('New York');

    // Assert
    expect(weather).toEqual(mockWeather);
    expect(axios.get).toHaveBeenCalledWith(
      'https://api.weather.com/forecast',
      {
        params: { city: 'New York', api_key: 'test_key' },
      }
    );
  });

  it('handles API errors', async () => {
    // Arrange
    axios.get.mockRejectedValue(new Error('API unavailable'));

    // Act & Assert
    await expect(service.getWeather('New York')).rejects.toThrow('API unavailable');
  });
});
```

### Mocking Database

**Python (pytest fixtures):**
```python
import pytest
from unittest.mock import Mock
from src.user_service import UserService

@pytest.fixture
def mock_user_repository():
    """Mock user repository"""
    repo = Mock()
    repo.find_by_id.return_value = {
        'id': 1,
        'email': 'test@example.com',
        'name': 'Test User'
    }
    return repo

def test_get_user(mock_user_repository):
    """Test UserService.get_user with mocked repository"""
    # Arrange
    service = UserService(mock_user_repository)

    # Act
    user = service.get_user(1)

    # Assert
    assert user['id'] == 1
    assert user['email'] == 'test@example.com'
    mock_user_repository.find_by_id.assert_called_once_with(1)
```

## Test Data & Fixtures

### Factory Pattern

**Python (factory_boy):**
```python
import factory
from src.models import User, Post

class UserFactory(factory.Factory):
    class Meta:
        model = User

    email = factory.Sequence(lambda n: f'user{n}@example.com')
    name = factory.Faker('name')
    age = factory.Faker('random_int', min=18, max=80)

class PostFactory(factory.Factory):
    class Meta:
        model = Post

    title = factory.Faker('sentence')
    content = factory.Faker('paragraph')
    author = factory.SubFactory(UserFactory)

# Usage in tests
def test_create_user():
    user = UserFactory()
    assert user.email.endswith('@example.com')

def test_create_post_with_author():
    post = PostFactory()
    assert post.author.email is not None
```

### Test Fixtures

**pytest fixtures:**
```python
import pytest

@pytest.fixture
def sample_user():
    """Provide sample user data"""
    return {
        'id': 1,
        'email': 'test@example.com',
        'name': 'Test User'
    }

@pytest.fixture
def authenticated_client(client, sample_user):
    """Provide authenticated API client"""
    token = create_auth_token(sample_user)
    client.headers['Authorization'] = f'Bearer {token}'
    return client

def test_get_profile(authenticated_client, sample_user):
    """Test getting user profile"""
    response = authenticated_client.get('/api/profile')
    assert response.json()['email'] == sample_user['email']
```

## Snapshot Testing

**Jest Snapshots:**
```javascript
import React from 'react';
import renderer from 'react-test-renderer';
import UserProfile from './UserProfile';

describe('UserProfile', () => {
  it('renders correctly', () => {
    const user = {
      id: 1,
      name: 'Test User',
      email: 'test@example.com',
    };

    const tree = renderer.create(<UserProfile user={user} />).toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('renders with avatar', () => {
    const user = {
      id: 1,
      name: 'Test User',
      email: 'test@example.com',
      avatar: 'https://example.com/avatar.jpg',
    };

    const tree = renderer.create(<UserProfile user={user} />).toJSON();
    expect(tree).toMatchSnapshot();
  });
});
```

## Async Testing

**Python (pytest-asyncio):**
```python
import pytest
from src.async_service import fetch_data

@pytest.mark.asyncio
async def test_fetch_data():
    """Test async data fetching"""
    # Act
    data = await fetch_data('https://api.example.com/data')

    # Assert
    assert data is not None
    assert 'items' in data
```

**JavaScript (Jest):**
```javascript
describe('Async Operations', () => {
  it('fetches data successfully', async () => {
    // Act
    const data = await fetchData('https://api.example.com/data');

    // Assert
    expect(data).toBeDefined();
    expect(data.items).toBeInstanceOf(Array);
  });

  it('handles promise rejection', async () => {
    // Act & Assert
    await expect(fetchData('invalid-url')).rejects.toThrow('Failed to fetch');
  });
});
```

## Test Organization

### File Structure

```
project/
├── src/
│   ├── auth/
│   │   ├── login.ts
│   │   └── register.ts
│   └── users/
│       ├── userService.ts
│       └── userRepository.ts
└── tests/
    ├── unit/
    │   ├── auth/
    │   │   ├── login.test.ts
    │   │   └── register.test.ts
    │   └── users/
    │       ├── userService.test.ts
    │       └── userRepository.test.ts
    ├── integration/
    │   ├── auth/
    │   │   └── authFlow.test.ts
    │   └── api/
    │       └── userApi.test.ts
    └── e2e/
        ├── registration.spec.ts
        └── login.spec.ts
```

### Naming Conventions

**Python:**
- Test files: `test_*.py` or `*_test.py`
- Test classes: `TestClassName`
- Test methods: `test_method_name`

**JavaScript:**
- Test files: `*.test.js` or `*.spec.js`
- Test suites: `describe('Component/Feature')`
- Test cases: `it('should do something')` or `test('does something')`

## Quick Test Templates

### Basic Function Test
```javascript
describe('functionName', () => {
  it('handles normal input', () => {
    expect(functionName(input)).toBe(expectedOutput);
  });

  it('handles edge cases', () => {
    expect(functionName(edgeCase)).toBe(expectedEdgeOutput);
  });

  it('throws error on invalid input', () => {
    expect(() => functionName(invalid)).toThrow('Error message');
  });
});
```

### API Endpoint Test
```javascript
describe('POST /api/resource', () => {
  it('creates resource successfully', async () => {
    const response = await request(app)
      .post('/api/resource')
      .send(validData)
      .expect(201);

    expect(response.body).toMatchObject(expectedShape);
  });

  it('validates input', async () => {
    await request(app)
      .post('/api/resource')
      .send(invalidData)
      .expect(400);
  });
});
```

### React Component Test
```javascript
describe('<ComponentName />', () => {
  it('renders without crashing', () => {
    render(<ComponentName />);
  });

  it('displays correct content', () => {
    const { getByText } = render(<ComponentName text="Hello" />);
    expect(getByText('Hello')).toBeInTheDocument();
  });

  it('handles user interaction', () => {
    const handleClick = jest.fn();
    const { getByRole } = render(<ComponentName onClick={handleClick} />);

    fireEvent.click(getByRole('button'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });
});
```

---

**Enforcement Level**: SUGGEST (Advisory)
**Priority**: HIGH
**Supports**: All programming languages and test frameworks
**Best Practice**: AAA pattern (Arrange, Act, Assert)
