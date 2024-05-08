create or replace view semiJoinView4308675431162616690 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView1086572410370618197 as select movie_id as v12, info as v7 from movie_info AS mi where (movie_id) in (select (v12) from semiJoinView4308675431162616690) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view semiJoinView3002062245207526881 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (v12) from semiJoinView1086572410370618197) and production_year>2005;
create or replace view tAux26 as select v13 from semiJoinView3002062245207526881;
select distinct v13 from tAux26;
