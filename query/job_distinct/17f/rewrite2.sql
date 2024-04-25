create or replace view semiJoinView4338414660768695230 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView4008752725801353989 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView4338414660768695230);
create or replace view semiJoinView6876659794175979017 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView6359300035535892377 as select v3 from semiJoinView4008752725801353989 where (v3) in (select (v3) from semiJoinView6876659794175979017);
create or replace view semiJoinView843111910490619563 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView6359300035535892377);
create or replace view semiJoinView1430917067763916431 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView843111910490619563) and name LIKE '%B%';
create or replace view nAux80 as select v27 from semiJoinView1430917067763916431;
select distinct v27 from nAux80;
