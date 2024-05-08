create or replace view semiJoinView2680937005305584597 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView1193467903384349307 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[sm]');
create or replace view semiJoinView8876708167719423466 as select v12, v18 from semiJoinView2680937005305584597 where (v12) in (select (v12) from semiJoinView1193467903384349307);
create or replace view semiJoinView8700244601907680181 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView8876708167719423466);
create or replace view tAux93 as select v20 from semiJoinView8700244601907680181;
select distinct v20 from tAux93;
