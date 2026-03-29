# 🚀 n8n + Telegram + YouTube Shorts Otomasyon Kurulum Rehberi

Bu rehber, Telegram'dan gelen mesajlarla otomatik YouTube Shorts videosu oluşturan sistemi adım adım kurmanızı sağlar.

---

## 📋 Genel Bakış

```
📱 Telegram'dan konu gönder → ⚙️ n8n işlesin → 🤖 Gemini script yazsın → 🎬 Video oluşsun → 📺 YouTube'a yüklensin
```

---

## 🔧 ADIM 1: n8n'i Açma (Bilgisayarınızda Kurulu)

n8n zaten bilgisayarınızda kurulu! Açmak için:

### Yöntem 1: Komut Satırından
1. **PowerShell** veya **Komut İstemi (CMD)** açın
2. Şunu yazın:
   ```
   n8n
   ```
3. Birkaç saniye bekleyin, şöyle bir çıktı göreceksiniz:
   ```
   n8n ready on 0.0.0.0, port 5678
   Editor is now accessible via: http://localhost:5678
   ```
4. Tarayıcınızı açıp `http://localhost:5678` adresine gidin

### Yöntem 2: Tek Tıkla Başlatma (Pencere Açık Kalır)
Projedeki **`start-n8n.bat`** dosyasına çift tıklayın.
- n8n otomatik başlayacak ve tarayıcıdan `http://localhost:5678` adresine gidin
- ⚠️ **Bu pencereyi kapatmayın!** Kapattığınızda n8n durur.
- n8n çalışırken pencere açık kalacak, hata olursa mesaj gösterilecek.

### Yöntem 3: Arka Planda Çalıştırma (PM2 ile) ⭐ ÖNERİLEN
PM2 sayesinde n8n pencere kapatılsa bile arka planda çalışmaya devam eder!

**Tek tıkla başlatma:**
Projedeki **`start-n8n-background.bat`** dosyasına çift tıklayın. Otomatik olarak PM2 ile başlatılacak.

**Veya PowerShell/CMD'den:**
```bash
npx -y pm2 start n8n --name "n8n-shorts"
npx -y pm2 save
```

**PM2 Komut Referansı:**
| Komut | Ne Yapar |
|-------|----------|
| `npx pm2 status` | Çalışan servisleri gösterir |
| `npx pm2 logs n8n-shorts` | Logları canlı izler |
| `npx pm2 stop n8n-shorts` | n8n'i durdurur |
| `npx pm2 restart n8n-shorts` | n8n'i yeniden başlatır |
| `npx pm2 delete n8n-shorts` | Servisi tamamen kaldırır |

> ✅ **PM2 ile başlattığınızda** bilgisayarınız açık olduğu sürece n8n çalışır, pencere kapansa bile!

---

## 📱 ADIM 2: Telegram Bot Oluşturma

### 2.1 BotFather ile Bot Oluşturma
1. Telegram'ı açın
2. Arama çubuğuna `@BotFather` yazın ve tıklayın
3. `/start` yazıp gönderin
4. `/newbot` yazıp gönderin
5. Bot'a bir **isim** verin (örnek: `YouTube Shorts Üretici`)
6. Bot'a bir **kullanıcı adı** verin (örnek: `yt_shorts_maker_bot`) - `_bot` ile bitmeli
7. BotFather size bir **API Token** verecek, şuna benzer:
   ```
   6789012345:AAHfiqksKN8e8E-xample-token-here
   ```
8. **Bu token'ı kaydedin!** n8n'de kullanacağız.

### 2.2 Bot'a Mesaj Gönderme Testi
1. Telegram'da yeni oluşturduğunuz bot'u arayın
2. `/start` yazarak konuşmayı başlatın
3. Bot henüz cevap vermeyecek (normal, n8n bağlanınca çalışacak)

---

## 🤖 ADIM 3: Google Gemini API Anahtarı Alma (ÜCRETSİZ!)

### Gemini Ücretsiz mi?
✅ **EVET, Gemini API ücretsiz tier'a sahip!**

| Özellik | Ücretsiz Tier |
|---------|--------------|
| Maliyet | 0 TL / 0 USD |
| Günlük İstek | ~100-1000 istek/gün |
| Dakika Başı | 5-15 istek/dakika |
| Token Limiti | ~250.000 token/dakika |
| Kredi Kartı | ❌ Gerekmez |

> 💡 YouTube Shorts scripti yazmak için bu limitler fazlasıyla yeterli!

