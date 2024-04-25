create or replace view semiJoinView780114866222439958 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView6953919368799245992 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8380596890849735808 as select v3, v25 from semiJoinView6953919368799245992 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView2659700356928060116 as select v3, v20 from semiJoinView780114866222439958 where (v3) in (select (v3) from semiJoinView8380596890849735808);
create or replace view semiJoinView7427948815776815408 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView2659700356928060116);
create or replace view semiJoinView6594061250831636038 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView7427948815776815408);
create or replace view nAux6 as select v27 from semiJoinView6594061250831636038;
select distinct v27 from nAux6;
