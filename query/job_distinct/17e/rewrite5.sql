create or replace view semiJoinView8552950023012219844 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView8336327556492723451 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView1599158536337087969 as select v3, v20 from semiJoinView8552950023012219844 where (v3) in (select (v3) from semiJoinView8336327556492723451);
create or replace view semiJoinView3359837966771060540 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView1599158536337087969);
create or replace view semiJoinView1477809542839864599 as select v26, v3 from semiJoinView3359837966771060540 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView496113177806076482 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView1477809542839864599);
create or replace view nAux85 as select v27 from semiJoinView496113177806076482;
select distinct v27 from nAux85;
