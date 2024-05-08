create or replace view semiJoinView6591929373455306227 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView1966857378225436850 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView2813729804498560443 as select v3, v20 from semiJoinView6591929373455306227 where (v3) in (select (v3) from semiJoinView1966857378225436850);
create or replace view semiJoinView4203863167115403756 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView2863752902638918542 as select v26, v3 from semiJoinView4203863167115403756 where (v3) in (select (v3) from semiJoinView2813729804498560443);
create or replace view semiJoinView1718945295514797586 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView2863752902638918542) and name LIKE 'B%';
create or replace view nAux49 as select v27 from semiJoinView1718945295514797586;
select distinct v27 from nAux49;
