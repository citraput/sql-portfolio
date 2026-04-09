-- ============================================
-- Soal 01: Borrower dengan pinjaman aktif > 1
-- Topik  : CTE + JOIN + HAVING
-- Dataset: Amartha Practice (BigQuery)
-- Tanggal: 2024-12
-- ============================================

WITH pinjaman_aktif AS (
  SELECT
    b.borrower_id,
    b.name,
    b.region
  FROM borrowers b
  JOIN loans l ON b.borrower_id = l.borrower_id
  WHERE l.status = 'active'
)
SELECT
  borrower_id,
  name,
  region,
  COUNT(*) AS total_pinjaman_aktif
FROM pinjaman_aktif
GROUP BY 1, 2, 3
HAVING total_pinjaman_aktif > 1
ORDER BY total_pinjaman_aktif DESC