-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 13, 2024 at 10:13 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laundry_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `TampilkanPesanan` ()   BEGIN
    SELECT * FROM Pesanan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStatusPesanan` (IN `ID` INT, IN `TanggalSelesai` DATE)   BEGIN
    IF EXISTS (SELECT 1 FROM Pesanan WHERE ID_Pesanan = ID) THEN
        UPDATE Pesanan SET Tanggal_Selesai = TanggalSelesai WHERE ID_Pesanan = ID;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pesanan tidak ditemukan';
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `HitungPembayaranPelanggan` (`ID_Pelanggan` INT, `Metode` VARCHAR(50)) RETURNS DECIMAL(10,2)  BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(P.Jumlah) INTO total 
    FROM Pembayaran P
    JOIN Pesanan O ON P.ID_Pesanan = O.ID_Pesanan
    WHERE O.ID_Pelanggan = ID_Pelanggan AND P.Metode_Pembayaran = Metode;
    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `HitungTotalPembayaran` () RETURNS DECIMAL(10,2)  BEGIN
    DECLARE total DECIMAL(10, 2);
    
    SELECT SUM(Jumlah) INTO total FROM Pembayaran;
    
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `ID_Karyawan` int(11) NOT NULL,
  `Nama_Karyawan` varchar(100) DEFAULT NULL,
  `Posisi` varchar(50) DEFAULT NULL,
  `Gaji` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`ID_Karyawan`, `Nama_Karyawan`, `Posisi`, `Gaji`) VALUES
(1, 'Andi', 'Kasir', 3000000.00),
(2, 'Budi', 'Petugas Cuci', 2500000.00),
(3, 'Cici', 'Petugas Setrika', 2500000.00),
(4, 'Didi', 'Petugas Pengiriman', 2700000.00),
(5, 'Eka', 'Supervisor', 3500000.00),
(6, 'Fifi', 'Kasir', 3000000.00),
(7, 'Gilang', 'Petugas Cuci', 2500000.00),
(8, 'Hana', 'Petugas Setrika', 2500000.00),
(9, 'Iwan', 'Petugas Pengiriman', 2700000.00),
(10, 'Joko', 'Manager', 4000000.00),
(11, 'Kiki', 'Kasir', 3000000.00),
(12, 'Lina', 'Petugas Cuci', 2500000.00),
(13, 'Maya', 'Petugas Setrika', 2500000.00),
(14, 'Nina', 'Petugas Pengiriman', 2700000.00),
(15, 'Oki', 'Supervisor', 3500000.00);

-- --------------------------------------------------------

--
-- Table structure for table `layanan`
--

CREATE TABLE `layanan` (
  `ID_Layanan` int(11) NOT NULL,
  `Nama_Layanan` varchar(100) DEFAULT NULL,
  `Harga` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `layanan`
--

INSERT INTO `layanan` (`ID_Layanan`, `Nama_Layanan`, `Harga`) VALUES
(1, 'Cuci Kering', 20000.00),
(2, 'Cuci Basah', 15000.00),
(3, 'Setrika', 10000.00),
(4, 'Cuci dan Setrika', 25000.00),
(5, 'Cuci Karpet', 50000.00),
(6, 'Cuci Sepatu', 30000.00),
(7, 'Dry Cleaning', 45000.00),
(8, 'Cuci Selimut', 40000.00),
(9, 'Cuci Boneka', 35000.00),
(10, 'Cuci Tas', 60000.00),
(11, 'Cuci Gordyn', 70000.00),
(12, 'Cuci Jaket', 30000.00),
(13, 'Cuci Bed Cover', 80000.00),
(14, 'Cuci Baju', 20000.00),
(15, 'Cuci Celana', 15000.00),
(16, 'Cuci Helm', 25000.00);

-- --------------------------------------------------------

--
-- Table structure for table `log_pembayaran`
--

CREATE TABLE `log_pembayaran` (
  `ID_Log` int(11) NOT NULL,
  `ID_Pembayaran` int(11) DEFAULT NULL,
  `Tanggal_Pembayaran` date DEFAULT NULL,
  `Jumlah` decimal(10,2) DEFAULT NULL,
  `Metode_Pembayaran` varchar(50) DEFAULT NULL,
  `Aksi` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `ID_Pelanggan` int(11) NOT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Alamat` varchar(255) DEFAULT NULL,
  `Telepon` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`ID_Pelanggan`, `Nama`, `Alamat`, `Telepon`) VALUES
