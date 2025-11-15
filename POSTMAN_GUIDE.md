# Postman Collection for Go Lazy API

## 📦 Import Instructions

1. Open Postman
2. Click "Import" button (top left)
3. Select `postman_collection.json` file
4. Collection will be imported with all endpoints and variables

## 🔧 Configuration

The collection includes the following environment variables:

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `base_url` | `http://localhost:8080` | API base URL |
| `access_token` | Auto-populated | JWT access token (auto-saved from login) |
| `refresh_token` | Auto-populated | JWT refresh token (auto-saved from login) |
| `user_email` | Auto-populated | Last created user email |
| `user_phone` | Auto-populated | Last created user phone |

### Change Base URL

To use a different environment (staging, production):
1. Click on collection name → Variables tab
2. Update `base_url` value
3. Save changes

## 📋 Available Endpoints

### 1. Health Check
- **GET** `/`
- Simple endpoint to verify API is running
- No authentication required

### 2. Create User
- **POST** `/user/create`
- Creates a new user account
- No authentication required

**Request Body:**
```json
{
  "email": "user@example.com",
  "phoneNumber": "+1234567890",
  "firstName": "John",
  "lastName": "Doe"
}
```

**Response:** `201 Created`

### 3. Login with Email
- **POST** `/user/login`
- Login using email and OTP
- Returns JWT tokens
- Tokens are auto-saved to collection variables

**Request Body:**
```json
{
  "email": "user@example.com",
  "otp": "123456"
}
```

**Response:**
```json
{
  "access_token": "eyJhbGci...",
  "refresh_token": "eyJhbGci...",
  "expires_in": 900,
  "token_type": "Bearer"
}
```

### 4. Login with Phone
- **POST** `/user/login`
- Login using phone number and OTP
- Returns JWT tokens
- Tokens are auto-saved to collection variables

**Request Body:**
```json
{
  "phoneNumber": "+1234567890",
  "otp": "123456"
}
```

### 5. Refresh Token
- **POST** `/user/refresh_token`
- Get new tokens using refresh token
- New tokens are auto-saved to collection variables

**Request Body:**
```json
{
  "refresh_token": "{{refresh_token}}"
}
```

**Response:**
```json
{
  "access_token": "eyJhbGci...",
  "refresh_token": "eyJhbGci...",
  "expires_in": 900,
  "token_type": "Bearer"
}
```

### 6. Get User Profile
- **GET** `/user/profile`
- **Protected Route** - Requires JWT authentication
- Returns authenticated user's profile

**Headers:**
```
Authorization: Bearer {{access_token}}
```

**Response:**
```json
{
  "id": "user-id",
  "firstName": "John",
  "lastName": "Doe",
  "email": "user@example.com",
  "phoneNumber": "+1234567890",
  "isEmailVerified": true,
  "isPhoneVerified": false
}
```

## 🚀 Quick Start Guide

### Step 1: Create a User
1. Select "Create User" request
2. Modify the request body with your details
3. Click "Send"
4. Expected response: `201 Created`

### Step 2: Login
1. Select "Login with Email" or "Login with Phone"
2. Use the same credentials from Step 1
3. Add the OTP code (from your email/phone or database)
4. Click "Send"
5. Tokens are automatically saved to collection variables

### Step 3: Access Protected Resources
1. Select "Get User Profile" request
2. The `Authorization` header is automatically populated with `{{access_token}}`
3. Click "Send"
4. You should receive your user profile data

### Step 4: Refresh Tokens (when access token expires)
1. Select "Refresh Token" request
2. Click "Send"
3. New tokens are automatically saved

## 🔄 Authentication Flow Example

The collection includes a complete flow under **Examples → Full Authentication Flow**:

1. **Step 1** - Create User
2. **Step 2** - Login (tokens auto-saved)
3. **Step 3** - Access Protected Resource (using saved token)
4. **Step 4** - Refresh Token (get new tokens)

Run these in sequence to see the complete authentication flow.

## 🔐 Authorization

The collection uses Bearer Token authentication for protected endpoints.

- Access tokens expire in **15 minutes** (default)
- Refresh tokens expire in **7 days** (default)

When you receive a `401 Unauthorized` error:
1. Use the "Refresh Token" request to get new tokens
2. Or login again

## 📝 Test Scripts

The collection includes automatic test scripts that:

1. **Login requests** → Save `access_token` and `refresh_token` to variables
2. **Refresh Token** → Update tokens with new values
3. **Create User** → Save user email and phone for reference

You can view these scripts in the "Tests" tab of each request.

## 🧪 Testing Tips

### Test with Invalid Token
1. Manually set `access_token` to an invalid value in collection variables
2. Try accessing "Get User Profile"
3. Should receive `401 Unauthorized`

### Test Token Expiration
1. Wait 15 minutes after login
2. Try accessing "Get User Profile"
3. Should receive `401 Unauthorized` (token expired)
4. Use "Refresh Token" to get new tokens

### Test Different Users
1. Create multiple users with different emails
2. Login with each user
3. Check profile to verify correct user data

## 🔧 Troubleshooting

### "Missing or invalid authorization header"
- Ensure you've logged in first
- Check that `access_token` variable is populated
- Verify the Authorization header format: `Bearer {{access_token}}`

### "Invalid or expired access token"
- Token may have expired (15 minutes)
- Use "Refresh Token" request
- Or login again

### "Invalid or expired refresh token"
- Refresh token expired (7 days)
- Login again to get new tokens

### 401 Unauthorized on Profile
- Make sure you've logged in first
- Check that `access_token` is set in collection variables
- Try refreshing the token

## 📊 Collection Structure

```
Go Lazy API - JWT Authentication
├── Health Check
├── User
│   ├── Create User
│   ├── Login with Email
│   ├── Login with Phone
│   ├── Refresh Token
│   └── Get User Profile
└── Examples
    └── Full Authentication Flow
        ├── Step 1 - Create User
        ├── Step 2 - Login
        ├── Step 3 - Access Protected Resource
        └── Step 4 - Refresh Token
```

## 🌐 Using with Different Environments

### Development
```
base_url: http://localhost:8080
```

### Staging
```
base_url: https://staging-api.yourdomain.com
```

### Production
```
base_url: https://api.yourdomain.com
```

Update the `base_url` variable in collection variables to switch environments.

## 📚 Additional Resources

- See `JWT_IMPLEMENTATION.md` for detailed JWT documentation
- See `JWT_KEYS.md` for environment variable setup
- API runs on port `8080` by default

## 🤝 Contributing

When adding new endpoints:
1. Add the request to the appropriate folder
2. Update this README
3. Add test scripts if applicable
4. Document request/response examples
