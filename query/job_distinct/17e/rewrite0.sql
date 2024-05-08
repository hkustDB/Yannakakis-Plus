create or replace view semiJoinView4681681789031733074 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView1794343918733579254 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView7286996302512568734 as select v3, v25 from semiJoinView4681681789031733074 where (v3) in (select (v3) from semiJoinView1794343918733579254);
create or replace view semiJoinView7324788137394577771 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView7286996302512568734);
create or replace view semiJoinView6954259635358158212 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView7324788137394577771);
create or replace view semiJoinView3207500125570758302 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6954259635358158212);
create or replace view nAux20 as select v27 from semiJoinView3207500125570758302;
select distinct v27 from nAux20;
