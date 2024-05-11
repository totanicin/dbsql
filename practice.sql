-- 問1
-- 国名を全て抽出してください。
SELECT name FROM countries;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。
SELECT code, name, continent, region, surface_area
FROM countries
WHERE continent = 'Europe';

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。
SELECT code, name, continent, region, surface_area
FROM countries
WHERE continent != 'Europe';

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。
SELECT code, name, continent, region, surface_area, indep_year, population
FROM countries
WHERE population >= 100000;

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。
SELECT code, name, continent, region, surface_area
FROM countries
WHERE life_expectancy BETWEEN 56 AND 76;

-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。
SELECT id, name, country_code, district, population
FROM cities
WHERE country_code IN ('NLB', 'ALB', 'DZA');

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。
SELECT code, name, continent, region, surface_area, indep_year
FROM countries
WHERE indep_year IS NULL;

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。
SELECT code, name, continent, region, surface_area, indep_year
FROM countries
WHERE indep_year IS NOT NULL;

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。
SELECT code, name, continent, region, surface_area
FROM countries
WHERE name LIKE '%ia';

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。
SELECT code, name, continent, region, surface_area
FROM countries
WHERE name LIKE '%st%';

-- 問11
-- 名前が「an」で始まる国を抽出してください。
SELECT code, name, continent, region, surface_area, indep_year
FROM countries
WHERE name LIKE 'an%';

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
SELECT code, name, continent, region, surface_area, indep_year
FROM countries
WHERE indep_year < 1990 OR population > 100000;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。
SELECT code, name, continent, region, surface_area, indep_year
FROM countries
WHERE code IN ('DZA', 'ALB') AND indep_year < 1990;

-- 問14
-- 全ての地方をグループ化せずに表示してください。
SELECT region FROM countries;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」
SELECT CONCAT(name, 'の人口は', population, '人です') AS population_statement FROM countries;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT name, life_expectancy
FROM countries
WHERE life_expectancy IS NOT NULL
ORDER BY life_expectancy ASC;

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT name, life_expectancy
FROM countries
WHERE life_expectancy IS NOT NULL
ORDER BY life_expectancy DESC;

-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。
SELECT name, life_expectancy, indep_year
FROM countries
WHERE life_expectancy IS NOT NULL
ORDER BY life_expectancy DESC, indep_year DESC;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。
SELECT SUBSTRING(code, 1, 1) AS first_letter, name FROM countries;

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。
SELECT name, LENGTH(name) AS name_length FROM countries ORDER BY name_length DESC;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)
SELECT region, AVG(life_expectancy) AS avg_life_expectancy, AVG(population) AS avg_population FROM countries GROUP BY region;

-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)
SELECT region, MAX(life_expectancy) AS max_life_expectancy, MAX(population) AS max_population FROM countries GROUP BY region;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください
SELECT MIN(surface_area) FROM countries WHERE continent = 'Asia';

-- 問24
-- アジア大陸の表面積の合計を表示してください。
SELECT SUM(surface_area) FROM countries WHERE continent = 'Asia';

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。
SELECT c.name, cl.language FROM countries c JOIN countrylanguages cl ON c.code = cl.country_code;

-- 問26
-- 全ての国と言語と市区町村を表示してください。
SELECT c.name, cl.language, ct.name FROM countries c JOIN countrylanguages cl ON c.code = cl.country_code JOIN cities ct ON c.code = ct.country_code;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。
SELECT cele.name, c.name FROM celebrities cele LEFT JOIN countries c ON cele.country_code = c.code;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。
SELECT cele.name, c.name AS country_name, cl.language FROM celebrities cele JOIN countries c ON cele.country_code = c.code JOIN countrylanguages cl ON c.code = cl.country_code AND cl.is_official = 'T';

-- 問29
-- 全ての有名人の名前と国名をに出力してください。 ただしテーブル結合せずサブクエリを使用してください。
SELECT cele.name, (SELECT c.name FROM countries c WHERE c.code = cele.country_code) AS country_name FROM celebrities cele;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
SELECT
  c.code AS country_code,
  MAX(cele.age) AS Max_Age,
  MIN(cele.age) AS Min_Age
FROM
  countries c
JOIN
  celebrities cele ON c.code = cele.country_code
GROUP BY
  c.code
HAVING
  MAX(cele.age) >= 50 AND MIN(cele.age) <= 30;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。
SELECT '1991' AS year, COUNT(*) AS count FROM celebrities WHERE YEAR(birth) = 1991
UNION ALL
SELECT '1981' AS year, COUNT(*) AS count FROM celebrities WHERE YEAR(birth) = 1981;

-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
SELECT c.name, AVG(TIMESTAMPDIFF(YEAR, cele.birth, CURDATE())) AS avg_age 
FROM countries c 
JOIN celebrities cele ON c.code = cele.country_code 
GROUP BY c.name 
ORDER BY avg_age DESC;