create or replace view semiJoinView3494333269847193088 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[de]');
create or replace view semiJoinView8578717708574319114 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (movie_id) in (select (v12) from semiJoinView3494333269847193088);
create or replace view semiJoinView4098155677704928446 as select v12, v18 from semiJoinView8578717708574319114 where (v18) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3013136161713907400 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView4098155677704928446);
create or replace view tAux14 as select v20 from semiJoinView3013136161713907400;
select distinct v20 from tAux14;
