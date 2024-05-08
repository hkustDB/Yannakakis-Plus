create or replace view semiJoinView5426878036702016582 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView4305498258764772002 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView6798988072221508134 as select v3, v20 from semiJoinView5426878036702016582 where (v20) in (select (id) from company_name AS cn);
create or replace view semiJoinView3288159560157886046 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView4305498258764772002);
create or replace view semiJoinView4756418348901802581 as select v26, v3 from semiJoinView3288159560157886046 where (v3) in (select (v3) from semiJoinView6798988072221508134);
create or replace view semiJoinView6253439224910011691 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView4756418348901802581);
create or replace view nAux59 as select v27 from semiJoinView6253439224910011691;
select distinct v27 from nAux59;