### 3.1 API Anahtarı Alma
1. [Google AI Studio](https://aistudio.google.com/app/apikey) adresine gidin
2. Google hesabınızla giriş yapın
3. **"Create API Key"** (API Anahtarı Oluştur) butonuna tıklayın
4. Bir proje seçin veya yeni oluşturun
5. API anahtarınızı kopyalayın, şuna benzer:
   ```
   AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
   ```
6. **Bu anahtarı güvenli bir yerde saklayın!**

---

## 📺 ADIM 4: YouTube Kanalı Oluşturma

### 4.1 YouTube Kanalı Açma (Ücretsiz)
1. [YouTube](https://www.youtube.com) adresine gidin
2. Sağ üstteki profil resminize tıklayın
3. **"Kanal oluştur"** veya **"Create a channel"** seçeneğine tıklayın
4. **"Marka Hesabı kullan"** seçin (ileride yönetim kolaylığı sağlar)
5. Kanal adınızı girin (örnek: `AI Shorts Türkiye`)
6. Handle belirleyin (örnek: `@AIShortsTR`)

### 4.2 Kanal Ayarları
1. [YouTube Studio](https://studio.youtube.com) adresine gidin
2. Sol menüden **Ayarlar** → **Kanal** → **Özellik uygunluğu** gidin
3. **Telefon doğrulaması** yapın (özel thumbnail için gerekli)
4. **Kanal** → **Temel bilgiler** bölümünden:
   - Ülke: Türkiye
   - Anahtar kelimeler: `shorts, yapay zeka, ai, türkçe`

### 4.3 YouTube API Etkinleştirme (n8n bağlantısı için)
1. [Google Cloud Console](https://console.cloud.google.com/) adresine gidin
2. Üstteki proje seçiciden **"Yeni Proje"** oluşturun (isim: `n8n-youtube`)
3. Sol menüden **API ve Hizmetler** → **Kitaplık** gidin
4. **"YouTube Data API v3"** arayın ve **ETKİNLEŞTİR** tıklayın
5. Sol menüden **API ve Hizmetler** → **Kimlik Bilgileri** gidin
6. **"+ KİMLİK BİLGİSİ OLUŞTUR"** → **"OAuth İstemci Kimliği"** seçin
7. Uygulama türü: **"Web uygulaması"**
8. Yetkili yönlendirme URI'leri: `http://localhost:5678/rest/oauth2-credential/callback`
9. **"Oluştur"** tıklayın
10. **Client ID** ve **Client Secret** değerlerini kaydedin

> ⚠️ **OAuth Onay Ekranı:** İlk seferde "OAuth onay ekranını yapılandırın" diyebilir. "Harici" seçip, gerekli alanları doldurun. Test modunda kendinizi test kullanıcısı olarak ekleyin.

---

## ⚙️ ADIM 5: n8n'de Credential (Kimlik) Ayarlama

### 5.1 n8n'i Açın
1. `http://localhost:5678` adresine gidin
2. İlk açılışta hesap oluşturmanız istenebilir

### 5.2 Telegram Credential
1. Sol menüden **Credentials** (Kimlik Bilgileri) → **Add Credential** tıklayın
2. **"Telegram"** arayın ve seçin
3. **Access Token**: BotFather'dan aldığınız token'ı yapıştırın
4. **Save** tıklayın

### 5.3 Google Gemini Credential
1. **Add Credential** → **"Google Gemini"** veya **"Google PaLM"** arayın
2. **API Key**: Google AI Studio'dan aldığınız anahtarı yapıştırın
3. **Save** tıklayın

### 5.4 YouTube (Google OAuth2) Credential
1. **Add Credential** → **"YouTube"** veya **"Google OAuth2"** arayın
2. **Client ID**: Google Cloud Console'dan aldığınız ID
3. **Client Secret**: Google Cloud Console'dan aldığınız secret
4. **"Sign in with Google"** tıklayıp YouTube kanalınıza izin verin
5. **Save** tıklayın

---

## 📥 ADIM 6: Workflow'u İçe Aktarma

1. n8n arayüzünde **"Import from File"** (Dosyadan İçe Aktar) tıklayın
   - Alternatif: Ctrl+I kısayolunu kullanın
2. Projenizdeki `n8n-workflow.json` dosyasını seçin
3. Workflow açılacak — tüm node'ları göreceksiniz
4. Her node'a tıklayıp doğru credential'ı seçtiğinizden emin olun
5. Sağ üstten **"Active"** anahtarını açık konuma getirin
6. **Tebrikler!** Workflow aktif! 🎉

---

## 🧪 ADIM 7: Test Etme

1. Telegram'da bot'unuza şu mesajı gönderin:
   ```
   Konu: Sabah rutini 5 alışkanlık
   ```
2. n8n workflow'unda **Executions** sekmesinden çalışmayı izleyin
3. Gemini bir script oluşturacak
4. Video oluşturulacak (metin + arka plan)
5. YouTube Shorts olarak yüklenecek
6. Telegram'dan onay mesajı alacaksınız ✅

---

## ❓ Sık Sorulan Sorular

**S: start-n8n.bat açılıp hemen kapanıyor?**
> Bu sorun düzeltildi! Güncel `start-n8n.bat` dosyasını kullanın. Alternatif olarak `start-n8n-background.bat` ile PM2 üzerinden başlatın.

**S: n8n komut satırında açılmıyor?**
> Node.js'in yüklü olduğundan emin olun: `node -v` yazıp kontrol edin. Yüklü değilse [nodejs.org](https://nodejs.org) adresinden LTS sürümü indirin.

**S: FFmpeg kurulu mu kontrol etmek istiyorum?**
> PowerShell'de `ffmpeg -version` yazın. Kurulu değilse: `winget install ffmpeg`

**S: Telegram bot mesajıma cevap vermiyor?**
> n8n'in çalıştığından ve workflow'un "Active" olduğundan emin olun.

**S: YouTube'a video yüklenmiyor?**
> OAuth credential'ın doğru ayarlandığından ve YouTube API'nin etkin olduğundan emin olun.

**S: Gemini "429 Too Many Requests" hatası veriyor?**
> Ücretsiz tier limitini aştınız. Birkaç dakika bekleyin ve tekrar deneyin.

**S: PM2'yi nasıl durdurabilirim?**
> `npx pm2 stop n8n-shorts` komutuyla durdurabilirsiniz. Tamamen kaldırmak için: `npx pm2 delete n8n-shorts`

---

## 🔗 Faydalı Linkler

| Kaynak | Link |
|--------|------|
| n8n Yerel Arayüz | http://localhost:5678 |
| Google AI Studio | https://aistudio.google.com |
| Google Cloud Console | https://console.cloud.google.com |
| YouTube Studio | https://studio.youtube.com |
| Telegram BotFather | https://t.me/BotFather |
| n8n Dokümanları | https://docs.n8n.io |
