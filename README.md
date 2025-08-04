# Shartflix-MovieApp-

| Uygulama Videosu |
|:---:|

https://github.com/user-attachments/assets/3830d3ad-3376-4c4f-8894-89175a6483c5

---

## 🚀 Temel Gereksinimler 

### 1. Kimlik Doğrulama 
- Giriş ve kayıt implementasyonu yapıldı.
- Token flutter_secure_storage ile güvenli şekilde saklandı.
- Başarılı girişte bloc listener ve go_router sayesinde sayfa geçişi yapıldı.

| Giriş Ekranı | Kayıt Ekranı  |
|:---:|:---:|
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-05 at 02 16 38" src="https://github.com/user-attachments/assets/dd231841-3f5e-440b-8c56-412124eb771d" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-05 at 02 16 46" src="https://github.com/user-attachments/assets/90f93b55-3953-42db-9644-5fcbf8f891eb" /> |

### 2. Ana Sayfa Özellikleri
- Sonsuz kaydırma (Infinite scroll) ile filmlerin dinamik olarak yüklenmesi sağlandı.
- Her sayfada 5 film gösterimi yapıldı (Pagination). 
- Otomatik yükleme göstergesi eklendi. 
- Aşağı çekerek yenileme (Pull-to-refresh) özelliği eklendi.
- Favori film ekleme/çıkarma işlemlerinde anlık UI güncellemesi yapıldı.
  
| Ana Sayfa | Ana Sayfa |
|:---:|:---:|
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-05 at 02 21 27" src="https://github.com/user-attachments/assets/e438493c-2ca3-4725-b878-b799b80715bd" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-05 at 02 21 49" src="https://github.com/user-attachments/assets/c025f664-d6f6-40fe-ab7b-b6afa5badf50" /> |

### 3. Profil Özellikleri 
- Kullanıcı bilgilerinin (isim, ID) görüntülenmesi yapıldı. 
- Kullanıcının favori filmlerinin listelenmesi.
- Profil fotoğrafı seçme kırpma ve yükleme özelliği eklendi.

| Profil Sayfası | Fotoğraf Seçme |
|:---:|:---:|
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-05 at 02 25 33" src="https://github.com/user-attachments/assets/8a64f59a-6766-4100-a85d-881739056501" />| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-05 at 02 26 11" src="https://github.com/user-attachments/assets/d89ec230-4683-4827-8325-07c1490ae806" /> |

### 4. Navigasyon 
- Bottom navbar go_router ile tasarlandı.
- Sayfa değişse de ana sayfa state korundu kaldığı yerden devam etti.

### 5. Kod Yapısı
- MVVM sayesinde, kullanıcı arayüzü ve iş mantığı arasındaki karmaşıklığı giderdim.
- Clean Architecture ile yazdığım projede, iş mantığını arayüzden tamamen ayırabildim. 
- Sayfa değişse de ana sayfa state korundu kaldığı yerden devam etti.
- Bloc State Management kullanarak, özellikle karmaşık durumlara sahip ekranlarda, uygulamanın durum yönetimini olay (event) ve durum (state) bazlı bir yaklaşımla daha düzenli hale getirdim. Bu, hem kodun okunabilirliğini artırdı hem de test edilebilirliğini kolaylaştırdı.


### 6. Sınırlı Teklif Bottom Sheet 
- Sınırlı Teklif bottom sheet tasarımını yaptım.

| Sınırlı Teklif |
|:---:|
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-05 at 02 31 33" src="https://github.com/user-attachments/assets/a4d0c064-84d5-4b00-9952-bc7766eae812" /> |

---

## 📌 Bonus Özellikler


- Custom Theme oluşturuldu ve dark light theme arasında geçiş yapmayı kolay hale getirildi.

- Navigation servis kuruldu. go_router

- Localization sınıfı eklendi. easy_localization kullanıldı ve tr en seçenekleri eklendi. Profildeki buttondan uygulamayı ingilizce yaparak deneyebilirsiniz. Tasarım bozmamak için tr seçeneğini eklemedim.

- Logger servisi kuruldu.

- FirebaseCrashlytics, Analytics kuruldu ve uygulamaya entegre edildi.

- Yüklenme animasyonu lottie kullanarak oluşturuldu ve uygulamanın her yerinde kullanıldı.

- flutter_secure_storage sayesinde güvenli token kullanımı yapıldı.

- Splash screen oluşturuldu ve uygulama iconu değiştirildi.

- Logger implementasyonu yapıldı.




