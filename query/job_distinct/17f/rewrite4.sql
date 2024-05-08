create or replace view semiJoinView5424518593036660913 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView653694520078176155 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView8579619137947313912 as select v3, v25 from semiJoinView5424518593036660913 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView3639689487130448214 as select v3, v20 from semiJoinView653694520078176155 where (v3) in (select (v3) from semiJoinView8579619137947313912);
create or replace view semiJoinView6167588126301874691 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView3639689487130448214);
create or replace view semiJoinView7975146269098397329 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6167588126301874691);
create or replace view nAux47 as select v27 from semiJoinView7975146269098397329;
select distinct v27 from nAux47;
