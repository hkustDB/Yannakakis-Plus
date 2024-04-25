create or replace view semiJoinView2304250542939194583 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView5970370832951648555 as select v3, v20 from semiJoinView2304250542939194583 where (v20) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView1812000897081207693 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView1727834295903035177 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView5970370832951648555);
create or replace view semiJoinView4333517806114060702 as select v26, v3 from semiJoinView1727834295903035177 where (v3) in (select (v3) from semiJoinView1812000897081207693);
create or replace view semiJoinView2171376514763659204 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView4333517806114060702);
create or replace view nAux73 as select v27 from semiJoinView2171376514763659204;
select distinct v27 from nAux73;
