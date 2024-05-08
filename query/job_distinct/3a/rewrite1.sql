create or replace view semiJoinView6837560393350773668 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (movie_id) in (select (movie_id) from movie_info AS mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view semiJoinView6124067227027575564 as select v12, v1 from semiJoinView6837560393350773668 where (v1) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView7959795947915687523 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (v12) from semiJoinView6124067227027575564) and production_year>2005;
create or replace view tAux52 as select v13 from semiJoinView7959795947915687523;
select distinct v13 from tAux52;
