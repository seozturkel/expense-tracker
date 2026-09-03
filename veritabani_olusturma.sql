-- Kategoriler Tablosu (Market, Fatura, Kira vb.)
CREATE TABLE Kategoriler (
    KategoriID SERIAL PRIMARY KEY,
    KategoriAdi VARCHAR(50) NOT NULL
);

-- Harcamalar/İşlemler Tablosu
CREATE TABLE Harcamalar (
    HarcamaID SERIAL PRIMARY KEY,
    KategoriID INT REFERENCES Kategoriler(KategoriID),
    Tutar DECIMAL(10, 2) NOT NULL,
    Aciklama VARCHAR(150),
    HarcamaTarihi DATE NOT NULL  
-- Kategorileri ekleyelim
INSERT INTO Kategoriler (KategoriAdi) VALUES 
('Market'), 
('Faturalar'), 
('Ulaşım'), 
('Eğlence');

-- Harcamaları ekleyelim
INSERT INTO Harcamalar (KategoriID, Tutar, Aciklama, HarcamaTarihi) VALUES 
(1, 450.50, 'Haftalık market alışverişi', '2026-06-01'),
(2, 350.00, 'Elektrik ve su faturası', '2026-06-03'),
(3, 120.00, 'Metro kartı dolumu', '2026-06-04'),
(1, 210.00, 'Ekmek ve süt', '2026-06-05'),
(4, 300.00, 'Sinema bileti', '2026-06-06'),
(2, 600.00, 'İnternet faturası', '2026-06-07');

SELECT k.KategoriAdi, SUM(h.Tutar) AS ToplamHarcama
FROM Kategoriler k
JOIN Harcamalar h ON k.KategoriID = h.KategoriID
GROUP BY k.KategoriAdi
ORDER BY ToplamHarcama DESC;

SELECT Aciklama, Tutar, HarcamaTarihi
FROM Harcamalar
WHERE Tutar > (SELECT AVG(Tutar) FROM Harcamalar);
