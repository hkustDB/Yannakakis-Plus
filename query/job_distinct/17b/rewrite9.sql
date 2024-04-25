create or replace view semiJoinView8941521862837624210 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView2704645245942549429 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7146034373848914111 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView2704645245942549429);
create or replace view semiJoinView6673453175198629680 as select v3, v20 from semiJoinView8941521862837624210 where (v3) in (select (v3) from semiJoinView7146034373848914111);
create or replace view semiJoinView3273487165572729547 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView6673453175198629680);
create or replace view semiJoinView6534926908230802644 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3273487165572729547);
create or replace view nAux52 as select v27 from semiJoinView6534926908230802644;
select distinct v27 from nAux52;
