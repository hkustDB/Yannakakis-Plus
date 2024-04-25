create or replace view semiJoinView558176911539224997 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[de]');
create or replace view semiJoinView7579296521319187120 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8868587523781509970 as select v12, v1 from semiJoinView558176911539224997 where (v12) in (select (v12) from semiJoinView7579296521319187120);
create or replace view semiJoinView5913704375508753902 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView8868587523781509970);
create or replace view tAux16 as select v20 from semiJoinView5913704375508753902;
select distinct v20 from tAux16;
