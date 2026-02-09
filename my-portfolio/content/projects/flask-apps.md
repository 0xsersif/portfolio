---
title: "Production Flask Web Applications"
date: 2025-07-20
description: "Full-stack Flask apps deployed on cPanel with authentication, database, and real users"
tags: ["Flask", "Python", "Full-Stack", "cPanel"]
categories: ["Full-Stack"]
---

# Production Flask Web Applications

## Full-Stack Apps with Real Users

Built and deployed **production Flask applications** on cPanel hosting, handling real users with authentication, database integration, and responsive design.

## Featured Application: Run1Events

**Event registration system** for local running club with admin panel.

### Features

✅ **User Registration** — Collect participant details  
✅ **Authentication** — Admin login with session management  
✅ **Database** — PostgreSQL for structured data  
✅ **Admin Panel** — Manage registrations, export to Excel  
✅ **Email Notifications** — Flask-Mail for confirmations  
✅ **Responsive Design** — Mobile-first CSS

### Tech Stack

- **Flask** — Web framework
- **PostgreSQL** — Relational database
- **SQLAlchemy** — ORM for database
- **Flask-Login** — User session management
- **Flask-Mail** — Email sending
- **WTForms** — Form validation
- **Bootstrap** — Responsive UI
- **cPanel** — Production hosting

## Architecture

```
User Request
    ↓
Nginx (Reverse Proxy)
    ↓
Flask App (WSGI)
    ↓
SQLAlchemy ORM
    ↓
PostgreSQL Database
```

## Code Highlights

### User Authentication

```python
from flask_login import LoginManager, login_user, login_required

login_manager = LoginManager()
login_manager.init_app(app)

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']
    
    user = User.query.filter_by(username=username).first()
    if user and check_password_hash(user.password, password):
        login_user(user)
        return redirect(url_for('admin'))
    return 'Invalid credentials', 401
```

### Database Models

```python
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Registration(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True)
    phone = db.Column(db.String(20))
    event = db.Column(db.String(50))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
```

### Form Validation

```python
from wtforms import StringField, validators

class RegistrationForm(FlaskForm):
    name = StringField('Name', [
        validators.DataRequired(),
        validators.Length(min=2, max=100)
    ])
    email = EmailField('Email', [
        validators.DataRequired(),
        validators.Email()
    ])
    phone = StringField('Phone', [
        validators.Regexp(r'^\+?1?\d{9,15}$')
    ])
```

## Deployment on cPanel

### Challenges

1. **Python Version Mismatch** — cPanel default vs app requirements
2. **Process Limits** — LSAPI children constraints
3. **Static Files** — Nginx configuration
4. **Email SMTP** — Authentication setup

### Solutions

```bash
# Virtual environment with correct Python
python3.10 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Passenger WSGI configuration
passenger_enabled on
passenger_python /home/user/venv/bin/python
```

## Production Metrics

📊 **210+ registered users** across multiple events  
📊 **99.5% uptime** over 6 months  
📊 **<500ms average response time**  
📊 **Zero data loss** incidents  
📊 **100% email delivery rate** (MailerSend SMTP)

## Features in Detail

### Admin Panel

**Capabilities**:
- View all registrations (sortable table)
- Search/filter by event, date, name
- Export to Excel (pandas + openpyxl)
- Delete/edit registrations
- Send bulk emails

### Email System

**Automated Emails**:
- Registration confirmation
- Event reminders (1 day before)
- Admin notifications for new registrations

**Configuration**:
```python
app.config['MAIL_SERVER'] = 'smtp.mailersend.net'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'MS_xxx'
app.config['MAIL_PASSWORD'] = 'MS_yyy'
```

### Database Migrations

Using Flask-Migrate (Alembic):

```bash
flask db init
flask db migrate -m "Add phone field"
flask db upgrade
```

## Security Features

✅ **CSRF Protection** — WTForms tokens  
✅ **Password Hashing** — bcrypt (Werkzeug)  
✅ **SQL Injection Prevention** — SQLAlchemy ORM  
✅ **XSS Protection** — Jinja2 auto-escaping  
✅ **HTTPS** — SSL certificate (Let's Encrypt)

## Responsive Design

**Mobile-First CSS**:
```css
@media (max-width: 768px) {
    .registration-form {
        padding: 20px;
        font-size: 16px;
    }
    table {
        display: block;
        overflow-x: auto;
    }
}
```

## Error Handling

```python
@app.errorhandler(404)
def not_found(e):
    return render_template('404.html'), 404

@app.errorhandler(500)
def server_error(e):
    app.logger.error(f'Server Error: {e}')
    return render_template('500.html'), 500
```

## Debugging Production Issues

**Challenges Faced**:
1. **Email SMTP failures** → Switch from Flask-Mail to MailerSend API
2. **Process crashes** → Passenger configuration tuning
3. **Template errors** → Jinja2 undefined variable handling
4. **Caching issues** → Browser cache busting with versioned assets

## GitHub Repository

📂 **[View Source Code →](https://github.com/0xmuler/run1events)**

**Note**: Production credentials removed, `.env.example` provided

## Key Learnings

1. **Production ≠ localhost** — Different Python versions, configs
2. **cPanel has quirks** — Passenger, process limits, caching
3. **Email is hard** — SMTP auth, deliverability, spam filters
4. **Users find bugs** — Real usage reveals edge cases
5. **Monitoring matters** — Logs saved debugging time

## Best Practices Applied

✅ **Environment Variables** — `.env` for secrets (python-dotenv)  
✅ **Logging** — Flask logger for debugging  
✅ **Git Workflow** — Feature branches, clean commits  
✅ **Documentation** — README with setup instructions  
✅ **Testing** — pytest for routes and forms

## Future Enhancements

- **API** — REST API for mobile app
- **Payment Integration** — Stripe for event fees
- **QR Codes** — Check-in system at events
- **Analytics** — Dashboard with registration stats
- **Multi-language** — Flask-Babel for i18n
