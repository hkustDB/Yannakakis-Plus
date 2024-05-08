create or replace view semiJoinView1569373838406328618 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView6715704585775785894 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView4245357633330285915 as select v3, v25 from semiJoinView1569373838406328618 where (v3) in (select (id) from title AS t);
create or replace view semiJoinView9014834145255949593 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView4245357633330285915);
create or replace view semiJoinView3866121141229374278 as select v26, v3 from semiJoinView9014834145255949593 where (v3) in (select (v3) from semiJoinView6715704585775785894);
create or replace view semiJoinView7823534933025416434 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3866121141229374278);
create or replace view nAux56 as select v27 from semiJoinView7823534933025416434;
select distinct v27 from nAux56;
