create or replace view semiJoinView5190239201157735615 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (movie_id) from movie_info AS mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American')) and production_year>1990;
create or replace view semiJoinView4563049104474552 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView7316185259672111284 as select v12, v13, v16 from semiJoinView5190239201157735615 where (v12) in (select (v12) from semiJoinView4563049104474552);
create or replace view tAux27 as select v13 from semiJoinView7316185259672111284;
select distinct v13 from tAux27;
