create or replace view semiJoinView8240611487529916542 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView7905846538414615573 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3550419476391874515 as select v3, v25 from semiJoinView7905846538414615573 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView5587934127087404163 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView8240611487529916542);
create or replace view semiJoinView1974477372655081742 as select v26, v3 from semiJoinView5587934127087404163 where (v3) in (select (v3) from semiJoinView3550419476391874515);
create or replace view semiJoinView4829418205776297589 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView1974477372655081742);
create or replace view nAux56 as select v27 from semiJoinView4829418205776297589;
select distinct v27 from nAux56;
