create or replace view semiJoinView2325953997707130477 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView2834933267935563331 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView4060683407019177697 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView2325953997707130477);
create or replace view semiJoinView5354089810789446954 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView2834933267935563331);
create or replace view semiJoinView432670091035657296 as select v26, v3 from semiJoinView5354089810789446954 where (v3) in (select (v3) from semiJoinView4060683407019177697);
create or replace view semiJoinView4504326739112797207 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView432670091035657296) and name LIKE 'X%';
create or replace view nAux5 as select v27 from semiJoinView4504326739112797207;
select distinct v27 from nAux5;
