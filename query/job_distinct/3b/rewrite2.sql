create or replace view semiJoinView5238734619782520202 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (movie_id) in (select (movie_id) from movie_info AS mi where info= 'Bulgaria');
create or replace view semiJoinView9218788980791211012 as select v12, v1 from semiJoinView5238734619782520202 where (v1) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView313496461242365822 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (v12) from semiJoinView9218788980791211012) and production_year>2010;
create or replace view tAux32 as select v13 from semiJoinView313496461242365822;
select distinct v13 from tAux32;
