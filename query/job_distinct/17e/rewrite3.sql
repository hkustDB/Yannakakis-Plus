create or replace view semiJoinView699472926326430301 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView5369294855270619112 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView4755916709208310117 as select v3, v25 from semiJoinView699472926326430301 where (v25) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView5717277842515315487 as select v3, v20 from semiJoinView5369294855270619112 where (v3) in (select (v3) from semiJoinView4755916709208310117);
create or replace view semiJoinView4612590814623034863 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView5717277842515315487);
create or replace view semiJoinView4105753723013320365 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView4612590814623034863);
create or replace view nAux37 as select v27 from semiJoinView4105753723013320365;
select distinct v27 from nAux37;
