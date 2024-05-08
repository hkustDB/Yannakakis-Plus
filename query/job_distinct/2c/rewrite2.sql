create or replace view semiJoinView3547319284836752869 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[sm]');
create or replace view semiJoinView413036915518216867 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView2462515930879542846 as select v12, v1 from semiJoinView3547319284836752869 where (v12) in (select (v12) from semiJoinView413036915518216867);
create or replace view semiJoinView1968176304328882618 as select id as v12, title as v20 from title AS t where (id) in (select (v12) from semiJoinView2462515930879542846);
create or replace view tAux73 as select v20 from semiJoinView1968176304328882618;
select distinct v20 from tAux73;
