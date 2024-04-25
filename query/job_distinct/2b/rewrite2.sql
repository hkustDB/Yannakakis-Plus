create or replace view semiJoinView357922934413977427 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3155972128469606820 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[nl]');
create or replace view semiJoinView7345418896966087632 as select v12, v18 from semiJoinView357922934413977427 where (v12) in (select (v12) from semiJoinView3155972128469606820);
create or replace view semiJoinView8785770927726652912 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView7345418896966087632);
create or replace view tAux71 as select v20 from semiJoinView8785770927726652912;
select distinct v20 from tAux71;
