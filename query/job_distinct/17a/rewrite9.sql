create or replace view semiJoinView2135931269761376288 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView885112699350420282 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (movie_id) in (select (v3) from semiJoinView2135931269761376288);
create or replace view semiJoinView5506209262478157029 as select v3, v25 from semiJoinView885112699350420282 where (v25) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView5015163282640540244 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView5506209262478157029);
create or replace view semiJoinView7595863787709370596 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView5015163282640540244);
create or replace view semiJoinView2470883732386758066 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView7595863787709370596);
create or replace view nAux43 as select v27 from semiJoinView2470883732386758066;
select distinct v27 from nAux43;
