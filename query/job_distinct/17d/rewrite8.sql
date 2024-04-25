create or replace view semiJoinView3885419140762083433 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView6937156609445359005 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView3797373758285209496 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView7188971186113207650 as select v3, v20 from semiJoinView6937156609445359005 where (v3) in (select (v3) from semiJoinView3797373758285209496);
create or replace view semiJoinView2705173760201586040 as select v26, v3 from semiJoinView3885419140762083433 where (v3) in (select (v3) from semiJoinView7188971186113207650);
create or replace view semiJoinView2794380154996766276 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView2705173760201586040) and name LIKE '%Bert%';
create or replace view nAux59 as select v27 from semiJoinView2794380154996766276;
select distinct v27 from nAux59;
