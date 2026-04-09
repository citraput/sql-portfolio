-- ============================================
-- Soal 02: Aging report pinjaman overdue
-- Topik  : Aging Bucket + CASE WHEN + DATE_DIFF
-- Dataset: loans
-- Output : Distribusi keterlambatan per bucket
-- ============================================

WITH overdue_loans AS (
  SELECT
    loan_id,
    amount,
    DATE_DIFF(CURRENT_DATE(), due_date, DAY) AS hari_terlambat
  FROM `latihan-sql-492801.amartha_practice.loans`
  WHERE status = 'overdue'
)
SELECT
  CASE
    WHEN hari_terlambat BETWEEN 1  AND 30 THEN '1-30 hari'
    WHEN hari_terlambat BETWEEN 31 AND 60 THEN '31-60 hari'
    WHEN hari_terlambat BETWEEN 61 AND 90 THEN '61-90 hari'
    ELSE '>90 hari'
  END AS aging_bucket,
  COUNT(loan_id)  AS jumlah_loan,
  SUM(amount)     AS total_amount
FROM overdue_loans
GROUP BY aging_bucket
ORDER BY MIN(hari_terlambat)