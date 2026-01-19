echo '/* === MOBILE ONLY OPTIMIZATION (DESKTOP UNCHANGED) === */' >> static/css/main.css
echo '@media (max-width: 768px) {' >> static/css/main.css
echo '  .hero { padding: 48px 16px !important; text-align: center !important; }' >> static/css/main.css
echo '  .hero-title { font-size: 2rem !important; line-height: 1.2 !important; }' >> static/css/main.css
echo '  .hero-subtitle { font-size: 1rem !important; max-width: 100% !important; opacity: 0.9 !important; }' >> static/css/main.css
echo '  .hero-actions { flex-direction: column !important; gap: 12px !important; }' >> static/css/main.css
echo '  .hero-actions a { width: 100% !important; text-align: center !important; }' >> static/css/main.css
echo '}' >> static/css/main.css
