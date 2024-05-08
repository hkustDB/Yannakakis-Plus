create or replace view semiJoinView7335231995630371626 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView5854702708472013173 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView8304128036511978692 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView7335231995630371626);
create or replace view semiJoinView6739089157265594682 as select v3 from semiJoinView8304128036511978692 where (v3) in (select (v3) from semiJoinView5854702708472013173);
create or replace view semiJoinView2854187125593432370 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView6739089157265594682);
create or replace view semiJoinView5453049816081605227 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView2854187125593432370);
create or replace view nAux80 as select v27 from semiJoinView5453049816081605227;
select distinct v27 from nAux80;
