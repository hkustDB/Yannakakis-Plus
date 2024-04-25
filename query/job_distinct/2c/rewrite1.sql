create or replace view semiJoinView7725251980003299601 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView5907703084091686924 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[sm]');
create or replace view semiJoinView676450995788430977 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView7725251980003299601);
create or replace view semiJoinView2933397246426720370 as select v12, v20 from semiJoinView676450995788430977 where (v12) in (select (v12) from semiJoinView5907703084091686924);
create or replace view tAux81 as select v20 from semiJoinView2933397246426720370;
select distinct v20 from tAux81;
