create or replace view semiJoinView7904993458974687813 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (movie_id) in (select (movie_id) from movie_info AS mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view semiJoinView3696638641294851777 as select v12, v1 from semiJoinView7904993458974687813 where (v1) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView2452240455264983039 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (v12) from semiJoinView3696638641294851777) and production_year>1990;
create or replace view tAux43 as select v13 from semiJoinView2452240455264983039;
select distinct v13 from tAux43;
