create or replace view semiJoinView864744858857462810 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView903730690365709677 as select movie_id as v12, info as v7 from movie_info AS mi where (movie_id) in (select (v12) from semiJoinView864744858857462810) and info= 'Bulgaria';
create or replace view semiJoinView685920402004185972 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (v12) from semiJoinView903730690365709677) and production_year>2010;
create or replace view tAux65 as select v13 from semiJoinView685920402004185972;
select distinct v13 from tAux65;
