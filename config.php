<?php
declare(strict_types=1);

if (is_file(__DIR__ . '/vendor/autoload.php')) {
    require __DIR__ . '/vendor/autoload.php';
}

const APP_NAME = 'Hausa to English Translator';
const DB_HOST = 'localhost';
const DB_NAME = 'kare_kare';
const DB_USER = 'root';
const DB_PASS = '';

function db(): PDO {
    static $pdo;
    if (!$pdo) {
        $pdo = new PDO('mysql:host=' . (getenv('DB_HOST') ?: DB_HOST) . ';dbname=' . (getenv('DB_NAME') ?: DB_NAME) . ';charset=utf8mb4', getenv('DB_USER') ?: DB_USER, getenv('DB_PASS') ?: DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
    }
    return $pdo;
}
session_start();
function e(?string $text): string { return htmlspecialchars($text ?? '', ENT_QUOTES, 'UTF-8'); }
function csrf(): string { if (!isset($_SESSION['csrf'])) { $_SESSION['csrf'] = bin2hex(random_bytes(32)); } return $_SESSION['csrf']; }
function verify_csrf(): void { if (!hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'] ?? '')) { http_response_code(419); exit('Invalid request token. Please try again.'); } }
function user(): ?array { return $_SESSION['user'] ?? null; }
function is_admin(): bool { return (user()['role'] ?? '') === 'admin'; }
function require_login(): void { if (!user()) { flash('Please sign in to continue.', 'warning'); header('Location: ?page=login'); exit; } }
function require_admin(): void { require_login(); if (!is_admin()) { http_response_code(403); exit('Administrator access required.'); } }
function flash(string $message, string $type = 'success'): void { $_SESSION['flash'][] = compact('message', 'type'); }
function flashes(): array { $items = $_SESSION['flash'] ?? []; unset($_SESSION['flash']); return $items; }
function log_activity(string $action, ?string $details = null): void { if (user()) { $q = db()->prepare('INSERT INTO activity_logs (user_id, role, action, details) VALUES (?, ?, ?, ?)'); $q->execute([user()['id'], user()['role'], $action, $details]); } }
function redirect(string $url = '?'): never { header('Location: ' . $url); exit; }
