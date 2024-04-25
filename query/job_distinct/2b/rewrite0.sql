create or replace view semiJoinView1477861527105993185 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[nl]');
create or replace view semiJoinView8832280021489625337 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView6956086901483463961 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView8832280021489625337);
create or replace view semiJoinView2133970988455097197 as select v12, v20 from semiJoinView6956086901483463961 where (v12) in (select (v12) from semiJoinView1477861527105993185);
create or replace view tAux48 as select v20 from semiJoinView2133970988455097197;
select distinct v20 from tAux48;
