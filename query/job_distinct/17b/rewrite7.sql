create or replace view semiJoinView4845052051191483902 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8519372084152562383 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView457714442763510645 as select v3, v20 from semiJoinView8519372084152562383 where (v20) in (select (id) from company_name AS cn);
create or replace view semiJoinView6100032758861732698 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView4845052051191483902);
create or replace view semiJoinView6517325134524532185 as select v26, v3 from semiJoinView6100032758861732698 where (v3) in (select (v3) from semiJoinView457714442763510645);
create or replace view semiJoinView6537369956619840234 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView6517325134524532185);
create or replace view nAux27 as select v27 from semiJoinView6537369956619840234;
select distinct v27 from nAux27;
