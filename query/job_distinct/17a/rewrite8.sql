create or replace view semiJoinView8741895616387897210 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7440320550825606606 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView8741895616387897210);
create or replace view semiJoinView5303131791796453474 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView6157179490523816393 as select v3 from semiJoinView7440320550825606606 where (v3) in (select (v3) from semiJoinView5303131791796453474);
create or replace view semiJoinView4439940697403155579 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView6157179490523816393);
create or replace view semiJoinView2797052158878546594 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView4439940697403155579);
create or replace view nAux23 as select v27 from semiJoinView2797052158878546594;
select distinct v27 from nAux23;