(1, 'Ahmad', 'Jl. Merdeka No.1', '081234567890'),
(2, 'Budi', 'Jl. Soekarno No.2', '081234567891'),
(3, 'Citra', 'Jl. Hatta No.3', '081234567892'),
(4, 'Dewi', 'Jl. Sudirman No.4', '081234567893'),
(5, 'Eko', 'Jl. Thamrin No.5', '081234567894'),
(6, 'Fahmi', 'Jl. Sisingamangaraja No.6', '081234567895'),
(7, 'Gita', 'Jl. Diponegoro No.7', '081234567896'),
(8, 'Hani', 'Jl. Pattimura No.8', '081234567897'),
(9, 'Iwan', 'Jl. Gatot Subroto No.9', '081234567898'),
(10, 'Joko', 'Jl. Ahmad Yani No.10', '081234567899'),
(11, 'Kiki', 'Jl. S. Parman No.11', '081234567900'),
(12, 'Lina', 'Jl. Antasari No.12', '081234567901'),
(13, 'Maya', 'Jl. M.H. Thamrin No.13', '081234567902'),
(14, 'Nina', 'Jl. Sudirman No.14', '081234567903'),
(15, 'Oki', 'Jl. K.H. Mas Mansyur No.15', '081234567904');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `ID_Pembayaran` int(11) NOT NULL,
  `ID_Pesanan` int(11) DEFAULT NULL,
  `Tanggal_Pembayaran` date DEFAULT NULL,
  `Jumlah` decimal(10,2) DEFAULT NULL,
  `Metode_Pembayaran` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`ID_Pembayaran`, `ID_Pesanan`, `Tanggal_Pembayaran`, `Jumlah`, `Metode_Pembayaran`) VALUES
(2, 2, '2023-07-04', 15000.00, 'Debit'),
(3, 3, '2023-07-05', 10000.00, 'Credit'),
(4, 4, '2023-07-06', 25000.00, 'Cash'),
(5, 5, '2023-07-07', 50000.00, 'Debit'),
(6, 6, '2023-07-08', 30000.00, 'Credit'),
(7, 7, '2023-07-09', 45000.00, 'Cash'),
(8, 8, '2023-07-10', 40000.00, 'Debit'),
(9, 9, '2023-07-11', 35000.00, 'Credit'),
(10, 10, '2023-07-12', 60000.00, 'Cash'),
(11, 11, '2023-07-13', 70000.00, 'Debit'),
(12, 12, '2023-07-14', 30000.00, 'Credit'),
(13, 13, '2023-07-15', 80000.00, 'Cash'),
(14, 14, '2023-07-16', 20000.00, 'Debit'),
(15, 15, '2023-07-17', 15000.00, 'Credit');

