create or replace view semiJoinView7854704886244665926 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7093141400914891865 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView3171764345179229164 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView7093141400914891865);
create or replace view semiJoinView2903041462921128180 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView7854704886244665926);
create or replace view semiJoinView4777832929893830232 as select v26, v3 from semiJoinView3171764345179229164 where (v3) in (select (v3) from semiJoinView2903041462921128180);
create or replace view semiJoinView8796551740364098348 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView4777832929893830232);
create or replace view nAux26 as select v27 from semiJoinView8796551740364098348;
select distinct v27 from nAux26;
