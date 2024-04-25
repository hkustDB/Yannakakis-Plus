create or replace view semiJoinView9182644996609169878 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView6768244094257457603 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView4566080187520739595 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7922195091273000490 as select v3, v20 from semiJoinView9182644996609169878 where (v3) in (select (v3) from semiJoinView4566080187520739595);
create or replace view semiJoinView5555845523016343342 as select v26, v3 from semiJoinView6768244094257457603 where (v3) in (select (v3) from semiJoinView7922195091273000490);
create or replace view semiJoinView2255215880357441683 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView5555845523016343342) and name LIKE 'X%';
create or replace view nAux53 as select v27 from semiJoinView2255215880357441683;
select distinct v27 from nAux53;
