
-- 1. Global Number 
SELECT SUM(new_cases) as SummedCases, SUM(CAST (new_deaths as int)) AS SummedDeaths, SUM(CAST (new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
FROM portfolio.dbo.CovidDeaths
WHERE continent is not null 
ORDER BY 1,2 

-- 2. break things in continent because location also contains continent names, and exclude EU because it is part of Europe
SELECT location, SUM (CAST(new_deaths as int))  AS TotalDeathCount 
FROM portfolio.dbo.CovidDeaths
WHERE continent is null and location not in ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount Desc

-- 3. Countries having high infection rate and max cases per population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM portfolio.dbo.CovidDeaths
GROUP BY location, Population
ORDER BY PercentPopulationInfected desc

-- 4. Countries having high infection rate and max cases per population with date
SELECT location, population, date, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM portfolio.dbo.CovidDeaths
GROUP BY location, Population, date
ORDER BY PercentPopulationInfected desc