create or replace view semiJoinView621474498238610609 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7689266311883858495 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView5823853428937574916 as select v12, v18 from semiJoinView621474498238610609 where (v12) in (select (v12) from semiJoinView7689266311883858495);
create or replace view semiJoinView1648385872072712533 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView5823853428937574916);
create or replace view tAux35 as select v20 from semiJoinView1648385872072712533;
select distinct v20 from tAux35;
