create or replace view semiJoinView103454377040300170 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView728938567814918126 as select v3, v20 from semiJoinView103454377040300170 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView1097525325072073775 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView981984058447206928 as select v3, v25 from semiJoinView1097525325072073775 where (v3) in (select (v3) from semiJoinView728938567814918126);
create or replace view semiJoinView6343215989088631976 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView981984058447206928);
create or replace view semiJoinView1942020907839342113 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6343215989088631976);
create or replace view nAux11 as select v27 from semiJoinView1942020907839342113;
select distinct v27 from nAux11;
