create or replace view semiJoinView5614615105358424986 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView213559753607211206 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView5614615105358424986);
create or replace view semiJoinView1459728043758276049 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3533756132694051915 as select v3, v25 from semiJoinView1459728043758276049 where (v3) in (select (v3) from semiJoinView213559753607211206);
create or replace view semiJoinView1567131834296732921 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView3533756132694051915);
create or replace view semiJoinView7931676435299526921 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView1567131834296732921);
create or replace view nAux59 as select v27 from semiJoinView7931676435299526921;
select distinct v27 from nAux59;
