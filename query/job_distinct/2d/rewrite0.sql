create or replace view semiJoinView7034290334298462570 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3191622499722712550 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView7034290334298462570);
create or replace view semiJoinView5903592833146932992 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView4682255775125203967 as select v12, v20 from semiJoinView3191622499722712550 where (v12) in (select (v12) from semiJoinView5903592833146932992);
create or replace view tAux53 as select v20 from semiJoinView4682255775125203967;
select distinct v20 from tAux53;
