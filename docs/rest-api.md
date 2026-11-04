# HabitShare REST API — Dokumentasi untuk Pengembang Android

Base URL (local): `http://localhost:8000`
Base URL (prod): `https://habit-tracker.nanoprojectdevindonesia.com`

Autentikasi: Laravel Sanctum (Bearer token). Semua endpoint (kecuali login/register) butuh header:
`Authorization: Bearer <token>`

## 1. Auth

### POST /api/login
Request:
```json
{ "email": "student@example.com", "password": "password", "device_name": "android-app" }
```
Response 200:
```json
{ "token": "1|abc...", "user": { "id": 1, "name": "Student", "email": "student@example.com", "roles": ["student"] } }
```

### POST /api/register
Request:
```json
{ "name": "Budi", "email": "budi@example.com", "password": "password", "password_confirmation": "password" }
```
Response 201: { "token": "...", "user": {...} }

### POST /api/logout
Header: Authorization. Response 204.

## 2. Habits (Student)

### GET /api/habits
Response 200:
```json
[ { "id": 1, "name": "Morning Jog", "category": { "id": 1, "name": "Olahraga" }, "pivot": { "color": "#ff0000", "frequency": "daily", "is_active": true } } ]
```

### POST /api/habits/{habit}/toggle
Request (optional):
```json
{ "status": "done" }
```
status: `done` | `none`. Response 200: { "message": "ok" }

## 3. Reflections

### POST /api/reflections
Request:
```json
{ "mood": "HAPPY", "note": "Hari yang baik" }
```
Response 201: { "id": 1, "mood": "HAPPY", "note": "...", "ref_date": "2026-11-02" }

## 4. Attendance

### POST /api/attendances
Request:
```json
{ "classroom_id": 5 }
```
Response 201: { "message": "Kehadiran berhasil diajukan dan menunggu konfirmasi." }

## 5. Error Format
```json
{ "message": "...", "errors": { "field": ["..."] } }
```
Status: 422 validation, 401 unauth, 403 forbidden, 404 not found.
```

Catatan: endpoint di atas merupakan rekomendasi; implementasi route API belum ada di project ini (hanya web/session). Untuk Android, tambahkan `routes/api.php` + Sanctum.