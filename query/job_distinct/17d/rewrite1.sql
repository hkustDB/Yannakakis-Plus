create or replace view semiJoinView163595543650133360 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView1564220309950838967 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView271540463468865493 as select v3, v20 from semiJoinView1564220309950838967 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView8950864602163906862 as select v3, v25 from semiJoinView163595543650133360 where (v3) in (select (v3) from semiJoinView271540463468865493);
create or replace view semiJoinView8643387862825857380 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView8950864602163906862);
create or replace view semiJoinView518137476080743787 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView8643387862825857380) and name LIKE '%Bert%';
create or replace view nAux1 as select v27 from semiJoinView518137476080743787;
select distinct v27 from nAux1;
