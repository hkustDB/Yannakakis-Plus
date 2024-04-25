create or replace view semiJoinView312863328334051247 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView5019893299111257663 as select movie_id as v12, info as v7 from movie_info AS mi where (movie_id) in (select (v12) from semiJoinView312863328334051247) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view semiJoinView1674543688929302951 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (v12) from semiJoinView5019893299111257663) and production_year>1990;
create or replace view tAux9 as select v13 from semiJoinView1674543688929302951;
select distinct v13 from tAux9;
