create or replace view semiJoinView6038124740571813893 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8821135019887064293 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView7600690115265505338 as select id as v3 from title AS t where (id) in (select (v3) from semiJoinView8821135019887064293);
create or replace view semiJoinView8673389332807528468 as select v3 from semiJoinView7600690115265505338 where (v3) in (select (v3) from semiJoinView6038124740571813893);
create or replace view semiJoinView5007165899588964533 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView8673389332807528468);
create or replace view semiJoinView292252606107154550 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView5007165899588964533);
create or replace view nAux32 as select v27 from semiJoinView292252606107154550;
select distinct v27 from nAux32;
