create or replace view semiJoinView1632556407702878086 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView6290828034981768668 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView2363177648464871829 as select v3, v25 from semiJoinView6290828034981768668 where (v25) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView4113171924200559819 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1632556407702878086);
create or replace view semiJoinView3008235568836795212 as select v26, v3 from semiJoinView4113171924200559819 where (v3) in (select (v3) from semiJoinView2363177648464871829);
create or replace view semiJoinView7427166000014622799 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3008235568836795212) and name LIKE '%Bert%';
create or replace view nAux75 as select v27 from semiJoinView7427166000014622799;
select distinct v27 from nAux75;
