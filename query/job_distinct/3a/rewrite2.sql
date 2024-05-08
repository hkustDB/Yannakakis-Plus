create or replace view semiJoinView2938230946175458555 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (movie_id) from movie_info AS mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German')) and production_year>2005;
create or replace view semiJoinView4682823594815345725 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView794332852750524462 as select v12, v13, v16 from semiJoinView2938230946175458555 where (v12) in (select (v12) from semiJoinView4682823594815345725);
create or replace view tAux76 as select v13 from semiJoinView794332852750524462;
select distinct v13 from tAux76;
