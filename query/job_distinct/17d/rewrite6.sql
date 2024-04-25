create or replace view semiJoinView6973229227930039327 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView5373518805348999344 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView408105853350991015 as select v3, v20 from semiJoinView5373518805348999344 where (v3) in (select (v3) from semiJoinView6973229227930039327);
create or replace view semiJoinView1570024117462883079 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView408105853350991015);
create or replace view semiJoinView6852623343364971724 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1570024117462883079);
create or replace view semiJoinView279983342140854347 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6852623343364971724) and name LIKE '%Bert%';
create or replace view nAux24 as select v27 from semiJoinView279983342140854347;
select distinct v27 from nAux24;
