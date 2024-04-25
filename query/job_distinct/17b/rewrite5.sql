create or replace view semiJoinView3386634395182795824 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8077838340786583309 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView7786864567536870011 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView3386634395182795824);
create or replace view semiJoinView4736144048353358149 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView7786864567536870011);
create or replace view semiJoinView3498085316588314353 as select v26, v3 from semiJoinView4736144048353358149 where (v3) in (select (v3) from semiJoinView8077838340786583309);
create or replace view semiJoinView259741204422057762 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3498085316588314353);
create or replace view nAux81 as select v27 from semiJoinView259741204422057762;
select distinct v27 from nAux81;
