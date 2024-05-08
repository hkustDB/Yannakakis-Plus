create or replace view semiJoinView5031714647888380639 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView1332657714698867855 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView5031714647888380639);
create or replace view semiJoinView6703609790076663637 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView271799463643434287 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1332657714698867855);
create or replace view semiJoinView8203527723293433851 as select v26, v3 from semiJoinView271799463643434287 where (v3) in (select (v3) from semiJoinView6703609790076663637);
create or replace view semiJoinView7352721763956067738 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView8203527723293433851) and name LIKE '%B%';
create or replace view nAux94 as select v27 from semiJoinView7352721763956067738;
select distinct v27 from nAux94;
