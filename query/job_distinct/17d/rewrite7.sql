create or replace view semiJoinView5727979566053110220 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView5108749253056770537 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView3134105371346554262 as select v3, v25 from semiJoinView5727979566053110220 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView4083098005551418237 as select v3, v20 from semiJoinView5108749253056770537 where (v3) in (select (v3) from semiJoinView3134105371346554262);
create or replace view semiJoinView341981590919103992 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView4083098005551418237);
create or replace view semiJoinView8770809802976143657 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView341981590919103992);
create or replace view nAux91 as select v27 from semiJoinView8770809802976143657;
select distinct v27 from nAux91;