--
-- Triggers `pembayaran`
--
DELIMITER $$
CREATE TRIGGER `AfterDeletePembayaran` AFTER DELETE ON `pembayaran` FOR EACH ROW BEGIN
    INSERT INTO Log_Pembayaran (ID_Pembayaran, Tanggal_Pembayaran, Jumlah, Metode_Pembayaran, Aksi)
    VALUES (OLD.ID_Pembayaran, OLD.Tanggal_Pembayaran, OLD.Jumlah, OLD.Metode_Pembayaran, 'DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterInsertPembayaran` AFTER INSERT ON `pembayaran` FOR EACH ROW BEGIN
    INSERT INTO Log_Pembayaran (ID_Pembayaran, Tanggal_Pembayaran, Jumlah, Metode_Pembayaran, Aksi)
    VALUES (NEW.ID_Pembayaran, NEW.Tanggal_Pembayaran, NEW.Jumlah, NEW.Metode_Pembayaran, 'INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterUpdatePembayaran` AFTER UPDATE ON `pembayaran` FOR EACH ROW BEGIN
    INSERT INTO Log_Pembayaran (ID_Pembayaran, Tanggal_Pembayaran, Jumlah, Metode_Pembayaran, Aksi)
    VALUES (NEW.ID_Pembayaran, NEW.Tanggal_Pembayaran, NEW.Jumlah, NEW.Metode_Pembayaran, 'UPDATE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeDeletePembayaran` BEFORE DELETE ON `pembayaran` FOR EACH ROW BEGIN
    INSERT INTO Log_Pembayaran (ID_Pembayaran, Tanggal_Pembayaran, Jumlah, Metode_Pembayaran, Aksi)
    VALUES (OLD.ID_Pembayaran, OLD.Tanggal_Pembayaran, OLD.Jumlah, OLD.Metode_Pembayaran, 'DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeInsertPembayaran` BEFORE INSERT ON `pembayaran` FOR EACH ROW BEGIN
    IF NEW.Jumlah <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jumlah pembayaran harus lebih dari 0';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeUpdatePembayaran` BEFORE UPDATE ON `pembayaran` FOR EACH ROW BEGIN
    IF NEW.Jumlah <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jumlah pembayaran harus lebih dari 0';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `ID_Pesanan` int(11) NOT NULL,
  `ID_Pelanggan` int(11) DEFAULT NULL,
  `ID_Layanan` int(11) DEFAULT NULL,
  `ID_Karyawan` int(11) DEFAULT NULL,
  `Tanggal_Pesanan` date DEFAULT NULL,
  `Tanggal_Selesai` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`ID_Pesanan`, `ID_Pelanggan`, `ID_Layanan`, `ID_Karyawan`, `Tanggal_Pesanan`, `Tanggal_Selesai`) VALUES
(1, 1, 1, 1, '2023-07-01', '2023-07-10'),
(2, 2, 2, 2, '2023-07-02', '2023-07-04'),
(3, 3, 3, 3, '2023-07-03', '2023-07-05'),
(4, 4, 4, 4, '2023-07-04', '2023-07-06'),
(5, 5, 5, 5, '2023-07-05', '2023-07-07'),
(6, 6, 6, 6, '2023-07-06', '2023-07-08'),
(7, 7, 7, 7, '2023-07-07', '2023-07-09'),
(8, 8, 8, 8, '2023-07-08', '2023-07-10'),
(9, 9, 9, 9, '2023-07-09', '2023-07-11'),
(10, 10, 10, 10, '2023-07-10', '2023-07-12'),
(11, 11, 11, 11, '2023-07-11', '2023-07-13'),
(12, 12, 12, 12, '2023-07-12', '2023-07-14'),
(13, 13, 13, 13, '2023-07-13', '2023-07-15'),
(14, 14, 14, 14, '2023-07-14', '2023-07-16'),
(15, 15, 15, 15, '2023-07-15', '2023-07-17');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_detailpesanan`
-- (See below for the actual view)
--
CREATE TABLE `v_detailpesanan` (
`ID_Pesanan` int(11)
,`Nama` varchar(100)
,`Nama_Layanan` varchar(100)
,`Nama_Karyawan` varchar(100)
,`Tanggal_Pesanan` date
,`Tanggal_Selesai` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_layananharga`
-- (See below for the actual view)
--
CREATE TABLE `v_layananharga` (
`Nama_Layanan` varchar(100)
,`Harga` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pesananpelanggan`
-- (See below for the actual view)
--
CREATE TABLE `v_pesananpelanggan` (
`ID_Pesanan` int(11)
,`Nama` varchar(100)
,`Tanggal_Pesanan` date
,`Tanggal_Selesai` date
);

-- --------------------------------------------------------

--
-- Structure for view `v_detailpesanan`
--
DROP TABLE IF EXISTS `v_detailpesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_detailpesanan`  AS SELECT `o`.`ID_Pesanan` AS `ID_Pesanan`, `c`.`Nama` AS `Nama`, `s`.`Nama_Layanan` AS `Nama_Layanan`, `e`.`Nama_Karyawan` AS `Nama_Karyawan`, `o`.`Tanggal_Pesanan` AS `Tanggal_Pesanan`, `o`.`Tanggal_Selesai` AS `Tanggal_Selesai` FROM (((`pesanan` `o` join `pelanggan` `c` on(`o`.`ID_Pelanggan` = `c`.`ID_Pelanggan`)) join `layanan` `s` on(`o`.`ID_Layanan` = `s`.`ID_Layanan`)) join `karyawan` `e` on(`o`.`ID_Karyawan` = `e`.`ID_Karyawan`))WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `v_layananharga`
--
DROP TABLE IF EXISTS `v_layananharga`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_layananharga`  AS SELECT `layanan`.`Nama_Layanan` AS `Nama_Layanan`, `layanan`.`Harga` AS `Harga` FROM `layanan` ;

-- --------------------------------------------------------

--
-- Structure for view `v_pesananpelanggan`
--
DROP TABLE IF EXISTS `v_pesananpelanggan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pesananpelanggan`  AS SELECT `p`.`ID_Pesanan` AS `ID_Pesanan`, `c`.`Nama` AS `Nama`, `p`.`Tanggal_Pesanan` AS `Tanggal_Pesanan`, `p`.`Tanggal_Selesai` AS `Tanggal_Selesai` FROM (`pesanan` `p` join `pelanggan` `c` on(`p`.`ID_Pelanggan` = `c`.`ID_Pelanggan`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`ID_Karyawan`);

--
-- Indexes for table `layanan`
--
ALTER TABLE `layanan`
  ADD PRIMARY KEY (`ID_Layanan`);

--
-- Indexes for table `log_pembayaran`
--
ALTER TABLE `log_pembayaran`
  ADD PRIMARY KEY (`ID_Log`),
  ADD KEY `ID_Pembayaran` (`ID_Pembayaran`,`Tanggal_Pembayaran`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`ID_Pelanggan`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`ID_Pembayaran`),
  ADD KEY `ID_Pesanan` (`ID_Pesanan`),
  ADD KEY `idx_metode_jumlah` (`Metode_Pembayaran`,`Jumlah`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`ID_Pesanan`),
  ADD KEY `ID_Layanan` (`ID_Layanan`),
  ADD KEY `ID_Karyawan` (`ID_Karyawan`),
  ADD KEY `idx_pesanan_tanggal` (`ID_Pelanggan`,`Tanggal_Pesanan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `ID_Karyawan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `layanan`
--
ALTER TABLE `layanan`
  MODIFY `ID_Layanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `log_pembayaran`
--
ALTER TABLE `log_pembayaran`
  MODIFY `ID_Log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `ID_Pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `ID_Pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `ID_Pesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`ID_Pesanan`) REFERENCES `pesanan` (`ID_Pesanan`);

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`ID_Pelanggan`) REFERENCES `pelanggan` (`ID_Pelanggan`),
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`ID_Layanan`) REFERENCES `layanan` (`ID_Layanan`),
  ADD CONSTRAINT `pesanan_ibfk_3` FOREIGN KEY (`ID_Karyawan`) REFERENCES `karyawan` (`ID_Karyawan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
