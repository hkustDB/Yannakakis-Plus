create or replace view semiJoinView1794381621516496089 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView2283637898828551138 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7888059499818107091 as select v3, v20 from semiJoinView1794381621516496089 where (v20) in (select (id) from company_name AS cn);
create or replace view semiJoinView536629188388568422 as select v3, v25 from semiJoinView2283637898828551138 where (v3) in (select (v3) from semiJoinView7888059499818107091);
create or replace view semiJoinView478289683766331370 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView536629188388568422);
create or replace view semiJoinView3808070992863935482 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView478289683766331370);
create or replace view nAux11 as select v27 from semiJoinView3808070992863935482;
select distinct v27 from nAux11;
