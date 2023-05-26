USE FuramaManagement;
-- 2.Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự. 
SELECT * FROM nhan_vien
where ho_ten like 'H%' or ho_ten like  'T%' or ho_ten like 'K%'AND length(ho_ten) <= 15;
;
-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
SELECT * FROM khach_hang
WHERE YEAR(CURRENT_DATE) - YEAR(ngay_sinh) BETWEEN 18 and 50
AND (dia_chi LIKE '%Đà Nẵng%' OR dia_chi LIKE '%Quảng Trị%');
-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
SELECT kh.ho_ten, COUNT(hd.ma_khach_hang)
FROM khach_hang kh
JOIN loai_khach lk ON kh.ma_loai_khach = lk.ma_loai_khach
JOIN hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
WHERE lk.ten_loai_khach = 'Diamond'
GROUP BY kh.ho_ten;
-- 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
SELECT 
    khach_hang.ma_khach_hang,
    khach_hang.ho_ten,
    loai_khach.ten_loai_khach,
    hop_dong.ma_hop_dong,
    dich_vu.ten_dich_vu,
    hop_dong.ngay_lam_hop_dong,
    hop_dong.ngay_ket_thuc,
    (hop_dong_chi_tiet.so_luong * dich_vu_di_kem.gia + dich_vu.chi_phi_thue) AS tong_tien
FROM
    khach_hang
    LEFT JOIN loai_khach ON khach_hang.ma_loai_khach = loai_khach.ma_loai_khach
    LEFT JOIN hop_dong ON khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
    LEFT JOIN hop_dong_chi_tiet ON hop_dong.ma_hop_dong = hop_dong_chi_tiet.ma_hop_dong
    LEFT JOIN dich_vu ON hop_dong.ma_dich_vu = dich_vu.ma_dich_vu
    LEFT JOIN dich_vu_di_kem ON hop_dong_chi_tiet.ma_dich_vu_di_kem = dich_vu_di_kem.ma_dich_vu_di_kem
ORDER BY khach_hang.ma_khach_hang;
























SELECT kh.ma_khach_hang, kh.ho_ten, kh.ho_ten, hd.ma_hop_dong, dv.ten_dich_vu, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc, IFNULL(t.totalCPT + IFNULL(SUM(hdct.so_luong * dvdk.gia), 0),0) total FROM khach_hang kh
LEFT JOIN hop_dong hd USING(ma_khach_hang)
LEFT JOIN hop_dong_chi_tiet hdct USING(ma_hop_dong)
LEFT JOIN dich_vu_di_kem dvdk USING(ma_dich_vu_di_kem)
LEFT JOIN dich_vu dv USING(ma_dich_vu)
LEFT JOIN
(
SELECT hd.ma_hop_dong ,IFNULL(SUM(dv.chi_phi_thue), 0)  totalCPT FROM khach_hang kh
LEFT JOIN hop_dong hd USING(ma_khach_hang)
LEFT JOIN dich_vu dv USING(ma_dich_vu)
GROUP BY kh.ma_khach_hang
) t USING(ma_hop_dong)
GROUP BY kh.ma_khach_hang ;






















-- 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).

SELECT
    ma_dich_vu,
    ten_dich_vu,
    dien_tich,
    chi_phi_thue,
    ten_loai_dich_vu
from
    dich_vu
    JOIN loai_dich_vu USING (ma_loai_dich_vu)
WHERE
    ma_dich_vu not in (
        SELECT
            ma_dich_vu
        FROM
            dich_vu
            join hop_dong using (ma_dich_vu)
        WHERE
            month(ngay_lam_hop_dong) BETWEEN 1
            and 3
            and year(ngay_lam_hop_dong) = 2021
    );
-- 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.

SELECT
    ma_dich_vu,
    ten_dich_vu,
    dien_tich,
    so_nguoi_toi_da,
    chi_phi_thue,
    ten_loai_dich_vu
FROM
    dich_vu
JOIN loai_dich_vu USING (ma_loai_dich_vu)
WHERE
    ma_dich_vu IN (
        SELECT
            ma_dich_vu
        FROM
            hop_dong
        WHERE
            YEAR(ngay_lam_hop_dong) = 2020
    )
    AND ma_dich_vu NOT IN (
        SELECT
            ma_dich_vu
        FROM
            hop_dong
        WHERE
            YEAR(ngay_lam_hop_dong) = 2021
    );

-- 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
-- Cach 1:
SELECT DISTINCT ho_ten
FROM
    khach_hang;
-- Cach 2:
SELECT ho_ten
FROM khach_hang
GROUP BY ho_ten;
-- Cách 3:
SELECT ANY_VALUE(ho_ten) AS ho_ten
FROM khach_hang
GROUP BY ho_ten;
-- Cách 4:
SELECT
    ho_ten
FROM
    khach_hang
UNION
SELECT
    ho_ten
FROM
    khach_hang;
-- 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
SELECT MONTH(ngay_lam_hop_dong) AS thang, COUNT(hd.ma_khach_hang) AS so_luong_khach_hang
FROM hop_dong hd
WHERE YEAR(hd.ngay_lam_hop_dong) = 2021
GROUP BY thang
ORDER BY MONTH(hd.ngay_lam_hop_dong);
-- 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
SELECT
    hd.ma_hop_dong,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    sum(hd.tien_dat_coc) tong_tien_coc,
    IFNULL(sum(hdct.so_luong), 0) so_luong_dich_vu_di_kem
FROM
    hop_dong hd
    left JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
GROUP by
    hd.ma_hop_dong;


