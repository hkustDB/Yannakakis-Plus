create or replace view semiJoinView1225572161442897740 as select id as v12, title as v13, production_year as v16 from title AS t where (id) in (select (movie_id) from movie_info AS mi where info= 'Bulgaria') and production_year>2010;
create or replace view semiJoinView8029853486833276498 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView6846757834529895267 as select v12, v13, v16 from semiJoinView1225572161442897740 where (v12) in (select (v12) from semiJoinView8029853486833276498);
create or replace view tAux1 as select v13 from semiJoinView6846757834529895267;
select distinct v13 from tAux1;
