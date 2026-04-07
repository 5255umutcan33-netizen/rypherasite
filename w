<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ryphera OS | Scripting Solutions</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700;900&display=swap');
        body { background-color: #0f0f0f; color: #ffffff; font-family: 'Inter', sans-serif; overflow: hidden; margin: 0; padding: 0; } 
        
        .glass { background: rgba(255, 255, 255, 0.03); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.05); }
        .gradient-text { background: linear-gradient(90deg, #ffffff, #666666); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        #pre-intro { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: radial-gradient(circle at center, #1a1a1a 0%, #050505 100%); z-index: 9999; display: flex; justify-content: center; align-items: center; animation: preIntroFadeOut 0.8s ease-in-out 3.5s forwards; }
        .snake-container { position: absolute; width: 100%; height: 100%; overflow: hidden; z-index: 1; }
        .snake { position: absolute; background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.8), transparent); height: 2px; width: 150px; border-radius: 50%; filter: blur(2px); opacity: 0; }
        .snake-1 { top: 20%; animation: slitherRight 2s cubic-bezier(0.4, 0, 0.2, 1) 0.2s forwards; }
        .snake-2 { top: 50%; right: 0; width: 200px; animation: slitherLeft 2.5s cubic-bezier(0.4, 0, 0.2, 1) 0.5s forwards; }
        .snake-3 { bottom: 20%; left: -100px; transform: rotate(-20deg); animation: slitherDiagonal 2s cubic-bezier(0.4, 0, 0.2, 1) 0.8s forwards; }
        #pre-intro-text { font-size: 4rem; font-weight: 900; letter-spacing: 1rem; color: #ffffff; text-transform: uppercase; z-index: 2; text-shadow: 0 0 20px rgba(255, 255, 255, 0.3); animation: textReveal 1.5s cubic-bezier(0.16, 1, 0.3, 1) 1.5s forwards; transform: scale(0.8); opacity: 0; filter: blur(10px); }
        @media (min-width: 768px) { #pre-intro-text { font-size: 6rem; letter-spacing: 2rem; } }

        @keyframes slitherRight { 0% { transform: translateX(-200px); opacity: 0; } 50% { opacity: 1; } 100% { transform: translateX(120vw); opacity: 0; } }
        @keyframes slitherLeft { 0% { transform: translateX(200px); opacity: 0; } 50% { opacity: 1; } 100% { transform: translateX(-120vw); opacity: 0; } }
        @keyframes slitherDiagonal { 0% { transform: translate(-200px, 100px) rotate(-20deg); opacity: 0; } 50% { opacity: 1; } 100% { transform: translate(120vw, -300px) rotate(-20deg); opacity: 0; } }
        @keyframes textReveal { 0% { transform: scale(0.8); opacity: 0; filter: blur(10px); } 100% { transform: scale(1); opacity: 1; filter: blur(0px); } }
        @keyframes preIntroFadeOut { 0% { transform: translateY(0%); opacity: 1; } 100% { transform: translateY(-100%); opacity: 0; visibility: hidden; } }

        #main-content { opacity: 0; transition: opacity 1s ease-in; display: flex; flex-direction: column; min-height: 100vh; }
        .page-view { display: none; opacity: 0; transform: translateY(20px); transition: opacity 0.5s ease-out, transform 0.5s ease-out; flex-grow: 1; }
        .page-view.active { display: block; opacity: 1; transform: translateY(0); }
        .nav-link { position: relative; }
        .nav-link::after { content: ''; position: absolute; width: 0; height: 2px; display: block; margin-top: 5px; right: 0; background: #fff; transition: width 0.3s ease; }
        .nav-link:hover::after { width: 100%; left: 0; background: #fff; }
        .nav-link.active-nav::after { width: 100%; left: 0; background: #fff; }

        input, textarea, select { background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); color: white; border-radius: 0.5rem; padding: 0.75rem 1rem; width: 100%; outline: none; transition: border 0.3s; }
        input:focus, textarea:focus, select:focus { border-color: #5865F2; }
        option { background-color: #0f0f0f; color: white; }
    </style>
</head>
<body class="antialiased">

    <div id="pre-intro">
        <div class="snake-container"><div class="snake snake-1"></div><div class="snake snake-2"></div><div class="snake snake-3"></div></div>
        <div id="pre-intro-text">RYPHERA</div>
    </div>

    <div id="main-content">
        
        <nav class="p-6 relative flex items-center justify-between max-w-7xl mx-auto w-full">
            <div class="flex-1 flex justify-start">
                <div class="cursor-pointer flex items-center gap-3 transition hover:scale-105" onclick="changePage('home')">
                    <img src="logo.png" alt="Ryphera Logo" class="h-10 md:h-12 w-auto object-contain rounded-lg shadow-[0_0_15px_rgba(255,255,255,0.1)]" onerror="this.src='https://via.placeholder.com/50x50/1a1a1a/ffffff?text=R'">
                    <span class="hidden md:block text-2xl font-bold tracking-tighter">RYPHERA<span class="text-gray-600">OS</span></span>
                </div>
            </div>
            
            <div class="flex-1 flex justify-center space-x-8 hidden md:flex text-sm uppercase tracking-widest text-gray-400 font-medium items-center">
                <a href="#" onclick="changePage('home')" class="nav-link active-nav text-white transition" id="nav-home">Ana Sayfa</a>
                <a href="#" onclick="changePage('scripts')" class="nav-link hover:text-white transition" id="nav-scripts">Scriptler</a>
                <a href="#" onclick="changePage('apply')" class="nav-link hover:text-white transition" id="nav-apply">Başvuru</a>
                <a href="#" onclick="changePage('admin')" class="nav-link hover:text-white transition text-red-500" id="nav-admin">Admin Panel</a>
            </div>

            <div class="flex-1 flex justify-end">
                <button id="discord-login-btn" onclick="loginWithDiscord()" class="bg-[#5865F2] hover:bg-[#4752C4] text-white px-6 py-2 rounded-lg font-bold transition-all flex items-center gap-2 shadow-[0_0_15px_rgba(88,101,242,0.4)]">
                    <i class="fa-brands fa-discord text-xl" id="btn-icon"></i>
                    <span id="login-text">Giriş Yap</span>
                </button>
            </div>
        </nav>

        <div id="home-view" class="page-view active">
            <header class="py-24 px-6 text-center mt-10">
                <h1 class="text-5xl md:text-8xl font-black mb-6 tracking-tighter gradient-text leading-none">GELECEĞİN <br> SCRIPT SİSTEMİ.</h1>
                <p class="text-gray-400 text-lg md:text-xl max-w-2xl mx-auto mb-12 font-light leading-relaxed">Ryphera OS ile oyun deneyiminizi bir üst seviyeye taşıyın. Hızlı, güvenli ve tamamen optimize edilmiş altyapı.</p>
                <div class="flex flex-col md:flex-row justify-center gap-6">
                    <a href="https://discord.gg/DAVET-LINKI" target="_blank" class="bg-white text-black px-10 py-4 rounded-full font-bold hover:bg-gray-300 transition-all transform hover:scale-105 shadow-[0_0_20px_rgba(255,255,255,0.2)]">ŞİMDİ KATIL</a>
                    <a href="#" onclick="changePage('scripts')" class="glass px-10 py-4 rounded-full font-bold hover:bg-white/10 transition-all">SCRİPTLERİ GÖR</a>
                </div>
            </header>
        </div>

        <div id="scripts-view" class="page-view">
            <header class="py-12 px-6 text-center mt-6">
                <h2 class="text-4xl md:text-6xl font-black mb-4 tracking-tighter gradient-text">PREMIUM SCRIPTS</h2>
            </header>
            <section class="max-w-7xl mx-auto px-6 pb-24 text-center mt-10">
                <div class="glass max-w-2xl mx-auto p-12 rounded-3xl border-white/10 shadow-[0_0_30px_rgba(0,0,0,0.5)]">
                    <i class="fa-solid fa-ghost text-6xl mb-6 text-gray-600 animate-pulse"></i>
                    <h3 class="text-2xl font-bold mb-4 text-white">Şu An Script Bulunmuyor</h3>
                    <p class="text-gray-400 font-light leading-relaxed mb-8">Sistemimizde şu anda yayında olan bir script bulunmuyor. Çok yakında yeni nesil sistemlerimizle buradayız.</p>
                </div>
            </section>
        </div>

        <div id="apply-view" class="page-view">
            <header class="py-12 px-6 text-center mt-6">
                <h2 class="text-4xl md:text-6xl font-black mb-4 tracking-tighter text-blue-500">YETKİLİ BAŞVURUSU</h2>
                <p class="text-gray-400 text-lg max-w-2xl mx-auto font-light">Ryphera OS Yönetim Ekibine katılmak için formu doldurun.</p>
            </header>

            <section class="max-w-3xl mx-auto px-6 pb-24">
                <div class="glass p-8 md:p-12 rounded-3xl border-white/10 shadow-[0_0_30px_rgba(0,0,0,0.5)]">
                    <div id="apply-warning" class="text-center py-10">
                        <i class="fa-solid fa-lock text-6xl text-gray-600 mb-4"></i>
                        <h3 class="text-xl font-bold text-white mb-2">Giriş Yapmanız Gerekiyor</h3>
                        <p class="text-gray-400">Başvuru yapabilmek için sağ üstten Discord hesabınızla giriş yapmalısınız.</p>
                    </div>

                    <form id="applicationForm" class="space-y-6 hidden" onsubmit="sendApplication(event)">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div><label class="block text-sm font-bold text-gray-400 mb-2">Başvuru Bölgesi</label><select id="appRegion" required><option value="TR">Türkçe (Türkiye)</option><option value="EN">English (Global)</option></select></div>
                            <div><label class="block text-sm font-bold text-gray-400 mb-2">İsminiz nedir?</label><input type="text" id="appName" placeholder="Örn: Umutcan" required></div>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div><label class="block text-sm font-bold text-gray-400 mb-2">Kaç yaşındasınız?</label><input type="number" id="appAge" placeholder="Örn: 20" required></div>
                            <div><label class="block text-sm font-bold text-gray-400 mb-2">Günlük Aktiflik Süreniz?</label><input type="text" id="appActive" placeholder="Örn: 5-6 Saat" required></div>
                        </div>
                        <div><label class="block text-sm font-bold text-gray-400 mb-2">Komut kullanmayı biliyor musunuz?</label><textarea id="appCmd" rows="3" required></textarea></div>
                        <div><label class="block text-sm font-bold text-gray-400 mb-2">Neden yetkili olmak istiyorsunuz?</label><textarea id="appWhy" rows="4" required></textarea></div>
                        <button type="submit" id="submitBtn" class="w-full bg-[#5865F2] hover:bg-[#4752C4] text-white font-bold py-4 rounded-lg transition-all shadow-[0_0_15px_rgba(88,101,242,0.4)]"><i class="fa-solid fa-paper-plane mr-2"></i> Başvuruyu Gönder</button>
                    </form>
                </div>
            </section>
        </div>

        <div id="admin-view" class="page-view">
            <header class="py-12 px-6 text-center mt-6">
                <h2 class="text-4xl md:text-6xl font-black mb-4 tracking-tighter text-red-500">ADMIN PANEL</h2>
            </header>
            <section class="max-w-7xl mx-auto px-6 pb-24 text-center mt-10">
                <div id="admin-warning" class="glass max-w-2xl mx-auto p-12 rounded-3xl border-white/10 shadow-[0_0_30px_rgba(0,0,0,0.5)]">
                    <i class="fa-solid fa-ban text-6xl mb-6 text-red-600"></i>
                    <h3 class="text-2xl font-bold mb-4 text-white">Yetkisiz Erişim</h3>
                    <p class="text-gray-400 font-light leading-relaxed">Bu sayfayı görüntülemek için Yönetici (Admin) hesabınızla giriş yapmalısınız.</p>
                </div>
                
                <div id="admin-dashboard" class="hidden grid grid-cols-1 md:grid-cols-2 gap-8 text-left">
                    <div class="glass p-8 rounded-3xl border border-red-500/30">
                        <h3 class="text-xl font-bold text-white mb-4"><i class="fa-solid fa-server mr-2 text-red-400"></i> Sistem Durumu</h3>
                        <p class="text-gray-400">Bot Durumu: <span class="text-green-400">Aktif</span></p>
                        <p class="text-gray-400">Gelen Başvurular: Discord log kanalından takip ediliyor.</p>
                    </div>
                </div>
            </section>
        </div>

    </div>

    <script>
        // --- 1. AYARLAR (BURALARI KENDİNE GÖRE DOLDUR) ---
        const CLIENT_ID = "CLIENT_ID_BURAYA"; // Discord Developer Portal'dan al
        const REDIRECT_URI = encodeURIComponent("REDIRECT_URL_BURAYA"); // Örn: https://siten.vercel.app/
        const SAHIP_ID = "345821033414262794"; // Senin Discord ID'n (Admin paneli için)

        const WEBHOOK_TR = "WEBHOOK_TR_BURAYA"; 
        const WEBHOOK_EN = "WEBHOOK_EN_BURAYA";

        let loggedInUser = null;

        // --- 2. ANİMASYON VE SAYFA GEÇİŞİ ---
        document.addEventListener('DOMContentLoaded', () => {
            const preIntro = document.getElementById('pre-intro');
            const mainContent = document.getElementById('main-content');
            const body = document.body;
            setTimeout(() => { mainContent.style.opacity = '1'; body.style.overflow = 'auto'; }, 3500);
            setTimeout(() => { preIntro.style.display = 'none'; }, 4500);
            
            checkDiscordLogin(); // Sayfa açılınca token var mı kontrol et
        });

        function changePage(pageId) {
            const views = document.querySelectorAll('.page-view');
            const navLinks = document.querySelectorAll('.nav-link');
            const activeView = document.querySelector('.page-view.active');
            if (activeView.id === `${pageId}-view`) return;

            activeView.style.opacity = '0';
            activeView.style.transform = 'translateY(20px)';

            navLinks.forEach(link => { link.classList.remove('active-nav', 'text-white'); link.classList.add('text-gray-400'); });
            const activeNav = document.getElementById(`nav-${pageId}`);
            if(activeNav) { activeNav.classList.add('active-nav', 'text-white'); activeNav.classList.remove('text-gray-400'); }

            setTimeout(() => {
                activeView.classList.remove('active'); activeView.style.display = 'none';
                const newView = document.getElementById(`${pageId}-view`);
                newView.style.display = 'block';
                setTimeout(() => { newView.classList.add('active'); newView.style.opacity = '1'; newView.style.transform = 'translateY(0)'; }, 50);
            }, 300);
        }

        // --- 3. GERÇEK DISCORD GİRİŞİ ---
        function loginWithDiscord() {
            if (loggedInUser) return; // Zaten giriş yapıldıysa bişey yapma
            if (CLIENT_ID === "CLIENT_ID_BURAYA") {
                alert("Kanka kodun içine Client ID ve Redirect URL eklememişsin!");
                return;
            }
            const authUrl = `https://discord.com/api/oauth2/authorize?client_id=${CLIENT_ID}&redirect_uri=${REDIRECT_URI}&response_type=token&scope=identify`;
            window.location.href = authUrl; // Discord'a yönlendir
        }

        function checkDiscordLogin() {
            const fragment = new URLSearchParams(window.location.hash.slice(1));
            const [accessToken, tokenType] = [fragment.get('access_token'), fragment.get('token_type')];

            if (accessToken) {
                // Token URL'den geldi, kullanıcı verisini çekelim
                fetch('https://discord.com/api/users/@me', {
                    headers: { authorization: `${tokenType} ${accessToken}` }
                })
                .then(res => res.json())
                .then(response => {
                    loggedInUser = response;
                    
                    // Arayüzü Güncelle
                    document.getElementById('login-text').innerText = " " + response.username;
                    document.getElementById('btn-icon').className = "fa-solid fa-user-check text-green-400 text-xl";
                    document.getElementById('discord-login-btn').classList.replace('bg-[#5865F2]', 'bg-gray-800');
                    
                    // Başvuru Formunu Aç
                    document.getElementById('apply-warning').classList.add('hidden');
                    document.getElementById('applicationForm').classList.remove('hidden');

                    // Eğer giren sensen (Sahip) Admin Panelini Aç
                    if(response.id === SAHIP_ID) {
                        document.getElementById('admin-warning').classList.add('hidden');
                        document.getElementById('admin-dashboard').classList.remove('hidden');
                    }

                    // URL'deki token karmaşasını temizle
                    window.history.replaceState({}, document.title, window.location.pathname);
                })
                .catch(console.error);
            }
        }

        // --- 4. WEBHOOK İLE LOG GÖNDERME ---
        function sendApplication(e) {
            e.preventDefault();
            const btn = document.getElementById('submitBtn');
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin mr-2"></i> Gönderiliyor...';
            btn.disabled = true;

            const region = document.getElementById('appRegion').value;
            const targetWebhook = region === "TR" ? WEBHOOK_TR : WEBHOOK_EN;

            const payload = {
                username: "Ryphera Web System",
                embeds: [{
                    title: `📩 YENİ YETKİLİ BAŞVURUSU (WEB - ${region})`,
                    color: 3093151,
                    fields: [
                        { name: "Discord Hesabı", value: `${loggedInUser.username} (\`${loggedInUser.id}\`)`, inline: true },
                        { name: "İsim", value: document.getElementById('appName').value, inline: true },
                        { name: "Yaş", value: document.getElementById('appAge').value, inline: true },
                        { name: "Aktiflik", value: document.getElementById('appActive').value, inline: false },
                        { name: "Komut Bilgisi", value: document.getElementById('appCmd').value, inline: false },
                        { name: "Neden İstiyor?", value: document.getElementById('appWhy').value, inline: false }
                    ],
                    footer: { text: "Ryphera OS Web Application" },
                    timestamp: new Date().toISOString()
                }]
            };

            if(targetWebhook.includes("WEBHOOK_")) {
                alert("Başvuru Testi Başarılı!\nVerilerin Discord'a gitmesi için Webhook URL'lerini koda yapıştır.");
                btn.innerHTML = '<i class="fa-solid fa-check mr-2"></i> Gönderildi (Test)';
                btn.classList.replace('bg-[#5865F2]', 'bg-green-500');
                return;
            }

            fetch(targetWebhook, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            }).then(res => {
                if(res.ok) {
                    btn.innerHTML = '<i class="fa-solid fa-check mr-2"></i> Başarıyla Gönderildi';
                    btn.classList.replace('bg-[#5865F2]', 'bg-green-500');
                    document.getElementById('applicationForm').reset();
                } else throw new Error();
            }).catch(err => {
                btn.innerHTML = '<i class="fa-solid fa-xmark mr-2"></i> Hata Oluştu';
                btn.classList.replace('bg-[#5865F2]', 'bg-red-500');
            });
        }
    </script>
</body>
</html>